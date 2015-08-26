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


//#include "vbx_copyright.h"
//VBXCOPYRIGHT(scalar_sobel_argb32_3x3)

#include <stdio.h>
#include <stdlib.h>
#include "pixel.h"

#define FILTER_WIDTH       3
#define FILTER_HEIGHT      3
#define MAX_EDGE         255


void scalar_rgb2luma(uint16_t *luma, pixel *rgb, const int16_t image_width, const int16_t image_height, const int16_t image_pitch)
{
	int32_t i;
	for (i = image_pitch*image_height; i > 0; i--) {
		*luma++ = (25*rgb->b + 129*rgb->g + 66*rgb->r + 128) >> 8U;
		rgb++;
	}
}


void scalar_sobel_argb32_3x3(pixel *sobel, uint16_t *luma, const int16_t image_width, const int16_t image_height, const int16_t image_pitch, const int16_t renorm)
{
	int32_t i, j;
	int32_t gradient_x, gradient_y, edge;

	// set top output row(s) to black
	for (j = 0; j < FILTER_HEIGHT/2; j++) {
		for (i = 0; i < image_width; i++) {
			sobel->a = 0;
			sobel->r = 0;
			sobel->g = 0;
			sobel->b = 0;
			sobel++;
		}
		sobel += image_pitch - image_width;
	}

	for (j = 0; j <= image_height-FILTER_HEIGHT; j++) {
		// set left column(s) to black
		for (i = 0; i < FILTER_WIDTH/2; i++) {
			sobel->a = 0;
			sobel->r = 0;
			sobel->g = 0;
			sobel->b = 0;
			sobel++;
		}

		// calculate edges
		for (i = 0; i <= image_width-FILTER_WIDTH; i++) {
			gradient_x = abs((luma[0] + 2*luma[image_pitch]   + luma[2*image_pitch])
				           - (luma[2] + 2*luma[image_pitch+2] + luma[2*image_pitch+2]));
			gradient_y = abs((luma[0]             + 2*luma[1]               + luma[2])
				           - (luma[2*image_pitch] + 2*luma[2*image_pitch+1] + luma[2*image_pitch+2]));
			edge = (gradient_x + gradient_y) >> renorm;
			if (edge > MAX_EDGE)
				edge = MAX_EDGE;

			sobel->a = 0;
			sobel->r = edge;
			sobel->g = edge;
			sobel->b = edge;
			sobel++;
			luma++;
		}
		luma += (FILTER_WIDTH-1) + (image_pitch-image_width);

		// set right column(s) to black
		for (i = 0; i < FILTER_WIDTH/2; i++) {
			sobel->a = 0;
			sobel->r = 0;
			sobel->g = 0;
			sobel->b = 0;
			sobel++;
		}
		sobel += image_pitch - image_width;
	}

	// set bottom output row(s) to black
	for (j = 0; j < FILTER_HEIGHT/2; j++) {
		for (i = 0; i < image_width; i++) {
			sobel->a = 0;
			sobel->r = 0;
			sobel->g = 0;
			sobel->b = 0;
			sobel++;
		}
		sobel += image_pitch - image_width;
	}
}
