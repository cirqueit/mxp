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

#include "vbx_copyright.h"
VBXCOPYRIGHT( test_fft_vector_large )

#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#include "fft.h"
#include "vbx.h"
#include "vbx_port.h"
#include "vbx_common.h"
#include "vbx_vec_rev.h"

typedef vbx_uword_t* vptr_uword;
typedef vbx_uhalf_t* vptr_uhalf;
typedef vbx_ubyte_t* vptr_ubyte;
typedef vbx_word_t* vptr_word;
typedef vbx_half_t* vptr_half;
typedef vbx_byte_t* vptr_byte;

#define SWAP(x1,x2,tmp) do { tmp=x1; x1=x2; x2=tmp; } while(0)

static int isAbsOutOfRange( short fr[], short fi[], int n )
{
	//used for inverse only
	int i;
	for( i=0; i<n; ++i ) {
		int k = fr[i];
		if( abs(k) >= 16384 )
			return 1;
		k = fi[i];
		if( abs(k) >= 16384 )
			return 1;
	}
	return 0;
}

static int isAbsOutOfRangeV( vptr_half v_src_r, vptr_half v_src_i, vptr_half v_temp, int n )
{

	//used for inverse only
	vbx_set_vl(n);
	vbx(SVH, VABSDIFF, v_temp, 0, v_src_r );    // get abs value of real
	vbx(SVH, VSUB, v_temp, 16383, v_temp );     // if (16383 - v_src) < 0, needs scaling
	vbx_acc(SVH, VCMV_LTZ, v_temp, 1, v_temp ); // accum # of neg values to see if scaling required
	vbx_sync();
	if( v_temp[0] ){
		return 1;
	}

	vbx(SVH, VABSDIFF, v_temp, 0, v_src_i );    // get abs value of imag
	vbx(SVH, VSUB, v_temp, 16383, v_temp );     // if (16383 - v_src) < 0, needs scaling
	vbx_acc(SVH, VCMV_LTZ, v_temp, 1, v_temp ); // accum # of neg values to see if scaling required
	vbx_sync();
	if( v_temp[0] ){
		return 1;
	}

	return 0;
}

/* takes in precomputed bfly */
static int vector_fix_fft_dif_long_fly(short fr[], short fi[], short fr2[], short fi2[], short tw_r[], short tw_i[], short m, short inverse, short real)
{
	int i, j, l, k, scale, shift, a1,a2,bfly,mul,flight,swap,row_num;
	short  wr, wi;

	vptr_half v_fr, v_fi, v_fr2, v_fi2, v_tmp;
	vptr_half v_twr, v_twi;
	vptr_half v_arp, v_aip, v_brp, v_bip, v_crp, v_cip;
	vptr_half v_temp;
	vptr_half v_twr2, v_twi2;
	const int n = 1 << m;
	const int half = n >> 1;

	scale = 0;
	mul = 0;
	swap = m >> 1;

	l = m-1;
	flight = 1;
	bfly = half;

	const int INROWS = 1<<swap;
	const int INCOLS = 1<<(m-swap);

	if ( !(m%2) ){
		swap--;
	}

	// allocate space in vector memory for vectors
	v_fr  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_fi  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_fr2 = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_fi2 = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );

	v_twr   = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	v_twi   = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	v_temp  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );

	if( v_fr  == NULL || v_fi == NULL  || v_fr2 == NULL || v_fi2== NULL  || \
	    v_twr == NULL || v_twi == NULL || v_temp == NULL) {
	 	VBX_EXIT(-1);
	}

	v_twr2  = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	v_twi2  = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	if( v_twr2 == NULL || v_twi2 == NULL) {
	 	VBX_EXIT(-1);
	}
	vbx_dma_to_vector( v_fr, fr, n*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_fi, fi, n*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_twr, tw_r, half*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_twi, tw_i, half*sizeof(vbx_half_t) );

#if 1
        if(real){
            vector_fix_fft_untangle_real_scratch( v_fr, v_fi, v_fr2, v_fi2, v_twr,v_twi, m, inverse);
        }
#endif

	while (l > swap) {
		if (inverse) {
			// variable scaling, depending upon data
			shift = 0;
			if( isAbsOutOfRangeV(v_fr,v_fi,v_temp,n) ) {
				shift = 1;
				scale++;
			}
		} else {
			// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		// shift will be performed on each data point exactly once during pass

		SWAP( v_fr, v_fr2, v_tmp );
		SWAP( v_fi, v_fi2, v_tmp );

		if (shift){
			vbx_set_vl( n );
			vbx(SVH,VSHR,  v_fr2, 1,  v_fr2 );
			vbx(SVH,VSHR,  v_fi2, 1,  v_fi2 );
		}

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1) );
		vbx_2D( VVH, VADD, v_fr, v_fr2, v_fr2 + (1<<l) );
		vbx_2D( VVH, VADD, v_fi, v_fi2, v_fi2 + (1<<l) );

		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1) );
		vbx_2D( VVH, VSUB, v_fr2, v_fr2, v_fr2 + (1<<l) );
		vbx_2D( VVH, VSUB, v_fi2, v_fi2, v_fi2 + (1<<l) );

		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l+1), 0 );
		vbx_2D( VVH, VMULFXP, &v_fr[n>>1],  v_fr2,      v_twr );
		vbx_2D( VVH, VMULFXP,  v_temp,      v_fi2,      v_twi );

		vbx_set_vl( n>>1 ); // vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VSUB, &v_fr[n>>1], &v_fr[n>>1], v_temp );

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l+1), 0 );
		vbx_2D( VVH, VMULFXP, &v_fi[n>>1],  v_fi2,      v_twr );
		vbx_2D( VVH, VMULFXP,  v_temp,      v_fr2,      v_twi );

		vbx_set_vl( n>>1 ); //vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VADD,    &v_fi[n>>1], &v_fi[n>>1], v_temp );

		l--;
		mul++;
		flight <<= 1;

		if( l > swap ) {
			vbx_set_vl( 1<<l );
			vbx( VVWH, VMOV, v_twr, v_twr, 0 );
			vbx( VVWH, VMOV, v_twi, v_twi, 0 );
		}
	}

	if ( !(m%2) ) {
		l++;
		flight >>=1;
	}

	SWAP( v_fr, v_fr2, v_tmp );
	SWAP( v_fi, v_fi2, v_tmp );
#if 1
	//VECTORIZED MATRIX TRANSPOSE
	vbx_set_2D( INCOLS, INROWS*sizeof(vbx_half_t), sizeof(vbx_half_t), sizeof(vbx_half_t) );
	vbx_set_vl( 1 );
	for( row_num=0; row_num<INROWS; row_num++ ) {
		vbx_2D( VVHU, VMOV, v_fi+row_num, v_fi2+row_num*INCOLS, 0 );
		vbx_2D( VVHU, VMOV, v_fr+row_num, v_fr2+row_num*INCOLS, 0 );
	}
#endif
	mul = 1;
	while (l < m) {
		if (inverse) {
			// variable scaling, depending upon data
			shift = 0;
			if( isAbsOutOfRangeV(v_fr,v_fi,v_temp,n) ) {
				shift = 1;
				scale++;
			}
		} else {
			// fixed scaling, for proper normalization
			shift = 1;
		}

		SWAP( v_fr, v_fr2, v_tmp );
		SWAP( v_fi, v_fi2, v_tmp );

		if (shift){
			vbx_set_vl( n );
			vbx(SVH,VSHR,  v_fr2, 1,  v_fr2 ); //vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<(l+1)), 0, sizeof(vbx_half_t)*(1<<(l+1)) );
			vbx(SVH,VSHR,  v_fi2, 1,  v_fi2 );
		}

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VADD, v_fr, v_fr2, v_fr2 + (n>>1) );
		vbx_2D( VVH, VADD, v_fi, v_fi2, v_fi2 + (n>>1) );

		vbx_set_vl( n/2 ); //vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VSUB, v_fr2, v_fr2, v_fr2 + (n>>1) );
		vbx( VVH, VSUB, v_fi2, v_fi2, v_fi2 + (n>>1) );

	        /* creating vector of scalar values of both real and imag twiddle factors for 2D ops */
		vbx_set_vl( 1<<l );
		for( k=0; k<flight; k++ ) {
                	vbx(  SVH, VMOV, &v_twr2[ k<<l ], v_twr[ k<<mul ], 0 );
                	vbx(  SVH, VMOV, &v_twi2[ k<<l ], v_twi[ k<<mul ], 0 );
		}

		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VMULFXP, &v_fr[1<<l],  v_twr2,      v_fr2 );
		vbx_2D( VVH, VMULFXP, &v_fi[1<<l],  v_twr2,      v_fi2 );

		vbx_set_vl( n/2 );// vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VMULFXP,  v_temp,      v_twi2,      v_fi2 );
		vbx( VVH, VMULFXP, &v_temp[n/2], v_twi2,      v_fr2 );

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VSUB,    &v_fr[1<<l], &v_fr[1<<l],  v_temp );
		vbx_2D( VVH, VADD,    &v_fi[1<<l], &v_fi[1<<l], &v_temp[n/2] );

		l++;
		mul++;
		flight >>=1;
	}

	vbx_dma_to_host( fr2,  v_fr, n*sizeof(vbx_half_t) );
	vbx_dma_to_host( fi2,  v_fi, n*sizeof(vbx_half_t) );

	vbx_sync();
	vbx_sp_free();

	return scale;
}

/*
   swaps two regions a,b where each contain 2^m-1 elements
   requires 2N Bytes of scratch
*/
static void vector_swap_region(short ar[], short ai[], short br[], short bi[], short m)
{
	const int n = 1 << m;

#if 1
	if (n > (VBX_SCRATCHPAD_SIZE >> 1) ){
		vector_swap_region( ar,       ai,       br,       bi,       m-1);
		vector_swap_region( &ar[n/4], &ai[n/4], &br[n/4], &bi[n/4], m-1);

	} else {
		vptr_half v_a, v_b;
		v_a = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );
		v_b = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );

		if( v_a == NULL || v_b == NULL ){
		 	VBX_EXIT(-1);
		}

		/* send in real components */
		vbx_dma_to_vector( v_a, ar, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_b, br, n/2*sizeof(vbx_half_t) );

		/* send out real components */
		vbx_dma_to_host( br, v_a, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_host( ar, v_b, n/2*sizeof(vbx_half_t) );

		/* send in imag components */
		vbx_dma_to_vector( v_a, ai, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_b, bi, n/2*sizeof(vbx_half_t) );

		/* send out imag components */
		vbx_dma_to_host( bi, v_a, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_host( ai, v_b, n/2*sizeof(vbx_half_t) );

		/* free vector scratchpad */
		vbx_sync();
		vbx_sp_free();
	}
#else
		int i;
		short temp;
		for (i=0; i<n/2; i++){
			temp = ar[i];
			ar[i] = br[i];
			br[i] = temp;

			temp = ai[i];
			ai[i] = bi[i];
			bi[i] = temp;
		}
#endif
}

/*
  if odd or even scaled differently, scale the least scaled to match
  requires 2N Bytes
*/
static void vector_large_scale( short half_r[], short half_i[], short shift, short m)
{
	const int n = 1 << m;
	vptr_half v_r, v_i;

	if (n > (VBX_SCRATCHPAD_SIZE >> 1)  ){
		vector_large_scale( half_r,       half_i,       shift, m-1);
		vector_large_scale( &half_r[n/4], &half_i[n/4], shift, m-1);

	} else {

		v_r  = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );
		v_i  = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );

		if( v_r == NULL || v_i == NULL){
			VBX_EXIT(-1);
		}
		vbx_set_vl(n/2);
		vbx_dma_to_vector( v_r, half_r, n/2 * sizeof(vbx_half_t) );
		vbx( SVH, VSHR,  v_r, shift, v_r );
		vbx_dma_to_vector( v_i, half_i, n/2 * sizeof(vbx_half_t) );
		vbx( SVH, VSHR,  v_i, shift, v_i );

		vbx_dma_to_host( half_r, v_r, n/2 * sizeof(vbx_half_t) );
		vbx_dma_to_host( half_i, v_i, n/2 * sizeof(vbx_half_t) );

		vbx_sync();
		vbx_sp_free();
	}

}

/*
  combines even,odd into result fr2,fi2
  requires 8N Bytes of scratch
*/
static int vector_combine(short even_fr[], short even_fi[], short odd_fr[], short odd_fi[], short tw_r[], short tw_i[], short fr2[], short fi2[], short m, short inverse)
{
	const int n = 1 << m;
	int shift=0, scale=0,scale1,scale0;

	vptr_half v_temp, v_ar, v_ai, v_br, v_bi, v_fr, v_fi, v_fr2, v_fi2;
	vptr_half v_twr, v_twi;

	if (n > (VBX_SCRATCHPAD_SIZE >> 3) ){

		scale0 = vector_combine( even_fr,       even_fi,       odd_fr,       odd_fi,       tw_r,  tw_i,   fr2,       fi2,       m-1,inverse);
		scale1 = vector_combine( &even_fr[n/4], &even_fi[n/4], &odd_fr[n/4], &odd_fi[n/4], &tw_r[n/4],&tw_i[n/4], &fr2[n/2], &fi2[n/2], m-1,inverse);
		/* ensure both halves equally scaled */
		if (scale0 != scale1){
			if (scale0 > scale1){
				vector_large_scale(&fr2[n/2], &fi2[n/2], scale0 - scale1, m);
				scale = scale0;
			} else {
				vector_large_scale( fr2,      fi2,       scale1 - scale0, m);
				scale = scale1;
			}
		} else {
			scale = scale0;
		}
		vector_swap_region( &fr2[n/4], &fi2[n/4], &fr2[n/2] , &fi2[n/2], m-1);

	} else {
		/* alloc largest size possible in vector scratchpad - requires 8N bytes */
		v_fr  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
		v_fi  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
		v_fr2  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
		v_fi2  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );


		if( v_fr  == NULL || v_fi  == NULL  || \
		    v_fr2 == NULL || v_fi2 == NULL  ){
	 		VBX_EXIT(-1);
		}

		v_ar  = v_fr2;
		v_ai  = v_fi2;
		v_br  = &v_fr2[n/2];
		v_bi  = &v_fi2[n/2];

		v_temp = v_fr;
		vbx_dma_to_vector( v_br, even_fr, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_bi, even_fi, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_ar, odd_fr,  n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_ai, odd_fi,  n/2*sizeof(vbx_half_t) );

		if (inverse) {
			// variable scaling, depending upon data
			shift = 0;
			if( isAbsOutOfRangeV(v_fr2,v_fi2,v_temp,n) ) {
				shift = 1;
				scale++;
			}
		} else {
			// fixed scaling, for proper normalization
			shift = 1;
		}

		/* start combine */
		vbx_set_vl( n/2 );

		/* send in twiddle and odd components, scale odd if neccessary */
		if( shift ){
			vbx( SVH, VSHR,  v_ar, 1, v_ar );
			vbx( SVH, VSHR,  v_ai, 1, v_ai );
		}
		vbx_dma_to_vector( v_br, tw_r, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_bi, tw_i, n/2*sizeof(vbx_half_t) );

		/* complex multiply twiddle*odd */
		vbx( VVH, VMULFXP, v_fi,       v_ar, v_br);
		vbx( VVH, VMULFXP,&v_fi[n/2],  v_ai, v_bi);
		//vector_fix_mult2_round(  v_fi,        v_ar, v_br, v_temp ); // A = FIX_MULT(oddr,twr)
		//vector_fix_mult2_round(  &v_fi[n/2],  v_ai, v_bi, v_temp ); // B = FIX_MULT(oddi,twi)
		vbx( VVH, VSUB, &v_fr[n/2], v_fi, &v_fi[n/2] );             // real = A - B

		vbx( VVH, VMULFXP, v_fi,       v_ai, v_br);
		vbx( VVH, VMULFXP,&v_fi[n/2],  v_ar, v_bi);
		//vector_fix_mult2_round(  v_fi,        v_ai, v_br, v_temp ); // C = FIX_MULT(oddi,twr)
		//vector_fix_mult2_round(  &v_fi[n/2],  v_ar, v_bi, v_temp ); // D = FIX_MULT(oddr,twi)
		vbx( VVH, VADD, &v_fi[n/2], v_fi, &v_fi[n/2] );             // imag = C + D

		/* send in even components, scale even if neccessary */
		vbx_dma_to_vector( v_ar, even_fr, n/2*sizeof(vbx_half_t) );
		vbx_dma_to_vector( v_ai, even_fi, n/2*sizeof(vbx_half_t) );
		if( shift ){
			vbx( SVH, VSHR,  v_ar, 1, v_ar );
			vbx( SVH, VSHR,  v_ai, 1, v_ai );
		}

		/* add + send 1st half --even + tw*odd */
		vbx( VVH, VADD,  v_fr, v_ar, &v_fr[n/2] );
		vbx_dma_to_host( fr2,  v_fr, n/2*sizeof(vbx_half_t) );
		vbx( VVH, VADD,  v_fi, v_ai, &v_fi[n/2] );
		vbx_dma_to_host( fi2,  v_fi, n/2*sizeof(vbx_half_t) );

		/* sub + send 2nd half --even - tw*odd */
		vbx( VVH, VSUB,  v_fr,       v_ar, &v_fr[n/2] );
		vbx_dma_to_host( &fr2[n/2],  v_fr, n/2*sizeof(vbx_half_t) );
		vbx( VVH, VSUB,  v_fi,       v_ai, &v_fi[n/2] );
		vbx_dma_to_host( &fi2[n/2],  v_fi, n/2*sizeof(vbx_half_t) );

		/* free vector scratchpad */
		vbx_sync();
		vbx_sp_free();
	}
	return scale;
}


/*
  splits up fr,fi into even,odd
  requires 4N Bytes of scratch
*/
static void vector_split(short fr[], short fi[], short even_fr[], short even_fi[], short odd_fr[], short odd_fi[],short tw_r[], short tw_i[], short tw_r2[], short tw_i2[], short m)
{
	const int n = 1 << m;
	if (n > (VBX_SCRATCHPAD_SIZE >> 2) ){
		vector_split( fr,       fi,       even_fr,       even_fi,       odd_fr,       odd_fi,       tw_r,       tw_i,       tw_r2,      tw_i2, m-1);
		vector_split( &fr[n/2], &fi[n/2], &even_fr[n/4], &even_fi[n/4], &odd_fr[n/4], &odd_fi[n/4], &tw_r[n/4], &tw_i[n/4], &tw_r2[n/8], &tw_i2[n/8], m-1);

	} else {

		vptr_half v_full, v_half, v_bfly, v_fullm, v_halfm, v_bflym;
		/* alloc largest size possible in vector scratchpad - uses 4N Bytes */
		v_full  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
		v_half = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );
		v_bfly = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );


		if( v_full  == NULL || v_half == NULL || v_bfly == NULL ){
	 		VBX_EXIT(-1);
		}

		/* send in real array, use word -> half to gen real even and odd arrays */
		vbx_set_vl( n/2 );
		vbx_dma_to_vector( v_full, fr, n*sizeof(vbx_half_t) );
		vbx( VVWH, VMOV, v_half, v_full, 0 );
		vbx_dma_to_host( even_fr, v_half, n/2*sizeof(vbx_half_t) );
		vbx( VVWH, VMOV, v_half, v_full+1, 0 );
		vbx_dma_to_host( odd_fr, v_half, n/2*sizeof(vbx_half_t) );

		/* send in imag array, use word -> half to gen imag even and odd arrays */
		vbx_dma_to_vector( v_full, fi, n*sizeof(vbx_half_t) );
		vbx( VVWH, VMOV, v_half, v_full, 0 );
		vbx_dma_to_host( even_fi, v_half, n/2*sizeof(vbx_half_t) );
		vbx( VVWH, VMOV, v_half, v_full+1, 0 );
		vbx_dma_to_host( odd_fi, v_half, n/2*sizeof(vbx_half_t) );


		/* vectorized buttefly reduction,  */
		vbx_set_vl( n/4 );

		vbx_dma_to_vector( v_bfly, tw_r, n/2 * sizeof(vbx_half_t) );
		vbx( VVWH, VMOV, v_bfly, v_bfly, 0 );
		vbx_dma_to_host( tw_r2, v_bfly, n/4 * sizeof(vbx_half_t) );

		vbx_dma_to_vector( v_bfly, tw_i, n/2 * sizeof(vbx_half_t) );
		vbx( VVWH, VMOV, v_bfly, v_bfly, 0 );
		vbx_dma_to_host( tw_i2, v_bfly, n/4 * sizeof(vbx_half_t) );

		/* free vector scratchpad */
		vbx_sync();
		vbx_sp_free();
	}

}

/*
  generate butterflies used in large_fft and dif_long_fly
  requires N Bytes of scratch
*/
void vector_large_bfly_gen(short tw_r[], short tw_i[], short k, long offset, short m, short inverse)
{
#if 1
	int i;
	const int n = 1 << m;
	const int l = 1 << k;
	if(n > VBX_SCRATCHPAD_SIZE ){
		vector_large_bfly_gen( tw_r,       tw_i,       k, offset+0, m-1, inverse);
		vector_large_bfly_gen( &tw_r[n/4], &tw_i[n/4], k, offset+n/4, m-1, inverse);
	} else {
		/* temp alloc space to gen butterflies in scratchpad */
		vptr_half v_sine;
		v_sine  = (vptr_half)vbx_sp_malloc( n/2*sizeof(vbx_half_t) );
		if (v_sine == NULL){
			VBX_EXIT(-1);
		}
		/*generate real twiddles -- offset by pi/2*/
		vbx_dma_to_vector( v_sine, &Sinewave[l/4 + offset], n/2 * sizeof(vbx_half_t) );
		vbx_dma_to_host( tw_r, v_sine, n/2 * sizeof(vbx_half_t) );

		/*generate imag twiddles -- neg if forward fft*/
		vbx_dma_to_vector( v_sine, &Sinewave[offset], n/2 * sizeof(vbx_half_t) );
		vbx_set_vl( n/2 );
		if( !inverse ) {
			vbx( SVH, VMULLO, v_sine,-1, v_sine );
		}
		vbx_dma_to_host( tw_i, v_sine, n/2 * sizeof(vbx_half_t) );

		/* sync and free */
		vbx_sync();
		vbx_sp_free();
	}
#else
		int i;
		const int n = 1 << m;
		for (i=0; i<n/2; i++) {
			tw_r[i] =  Sinewave[i+n/4];
			tw_i[i] = -Sinewave[i];
			if (inverse)
				tw_i[i] = -tw_i[i];
		}
#endif

}

#if 0
void vector_fix_fft_untangle_real( short fr[], short fi[], int m, int inverse)
{	int n,j=0;
	short even_r, even_i, odd_r, odd_i, wr, wi, tempA, tempB;
        const int N = 1<<m;

	//untangle
	for(n= N/2; n; n--){
		even_r =  fr[n] + fr[N-n];
		even_i =  fi[n] - fi[N-n];
		odd_r  =  fi[n] + fi[N-n];
		odd_i  = -fr[n] + fr[N-n];

		wr =  (short)( 32767. * sin( (j    ) *(3.1415926535)/N) );
		wi =  (short)(-32767. * sin( (j+N/2) *(3.1415926535)/N) );
		j=j+1;

		if (inverse){
			wr=-wr;
		}

		tempA = FIX_MULT(odd_r, wr) - FIX_MULT(odd_i,wi);
                tempB = FIX_MULT(odd_i, wr) + FIX_MULT(odd_r,wi);

		fr[n]   =  ( even_r + tempA) >>1;
		fi[n]   =  ( even_i + tempB) >>1;
		fr[N-n] =  ( even_r - tempA) >>1;
		fi[N-n] =  (-even_i + tempB) >>1;
	}

	//zero values
	if (!inverse){
		even_r = fr[0];
		fr[0] = fr[0] + fi[0]; // A'= A+B
		fi[0] = even_r -fi[0]; // B'= A-B
	} else{
		even_r = fr[0];
		fr[0] = (fr[0] + fi[0]) >>1; // A'+ B' = (A+B) + (A-B) = 2A
		fi[0] = (even_r -fi[0]) >>1; // A'- B' = (A+B) - (A-B) = 2B
	}
}
#endif

void vector_fix_fft_untangle_real_scratch( vptr_half v_fr, vptr_half v_fi, vptr_half v_rfr, vptr_half v_rfi, vptr_half v_twr,vptr_half v_twi, int m, int inverse)
{	int n,j=0;
	short even_r, even_i, odd_r, odd_i, wr, wi, tempA, tempB;
        const int N = 1<<m;
#if 1
	//untangle
	//reverse fr and fi
        vbx_vector_reverse_half_fast(v_rfr,v_fr,N);
        vbx_vector_reverse_half_fast(v_rfi,v_fi,N);
        //add halves put in reverse vector
        vbx_set_vl(N/2);
        vbx(VVWH, VADD, v_rfr,    v_fr,    v_rfr);
        vbx(VVWH, VSUB, v_rfi,    v_fi,    v_rfi);
        vbx(VVWH, VSUB, v_rfr+1, v_rfr+1, v_fi+1);
        vbx(VVWH, VADD, v_rfi+1, v_rfi+1, v_fi+1);
        //mult odd*twiddle
        vbx(VVWH, VMULFXP, v_rfr+1, v_rfr+1, v_twr);
        vbx(VVWH, VMULFXP, v_rfi+1, v_rfi+1, v_twi);
        //add even+odd*twiddle
        vbx(VVH, VADD, v_fr, v_rfr, v_rfr+1);
        vbx(VVH, VADD, v_fi, v_rfi, v_rfi+1);
        //sub even-odd*twiddle
        vbx(VVH, VSUB, v_fr+N/2, v_rfr, v_rfr+1);
        vbx(VVH, VSUB, v_fi+N/2, v_rfi, v_rfi+1);
        //reverse 2nd half
        vbx_vector_reverse_half_fast(v_fr+N/2,v_fr+N/2,N/2);
        vbx_vector_reverse_half_fast(v_fi+N/2,v_fi+N/2,N/2);
#else
        //untangle
        for(n= N/2; n; n--){
		even_r =  fr[n] + fr[N-n];
		even_i =  fi[n] - fi[N-n];
		odd_r  =  fi[n] + fi[N-n];
		odd_i  = -fr[n] + fr[N-n];

		wr =  (short)( 32767. * sin( (j    ) *(3.1415926535)/N) );
		wi =  (short)(-32767. * sin( (j+N/2) *(3.1415926535)/N) );
		j=j+1;

		if (inverse){
			wr=-wr;
		}

		tempA = FIX_MULT(odd_r, wr) - FIX_MULT(odd_i,wi);
                tempB = FIX_MULT(odd_i, wr) + FIX_MULT(odd_r,wi);

		fr[n]   =  ( even_r + tempA) >>1;
		fi[n]   =  ( even_i + tempB) >>1;
		fr[N-n] =  ( even_r - tempA) >>1;
		fi[N-n] =  (-even_i + tempB) >>1;
	}

	//zero values
	if (!inverse){
		even_r = fr[0];
		fr[0] = fr[0] + fi[0]; // A'= A+B
		fi[0] = even_r -fi[0]; // B'= A-B
	} else{
		even_r = fr[0];
		fr[0] = (fr[0] + fi[0]) >>1; // A'+ B' = (A+B) + (A-B) = 2A
		fi[0] = (even_r -fi[0]) >>1; // A'- B' = (A+B) - (A-B) = 2B
	}
#endif
}

/* takes in precomputed bfly - input+bfly alaready in scratch*/
static int vector_fix_fft_dif_long_fly_scratch(vptr_half v_fr, vptr_half v_fi, vptr_half v_fr2, vptr_half v_fi2, vptr_half v_twr, vptr_half v_twi, vptr_half v_temp, short m, short inverse, short real)
{
#if 1
        if(real){
            vector_fix_fft_untangle_real_scratch( v_fr, v_fi, v_fr2, v_fi2, v_twr,v_twi, m, inverse);
        }
#endif
        int i, j, l, k, scale, shift,mul,flight,swap,row_num;
	short  wr, wi;

	vptr_half v_swap, v_twr2, v_twi2;
	vptr_half v_arp, v_aip, v_brp, v_bip, v_crp, v_cip,v_drp,v_dip ;

	const int n = 1 << m;

	scale = 0;
	mul = 0;
	swap = m >> 1;

	l = m-1;
	flight = 1;

	v_twr2 =  &v_twr[n/2];
	v_twi2 =  v_twi;

	const int INROWS = 1<<swap;
	const int INCOLS = 1<<(m-swap);

	if ( !(m%2) ){
		swap--;
	}

	while (l > swap) {
		if (inverse) {
			// variable scaling, depending upon data
			shift = 0;
			if( isAbsOutOfRangeV(v_fr,v_fi,v_temp,n/2) ) {
				shift = 1;
				scale++;
			} else if( isAbsOutOfRangeV(&v_fr[n/2],&v_fi[n/2],v_temp,n/2) ) {
				shift = 1;
				scale++;
			}
		} else {
			// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		SWAP( v_fr, v_fr2, v_swap );
		SWAP( v_fi, v_fi2, v_swap );

		if (shift){
			vbx_set_vl( n ); //vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<(l+1)), 0, sizeof(vbx_half_t)*(1<<(l+1)) );
			vbx(SVH,VSHR,  v_fr2, 1,  v_fr2 );
			vbx(SVH,VSHR,  v_fi2, 1,  v_fi2 );
		}
		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1) );
		vbx_2D( VVH, VADD, v_fr, v_fr2, v_fr2 + (1<<l) );
		vbx_2D( VVH, VADD, v_fi, v_fi2, v_fi2 + (1<<l) );

		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1) );
		vbx_2D( VVH, VSUB, v_fr2, v_fr2, v_fr2 + (1<<l) );
		vbx_2D( VVH, VSUB, v_fi2, v_fi2, v_fi2 + (1<<l) );

		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l+1), 0 );
		vbx_2D( VVH, VMULFXP, &v_fr[n>>1],  v_fr2,      v_twr );
		vbx_2D( VVH, VMULFXP,  v_temp,      v_fi2,      v_twi );

		vbx_set_vl(n/2);//vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VSUB,    &v_fr[n>>1], &v_fr[n>>1], v_temp );

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l+1), 0 );
		vbx_2D( VVH, VMULFXP, &v_fi[n>>1],  v_fi2,      v_twr );
		vbx_2D( VVH, VMULFXP,  v_temp,      v_fr2,      v_twi );

		vbx_set_vl(n/2); //vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VADD,    &v_fi[n>>1], &v_fi[n>>1], v_temp );

		l--;
		mul++;
		flight <<= 1;

		if( l > swap ) {
			vbx_set_vl( 1<<l );
			vbx( VVWH, VMOV, v_twr, v_twr, 0 );
			vbx( VVWH, VMOV, v_twi, v_twi, 0 );

			if (l == m-2){
				vbx( VVH, VMOV, &v_twr[n/4], v_twi, 0 );
				v_twi = &v_twr[n/4];
			}
		}
	}

	if ( !(m%2) ) {
		l++;
		flight >>=1;
	}

	SWAP( v_fr, v_fr2, v_swap );
	SWAP( v_fi, v_fi2, v_swap );

	/* VECTORIZED MATRIX TRANSPOSE */
	vbx_set_2D( INCOLS, INROWS*sizeof(vbx_half_t), sizeof(vbx_half_t), sizeof(vbx_half_t) );
	vbx_set_vl( 1 );
	for( row_num=0; row_num<INROWS; row_num++ ) {
		vbx_2D( VVHU, VMOV, v_fi+row_num, v_fi2+row_num*INCOLS, 0 );
		vbx_2D( VVHU, VMOV, v_fr+row_num, v_fr2+row_num*INCOLS, 0 );
	}

	mul = 1;
	while (l < m) {
		if (inverse) {
			/* variable scaling, depending upon data */
			shift =0;
			if( isAbsOutOfRangeV(v_fr,v_fi,v_temp,n/2) ) {
				shift = 1;
				scale++;
			} else if( isAbsOutOfRangeV(&v_fr[n/2],&v_fi[n/2],v_temp,n/2) ) {
				shift = 1;
				scale++;
			}
		} else {
			/* fixed scaling, for proper normalization */
			shift = 1;
		}

		SWAP( v_fr, v_fr2, v_swap );
		SWAP( v_fi, v_fi2, v_swap );

		if (shift){
			vbx_set_vl( n );//vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<(l+1)), 0, sizeof(vbx_half_t)*(1<<(l+1)) );
			vbx(SVH,VSHR,  v_fr2,         1,  v_fr2         );
			vbx(SVH,VSHR,  v_fi2,         1,  v_fi2         );
		}
		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VADD, v_fr, v_fr2, v_fr2 + (n>>1) );
		vbx_2D( VVH, VADD, v_fi, v_fi2, v_fi2 + (n>>1) );

		vbx_set_vl (n/2);//vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VSUB, v_fr2, v_fr2, v_fr2 + (n>>1) );
		vbx( VVH, VSUB, v_fi2, v_fi2, v_fi2 + (n>>1) );

		vbx_set_vl( 1<<l );
		for( k=0; k<flight; k++ ) {
                	vbx(  SVH, VMOV, &v_twr2[ k<<l ], v_twr[ k<<mul], 0 );
                	vbx(  SVH, VMOV, &v_twi2[ k<<l ], v_twi[ k<<mul], 0 );
		}

		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VMULFXP, &v_fr[1<<l],  v_twr2,      v_fr2 );
		vbx_2D( VVH, VMULFXP, &v_fi[1<<l],  v_twr2,      v_fi2 );

		vbx_set_vl( n/2 );//vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VMULFXP,  v_temp,      v_twi2,      v_fi2 );

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VSUB,    &v_fr[1<<l], &v_fr[1<<l], v_temp );

		vbx_set_vl( n/2 );//vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l), sizeof(vbx_half_t)*(1<<l) );
		vbx( VVH, VMULFXP,  v_temp,      v_twi2,     v_fr2 );

		vbx_set_vl( 1<<l );
		vbx_set_2D( flight, sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l+1), sizeof(vbx_half_t)*(1<<l) );
		vbx_2D( VVH, VADD,    &v_fi[1<<l], &v_fi[1<<l], v_temp );

		l++;
		mul++;
		flight >>=1;
	}

	vbx_set_vl(n);
	vbx( VVH, VMOV, v_fr2, v_fr, 0 );
	vbx( VVH, VMOV, v_fi2, v_fi, 0 );

	return scale;
}

/* compute fft for N samples larger than vector scratchpad allows
   call N/2 fft on even and odd pnts -- then combine w/ twiddle factors */
int vector_fix_fft_large_scratch(short *fr, short *fi, short *fr2, short *fi2, short *tw_r, short *tw_i, short m, short inverse, short real)
{

	int scale = 0, scale0, scale1, scaleC=0, shift, n = 1 << m;

	/* alloc space in scratchpad -- uses 8N bytes */
	vptr_half v_1, v_2, v_3, v_4;
	vptr_half v_full_r, v_full_i;
	vptr_half v_even_r, v_even_i, v_odd_r, v_odd_i;
	vptr_half v_tw_r, v_tw_i, v_tw_r2, v_tw_i2;
	vptr_half v_a, v_b, v_c;

	v_1  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_2  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_3  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_4  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	if( v_1 == NULL || v_2 == NULL || v_3 == NULL || v_4 == NULL ){
	 	VBX_EXIT(-1);
	}

	v_even_r = v_1;
	v_odd_r = &v_1[n/2];
	v_even_i = v_2;
	v_odd_i = &v_2[n/2];
	v_full_r = v_3;
	v_full_i = v_4;

	v_tw_r = v_3;
	v_tw_i = &v_3[n/2];
	v_c = &v_3[3*n/4];

	v_a = v_4;
	v_b = &v_4[n/2];

	/*DMA in fr,fi,twr,twi - setup even,odd and half bflys*/
	vbx_dma_to_vector( v_full_r, fr, n*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_full_i, fi, n*sizeof(vbx_half_t) );
	/* split up fr,fi into even,odd*/
	vbx_set_vl( n/2 );
	vbx( VVWH, VMOV, v_even_r, v_full_r, 0 );
	vbx( VVWH, VMOV, v_odd_r,  v_full_r+1, 0 );
	vbx( VVWH, VMOV, v_even_i, v_full_i, 0 );
	vbx( VVWH, VMOV, v_odd_i,  v_full_i+1, 0 );
	/* create 1/2 butterflies */
	vbx_dma_to_vector( v_tw_r, tw_r, n/2*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_tw_i, tw_i, n/2*sizeof(vbx_half_t) );
	vbx_set_vl( n/4 );
	vbx( VVWH, VMOV, v_tw_r, v_tw_r, 0 );
	//vbx( VVH, VMOV, &v_tw_r[n/4], v_tw_r, 0 ); // extra copy of reduced real twiddle for second fft
	vbx( VVWH, VMOV, v_tw_i, v_tw_i, 0 );
	scale0 = vector_fix_fft_dif_long_fly_scratch( v_even_r, v_even_i, v_a, v_b, v_tw_r, v_tw_i, v_c, m-1, inverse, real);
	/* recreate 1/2 butterflies */
	vbx_dma_to_vector( v_tw_i, tw_i, n/2*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_tw_r, tw_r, n/2*sizeof(vbx_half_t) );
	vbx_set_vl( n/4 );
	//vbx( VVH, VMOV, v_tw_r, &v_tw_r[n/4], 0 ); // move extra copy into place... faster than changing pointers
	vbx( VVWH, VMOV, v_tw_r, v_tw_r, 0 );
	vbx( VVWH, VMOV, v_tw_i, v_tw_i, 0 );
	scale1 = vector_fix_fft_dif_long_fly_scratch( v_odd_r,  v_odd_i,  v_a, v_b, v_tw_r, v_tw_i, v_c, m-1, inverse, real);
	vbx_dma_to_vector( v_tw_r, tw_r, n/2*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_tw_i, tw_i, n/2*sizeof(vbx_half_t) );
	/* ensure both halves equally scaled */
	if (scale0 != scale1){
			vbx_set_vl(n/2);
			if (scale0 > scale1){
				scale = scale0;
				vbx( SVH, VSHR,  v_odd_r, (scale0-scale1), v_odd_r );
				vbx( SVH, VSHR,  v_odd_i, (scale0-scale1), v_odd_i );
			} else {
				scale = scale1;
				vbx( SVH, VSHR,  v_even_r, (scale1-scale0), v_even_r );
				vbx( SVH, VSHR,  v_even_i, (scale1-scale0), v_even_i );
			}
	} else {
		scale = scale0;
	}
	/* combine results */
	if (inverse) {
		/* variable scaling, depending upon data */
		shift = 0;
		if( isAbsOutOfRangeV( v_even_r, v_even_i, v_a, n/2 ) ) {
			shift = 1;
			scaleC++;
		} else if ( isAbsOutOfRangeV( v_odd_r, v_odd_i, v_a, n/2 ) ){
			shift = 1;
			scaleC++;
		}
	} else {
		/* fixed scaling, for proper normalization */
		shift = 1;
	}
	/*scale even,odd if neccessary */
	vbx_set_vl( n/2 );
	if( shift ){
		vbx( SVH, VSHR,  v_odd_r, 1, v_odd_r );
		vbx( SVH, VSHR,  v_odd_i, 1, v_odd_i );
		vbx( SVH, VSHR,  v_even_r, 1, v_even_r );
		vbx( SVH, VSHR,  v_even_i, 1, v_even_i );
	}
	/* complex multiply twiddle*odd */
	vbx( VVH, VMULFXP, v_4,       v_odd_r, v_tw_r); // A = FIX_MULT(oddr,twr)
	vbx( VVH, VMULFXP, &v_4[n/2], v_odd_i, v_tw_i); // B = FIX_MULT(oddi,twi)
	vbx( VVH, VSUB, v_4, v_4, &v_4[n/2] );          // real = A - B
	vbx( VVH, VMULFXP, v_tw_r,  v_odd_i, v_tw_r );  // C = FIX_MULT(oddi,twr)
	vbx( VVH, VMULFXP, v_tw_i,  v_odd_r, v_tw_i );  // D = FIX_MULT(oddr,twi)
	vbx( VVH, VADD, v_3, v_tw_r, v_tw_i );          // imag = C + D
	/* sub + send 2nd half --even - tw*odd */
	vbx( VVH, VSUB,  &v_1[n/2], v_even_r, v_4 );
	vbx( VVH, VSUB,  &v_2[n/2], v_even_i, v_3 );
	/* add + send 1st half --even + tw*odd */
	vbx( VVH, VADD,  v_1, v_even_r, v_4 );
	vbx( VVH, VADD,  v_2, v_even_i, v_3 );
	/* DMA out fr,fi */
	vbx_dma_to_host( fr2, v_1, n*sizeof(vbx_half_t) );
	vbx_dma_to_host( fi2, v_2, n*sizeof(vbx_half_t) );
	vbx_sync();
	vbx_sp_free();

	scale = scale + scaleC;
	return scale;
}

/* compute fft for N samples larger than vector scratchpad allows
   call N/2 fft on even and odd pnts -- then combine w/ twiddle factors */
int vector_fix_fft_large(short *fr, short *fi, short *fr2, short *fi2, short *tw_r, short *tw_i, short m, short inverse, short real, short *mem)
{

	int scale = 0, scale0,scale1, n = 1 << m;
	short *even_fr,*even_fi,*odd_fr,*odd_fi,*even_fr2,*even_fi2,*odd_fr2,*odd_fi2,*tw_r2,*tw_i2;

	/* alloc even,odd src/dest and 1/2 bfly arrays */
	even_fr  = &mem[0*n/2];
	even_fi  = &mem[1*n/2];
	odd_fr   = &mem[2*n/2];
	odd_fi   = &mem[3*n/2];
	even_fr2 = &mem[4*n/2];
	even_fi2 = &mem[5*n/2];
	odd_fr2  = &mem[6*n/2];
	odd_fi2  = &mem[7*n/2];
	tw_r2    = &mem[8*n/2];
	tw_i2    = &mem[17*n/4];

	/* split up fr,fi into even,odd, and create 1/2 butterflies */
	vector_split(fr, fi, even_fr, even_fi, odd_fr, odd_fi, tw_r, tw_i, tw_r2, tw_i2, m); // requires

	/* if N/2 still great than max N, split and call this function again, otherwise calulate two 1/2 ffts */
	if ( n > (VBX_SCRATCHPAD_SIZE >> 2) ){
		scale0 = vector_fix_fft_large( even_fr, even_fi, even_fr2, even_fi2, tw_r2, tw_i2, m-1, inverse, real, &mem[ (9*n/2) ] );
		scale1 = vector_fix_fft_large(  odd_fr,  odd_fi,  odd_fr2,  odd_fi2, tw_r2, tw_i2, m-1, inverse, real, &mem[ (9*n/2) + (9*n/4) ] );
	} else{
		scale0 = vector_fix_fft_large_scratch( even_fr, even_fi, even_fr2, even_fi2, tw_r2, tw_i2, m-1, inverse,real);
		scale1 = vector_fix_fft_large_scratch(  odd_fr,  odd_fi,  odd_fr2,  odd_fi2, tw_r2, tw_i2, m-1, inverse,real);
	}

	/* ensure both halves equally scaled */
	if (scale0 != scale1){
			if (scale0 > scale1){
				vector_large_scale(odd_fr2,  odd_fi2, scale0 - scale1 , m);
				scale = scale0;
			} else {
				vector_large_scale(even_fr2, even_fi2, scale1-scale0, m);
				scale = scale1;
			}
	} else {
		scale = scale0;
	}

	/* combine results */
	scale0= vector_combine( even_fr2, even_fi2, odd_fr2, odd_fi2, tw_r, tw_i, fr2, fi2, m, inverse);
	scale = scale + scale0;

	return scale;
}

int vector_fix_fft_large_init(short fr[], short fi[], short fr2[], short fi2[], short tw_r[], short tw_i[], short m, short inverse, short real, short* large_mem)
{
	int scale = 0;
	const int n = 1 << m;

	if (real){
		short *real_fr = fr, *real_fi = &fr[n/2], *real_fr2 = fr2 , *real_fi2 = &fr2[n/2];
		if( inverse){
			//scalar_fix_fft_untangle_real( real_fr, real_fi, m-1, inverse);
		}

		/* call main function */
		if (n > (VBX_SCRATCHPAD_SIZE >> 2) ){
			scale = vector_fix_fft_large(real_fr, real_fi, real_fr2, real_fi2, tw_r, tw_i, m-1, inverse, real, large_mem);
		}else if (n > (VBX_SCRATCHPAD_SIZE >> 3) ){
			scale = vector_fix_fft_large_scratch(real_fr, real_fi, real_fr2, real_fi2, tw_r, tw_i, m-1, inverse, real);
		}else {
			scale = vector_fix_fft_dif_long_fly (real_fr, real_fi, real_fr2, real_fi2, tw_r, tw_i, m-1, inverse, real);
		}
		if(!inverse){
			//scalar_fix_fft_untangle_real( real_fr2, real_fi2, m-1, inverse);
		}

	} else {
		/* call main function */
		if(n > (VBX_SCRATCHPAD_SIZE >> 3 ) ){
			scale = vector_fix_fft_large(fr, fi, fr2, fi2, tw_r, tw_i, m, inverse, real, large_mem);
		}else if (n > (VBX_SCRATCHPAD_SIZE >> 4 ) ){
			scale = vector_fix_fft_large_scratch(fr, fi, fr2, fi2, tw_r, tw_i, m, inverse, real);
		}else{
			scale = vector_fix_fft_dif_long_fly (fr, fi, fr2, fi2, tw_r, tw_i, m, inverse, real);
		}
	}

	return scale;
}
