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
//
// Integer Matrix Multiply
// Scalar NIOS version 
//
#include <stdio.h>
#include <stdlib.h>
#include "vbx_common.h"

#include "scalar_mtx_mm.h"
// Scalar Matrix Multiply Routines

/** Scalar matrix multiply byte.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_mtx_mm_byte( int8_t *out, int8_t *in1, int8_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply half.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_mtx_mm_half( int16_t *out, int16_t *in1, int16_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply word.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_mtx_mm_word( int32_t *out, int32_t *in1, int32_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply unsigned byte.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_mtx_mm_ubyte( uint8_t *out, uint8_t *in1, uint8_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply unsigned half.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_mtx_mm_uhalf( uint16_t *out, uint16_t *in1, uint16_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply unsigned word.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_mtx_mm_uword( uint32_t *out, uint32_t *in1, uint32_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_ijk_mm_word( int32_t *out, int32_t *in1, int32_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
			for( k=0; k<N; k++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar matrix multiply.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_kij_mm_word( int32_t *out, int32_t *in1, int32_t *in2, const int32_t N )
{
	int32_t i,j,k;
	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
		}
	}

	for( k=0; k<N; k++ ) {
		for( i=0; i<N; i++ ) {
			for( j=0; j<N; j++ ) {
				out[i*N+j] += in1[i*N+k] * in2[k*N+j];
			}
		}
	}
}

/** Scalar block matrix multiply.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 * @param[in] BS.
 */
void scalar_block_ijk_mm_word( int32_t *out, int32_t *in1, int32_t *in2, const int32_t N, const int32_t BS )
{
	int32_t I,J,K;
	int32_t i,j,k;

	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
		}}

	for( I=0; I<N; I+=BS ) {
		for( J=0; J<N; J+=BS ) {
			for( K=0; K<N; K+=BS ) {
				for( i=I; i<min(N,I+BS); i++ ) {
					for( j=J; j<min(N,J+BS); j++ ) {
						for( k=K; k<min(N,K+BS); k++ ) {
							out[i*N+j] += in1[i*N+k] * in2[k*N+j];
						}}}
			}}}
}

/** Scalar block matrix multiply.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 * @param[in] BS.
 */
void scalar_block_kij_mm_word( int32_t *out, int32_t *in1, int32_t *in2, const int32_t N, const int32_t BS )
{
	int32_t I,J,K;
	int32_t i,j,k;
	int32_t a;

	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
		}}

	for( I=0; I<N; I+=BS ) {        
		for( J=0; J<N; J+=BS ) {        
			for( K=0; K<N; K+=BS ) {

				for( k=K; k<min(N,K+BS); k++ ) {
					for( i=I; i<min(N,I+BS); i++ ) {
						a = in1[i*N+k];
						for( j=J; j<min(N,J+BS); j++ ) {
							out[i*N+j] += a * in2[k*N+j];
						}}}
			}}}

}

/** Scalar block matrix multiply.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 * @param[in] BS.
 */
void scalar_block_kijkij_mm_word( int32_t *out, int32_t *in1, int32_t *in2, const int32_t N, const int32_t BS )
{
	int32_t I,J,K;
	int32_t i,j,k;
	int32_t a;

	for( i=0; i<N; i++ ) {
		for( j=0; j<N; j++ ) {
			out[i*N+j] = 0;
		}}

	for( K=0; K<N; K+=BS ) {
		for( I=0; I<N; I+=BS ) {
			for( J=0; J<N; J+=BS ) {
				for( k=K; k<min(N,K+BS); k++ ) {
					for( i=I; i<min(N,I+BS); i++ ) {
						a = in1[i*N+k];
						for( j=J; j<min(N,J+BS); j++ ) {
							out[i*N+j] += a * in2[k*N+j];
						}}}
			}}}
}

/** Scalar matrix transpose.
 *
 * @param[in] in1.
 * @param[in] in2.
 * @param[out] out.
 * @param[in] N.
 */
void scalar_transpose_matrix( int32_t *out, int32_t *in, const int32_t N )
{
	int32_t i,j;
	for(j = 0; j < N; j++){
		for(i = 0; i < N; i++){
			out[i*N+j] = in[j*N+i];
		}
	}
}

