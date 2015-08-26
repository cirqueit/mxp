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

#ifndef MM_CACHED_SCALAR_THRESHOLD
	/// If the number of elements is less than or equal to this, the MXP is not used.
	#define MM_CACHED_SCALAR_THRESHOLD VBX_CPU_DCACHE_LINE_SIZE*2
#endif
#include "vbx_port.h"

/** Copies a vector of elements allocated *in the scratchpad*.
 *  The function properly handles overlapping source and destination addresses.
 *  @pre  v_src contains elements to copy.
 *  @post v_dst contains a copy of v_src as it was when the function was called.
 *
 * @param[out] v_dst *in scratch*.
 * @param[in]  v_src *in scratch*.
 * @param[in]  N is number of elements to copy.
 * @param[in] pipeline_depth depth of processor pipeline. If unknown: use 1
 * @returns    negative on error condition. See vbw_exit_codes.h
 */
template<typename vbx_sp_t>
inline int vbw_vec_copy( vbx_sp_t *v_dst, vbx_sp_t *v_src, const int N)
{
	// if copying backwards, no problem

	if( v_dst == v_src || !N ) {
		return VBW_SUCCESS;
	}

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();


	int overlap = 0;

	// There is no hazard when v_dst < v_src
	if( v_src < v_dst  &&  v_dst < v_src+N ) {
		overlap = 1;
	}

	if( !overlap ) {
		// straight-forward copy, no hazards
		vbx_set_vl( N );
		vbxx(VMOV, v_dst, v_src);

	} else {
		// copy forwards, but start at the tail to
		// avoid the hazard. a 2D VMOV is done to
		// move W words at a time.
		int width = sizeof(vbx_word_t)/sizeof(vbx_sp_t)*this_mxp->vector_lanes; // VBX_WIDTH_BYTES;
		int nrows = N / width;
		vbx_set_vl( width );
		vbx_set_2D( nrows, -width*sizeof(vbx_sp_t), -width*sizeof(vbx_sp_t), 0 );
		vbxx_2D( VMOV, v_dst+N-width, v_src+N-width);
		// the 2D move copies a rectangle width * nrows.
		// copy any last residual amount at the head.
		vbx_set_vl( N - nrows*width );
		vbxx(VMOV, v_dst, v_src);
	}
	return VBW_SUCCESS;
}
extern "C" int vbw_vec_copy_word( vbx_word_t *v_dst, vbx_word_t *v_src, const int N)
{return  vbw_vec_copy<vbx_word_t>(v_dst,v_src, N);}
extern "C" int vbw_vec_copy_uword( vbx_uword_t *v_dst, vbx_uword_t *v_src, const int N)
{return  vbw_vec_copy<vbx_uword_t>(v_dst,v_src, N);}
extern "C" int vbw_vec_copy_half( vbx_half_t *v_dst, vbx_half_t *v_src, const int N)
{return  vbw_vec_copy<vbx_half_t>(v_dst,v_src, N);}
extern "C" int vbw_vec_copy_uhalf( vbx_uhalf_t *v_dst, vbx_uhalf_t *v_src, const int N)
{return  vbw_vec_copy<vbx_uhalf_t>(v_dst,v_src, N);}
extern "C" int vbw_vec_copy_byte( vbx_byte_t *v_dst, vbx_byte_t *v_src, const int N)
{return  vbw_vec_copy<vbx_byte_t>(v_dst,v_src, N);}
extern "C" int vbw_vec_copy_ubyte( vbx_ubyte_t *v_dst, vbx_ubyte_t *v_src, const int N)
{return  vbw_vec_copy<vbx_ubyte_t>(v_dst,v_src, N);}

/** Copies a vector of elements *in memory*.
 *  The function properly handles overlapping source and destination addresses.
 *  @pre  src contains elements to copy.
 *  @post dst contains a copy of src as it was when the function was called.
 *
 *  @param[out] dst *in memory*.
 *  @param[in]  src *in memory*.
 *  @param[in]  N is number of elements to copy.
 *  @returns    negative on error condition. See vbw_exit_codes.h
 */
template<typename vbx_mm_t>
inline int vbw_vec_copy_ext( vbx_mm_t *dst, vbx_mm_t *src, const int N )
{
	typedef vbx_mm_t vbx_sp_t;
	// If src and dst are the same, or we are copying 0 elements, we are done.
	if( dst == src || !N ) {
		return VBW_SUCCESS;
	}
	// Are we copying forward?
	int fwd_overlap = ( src < dst  &&  dst < src+N ) ? 1 : 0;

	// Catch when N is very small
	if( N<4 ) {
		int i;
		if( fwd_overlap ) {
			for( i=N-1; i>=0; i-- ) {
				dst[i]=src[i];
			}
		} else {
			for( i=0; i<N; i++ ) {
				dst[i]=src[i];
			}
		}
		return VBW_SUCCESS;
	}

	int FREE_BYTES = vbx_sp_getfree();

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int SP_WIDTH_B = this_mxp->scratchpad_alignment_bytes; // VBX_WIDTH_BYTES;

	int SP_VERY_LOW = FREE_BYTES < SP_WIDTH_B*4 ;

	// Catch when N is small enough that cached scalar does a better job
	if(  N <= MM_CACHED_SCALAR_THRESHOLD || SP_VERY_LOW  ) {
		int i;

		vbx_mm_t *A = (vbx_mm_t*)vbx_remap_cached(src,N*sizeof(vbx_mm_t));
		vbx_mm_t *B = (vbx_mm_t*)vbx_remap_cached(dst,N*sizeof(vbx_mm_t));

		if( fwd_overlap ) {
			for( i=N-1; i>=0; i-- ) {
				B[i]=A[i];
			}
		} else {
			for( i=0; i<N; i++ ) {
				B[i]=A[i];
			}
		}
		vbx_dcache_flush(B,N*sizeof(vbx_mm_t));
		return VBW_SUCCESS;
	}

	vbx_sp_push();
	vbx_sp_t *v_tmp = (vbx_sp_t *)vbx_sp_malloc( FREE_BYTES );

	// Will the whole thing fit in the scratchpad?
	if( N*sizeof(vbx_sp_t) <= (unsigned)FREE_BYTES ) {
		vbx_dma_to_vector(v_tmp, src, N*sizeof(vbx_sp_t));
		vbx_dma_to_host(dst, v_tmp, N*sizeof(vbx_sp_t));
		vbx_sp_pop();
		return VBW_SUCCESS;;
	}

	vbx_mm_t *psrc, *pdst;
	int remaining = N;
	int elements_per_pass = FREE_BYTES/sizeof(vbx_mm_t);

	// If copying forward, we need to traverse backward
	if( fwd_overlap ) {
		psrc = src + N;
		pdst = dst + N;
		while( remaining > 0 ) {
			if( remaining < elements_per_pass ) elements_per_pass = remaining;
			psrc -= elements_per_pass;
			pdst -= elements_per_pass;
			vbx_dma_to_vector(v_tmp, psrc, elements_per_pass*sizeof(vbx_sp_t));
			vbx_dma_to_host(pdst, v_tmp, elements_per_pass*sizeof(vbx_sp_t));
			remaining -= elements_per_pass;
		}
	} else {
		psrc = src;
		pdst = dst;
		while( remaining > 0 ) {
			if( remaining < elements_per_pass ) elements_per_pass = remaining;
			vbx_dma_to_vector(v_tmp, psrc, elements_per_pass*sizeof(vbx_sp_t));
			vbx_dma_to_host(pdst, v_tmp, elements_per_pass*sizeof(vbx_sp_t));
			psrc += elements_per_pass;
			pdst += elements_per_pass;
			remaining -= elements_per_pass;
		}
	}

	vbx_sp_pop();
	return VBW_SUCCESS;
}
extern "C" int vbw_vec_copy_ext_word( vbx_word_t *dst, vbx_word_t *src, const int N )
{return vbw_vec_copy_ext( dst,src, N );}
extern "C" int vbw_vec_copy_ext_uword( vbx_uword_t *dst, vbx_uword_t *src, const int N )
{return vbw_vec_copy_ext( dst,src, N );}
extern "C" int vbw_vec_copy_ext_half( vbx_half_t *dst, vbx_half_t *src, const int N )
{return vbw_vec_copy_ext( dst,src, N );}
extern "C" int vbw_vec_copy_ext_uhalf( vbx_uhalf_t *dst, vbx_uhalf_t *src, const int N )
{return vbw_vec_copy_ext( dst,src, N );}
extern "C" int vbw_vec_copy_ext_byte( vbx_byte_t *dst, vbx_byte_t *src, const int N )
{return vbw_vec_copy_ext( dst,src, N );}
extern "C" int vbw_vec_copy_ext_ubyte( vbx_ubyte_t *dst, vbx_ubyte_t *src, const int N )
{return vbw_vec_copy_ext( dst,src, N );}
