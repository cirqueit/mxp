/* VECTORBLOX MXP SOFTWARE DEVELOPMENT KIT
 *
 * Copyright (C) 2012-2015 VectorBlox Computing Inc., Vancouver, British Columbia, Canada.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 *     * Neither the name of VectorBlox Computing Inc. nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * This agreement shall be governed in all respects by the laws of the Province
 * of British Columbia and by the laws of Canada.
 *
 * This file is part of the VectorBlox MXP Software Development Kit.
 *
 */

/**@file*/
#include "vbx.h"
#include "vbw_exit_codes.h"
#include "vbx_port.h"
#include "limits.h"

///@{
/** Thresholds for MXPs with different lane sizes
 *  Vector lengths (measured in words) that are equal to or shorter than the thresholds defined here
 *  will be processed with a simpler algorithm because it should be faster. The speedup was determined
 *  experimentally on a NIOS, but the result should depend only on the MXP, independent of the CPU.
 *  @warning If any of these values are set below their stated minimums, the behavior is undefined.
 *  @note    MXPs with 4 or fewer lanes will always use the simpler algorithm.
 */
#define VL1_THRESHOLD_V32_UP  30*32              ///< MINIMUM: 2*32. Threshold for MXPs with 32 or more vector lanes.
#define VL1_THRESHOLD_V16     87*16              ///< MINIMUM: 2*16. Threshold for MXPs with 16 vector lanes.
#define VL1_THRESHOLD_V8      300*8              ///< MINIMUM: 2*8.  Threshold for MXPs with 8 vector lanes.
///@}

/** Maximum threshold for using scalar algorithm
 *  For vectors in main memory, vector lengths (measured in elements) that are equal to or shorter than
 *  this threshold will be processed with a cached scalar algorithm instead of using the MXP.
 *  @note This value was determined experimentally on a NIOS processor on a DE4 with a cache line size of 32 bytes,
 *           and *may not hold* with other configurations.
 *  @note    This value will be compared to the number of elements in the vector, not the number of bytes, as one might
 *           expect. Doing so yielded the best experimental results.
 *  @note    Set this to 0 to disable.
 */
#define MM_CACHED_SCALAR_THRESHOLD VBX_CPU_DCACHE_LINE_SIZE*2

/** Reverses a vector of words allocated *in the scratchpad*.
 *  @pre  N must be >= 1 (not checked)
 *  @pre  DST and SRC must not overlap
 *  @post DST is SRC in reverse word order
 *
 *  @param[out] DST *in scratch*.
 *  @param[in]  SRC *in scratch*.
 *  @param[in]  N   number of words to reverse.
 */
#define vec_rev_w(DST,SRC,N)	  \
	VBX_S{ \
		vbx_set_vl( 1 ); \
		vbx_set_2D( (unsigned int)(N), (int)-sizeof(vbx_word_t), sizeof(vbx_word_t), 0 ); \
		vbxx_2D(VMOV, (vbx_word_t*)(DST)+(unsigned int)(N)-1, (vbx_word_t*)(SRC)); \
	}VBX_E

/** Reverses a vector of words allocated *in the scratchpad*.
 *  @pre  N must be >= 1
 *  @pre  DST and SRC must not overlap
 *  @post DST is SRC in reverse word order, and with a 16bit rotation.
 *        Essentially, DST is SRC in reverse half-word order.
 *
 *  @param[out] DST *in scratch*.
 *  @param[in]  SRC *in scratch*.
 *  @param[in]  N   number of words to reverse and rotate.
 */
#define vec_rev_rot16_w(DST,SRC,N)	  \
	VBX_S{ \
		vbx_set_vl( 1 ); \
		vbx_set_2D( (unsigned int)(N), (int)-sizeof(vbx_word_t), 0, sizeof(vbx_word_t) ); \
		vbxx_2D(VROTL, (vbx_uword_t*)(DST)+(unsigned int)(N)-1, 16, (vbx_uword_t*)(SRC) ); \
	}VBX_E

/** Swaps upper and lower bytes of a vector of halfs allocated *in the scratchpad*.
 *  @pre N must be >= 1
 *  @pre SRC and DST can (and probably will) be pointing to the same address.
 *
 *  @param[out] DST *in scratch*.
 *  @param[in]  SRC *in scratch*.
 *  @param[in]  N   number of halfs to rotate.
 */
#define vec_rot8_h(DST,SRC,N)	  \
	VBX_S{ \
		vbx_set_vl( N ); \
		vbxx(VROTL, (vbx_uhalf_t *)DST, 8, (vbx_uhalf_t *)SRC ); \
	}VBX_E


/** Internal helper function to reverse and optionally rotate a vector of words *in the scratchpad*.
 *  This function uses a merge reverse algorithm that is faster on large vectors.
 *  @pre v_src contains the elements to reverse.
 *  @pre v_src, v_scratch0, and v_scratch1 must all be the same length.
 *  @pre v_scratch1 and v_src must not overlap.
 *  @pre v_src *may* overlap v_scratch0 (will clobber v_src).
 *  @pre MXP must be 2 lanes or more.
 *  @pre N is a multiple of SP_WIDTH_B.
 *  @pre NUM_ROWS == N*4 / SP_WIDTH_B.
 *  @pre v_mask must be SP_WIDTH_B bytes long.
 *  @post v_scratch0 and v_scratch1 contents are modified, with one containing the result.
 *  @post v_src clobbered only if v_src overlaps v_scratch0.
 *
 *  @param[in]  v_scratch1 *in scratch*.
 *  @param[in]  v_src *in scratch*.
 *  @param[in]  N is the number of words to reverse.
 *  @param[in]  v_scratch0 *in scratch*.
 *  @param[in]  v_mask *in scratch*.
 *  @param[in]  SP_WIDTH_B typically the scratchpad width in bytes, it is the length of the data to be worked on at a time.
 *  @param[in]  NUM_ROWS is the number of rows of length SP_WIDTH_B bytes.
 *  @param[in]  rot16 TRUE to swap upper and lower half-words of each word in result.
 *  @returns    the scratchpad address where the result resides. This will be equal to either v_scratch0 or v_scratch1,
 *              and will depend on log2(MXP vector lanes).
 */
static vbx_word_t *vec_rev_merge_w( vbx_word_t *v_scratch1, vbx_word_t *v_src, const unsigned int N, vbx_word_t *v_scratch0,
                                    vbx_word_t *v_mask, const unsigned int SP_WIDTH_B, const unsigned int NUM_ROWS, const unsigned int rot16 )
{
#if !VBX_SKIP_ALL_CHECKS
	if( !N || !v_scratch0 || !v_src || !v_scratch1 || !v_mask || SP_WIDTH_B < 8) {
		VBX_PRINTF("Helper function vec_rev_merge_w: null pointer or row length (vector lanes) too short.");
		VBX_EXIT(-1);
	}
#endif

	vbx_word_t *v_scratch[2] = { v_scratch0, v_scratch1 };
	unsigned int W = SP_WIDTH_B/4/2;                                         // half the number of words in a row
	unsigned int sel = 1;

	if( rot16 ) {
		vbx_set_vl( W );
		vbx_set_2D( NUM_ROWS, -SP_WIDTH_B, 0, SP_WIDTH_B );
		vbx_2D( SVWU, VROTL, (vbx_uword_t *)(v_scratch[sel]+N-W), 16, (vbx_uword_t *)v_src );
		vbx_2D( SVWU, VROTL, (vbx_uword_t *)(v_scratch[sel]+N-(W*2)), 16, (vbx_uword_t *)(v_src+W) );
	} else {
		vbx_set_vl( W );
		vbx_set_2D( NUM_ROWS, -SP_WIDTH_B, SP_WIDTH_B, 0 );
		vbx_2D( VVW, VMOV, v_scratch[sel]+N-W, v_src, 0 );
		vbx_2D( VVW, VMOV, v_scratch[sel]+N-(W*2), v_src+W, 0 );
	}

	vbx_set_vl( SP_WIDTH_B/4 );
	vbx_set_2D( NUM_ROWS, SP_WIDTH_B, SP_WIDTH_B, 0 );

	while( W > 1 ) {
		// set up odd/even mask register
		W /= 2;
		vbx( SEW, VAND, v_mask, W, 0 );
		vbx_2D( VVW, VCMV_NZ, v_scratch[!sel], v_scratch[sel]-W, v_mask );
		vbx_2D( VVW, VCMV_Z , v_scratch[!sel], v_scratch[sel]+W, v_mask );
		sel = !sel;
	}

	return v_scratch[sel];
}


/** Reverses a vector of elements allocated *in the scratchpad*.
 *  @pre v_src contains the elements to reverse.
 *  @pre v_dst and v_src must not overlap.
 *  @post v_dst will contain the elements of v_src in reverse order.
 *
 *  @param[out] v_dst *in scratch*.
 *  @param[in]  v_src *in scratch*.
 *  @param[in]  N is number of elements to reverse.
 *  @returns    negative on error condition. See vbw_exit_codes.h
 *
 *  @todo       handle overlapping input/output
 */
template<typename vbx_sp_t>
int vbw_vec_reverse( vbx_sp_t *v_dst, vbx_sp_t *v_src, const unsigned int N )
{
	const int VBW_ROT16= sizeof(vbx_sp_t) <=sizeof(vbx_half_t);
	const int VBW_ROT8= sizeof(vbx_sp_t)== sizeof(vbx_byte_t);
	const int VBW_RSHIFT_T_TO_W= (sizeof(vbx_sp_t)==sizeof(vbx_word_t)? 0:
	                              sizeof(vbx_sp_t)==sizeof(vbx_half_t)? 1:/*byte_sized*/2);
	const int VBW_LSHIFT_W_TO_T= VBW_RSHIFT_T_TO_W;

	vbx_mxp_t *this_mxp            = VBX_GET_THIS_MXP();
	const unsigned int NUM_LANES   = this_mxp->vector_lanes;

	//printf("\n%d\n",VBX_SKIP_ALL_CHECKS);

	// Can the whole vector fit in the scratchpad width?
	if( N < (NUM_LANES << VBW_LSHIFT_W_TO_T) ){
		vbx_set_vl( 1 );
		vbx_set_2D( N, (int)-sizeof(vbx_sp_t), (int)sizeof(vbx_sp_t), 0 );
		vbxx_2D(VMOV, v_dst+N-1, v_src);
		return VBW_SUCCESS;
	}

	unsigned int threshold_w = (NUM_LANES >= 32 ? VL1_THRESHOLD_V32_UP :
	                            NUM_LANES == 16 ? VL1_THRESHOLD_V16    :
	                            NUM_LANES == 8  ? VL1_THRESHOLD_V8     : UINT_MAX);

	unsigned int N_w          = N >> VBW_RSHIFT_T_TO_W;                  // Equivalent number of words in the vector

	if( N_w && N_w <= threshold_w ) {
		if( VBW_ROT16){
			// remainder of elements that can't add to a whole word
			unsigned int stub_t = N - (N_w << VBW_LSHIFT_W_TO_T);
			if( stub_t ) {
				vbx_set_vl( 1 );
				vbx_set_2D( stub_t, (int)-sizeof(vbx_sp_t), sizeof(vbx_sp_t), 0 );
				vbxx_2D(VMOV, v_dst+stub_t-1, v_src+N-stub_t);
				v_dst += stub_t;
			}
			vec_rev_rot16_w(v_dst, v_src, N_w);
		}else{
			vec_rev_w(v_dst, v_src, N_w);
		}

		if( VBW_ROT8){
			vec_rot8_h(v_dst, v_dst, N_w*2);
		}
		return VBW_SUCCESS;
	}


	const unsigned int SP_WIDTH_B       = this_mxp->scratchpad_alignment_bytes;
	const unsigned int FREE_BYTES       = vbx_sp_getfree();
	const unsigned int ODD_LOG_SEL      = NUM_LANES & 0x55555555 ? 1 : 0;

	vbx_word_t *v_mask, *v_result;
	vbx_word_t *v_scratch[2] = {0,0};

	unsigned int num_rows_w    = N_w / NUM_LANES;
	unsigned int working_set_w = num_rows_w * NUM_LANES;
	unsigned int tail_t        = N - (working_set_w << VBW_LSHIFT_W_TO_T);
	unsigned int remaining_w   = working_set_w;

	if( tail_t ) {
		vbx_set_vl( 1 );
		vbx_set_2D( tail_t, (int)-sizeof(vbx_sp_t), sizeof(vbx_sp_t), 0 );
		vbxx_2D(VMOV, v_dst+tail_t-1, v_src+N-tail_t);
		v_dst += tail_t;
	}

	vbx_word_t *v_src_w = (vbx_word_t *)v_src;
	vbx_word_t *v_dst_w = (vbx_word_t *)v_dst;

	if(!num_rows_w) {
		return VBW_SUCCESS;
	}

	remaining_w = working_set_w;
	while( remaining_w*sizeof(vbx_word_t) + SP_WIDTH_B > FREE_BYTES ) {
		if( remaining_w <= threshold_w*2 ) {
			if( VBW_ROT16){
				vec_rev_rot16_w(v_dst_w, v_src_w, remaining_w);
			}else{
				vec_rev_w(v_dst_w, v_src_w, remaining_w);
			}

			if( VBW_ROT8){
				vec_rot8_h(v_dst_w, v_dst_w, remaining_w*2);
			}
			return VBW_SUCCESS;
		}

		working_set_w = VBX_PAD_DN( (remaining_w - NUM_LANES)/2, NUM_LANES );
		v_mask = v_dst_w + (working_set_w*2);
		remaining_w -= working_set_w;

		v_scratch[0] = v_dst_w;
		v_scratch[1] = v_dst_w + working_set_w;
		num_rows_w = working_set_w / NUM_LANES;
		v_result = vec_rev_merge_w( v_scratch[ODD_LOG_SEL], v_src_w + remaining_w, working_set_w,
		                            v_scratch[!ODD_LOG_SEL], v_mask, SP_WIDTH_B, num_rows_w, VBW_ROT16 );
#if !VBX_SKIP_ALL_CHECKS
		if( v_result != v_dst_w ) {
			VBX_PRINTF("Unexpected behavior: merge reverse returned the wrong vector. Parameter order was chosen based on NUM_LANES.");
			VBX_EXIT(-1);
		}
#endif

		if( VBW_ROT8){
			vec_rot8_h(v_result, v_result, working_set_w*2);
		}
		v_dst_w += working_set_w;
	}


	vbx_sp_push();

	v_scratch[0] = v_dst_w;
	v_scratch[1] = (vbx_word_t*)vbx_sp_malloc( remaining_w * sizeof(vbx_word_t) );
#if !VBX_SKIP_ALL_CHECKS
	if( !v_scratch[1] ) {
		VBX_PRINTF("vbx_sp_malloc failed when it was predetermined to have enough space.");
		VBX_EXIT(-1);
	}
#endif

	v_mask = (vbx_word_t*)vbx_sp_malloc( SP_WIDTH_B );
#if !VBX_SKIP_ALL_CHECKS
	if( !v_mask ) {
		VBX_PRINTF("vbx_sp_malloc failed when it was predetermined to have enough space.");
		VBX_EXIT(-1);
	}
#endif

	num_rows_w = remaining_w / NUM_LANES;
	v_result = vec_rev_merge_w( v_scratch[ODD_LOG_SEL], v_src_w, remaining_w, v_scratch[!ODD_LOG_SEL],
	                            v_mask, SP_WIDTH_B, num_rows_w, VBW_ROT16 );
#if !VBX_SKIP_ALL_CHECKS
	if( v_result != v_dst_w ) {
		VBX_PRINTF("Unexpected behavior: merge reverse returned the wrong vector. Parameter order was chosen based on NUM_LANES.");
		VBX_EXIT(-1);
	}
#endif

	if( VBW_ROT8){
		vec_rot8_h(v_result, v_result, remaining_w*2);
	}
	vbx_sp_pop();
	return VBW_SUCCESS;
}
extern "C" int vbw_vec_reverse_word( vbx_word_t *v_dst, vbx_word_t *v_src, const unsigned int N )
{return vbw_vec_reverse(v_dst,v_src,N );}
extern "C" int vbw_vec_reverse_uword( vbx_uword_t *v_dst, vbx_uword_t *v_src, const unsigned int N )
{return vbw_vec_reverse(v_dst,v_src,N );}
extern "C" int vbw_vec_reverse_half( vbx_half_t *v_dst, vbx_half_t *v_src, const unsigned int N )
{return vbw_vec_reverse(v_dst,v_src,N );}
extern "C" int vbw_vec_reverse_uhalf( vbx_uhalf_t *v_dst, vbx_uhalf_t *v_src, const unsigned int N )
{return vbw_vec_reverse(v_dst,v_src,N );}
extern "C" int vbw_vec_reverse_byte( vbx_byte_t *v_dst, vbx_byte_t *v_src, const unsigned int N )
{return vbw_vec_reverse(v_dst,v_src,N );}
extern "C" int vbw_vec_reverse_ubyte( vbx_ubyte_t *v_dst, vbx_ubyte_t *v_src, const unsigned int N )
{return vbw_vec_reverse(v_dst,v_src,N );}

/** Reverses a vector of elements allocated *in memory*.
 *  @pre  src contains the elements to reverse.
 *  @pre  dst and src must not overlap.
 *  @post dst will contain the elements of src in reverse order.
 *
 *  @param[out] dst *in memory*.
 *  @param[in]  src *in memory*.
 *  @param[in]  N is number of elements to reverse.
 *  @returns    negative on error condition. See vbw_exit_codes.h
 *
 *  @todo       handle overlapping input/output
 */
template<typename vbx_mm_t>
int vbw_vec_reverse_ext( vbx_mm_t *dst, vbx_mm_t *src, const unsigned int N )
{

	typedef vbx_mm_t vbx_sp_t;
	const int VBW_ROT16= sizeof(vbx_sp_t) <=sizeof(vbx_half_t);
	const int VBW_ROT8= sizeof(vbx_sp_t)== sizeof(vbx_byte_t);
	const int VBW_RSHIFT_T_TO_W= (sizeof(vbx_sp_t)==sizeof(vbx_word_t)? 0:
	                              sizeof(vbx_sp_t)==sizeof(vbx_half_t)? 1:/*byte_sized*/2);
	const int VBW_LSHIFT_W_TO_T= VBW_RSHIFT_T_TO_W;
	// Catch when N is very small
	if( N<4 ) {
		unsigned int i = 0;
		while(i<N) {
			dst[N-i-1]=src[i];
			i++;
		}
		return VBW_SUCCESS;
	}

	vbx_mxp_t *this_mxp          = VBX_GET_THIS_MXP();
	unsigned int SP_WIDTH_B      = this_mxp->scratchpad_alignment_bytes;
	unsigned int FREE_BYTES      = vbx_sp_getfree();


	// Catch when N is small enough that cached scalar does a better job
	if( N <= MM_CACHED_SCALAR_THRESHOLD || FREE_BYTES < SP_WIDTH_B*5 ){
		unsigned int i;
		vbx_mm_t *A = (vbx_mm_t*)vbx_remap_cached(src,N*sizeof(vbx_mm_t));
		vbx_mm_t *B = (vbx_mm_t*)vbx_remap_cached(dst,N*sizeof(vbx_mm_t));
		for( i=0; i<N; i++ ) {
			B[N-i-1]=A[i];
		}
		vbx_dcache_flush(B,N*sizeof(vbx_mm_t));
		return VBW_SUCCESS;
	}

	unsigned int NUM_LANES   = this_mxp->vector_lanes;
	unsigned int tile_size_b = VBX_PAD_DN(((FREE_BYTES-SP_WIDTH_B)/2),SP_WIDTH_B);
	unsigned int tile_size_w = tile_size_b/4;
	unsigned int tile_size_t = tile_size_w << VBW_LSHIFT_W_TO_T;


	unsigned int num_tiles = N / tile_size_t;
	unsigned int rows_per_tile = tile_size_b / SP_WIDTH_B;

	unsigned int tile_part_t = N - num_tiles * tile_size_t;
	unsigned int threshold_w = NUM_LANES >= 32 ? VL1_THRESHOLD_V32_UP :
		NUM_LANES == 16 ? VL1_THRESHOLD_V16    :
		NUM_LANES == 8  ? VL1_THRESHOLD_V8     : UINT_MAX;


	if(tile_part_t){
		vbx_sp_push();
		vbx_sp_t *v_0 = (vbx_sp_t *)vbx_sp_malloc(tile_part_t*sizeof(vbx_sp_t));
		vbx_sp_t *v_1 = (vbx_sp_t *)vbx_sp_malloc(tile_part_t*sizeof(vbx_sp_t));

#if !VBX_SKIP_ALL_CHECKS
		if( !v_0 || !v_1) {
			VBX_PRINTF("vbx_sp_malloc failed when it was predetermined to have enough space.");
			VBX_EXIT(-1);
		}
#endif

		vbx_dma_to_vector(v_0, src+N-tile_part_t, tile_part_t*sizeof(vbx_mm_t));
		vbw_vec_reverse(v_1, v_0, tile_part_t);
		vbx_dma_to_host(dst, v_1, tile_part_t*sizeof(vbx_sp_t));
		dst += tile_part_t;
		vbx_sp_pop();
	}

	if(!num_tiles) {
		return VBW_SUCCESS;
	}

	vbx_sp_push();
	vbx_word_t *v_mask = (vbx_word_t *)vbx_sp_malloc(SP_WIDTH_B);
	vbx_word_t *v_scratch[2] = { (vbx_word_t *)vbx_sp_malloc(tile_size_b), (vbx_word_t *)vbx_sp_malloc(tile_size_b) };
	vbx_word_t *result;

#if !VBX_SKIP_ALL_CHECKS
	if( !v_scratch[0] || !v_scratch[1] || !v_mask ) {
		VBX_PRINTF("vbx_sp_malloc failed when it was predetermined to have enough space.");
		VBX_EXIT(-1);
	}
#endif

	src += (num_tiles - 1) * tile_size_t;

	if( tile_size_w <= threshold_w) {
		while( num_tiles ) {
			vbx_dma_to_vector( v_scratch[0], src, tile_size_b );
			if(VBW_ROT16){
				vec_rev_rot16_w(v_scratch[1], v_scratch[0], tile_size_w);
			}else{
				vec_rev_w(v_scratch[1], v_scratch[0], tile_size_w);
			}
			if( VBW_ROT8){
				vec_rot8_h( v_scratch[1], v_scratch[1], tile_size_w*2 );
			}
			vbx_dma_to_host( dst, v_scratch[1], tile_size_b );
			dst += tile_size_t;
			src -= tile_size_t;
			num_tiles--;
		}
	} else {
		while( num_tiles ) {
			vbx_dma_to_vector( v_scratch[0], src, tile_size_b );
			result = vec_rev_merge_w( v_scratch[1], v_scratch[0], tile_size_w, v_scratch[0], v_mask, SP_WIDTH_B,
			                          rows_per_tile, VBW_ROT16 );
			if(VBW_ROT8){
				vec_rot8_h( result, result, tile_size_w*2 );
			}
			vbx_dma_to_host( dst, result, tile_size_b );
			dst += tile_size_t;
			src -= tile_size_t;
			num_tiles--;
		}
	}

	vbx_sp_pop();
	return VBW_SUCCESS;
}
extern "C" int vbw_vec_reverse_ext_word( vbx_word_t *dst, vbx_word_t *src, const unsigned int N )
{return vbw_vec_reverse_ext(dst, src, N );}
extern "C" int vbw_vec_reverse_ext_uword( vbx_uword_t *dst, vbx_uword_t *src, const unsigned int N )
{return vbw_vec_reverse_ext(dst, src, N );}
extern "C" int vbw_vec_reverse_ext_half( vbx_half_t *dst, vbx_half_t *src, const unsigned int N )
{return vbw_vec_reverse_ext(dst, src, N );}
extern "C" int vbw_vec_reverse_ext_uhalf( vbx_uhalf_t *dst, vbx_uhalf_t *src, const unsigned int N )
{return vbw_vec_reverse_ext(dst, src, N );}
extern "C" int vbw_vec_reverse_ext_byte( vbx_byte_t *dst, vbx_byte_t *src, const unsigned int N )
{return vbw_vec_reverse_ext(dst, src, N );}
extern "C" int vbw_vec_reverse_ext_ubyte( vbx_ubyte_t *dst, vbx_ubyte_t *src, const unsigned int N )
{return vbw_vec_reverse_ext(dst, src, N );}
