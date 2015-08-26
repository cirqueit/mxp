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

//
#include "vbx_copyright.h"
VBXCOPYRIGHT( test_fft_scalar )

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/alt_timestamp.h>

#include "fft.h"

/* fix_fft.c - Fixed-point in-place Fast Fourier Transform  */
/*
  All data are fixed-point short integers, in which -32768
  to +32768 represent -1.0 to +1.0 respectively. Integer
  arithmetic is used for speed, instead of the more natural
  floating-point.

  For the forward FFT (time -> freq), fixed scaling is
  performed to prevent arithmetic overflow, and to map a 0dB
  sine/cosine wave (i.e. amplitude = 32767) to two -6dB freq
  coefficients. The return value is always 0.

  For the inverse FFT (freq -> time), fixed scaling cannot be
  done, as two 0dB coefficients would sum to a peak amplitude
  of 64K, overflowing the 32k range of the fixed-point integers.
  Thus, the fix_fft() routine performs variable scaling, and
  returns a value which is the number of bits LEFT by which
  the output must be shifted to get the actual amplitude
  (i.e. if fix_fft() returns 3, each value of fr[] and fi[]
  must be multiplied by 8 (2**3) for proper scaling.
  Clearly, this cannot be done within fixed-point short
  integers. In practice, if the result is to be used as a
  filter, the scale_shift can usually be ignored, as the
  result will be approximately correctly normalized as is.

  Written by:  Tom Roberts  11/8/89
  Made portable:  Malcolm Slaney 12/15/94 malcolm@interval.com
  Enhanced:  Dimitrios P. Bouras  14 Jun 2006 dbouras@ieee.org
*/


/*
  FIX_MULT() - fixed-point multiplication & scaling.
  Substitute inline assembly for hardware-specific
  optimization suited to a particluar DSP processor.
  Scaling ensures that result remains 16-bit.
*/
static inline short FIX_MULT(short a, short b){
#if ROUND
	/* shift right one less bit (i.e. 15-1) */
	int c = ((int)a * (int)b) >> 14;

	/* last bit shifted out = rounding-bit */
	b = c & 0x01;
	/* last shift + rounding bit */
	a = (c >> 1) + b;

	return a;
#else
	int c = ((int)a * (int)b) >> 15;
	return c;
#endif
}


int scalar_fix_fft_dif(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse)
{
	int i, j, l, k, scale, shift,a1,a2,bfly,mul,flight;
	short  wr, wi, xr, xi, yr, yi;
	short *tmp;

	const int n = 1 << m;
	const int half = n >> 1;

	scale = 0;
	l = 0;
	flight = 1<<(m-1);
	bfly = 1;
	mul = 0;

	while (l < m) {
		if (inverse) {

			// variable scaling, depending upon data
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				k = fi[i];
				if (k < 0)
					k = -k;
				if (j > 16383 || k > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		// shift will be performed on each data point exactly once during pass
		tmp = fr;
		fr = fr2;
		fr2 = tmp;
		tmp = fi;
		fi = fi2;
		fi2 = tmp;


		for (k=0; k<flight; ++k) {
			j = k << mul;
			wr =  Sinewave[j+n/4];
			wi = -Sinewave[j];
			if (inverse)
				wi = -wi;

			a1 = k  << l; //j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			for (i=0; i< bfly; ++i) {
				xr = fr2[ a1 + i ]; //j*2^(t-1) + k
				xi = fi2[ a1 + i ];
				yr = fr2[ a1 + half + i]; //j*2^(t-1) + 2^(n-1) + k
				yi = fi2[ a1 + half + i];

				if (shift) {
					xr >>= 1;
					xi >>= 1;
					yr >>= 1;
					yi >>= 1;
				}

				fr[ a2 + i ] = xr + yr; // j*2^t + k
				fi[ a2 + i ] = xi + yi;
				yr = xr - yr;
				yi = xi - yi;
				fr[ a2 + bfly + i ] = FIX_MULT(wr,yr) - FIX_MULT(wi,yi); // j*2^t +2^(t-1) + k
				fi[ a2 + bfly + i  ] = FIX_MULT(wr,yi) + FIX_MULT(wi,yr);
			}
		}
		l++;
		mul++;
		flight >>=1;
		bfly <<=1;
	}

	// put correct result back into both f[] & f2[]
	for (i=0; i< n; i++){
		fr2[i] = fr[i];
		fi2[i] = fi[i];
	}

	return scale;
}

int scalar_fix_fft_dif_fly(short fr[], short fi[], short fr2[], short fi2[], short tw_r[], short tw_i[], short m, short inverse)
{
	int i, j, l, k, scale, shift,a1,a2,bfly,mul,flight;
	short  wr, wi, xr, xi, yr, yi;
	short *tmp;

	const int n = 1 << m;
	const int half = n >> 1;

	scale = 0;
	l = 0;
	flight = 1<<(m-1);
	bfly = 1;
	mul = 0;

	while (l < m) {
		if (inverse) {

			// variable scaling, depending upon data
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				k = fi[i];
				if (k < 0)
					k = -k;
				if (j > 16383 || k > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		// shift will be performed on each data point exactly once during pass
		tmp = fr;
		fr = fr2;
		fr2 = tmp;
		tmp = fi;
		fi = fi2;
		fi2 = tmp;


		for (k=0; k<flight; ++k) {
			j = k << mul;
			wr =  tw_r[j];
			wi =  tw_i[j];

			a1 = k  << l; //j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			for (i=0; i< bfly; ++i) {
				xr = fr2[ a1 + i ]; //j*2^(t-1) + k
				xi = fi2[ a1 + i ];
				yr = fr2[ a1 + half + i]; //j*2^(t-1) + 2^(n-1) + k
				yi = fi2[ a1 + half + i];

				if (shift) {
					xr >>= 1;
					xi >>= 1;
					yr >>= 1;
					yi >>= 1;
				}

				fr[ a2 + i ] = xr + yr; // j*2^t + k
				fi[ a2 + i ] = xi + yi;
				yr = xr - yr;
				yi = xi - yi;
				fr[ a2 + bfly + i ] = FIX_MULT(wr,yr) - FIX_MULT(wi,yi); // j*2^t +2^(t-1) + k
				fi[ a2 + bfly + i  ] = FIX_MULT(wr,yi) + FIX_MULT(wi,yr);
			}
		}
		l++;
		mul++;
		flight >>=1;
		bfly <<=1;
	}

	// put correct result back into both f[] & f2[]
	for (i=0; i< n; i++){
		fr2[i] = fr[i];
		fi2[i] = fi[i];
	}

	return scale;
}

int scalar_fix_fft_dif_alt(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse)
{
	int i, j, l, k, scale, shift,a1,a2,bfly,mul,flight;
	short  wr, wi, xr, xi, yr, yi;
	short *tmp;

	const int n = 1 << m;
	const int half = n >> 1;

	scale = 0;
	l = m-1;
	flight = 1;
	bfly = 1<<(m-1);
	mul = 0;

	while (l >= 0) {
		if (inverse) {

			// variable scaling, depending upon data
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				k = fi[i];
				if (k < 0)
					k = -k;
				if (j > 16383 || k > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		// shift will be performed on each data point exactly once during pass
		tmp = fr;
		fr = fr2;
		fr2 = tmp;
		tmp = fi;
		fi = fi2;
		fi2 = tmp;

		for (k=0; k<flight; ++k) {
			a1 = k << l; //j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			for (i=0; i< bfly; ++i) {
				j = i << mul;
				wr =  Sinewave[j+n/4];
				wi = -Sinewave[j];

				if (inverse)
					wi = -wi;

				xr = fr2[ a2 + i ]; // j*2^t + k
				xi = fi2[ a2 + i ];
				yr = fr2[ a2 + bfly + i]; // j*2^t +2^(t-1) + k
				yi = fi2[ a2 + bfly + i];

				if (shift) {
					xr >>= 1;
					xi >>= 1;
					yr >>= 1;
					yi >>= 1;
				}

				fr[ a1 + i ] = xr + yr; //j*2^(t-1) + k
				fi[ a1 + i ] = xi + yi;
				yr = xr - yr;
				yi = xi - yi;
				fr[ a1 + half + i ] = FIX_MULT(wr,yr) - FIX_MULT(wi,yi); //j*2^(t-1) + 2^(n-1) + k
				fi[ a1 + half + i  ] = FIX_MULT(wr,yi) + FIX_MULT(wi,yr);
			}
		}
		l--;
		mul++;
		flight <<= 1;
		bfly >>= 1;
	}

	// put correct result back into both f[] & f2[]
	for (i=0; i< n; i++){
		fr2[i] = fr[i];
		fi2[i] = fi[i];
	}

	return scale;

}

int scalar_fix_fft_dif_long(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse)
{
	int i, j, l, k, scale, shift,a1,a2,bfly,mul,flight,swap;
	short  wr, wi, xr, xi, yr, yi;
	short *tmp;

	const int n = 1 << m;
	const int half = n >> 1;

	scale = 0;
	l = m-1;
	flight = 1;
	bfly = 1<<(m-1);
	mul = 0;
	swap = m >> 1;

	const int INROWS = 1<<swap;
	const int INCOLS = 1<<(m-swap);

	if ( !(m%2) ){
		swap--;
	}

	while (l > swap) {
		if (inverse) {

			// variable scaling, depending upon data
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				k = fi[i];
				if (k < 0)
					k = -k;
				if (j > 16383 || k > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			/// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		// shift will be performed on each data point exactly once during pass
		tmp = fr;
		fr = fr2;
		fr2 = tmp;
		tmp = fi;
		fi = fi2;
		fi2 = tmp;

		for (k=0; k<flight; ++k) {
			a1 = k << l; //j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			for (i=0; i< bfly; ++i) {
				j = i << mul;
				wr =  Sinewave[j+n/4];
				wi = -Sinewave[j];

				if (inverse)
					wi = -wi;

				xr = fr2[ a2 + i ]; // j*2^t + k
				xi = fi2[ a2 + i ];
				yr = fr2[ a2 + bfly + i]; // j*2^t +2^(t-1) + k
				yi = fi2[ a2 + bfly + i];

				if (shift) {
					xr >>= 1;
					xi >>= 1;
					yr >>= 1;
					yi >>= 1;
				}

				fr[ a1 + i ] = xr + yr; //j*2^(t-1) + k
				fi[ a1 + i ] = xi + yi;
				yr = xr - yr;
				yi = xi - yi;
				fr[ a1 + half + i ] = FIX_MULT(wr,yr) - FIX_MULT(wi,yi); //j*2^(t-1) + 2^(n-1) + k
				fi[ a1 + half + i  ] = FIX_MULT(wr,yi) + FIX_MULT(wi,yr);
			}
		}
		l--;
		mul++;
		flight <<= 1;
		bfly >>= 1;
	}

	if ( !(m%2) ) {
		l++;
		flight >>=1;
		bfly <<= 1;
	}

	//matrix transpose
	tmp = fr;
	fr = fr2;
	fr2 = tmp;
	tmp = fi;
	fi = fi2;
	fi2 = tmp;

	for (j=0; j< INROWS; j++) {
		for (i=0; i< INCOLS; i++) {
			fr[ j + INROWS*i ] = fr2[ j*INCOLS + i];
			fi[ j + INROWS*i ] = fi2[ j*INCOLS + i];
	    }
	}

	while (l < m) {
		if (inverse) {

			// variable scaling, depending upon data
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				k = fi[i];
				if (k < 0)
					k = -k;
				if (j > 16383 || k > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			// fixed scaling, for proper normalization
			// -- overall factor of 1/n, distributed to maximize arithmetic accuracy
			shift = 1;
		}
		// shift will be performed on each data point exactly once during pass
		tmp = fr;
		fr = fr2;
		fr2 = tmp;
		tmp = fi;
		fi = fi2;
		fi2 = tmp;


		for (k=0; k<flight; ++k) {
			j = k << mul;
			wr =  Sinewave[j+n/4];
			wi = -Sinewave[j];
			if (inverse)
				wi = -wi;

			a1 = k << l; //j*2^(t-1)
			a2 = a1 << 1; // j*2^t

			for (i=0; i< bfly; ++i) {
				xr = fr2[ a1 + i ]; //j*2^(t-1) + k
				xi = fi2[ a1 + i ];
				yr = fr2[ a1 + half + i]; //j*2^(t-1) + 2^(n-1) + k
				yi = fi2[ a1 + half + i];

				if (shift) {
					xr >>= 1;
					xi >>= 1;
					yr >>= 1;
					yi >>= 1;
				}

				fr[ a2 + i ] = xr + yr; // j*2^t + k
				fi[ a2 + i ] = xi + yi;
				yr = xr - yr;
				yi = xi - yi;
				fr[ a2 + bfly + i ] = FIX_MULT(wr,yr) - FIX_MULT(wi,yi); // j*2^t +2^(t-1) + k
				fi[ a2 + bfly + i  ] = FIX_MULT(wr,yi) + FIX_MULT(wi,yr);


			}
		}
		l++;
		mul++;
		flight >>=1;
		bfly <<=1;
	}

	// put correct result back into both f[] & f2[]
	for (i=0; i< n; i++){
		fr2[i] = fr[i];
		fi2[i] = fi[i];
	}

	return scale;

}

int scalar_fix_fft_stockham(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse)
{

	int  i, j, l, k, scale, shift,r,d,d2,jrs;
	short qr, qi, tr, ti, wr, wi;
	short *tmp;

	const int n = 1 << m;
	const int half = n >> 1;
	scale = 0;
	l = 1;
	k = m-1;
	r = half;

	while (l < n) {
		if (inverse) {
			/* variable scaling, depending upon data */
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				m = fi[i];
				if (m < 0)
					m = -m;
				if (j > 16383 || m > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			/*
			  fixed scaling, for proper normalization --
			  there will be log2(n) passes, so this results
			  in an overall factor of 1/n, distributed to
			  maximize arithmetic accuracy.
			*/
			shift = 1;
		}
		/*
		  it may not be obvious, but the shift will be
		  performed on each data point exactly once,
		  during this pass.
		*/
		tmp = fr;
		fr = fr2;
		fr2 = tmp;
		tmp = fi;
		fi = fi2;
		fi2 = tmp;

		d = 0;
		d2 = half;

		for (m=0; m<l; ++m) {
			j = m << k;
			wr =  Sinewave[j+n/4];
			wi = -Sinewave[j];
			if (inverse)
				wi = -wi;
			if (shift) {
				wr >>= 1;
				wi >>= 1;
			}
			jrs = m*(r+r);

			for (i=jrs; i<jrs+r; ++i) {
				j = i + r;
				tr = FIX_MULT(wr,fr2[j]) - FIX_MULT(wi,fi2[j]);
				ti = FIX_MULT(wr,fi2[j]) + FIX_MULT(wi,fr2[j]);
				qr = fr2[i];
				qi = fi2[i];
				if (shift) {
					qr >>= 1;
					qi >>= 1;
				}
				fr[d]  = qr + tr;
				fi[d]  = qi + ti;
				fr[d2] = qr - tr;
				fi[d2] = qi - ti;
				++d;
				++d2;
			}
		}
		--k;
		l <<= 1;
		r >>= 1;
	}

	// put correct result back into both f[] & f2[]
	for (i=0; i< n; i++){
		fr2[i] = fr[i];
		fi2[i] = fi[i];
	}

	return scale;
}
/*
  fix_fft() - perform forward/inverse fast Fourier transform.
  fr[n],fi[n] are real and imaginary arrays, both INPUT AND
  RESULT (in-place FFT), with 0 <= n < 2**m; set inverse to
  0 for forward transform (FFT), or 1 for iFFT.
*/
int scalar_fix_fft_cooley(short fr[], short fi[], short m, short inverse)
{
	int mr, nn, i, j, l, k, istep, n, scale, shift,swap;
	short qr, qi, tr, ti, wr, wi;



	n = 1 << m;
	mr = 0;
	nn = n - 1;
	scale = 0;
	k = m-1;

	/* decimation in time - re-order data */
	for (m=1; m<=nn; ++m) {
		l = n;
		do {
			l >>= 1;
		} while (mr+l > nn);
		mr = (mr & (l-1)) + l;

		if (mr <= m)
			continue;
		tr = fr[m];
		fr[m] = fr[mr];
		fr[mr] = tr;
		ti = fi[m];
		fi[m] = fi[mr];
		fi[mr] = ti;
	}

	l = 1;
	while (l < n) {
		if (inverse) {
			/* variable scaling, depending upon data */
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				m = fi[i];
				if (m < 0)
					m = -m;
				if (j > 16383 || m > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			/*
			  fixed scaling, for proper normalization --
			  there will be log2(n) passes, so this results
			  in an overall factor of 1/n, distributed to
			  maximize arithmetic accuracy.
			*/
			shift = 1;
		}
		/*
		  it may not be obvious, but the shift will be
		  performed on each data point exactly once,
		  during this pass.
		*/
		istep = l << 1;
		for (m=0; m<l; ++m) {
			j = m << k;
			wr =  Sinewave[j+n/4];
			wi = -Sinewave[j];
			if (inverse)
				wi = -wi;
			if (shift) {
				wr >>= 1;
				wi >>= 1;
			}
			for (i=m; i<n; i+=istep) {
				j = i + l;
				tr = FIX_MULT(wr,fr[j]) - FIX_MULT(wi,fi[j]);
				ti = FIX_MULT(wr,fi[j]) + FIX_MULT(wi,fr[j]);
				qr = fr[i];
				qi = fi[i];
				if (shift) {
					qr >>= 1;
					qi >>= 1;
				}
				fr[j] = qr - tr;
				fi[j] = qi - ti;
				fr[i] = qr + tr;
				fi[i] = qi + ti;
			}
		}
		--k;
		l = istep;
	}


	return scale;
}

int scalar_fix_fft_cooley_fly(short fr[], short fi[], short tw_r[], short tw_i[], short m, short inverse)
{
	int mr, nn, i, j, l, k, istep, n, scale, shift,swap;
	short qr, qi, tr, ti, wr, wi;



	n = 1 << m;
	mr = 0;
	nn = n - 1;
	scale = 0;
	k = m-1;

	/* decimation in time - re-order data */
	for (m=1; m<=nn; ++m) {
		l = n;
		do {
			l >>= 1;
		} while (mr+l > nn);
		mr = (mr & (l-1)) + l;

		if (mr <= m)
			continue;
		tr = fr[m];
		fr[m] = fr[mr];
		fr[mr] = tr;
		ti = fi[m];
		fi[m] = fi[mr];
		fi[mr] = ti;
	}

	l = 1;
	while (l < n) {
		if (inverse) {
			/* variable scaling, depending upon data */
			shift = 0;
			for (i=0; i<n; ++i) {
				j = fr[i];
				if (j < 0)
					j = -j;
				m = fi[i];
				if (m < 0)
					m = -m;
				if (j > 16383 || m > 16383) {
					shift = 1;
					break;
				}
			}
			if (shift)
				++scale;
		} else {
			/*
			  fixed scaling, for proper normalization --
			  there will be log2(n) passes, so this results
			  in an overall factor of 1/n, distributed to
			  maximize arithmetic accuracy.
			*/
			shift = 1;
		}
		/*
		  it may not be obvious, but the shift will be
		  performed on each data point exactly once,
		  during this pass.
		*/
		istep = l << 1;
		for (m=0; m<l; ++m) {
			j = m << k;
			wr =  tw_r[j];
			wi =  tw_i[j];
			if (inverse)
				wi = -wi;
			if (shift) {
				wr >>= 1;
				wi >>= 1;
			}
			for (i=m; i<n; i+=istep) {
				j = i + l;
				tr = FIX_MULT(wr,fr[j]) - FIX_MULT(wi,fi[j]);
				ti = FIX_MULT(wr,fi[j]) + FIX_MULT(wi,fr[j]);
				qr = fr[i];
				qi = fi[i];
				if (shift) {
					qr >>= 1;
					qi >>= 1;
				}
				fr[j] = qr - tr;
				fi[j] = qi - ti;
				fr[i] = qr + tr;
				fi[i] = qi + ti;
			}
		}
		--k;
		l = istep;
	}


	return scale;
}

/*
  fix_fftr() - forward/inverse FFT on array of real numbers.
  Real FFT/iFFT using half-size complex FFT by distributing
  even/odd samples into real/imaginary arrays respectively.
  In order to save data space (i.e. to avoid two arrays, one
  for real, one for imaginary samples), we proceed in the
  following two steps: a) samples are rearranged in the real
  array so that all even samples are in places 0-(N/2-1) and
  all imaginary samples in places (N/2)-(N-1), and b) fix_fft
  is called with fr and fi pointing to index 0 and index N/2
  respectively in the original array. The above guarantees
  that fix_fft "sees" consecutive real samples as alternating
  real and imaginary samples in the complex array.
*/
int scalar_fix_fft_cooley_real(short f[], int m, int inverse)
{
	int half = 1<<(m-1), scale = 0;
	short *fr=f, *fi=&f[half];

	if (inverse)
		scalar_fix_fft_untangle_real( fr, fi, m-1, inverse);

	scale = scalar_fix_fft_cooley(fr, fi, m-1, inverse);

	if (! inverse)
		scalar_fix_fft_untangle_real( fr, fi, m-1, inverse);

	return scale;
}

int scalar_fix_fft_stockham_real(short f[], short f2[], int m, int inverse)
{
	int half = 1<<(m-1), scale = 0;
	short *fr=f, *fi=&f[half], *fr2 =f2 , *fi2 = &f2[half];

	if (inverse)
		scalar_fix_fft_untangle_real( fr, fi, m-1, inverse);

	scale = scalar_fix_fft_dif(fr, fi, fr2, fi2, m-1, inverse);

	if (! inverse)
		scalar_fix_fft_untangle_real( fr2, fi2, m-1, inverse);

	return scale;
}

int scalar_fix_fft_stockham_real_fly(short f[], short f2[], short tw_r[], short tw_i[], int m, int inverse)
{
	int half = 1<<(m-1), scale = 0;
	short *fr=f, *fi=&f[half], *fr2 =f2 , *fi2 = &f2[half];

	if (inverse)
		scalar_fix_fft_untangle_real( fr, fi, m-1, inverse);

	scale = scalar_fix_fft_dif_fly(fr, fi, fr2, fi2, tw_r, tw_i, m-1, inverse);

	if (! inverse)
		scalar_fix_fft_untangle_real( fr2, fi2, m-1, inverse);

	return scale;
}

void scalar_fix_fft_untangle_real( short fr[], short fi[], int m, int inverse)
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
