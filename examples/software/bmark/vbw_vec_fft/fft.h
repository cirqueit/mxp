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

#ifndef __FFT_H
#define __FFT_H

// Rounding for both scalar and vector
#define ROUND 0

extern short *Sinewave;

// Scalar functions
int scalar_fix_fft_cooley(short fr[], short fi[], short m, short inverse);
int scalar_fix_fft_cooley_real(short f[], int m, int inverse);
int scalar_fix_fft_stockham(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse);
int scalar_fix_fft_dif_long(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse);
int scalar_fix_fft_dif(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse);
int scalar_fix_fft_dif_alt(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse);
int scalar_fix_fft_stockham_real(short f[], short f2[], int m, int inverse);
void scalar_fix_fft_untangle_real( short fr[], short fi[], int m, int inverse);
int scalar_fix_fft_stockham_real_fly(short f[], short f2[], short tw_r[], short tw_i[], int m, int inverse);
int scalar_fix_fft_dif_fly(short fr[], short fi[], short fr2[], short fi2[], short tw_r[], short tw_i[], short m, short inverse);
int scalar_fix_fft_cooley_fly(short fr[], short fi[], short tw_r[], short tw_i[], short m, short inverse);
// Vector functions
int vector_fix_fft_dif_real_joe(short f[],short f2[], short bf[], int m, int inverse);
int vector_fix_fft_dif_real_guy(short f[],short f2[], short bf[], int m, int inverse);
int vector_fix_fft_dif_real_gold(short f[],short f2[], int m, int inverse);
int vector_fix_fft_dif_long(short fr[], short fi[], short fr2[], short fi2[], short m, short inverse, short real);
int vector_fix_fft_large_init(short fr[], short fi[], short fr2[], short fi2[], short tw_r[], short tw_i[], short m, short inverse, short real, short* large_mem);
void vector_large_bfly_gen(short tw_r[], short tw_i[], short k, long offset, short m, short inverse);

#endif //__FFT_H
