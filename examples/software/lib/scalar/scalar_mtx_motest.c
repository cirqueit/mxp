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

#include "scalar_mtx_motest.h"

/**Scalar Motion Estimation.
 * Motion estimation.  Scan the block to be estimated over the image,
 * at each location calculating the SAD of the block and the reference image.
 * This function just calls (and is therefore functionally equivalent to)
 * scalar_mtx_motest_byte. This is just provided so that you can call the scalar function
 * with the same syntax as the vector version (receiving values as members of a
 * vbw_motest_t struct).
 * 
 * @FIXME Using bytes as input data.
 *
 * @param[out] result
 * @param[in] x
 * @param[in] y
 * @param[in] m
 *
 */
void vbw_mtx_motest_scalar_byte(output_type *result, input_type *x, input_type *y, vbw_motest_t *m)
{
	scalar_mtx_motest_byte( result, x, y, m->search_height, m->search_width, m->block_height,
	                        m->block_width, m->image_width);
	return;
}

/**Scalar Motion Estimation.
 * Motion estimation.  Scan the block to be estimated over the image,
 * at each location calculating the SAD of the block and the reference image
 *
 * @param[out] result.
 * @param[in] x.
 * @param[in] y.
 * @param[in] search_height.
 * @param[in] search_width.
 * @param[in] block_height.
 * @param[in] block_width.
 * @param[in] image_width.
 */
void scalar_mtx_motest_byte(uint32_t *result, uint8_t *x, uint8_t *y, const int32_t search_height, const int32_t search_width, const int32_t block_height, const int32_t block_width, const int32_t image_width)
{
	int32_t i, j, k, l;
	uint32_t answer;
	uint8_t *x_line;
	uint8_t *y_line;

	for( l=0; l<search_height; l++ ) {
		for( k=0; k<search_width; k++ ) {
			answer = 0;
			for( j=0; j<block_height; j++ ) {
				x_line = x + ( image_width*j );
				y_line = y + ( image_width*(l+j)+k );
				for( i=0; i<block_width; i++ ) {
					answer += abs( *(x_line++) - *(y_line++) );
				}
			}
			result[l*search_width+k] = answer;
		}
	}
}
