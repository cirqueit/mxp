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
#include "scalar_mtx_xp.h"

/** Scalar Matrix Transpose Byte
 * Assumes in != out
 *
 * @param[out] out.
 * @param[in] in.
 * @param[in] INROWS.
 * @param[in] INCOLS.
 */

#define CACHE_FRIENDLY 0	// This does offer some improvement but has only been tested on a NIOS processor and so is disabled by default
#define CACHE_WIDTH_B 32        // Simple cache-friendly algorithm uses square tiles that are CACHE_WIDTH_B*CACHE_FACTOR bytes wide and tall
#define CACHE_FACTOR 2

void scalar_mtx_xp_byte(int8_t *out, int8_t *in, const int32_t INROWS, const int32_t INCOLS)
{
	#if CACHE_FRIENDLY
		int TILE_WIDTH = ((CACHE_WIDTH_B / sizeof(int8_t))*CACHE_FACTOR);
		int TILE_HEIGHT = TILE_WIDTH;

		int32_t x, y, tile_x, tile_y;
		for( tile_x = 0; tile_x < INCOLS; tile_x += TILE_WIDTH ) {
			for( tile_y = 0; tile_y < INROWS; tile_y += TILE_HEIGHT ) {
				for( y = tile_y; y < tile_y + TILE_HEIGHT && y < INROWS; y++) {
					int8_t *inp  =  &in[y*INCOLS+tile_x];
					int8_t *outp = &out[y+tile_x*INROWS];
					for( x = tile_x; x < tile_x + TILE_WIDTH && x < INCOLS; x++ ) {
						*outp = *inp++; outp += INROWS;
						//printf("%i\t", in[y*INCOLS+x]);
					}
					//printf("\n");
				}
				//printf("\n");
			}
		}
	#else
		int32_t i,j;
		for(j = 0; j < INROWS; j++){
			//print32_tf( "\nj:%d\n", j ); fflush(stdout);
			for(i = 0; i < INCOLS; i++){
				//print32_tf( "i:%d ", i ); fflush(stdout);
				out[i*INROWS+j] = in[j*INCOLS+i];
			}
		}
	#endif
}

/** Scalar Matrix Transpose Half
 * Assumes in != out
 *
 * @param[out] out.
 * @param[in] in.
 * @param[in] INROWS.
 * @param[in] INCOLS.
 */
void scalar_mtx_xp_half(int16_t *out, int16_t *in, const int32_t INROWS, const int32_t INCOLS)
{
	#if CACHE_FRIENDLY
		int TILE_WIDTH = ((CACHE_WIDTH_B / sizeof(int16_t))*CACHE_FACTOR);
		int TILE_HEIGHT = TILE_WIDTH;

		int32_t x, y, tile_x, tile_y;
		for( tile_x = 0; tile_x < INCOLS; tile_x += TILE_WIDTH ) {
			for( tile_y = 0; tile_y < INROWS; tile_y += TILE_HEIGHT ) {
				for( y = tile_y; y < tile_y + TILE_HEIGHT && y < INROWS; y++) {
					int16_t *inp  =  &in[y*INCOLS+tile_x];
					int16_t *outp = &out[y+tile_x*INROWS];
					for( x = tile_x; x < tile_x + TILE_WIDTH && x < INCOLS; x++ ) {
						*outp = *inp++; outp += INROWS;
						//printf("%i\t", in[y*INCOLS+x]);
					}
					//printf("\n");
				}
				//printf("\n");
			}
		}
	#else
		int32_t i,j;
		for(j = 0; j < INROWS; j++){
			//print32_tf( "\nj:%d\n", j ); fflush(stdout);
			for(i = 0; i < INCOLS; i++){
				//print32_tf( "i:%d ", i ); fflush(stdout);
				out[i*INROWS+j] = in[j*INCOLS+i];
			}
		}
	#endif
}

/** Scalar Matrix Transpose Word
 * Assumes in != out
 *
 * @param[out] out.
 * @param[in] in.
 * @param[in] INROWS.
 * @param[in] INCOLS.
 */
void scalar_mtx_xp_word(int32_t *out, int32_t *in, const int32_t INROWS, const int32_t INCOLS)
{
	#if CACHE_FRIENDLY
		int TILE_WIDTH = ((CACHE_WIDTH_B / sizeof(int32_t))*CACHE_FACTOR);
		int TILE_HEIGHT = TILE_WIDTH;

		int32_t x, y, tile_x, tile_y;
		for( tile_x = 0; tile_x < INCOLS; tile_x += TILE_WIDTH ) {
			for( tile_y = 0; tile_y < INROWS; tile_y += TILE_HEIGHT ) {
				for( y = tile_y; y < tile_y + TILE_HEIGHT && y < INROWS; y++) {
					int32_t *inp  =  &in[y*INCOLS+tile_x];
					int32_t *outp = &out[y+tile_x*INROWS];
					for( x = tile_x; x < tile_x + TILE_WIDTH && x < INCOLS; x++ ) {
						*outp = *inp++; outp += INROWS;
						//printf("%i\t", in[y*INCOLS+x]);
					}
					//printf("\n");
				}
				//printf("\n");
			}
		}
	#else
		int32_t i,j;
		for(j = 0; j < INROWS; j++){
			//print32_tf( "\nj:%d\n", j ); fflush(stdout);
			for(i = 0; i < INCOLS; i++){
				//print32_tf( "i:%d ", i ); fflush(stdout);
				out[i*INROWS+j] = in[j*INCOLS+i];
			}
		}
	#endif
}

/** Scalar Matrix Transpose Unsigned Byte
 * Assumes in != out
 *
 * @param[out] out.
 * @param[in] in.
 * @param[in] INROWS.
 * @param[in] INCOLS.
 */
void scalar_mtx_xp_ubyte(uint8_t *out, uint8_t *in, const int32_t INROWS, const int32_t INCOLS)
{
	#if CACHE_FRIENDLY
		int TILE_WIDTH = ((CACHE_WIDTH_B / sizeof(uint8_t))*CACHE_FACTOR);
		int TILE_HEIGHT = TILE_WIDTH;

		int32_t x, y, tile_x, tile_y;
		for( tile_x = 0; tile_x < INCOLS; tile_x += TILE_WIDTH ) {
			for( tile_y = 0; tile_y < INROWS; tile_y += TILE_HEIGHT ) {
				for( y = tile_y; y < tile_y + TILE_HEIGHT && y < INROWS; y++) {
					uint8_t *inp  =  &in[y*INCOLS+tile_x];
					uint8_t *outp = &out[y+tile_x*INROWS];
					for( x = tile_x; x < tile_x + TILE_WIDTH && x < INCOLS; x++ ) {
						*outp = *inp++; outp += INROWS;
						//printf("%i\t", in[y*INCOLS+x]);
					}
					//printf("\n");
				}
				//printf("\n");
			}
		}
	#else
		int32_t i,j;
		for(j = 0; j < INROWS; j++){
			//print32_tf( "\nj:%d\n", j ); fflush(stdout);
			for(i = 0; i < INCOLS; i++){
				//print32_tf( "i:%d ", i ); fflush(stdout);
				out[i*INROWS+j] = in[j*INCOLS+i];
			}
		}
	#endif
}

/** Scalar Matrix Transpose Unsigned Half
 * Assumes in != out
 *
 * @param[out] out.
 * @param[in] in.
 * @param[in] INROWS.
 * @param[in] INCOLS.
 */
void scalar_mtx_xp_uhalf(uint16_t *out, uint16_t *in, const int32_t INROWS, const int32_t INCOLS)
{
	#if CACHE_FRIENDLY
		int TILE_WIDTH = ((CACHE_WIDTH_B / sizeof(uint16_t))*CACHE_FACTOR);
		int TILE_HEIGHT = TILE_WIDTH;

		int32_t x, y, tile_x, tile_y;
		for( tile_x = 0; tile_x < INCOLS; tile_x += TILE_WIDTH ) {
			for( tile_y = 0; tile_y < INROWS; tile_y += TILE_HEIGHT ) {
				for( y = tile_y; y < tile_y + TILE_HEIGHT && y < INROWS; y++) {
					uint16_t *inp  =  &in[y*INCOLS+tile_x];
					uint16_t *outp = &out[y+tile_x*INROWS];
					for( x = tile_x; x < tile_x + TILE_WIDTH && x < INCOLS; x++ ) {
						*outp = *inp++; outp += INROWS;
						//printf("%i\t", in[y*INCOLS+x]);
					}
					//printf("\n");
				}
				//printf("\n");
			}
		}
	#else
		int32_t i,j;
		for(j = 0; j < INROWS; j++){
			//print32_tf( "\nj:%d\n", j ); fflush(stdout);
			for(i = 0; i < INCOLS; i++){
				//print32_tf( "i:%d ", i ); fflush(stdout);
				out[i*INROWS+j] = in[j*INCOLS+i];
			}
		}
	#endif
}

/** Scalar Matrix Transpose Unsigned Word
 * Assumes in != out
 *
 * @param[out] out.
 * @param[in] in.
 * @param[in] INROWS.
 * @param[in] INCOLS.
 */
void scalar_mtx_xp_uword(uint32_t *out, uint32_t *in, const int32_t INROWS, const int32_t INCOLS)
{
	#if CACHE_FRIENDLY
		int TILE_WIDTH = ((CACHE_WIDTH_B / sizeof(uint32_t))*CACHE_FACTOR);
		int TILE_HEIGHT = TILE_WIDTH;

		int32_t x, y, tile_x, tile_y;
		for( tile_x = 0; tile_x < INCOLS; tile_x += TILE_WIDTH ) {
			for( tile_y = 0; tile_y < INROWS; tile_y += TILE_HEIGHT ) {
				for( y = tile_y; y < tile_y + TILE_HEIGHT && y < INROWS; y++) {
					uint32_t *inp  =  &in[y*INCOLS+tile_x];
					uint32_t *outp = &out[y+tile_x*INROWS];
					for( x = tile_x; x < tile_x + TILE_WIDTH && x < INCOLS; x++ ) {
						*outp = *inp++; outp += INROWS;
						//printf("%i\t", in[y*INCOLS+x]);
					}
					//printf("\n");
				}
				//printf("\n");
			}
		}
	#else
		int32_t i,j;
		for(j = 0; j < INROWS; j++){
			//print32_tf( "\nj:%d\n", j ); fflush(stdout);
			for(i = 0; i < INCOLS; i++){
				//print32_tf( "i:%d ", i ); fflush(stdout);
				out[i*INROWS+j] = in[j*INCOLS+i];
			}
		}
	#endif
}
