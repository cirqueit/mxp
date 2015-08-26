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
#include "scalar_mtx_median_argb32.h"
#include <stdio.h>

/** Scalar Median filter argb32.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_argb32(pixel *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
    int32_t filter_size = filter_height * filter_width;
	int32_t y,x,j,i;
	uint8_t array_r[filter_size];
	uint8_t array_g[filter_size];
	uint8_t array_b[filter_size];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array_r[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)].r;
					array_g[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)].g;
					array_b[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)].b;
				}
			}
            input[y*image_pitch+x].r = scalar_bubble_ubyte(array_r, filter_size);
            input[y*image_pitch+x].g = scalar_bubble_ubyte(array_g, filter_size);
            input[y*image_pitch+x].b = scalar_bubble_ubyte(array_b, filter_size);
		}
	}
}
