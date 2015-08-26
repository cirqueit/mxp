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
VBXCOPYRIGHT( test_fft_vector )

/* fft_vector.c - Fixed-point in-place Fast Fourier Transform  */
/*
  All data are fixed-point short integers, in which -32768
  to +32768 represent -1.0 to +1.0 respectively.

  For FFT (time -> freq), fixed scaling is prevents arithmetic
  overflow, and to map a 0dB sine/cosine wave (i.e. amplitude = 32767)
  to two -6dB freq coefficients. The return value is always 0.

  For IFFT (freq -> time), fixed scaling cannot be done, as two 0dB
  coefficients would sum to a peak amplitude of 64K, overflowing the
  fixed-point integers. So variable scaling is performed, and
  returns a value which is the number of bits the output must be
  shifted left to get the actual amplitude
  (i.e. if fix_fft() returns 3, each value of fr[] and fi[]
  must be multiplied by 8 (2**3) for proper scaling.)
  Clearly, this cannot be done within fixed-point short
  integers. In practice, if the result is to be used as a
  filter, the scale_shift can usually be ignored, as the
  result will be approximately correctly normalized as is.

  Written by:  Tom Roberts  11/8/89
  Made portable:  Malcolm Slaney 12/15/94 malcolm@interval.com
  Enhanced:  Dimitrios P. Bouras  14 Jun 2006 dbouras@ieee.org
*/

#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#include "vbx.h"
#include "vbx_port.h"
#include "vbx_common.h"

#include "fft.h"

typedef vbx_uword_t* vptr_uword;
typedef vbx_uhalf_t* vptr_uhalf;
typedef vbx_ubyte_t* vptr_ubyte;
typedef vbx_word_t* vptr_word;
typedef vbx_half_t* vptr_half;
typedef vbx_byte_t* vptr_byte;

#define TIME_SHIFT 193
#ifdef TIME
  #define FFT_START(A)   do{ A -= vbx_timestamp() + TIME_SHIFT; }while(0)
  #define FFT_CHANGE(A,B) do{ vbx_sync(); int __ts__ = vbx_timestamp(); A += __ts__; B -= __ts__ + TIME_SHIFT; }while(0)
  #define FFT_END(A)     do{ A += vbx_timestamp(); }while(0)
#else
  #define FFT_START(A)    do { } while(0)
  #define FFT_CHANGE(A,B) do { } while(0)
  #define FFT_STOP(A)     do { } while(0)
#endif

#define SWAP(x1,x2,tmp) do { tmp=x1; x1=x2; x2=tmp; } while(0)

// attempt at rounding another way - this is a work-in-progress
static void foo()
{
#if 0
	// compute 15 MSB of solution
	vbx( SVHW, VMUL,   v_temp1,    tw, v_src   );
	vbx( SVWW, VSHL,   v_temp1,     1, v_temp1 );
	// compute the rounding bit
	vbx( SVWHU, VSHR,  v_dest,      15, v_temp1 );
	vbx( VVWH,  VMOV,  v_temp1, v_temp1,      0 );
	vbx( VVHWU, VADD,  v_dest,      15, v_temp1 );
#endif
}

// fix_mult() - fixed-point multiplication & scaling. Scaling ensures that result remains 16-bit.
static inline void vector_fix_mult_round( vptr_half v_dest, vptr_half v_src, short tw, vptr_half v_temp1 )
{
	// compute 15 MSB of solution
	vbx( SVH, VMULHI, v_dest,     tw, v_src   );
	vbx( SVH, VSHL,   v_dest,      1, v_dest  );

#if ROUND

	// compute 1 LSB of solution and rounding bit
	vbx( SVH,  VMULLO,  v_temp1,    tw, v_src   );
	vbx( SVHU, VSHR,    v_temp1,    14, v_temp1 );

	// Now, v_temp1 holds the 2 MSB of MULLO.
	//
	// The 2 MSB of MULLO represents 1 LSB of solution,
	// to be shifted in. The other bit is a rounding bit
	// to be added to the solution.
	// There are 4 cases to round:
	//    00 --> add 0 --> add 00=0, subtract MSB=0
	//    01 --> add 1 --> add 01=1, subtract MSB=0
	//    10 --> add 1 --> add 10=2, subtract MSB=1
	//    11 --> add 2 --> add 11=3, subtract MSB=1

	// add both LSB and rounding bit to solution
	// this adds 0,1,2,3 to solution
	vbx( VVH, VADD,   v_dest, v_dest, v_temp1 );
	// remove rounding excess
	vbx( SVH, VSHR,   v_temp1,     1, v_temp1 );
	vbx( VVH, VSUB,   v_dest, v_dest, v_temp1 );
#endif
}

static inline void vector_fix_mult2_round( vptr_half v_dest, vptr_half v_src, vptr_half v_tw, vptr_half v_temp1 )
{
	vbx( VVH, VMULHI, v_dest,  v_tw, v_src  );
	vbx( SVH, VSHL,   v_dest,     1, v_dest );

#if ROUND

	// compute 1 LSB of solution and rounding bit
	vbx( VVH,  VMULLO,  v_temp1,  v_tw, v_src   );
	vbx( SVHU, VSHR,    v_temp1,    14, v_temp1 );

	// add both LSB and rounding bit to solution
	// this adds 0,1,2,3 to solution
	vbx( VVH, VADD,   v_dest, v_dest, v_temp1 );

	// remove rounding excess
	vbx( SVH, VSHR,   v_temp1,     1, v_temp1 );
	vbx( VVH, VSUB,   v_dest, v_dest, v_temp1 );
#endif
}

static inline void vector_fix_mult( vptr_half v_dest, vptr_half v_src, short tw )
{
	//no rounding in version
	vbx( SVH, VMULHI, v_dest, tw, v_src  );
	vbx( SVH, VSHL,   v_dest,  1, v_dest );
}

static inline void vector_fix_mult2( vptr_half v_dest, vptr_half v_src, vptr_half v_tw )
{
	//no rounding in version
	vbx( VVH, VMULHI, v_dest,  v_tw, v_src  );
	vbx( SVH, VSHL,   v_dest,     1, v_dest );
}

#if 0
static int isAbsOutOfRange( short fr[], short fi[], int n )
{
	// needs vectorizing -- used for inverse only
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
#endif

static int isAbsOutOfRangeV( vptr_half v_src_r, vptr_half v_src_i, vptr_half v_temp, int n )
{

	vbx_set_vl(n);
	vbx(SVH, VABSDIFF, v_temp, 0, v_src_r );    // get abs value of reals
	vbx(SVH, VSUB, v_temp, 16383, v_temp );  // if (16383 - v_src) < 0, needs scaling
	vbx_acc(SVH,VCMV_LTZ,v_temp,1,v_temp ); // accum # of neg values to see if scaling required
	vbx_sync();
	if( v_temp[0] ){
		return 1;
	}

	vbx(SVH, VABSDIFF, v_temp, 0, v_src_r );    // get abs value of imag
	vbx(SVH, VSUB,v_temp,16383, v_temp );  // if (16383 - v_src) < 0, needs scaling
	vbx_acc(SVH,VCMV_LTZ,v_temp,1,v_temp ); // accum # of neg values to see if scaling required
	vbx_sync();
	if( v_temp[0] ){
		return 1;
	}

	return 0;
}

int vector_fix_fft_dif_long(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse, short real)
{
	int add_time=0, mult_time=0, dma_time=0, matrix_time=0, bfly_gen_time=0, bfly_reduce_time=0, interleave_time=0, misc_time=0;

	int i, j, l, k, scale, shift, a1,a2,bfly,mul,flight,swap,row_num;
	short  wr, wi;

	vptr_half v_tt, v_ar, v_ai;
	vptr_half v_fr, v_fi, v_fr2, v_fi2, v_tmp;
	vptr_half v_bfr, v_bfi;
	vptr_half v_arp, v_aip, v_brp, v_bip, v_crp, v_cip;
	vptr_half v_temp;

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
	v_ar = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	v_ai = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	v_tt = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );

	v_bfr   = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );
	v_bfi   = (vptr_half)vbx_sp_malloc( half*sizeof(vbx_half_t) );

	v_temp = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );


	v_fr  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_fi  = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_fr2 = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );
	v_fi2 = (vptr_half)vbx_sp_malloc( n*sizeof(vbx_half_t) );

	if( v_ar  == NULL || v_ai == NULL  || \
	    v_bfr == NULL || v_bfi == NULL || \
	    v_fr  == NULL || v_fi == NULL  || \
	    v_fr2 == NULL || v_fi2== NULL  || \
	    v_tt == NULL  || v_temp == NULL ) {
	 	VBX_EXIT(-1);
	}


#if DMA
	vbx_dma_to_vector( v_fr, fr, n*sizeof(vbx_half_t) );
	vbx_dma_to_vector( v_fi, fi, n*sizeof(vbx_half_t) );
#endif

#if INTER
	//interleave data if real fft
	if(!inverse && real){
		vbx_set_vl( n );
		vbx( SEH, VAND,    	v_fr2, 		0x1,      	0 );     //0,1,0,1,0,1... odd elements == 1
		vbx( VVH, VMOV,    	v_fi2,  	v_fi,     	0 );     // contains copy of fr
		vbx( VVH, VCMV_NZ, 	v_fi,  		v_fr-1,  	v_fr2 ); // puts even fr into odd fi
		vbx( VVH, VCMV_NZ, 	v_fr-1, 	v_fi2, 		v_fr2 ); // puts odd fi into even fr
	}
#endif

#if GEN
	// generate initial butterfly list @ length n/2 -reduced each iteration after stockham operations
	vbx_dma_to_vector( v_fr2, Sinewave, 3*n/4 * sizeof(vbx_half_t) );
	vbx_set_vl( bfly );
	vbx( VVH, VMOV, v_bfr, v_fr2 + n/4, 0 );
	vbx( VVH, VMOV, v_bfi, v_fr2           , 0 );
	if( !inverse ) {
		vbx( SVH, VMULLO, v_bfi, -1, v_bfi );
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

		vbx_set_vl(bfly);

		for( k=0; k<flight; ++k ) {

			a1 = k  << l; // j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			// VECTORIZED INNER LOOP - STOCKHAM DIF
#if ADD
			// shift if neccessary, add va,vb , sub va,vb
			v_arp = &( v_fr2[a2] );
			v_brp = &( v_fr2[a2+bfly] );
			v_crp = &( v_fr[a1] );
			if( shift ) {
				vbx( SVH, VSHR,  v_ar, 1, v_arp );     // ar >>= 1
				vbx( SVH, VSHR,  v_tt, 1, v_brp );     // br >>= 1
				vbx( VVH, VADD, v_crp, v_ar, v_tt );   // fr[ a1 + i ] = ar + br
				vbx( VVH, VSUB,  v_ar, v_ar, v_tt );	  // ar = ar - br
			} else {
				vbx( VVH, VADD, v_crp, v_arp, v_brp ); // fr[ a1 + i ] = ar + br
				vbx( VVH, VSUB,  v_ar, v_arp, v_brp ); // ar = ar - br
			}

			v_aip = &( v_fi2[a2] );
			v_bip = &( v_fi2[a2+bfly] );
			v_cip = &( v_fi[a1] );
			if( shift ) {
				vbx( SVH, VSHR,  v_ai, 1, v_aip );      // ai >>= 1
				vbx( SVH, VSHR,  v_tt, 1, v_bip );      // bi >>= 1
				vbx( VVH, VADD, v_cip, v_ai, v_tt );    // fi[ a1 + i ] = ai + bi
				vbx( VVH, VSUB,  v_ai, v_ai, v_tt );	   // ai = ai - bi
			} else {
				vbx( VVH, VADD, v_cip, v_aip, v_bip );  // fi[ a1 + i ] = ai + bi
				vbx( VVH, VSUB,  v_ai, v_aip, v_bip );  // ai = ai - bi
			}
#endif
#if MULT

			// complex multiply va,twiddle
			v_crp = &( v_fr[a1+half] );
			vector_fix_mult2_round(  v_crp,  v_ar, v_bfr, v_temp );  // FIX_MULT(ar,wr)
			vector_fix_mult2_round(   v_tt,  v_ai, v_bfi, v_temp );  // FIX_MULT(ai,wi)
			vbx( VVH, VSUB, v_crp, v_crp, v_tt  );  // fr[ a1 + half + i ] = FIX_MULT(ar,wr) - FIX_MULT(ai,wi)

			v_cip = &( v_fi[a1+half] );
			vector_fix_mult2_round(  v_cip,  v_ai, v_bfr, v_temp );  // FIX_MULT(ai,wr)
			vector_fix_mult2_round(   v_tt,  v_ar, v_bfi, v_temp );  // FIX_MULT(ar,wi)
			vbx( VVH, VADD, v_cip, v_cip, v_tt  );  // fi[ a1 + half + i  ] = FIX_MULT(ai,wr) + FIX_MULT(ar,wi)
#endif
		}

		l--;
		mul++;
		flight <<= 1;
		bfly >>= 1;

#if REDUCE
		if( l > swap ) {
			vbx_set_vl( bfly );
			vbx( VVWH, VMOV, v_bfr, v_bfr, 0 );
			vbx( VVWH, VMOV, v_bfi, v_bfi, 0 );
		}
#endif
	}

	if ( !(m%2) ) {
		l++;
		flight >>=1;
		bfly <<= 1;
	}

	SWAP( v_fr, v_fr2, v_tmp );
	SWAP( v_fi, v_fi2, v_tmp );

#if MATRIX
	//VECTORIZED MATRIX TRANSPOSE
	vbx_set_2D( INCOLS, INROWS*sizeof(vbx_half_t), sizeof(vbx_half_t), sizeof(vbx_half_t) );
	vbx_set_vl( 1 );
	for( row_num=0; row_num<INROWS; row_num++ ) {
		vbx_2D( VVHU, VMOV, v_fi+row_num, v_fi2+row_num*INCOLS, 0 );
		vbx_2D( VVHU, VMOV, v_fr+row_num, v_fr2+row_num*INCOLS, 0 );
	}

#endif
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

		vbx_set_vl(bfly);

		for (k=0; k<flight; ++k) {
			j = k << mul;
			wr =  Sinewave[j+n/4];
			wi = -Sinewave[j];
			if (inverse)
				wi = -wi;

			a1 = k  << l; // j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			// VECTORIZED INNER LOOP - STOCKHAM DIT
#if ADD
			// shift if neccessary, add va,vb , sub va,vb
			v_arp = &( v_fr2[a1] );
			v_brp = &( v_fr2[a1+half] );
			v_crp = &( v_fr[a2] );
			if( shift ) {
				vbx( SVH, VSHR,  v_ar, 1, v_arp );      // ar >>= 1
				vbx( SVH, VSHR,  v_tt, 1, v_brp );      // br >>= 1
				vbx( VVH, VADD, v_crp, v_ar, v_tt );    // fr[ a2 + i ] = ar + br
				vbx( VVH, VSUB,  v_ar, v_ar, v_tt );	   // ar = ar - br
			} else {
				vbx( VVH, VADD, v_crp, v_arp, v_brp );  // fr[ a2 + i ] = ar + br
				vbx( VVH, VSUB,  v_ar, v_arp, v_brp );  // ar = ar - br
			}

			v_aip = &( v_fi2[a1] );
			v_bip = &( v_fi2[a1+half] );
			v_cip = &( v_fi[a2] );
			if( shift ) {
				vbx( SVH, VSHR,  v_ai, 1, v_aip );      // ai >>= 1
				vbx( SVH, VSHR,  v_tt, 1, v_bip );      // bi >>= 1
				vbx( VVH, VADD, v_cip, v_ai, v_tt );    // fi[ a2 + i ] = ai + bi
				vbx( VVH, VSUB,  v_ai, v_ai, v_tt );	   // ai = ai - bi
			} else {
				vbx( VVH, VADD, v_cip, v_aip, v_bip );  // fi[ a2 + i ] = ai + bi
				vbx( VVH, VSUB,  v_ai, v_aip, v_bip );  // ai = ai - bi
			}
#endif
#if MULT
			// complex multiply va,twiddle
			v_crp = &( v_fr[a2+bfly] );
			vector_fix_mult_round( v_crp, v_ar, wr, v_temp );       // FIX_MULT(wr,ar)
			vector_fix_mult_round(  v_tt, v_ai, wi, v_temp );       // FIX_MULT(wi,ai)
			vbx( VVH, VSUB, v_crp, v_crp, v_tt );  // fr[ a2 + bfly + i ] = FIX_MULT(wr,ar) - FIX_MULT(wi,ai)

			v_cip = &( v_fi[a2+bfly] );
			vector_fix_mult_round( v_cip, v_ai, wr, v_temp );       // FIX_MULT(wr,ai)
			vector_fix_mult_round(  v_tt, v_ar, wi, v_temp );       // FIX_MULT(wi,ar)
			vbx( VVH, VADD, v_cip, v_cip, v_tt );  // fi[ a2 + bfly + i  ] = FIX_MULT(wr,ai) + FIX_MULT(wi,ar)
#endif

		}
		l++;
		mul++;
		flight >>=1;
		bfly <<=1;
	}

#if INTER
	//interleave result if real ifft
	if(inverse && real){
		vbx_set_vl( n );
		vbx( SEH, VAND,    	v_fr2, 		0x1,      	0 );     // 0,1,0,1,0,1... odd elements == 1
		vbx( VVH, VMOV,    	v_fi2,  	v_fi,     	0 );     // contains copy of fr
		vbx( VVH, VCMV_NZ, 	v_fi,  		v_fr-1,  	v_fr2 ); // puts even fr into odd fi
		vbx( VVH, VCMV_NZ, 	v_fr-1, 	v_fi2, 		v_fr2 ); // puts odd fi into even fr
	}
#endif

#if DMA
	vbx_dma_to_host( fr2,  v_fr, n*sizeof(vbx_half_t) );
	vbx_dma_to_host( fi2,  v_fi, n*sizeof(vbx_half_t) );
#endif
	vbx_sync();
	vbx_sp_free();

	return scale;
}


int vector_fix_fft_dif_real_gold(short f[],short f2[], int m, int inverse)
{
	int half = 1<<(m-1), scale = 0, real = 1;
	short *fr=f, *fi=&f[half], *fr2 =f2 , *fi2 = &f2[half];

#if UNTANGLE
	if (inverse)
		scalar_fix_fft_untangle_real( fr, fi, m-1, inverse);
#endif

	scale = vector_fix_fft_dif_long(fr, fi, fr2, fi2, m-1, inverse, real);

#if UNTANGLE
	if (! inverse)
		scalar_fix_fft_untangle_real( fr2, fi2, m-1, inverse);
#endif
	return scale;
}
