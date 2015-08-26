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
VBXCOPYRIGHT(test_rgb2luma)

// This test currently requires at least 32KB of scratchpad memory.

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "pixel.h"
#include "vbw_mtx_sobel.h"
#include "scalar_mtx_sobel.h"

#define IMAGE_WIDTH     1920
#define IMAGE_HEIGHT    1080
#define IMAGE_PITCH     1920
#define RENORM_AMOUNT   2

#define MAX_PRINT_ERRORS  20

void init_matrix(pixel *input, const int image_width, const int image_height)
{
	int i    = image_width * image_height;
	int lfsr = -2;

	// Load data for each frame...
	while (i-- > 0) {
		input->r = lfsr & 0xFF; lfsr = lfsr_32(lfsr);
		input->g = lfsr & 0xFF; lfsr = lfsr_32(lfsr);
		input->b = lfsr & 0xFF; lfsr = lfsr_32(lfsr);
		input->a = lfsr & 0x00; lfsr = lfsr_32(lfsr);
		input++;
	}
}

// Set to 1 to measure only luma portion of algorithm.
// Also uses 8 bits for vector luma calculations.
#define USE_LUMA 0

int main(void)
{
	pixel *input;
	pixel *scalar_input;

#if USE_LUMA
	unsigned char  *vbx_luma;
#endif
	unsigned short *scalar_luma;

	pixel *vbx_output;
	pixel *scalar_output;

	vbx_timestamp_t time_start, time_stop;
	double scalar_time, vbx_time;
	int x, y;
	int errors = 0;

	vbx_test_init();

	vbx_mxp_print_params();

	input         = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_input  = (pixel *)vbx_remap_cached(input, IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
#if USE_LUMA
	vbx_luma      = (unsigned char *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned char));
#endif
	scalar_luma   = (unsigned short *)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned short));
	vbx_output    = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_output = (pixel *)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));

	printf("\nInitializing data\n");
	printf("Resolution = %dx%d\n", IMAGE_WIDTH, IMAGE_HEIGHT);
	init_matrix(input, IMAGE_WIDTH, IMAGE_HEIGHT);

	printf("Starting Sobel 3x3 edge-detection test\n");

#if USE_LUMA
	scalar_rgb2luma(scalar_luma, scalar_input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH);
#endif
	vbx_timestamp_start();
	time_start = vbx_timestamp();
#if !USE_LUMA
	scalar_rgb2luma(scalar_luma, scalar_input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH);
#endif
	scalar_sobel_argb32_3x3(scalar_output, scalar_luma, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH, RENORM_AMOUNT);
	time_stop = vbx_timestamp();
	scalar_time = vbx_print_scalar_time(time_start, time_stop);

#if USE_LUMA
	vbw_rgb2luma8(vbx_luma, (unsigned *)input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH);
#endif
	vbx_timestamp_start();
	time_start = vbx_timestamp();
#if USE_LUMA
	vbw_sobel_luma8_3x3((unsigned *)vbx_output, vbx_luma, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH, RENORM_AMOUNT);
#else
	vbw_sobel_argb32_3x3((unsigned *)vbx_output, (unsigned *)input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH, RENORM_AMOUNT);
#endif
	time_stop = vbx_timestamp();
	vbx_time = vbx_print_vector_time(time_start, time_stop, scalar_time);

	for (y = 0; y < IMAGE_HEIGHT; y++) {
		for (x = 0; x < IMAGE_WIDTH; x++) {
#if USE_LUMA
			if (scalar_luma[y*IMAGE_WIDTH+x] != vbx_luma[y*IMAGE_WIDTH+x]) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("Y Error at %d, %d: Expected = %02X, got = %02X\n",
							y, x, scalar_luma[y*IMAGE_WIDTH+x], vbx_luma[y*IMAGE_WIDTH+x]);
				}
				errors++;
			}
#endif
			if (scalar_output[y*IMAGE_WIDTH+x].r != vbx_output[y*IMAGE_WIDTH+x].r) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("R Error at %d, %d: Expected = %02X, got = %02X\n",
							y, x, scalar_output[y*IMAGE_WIDTH+x].r, vbx_output[y*IMAGE_WIDTH+x].r);
				}
				errors++;
			}
			if (scalar_output[y*IMAGE_WIDTH+x].g != vbx_output[y*IMAGE_WIDTH+x].g) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("G Error at %d, %d: Expected = %02X, got = %02X\n",
							y, x, scalar_output[y*IMAGE_WIDTH+x].g, vbx_output[y*IMAGE_WIDTH+x].g);
				}
				errors++;
			}
			if (scalar_output[y*IMAGE_WIDTH+x].b != vbx_output[y*IMAGE_WIDTH+x].b) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("B Error at %d, %d: Expected = %02X, got = %02X\n",
							y, x, scalar_output[y*IMAGE_WIDTH+x].b, vbx_output[y*IMAGE_WIDTH+x].b);
				}
				errors++;
			}
		}
	}

	VBX_TEST_END(errors);
	return errors;
}
