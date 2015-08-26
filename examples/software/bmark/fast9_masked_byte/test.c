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
VBXCOPYRIGHT(test_fast9)

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "fast9.h"
#if 0
#include "lenna.h"
#else
#include "building.h"
#endif

/*
  size:  512 > 256 > 12
*/
#define USE_512 1
#define USE_256 1

#define PRINT 0 // for printing arrays to output


uint8_t im0[144] = {  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0, 100, 100, 100, 100, 100, 100, 100, 100,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 };


uint8_t im1[144] = {  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 };

uint8_t im2[144] = {  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
                  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 };

#if USE_512
#define TILE_HEIGHT    16
#define TILE_WIDTH     16
#define TILES          32
#define IMAGE_HEIGHT   (TILE_HEIGHT*TILES)
#define IMAGE_WIDTH    (TILE_HEIGHT*TILES)
#else
#if USE_256
#define TILE_HEIGHT    16
#define TILE_WIDTH     16
#define TILES          16
#define IMAGE_HEIGHT   (TILE_HEIGHT*TILES)
#define IMAGE_WIDTH    (TILE_HEIGHT*TILES)
#else
#define IMAGE_HEIGHT   12
#define IMAGE_WIDTH    12
#endif //USE_256
#endif //USE_512
#define IMAGE_PITCH     IMAGE_WIDTH
#define THRESHOLD       20

#define MAX_PRINT_ERRORS  10

void init_input(uint8_t *dst, uint8_t *src)
{
    int i, j;
	for (j = 0; j < IMAGE_HEIGHT; j++) {
		for (i = 0; i < IMAGE_WIDTH; i++) {
            dst[j*IMAGE_WIDTH+i] = src[j*IMAGE_WIDTH+i];
        }
    }

}

void print_python_array(uint8_t *dst, char* str)
{
    int i, j;
    printf("%s = [", str);
	for (j = 0; j < IMAGE_HEIGHT; j++) {
		for (i = 0; i < IMAGE_WIDTH; i++) {
            if(!(i%32)){
                printf("\n");
            }
            printf("%d, ", dst[j*IMAGE_WIDTH+i]);
        }
        printf("\n");
    }
    printf("]\n");

}

int main(void)
{

	vbx_timestamp_t time_start, time_stop;
	double scalar_time, vbx_time, vbx_time_masked;
	int i, j, l;
    int mode, sync0, sync1;
	int errors = 0;

	vbx_test_init();
	vbx_mxp_print_params();
    uint8_t *input, *scalar_input, *vbx_output, *scalar_output, *vbx_output_masked;

	input         = (uint8_t *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(uint8_t));
	scalar_input  = (uint8_t *)vbx_remap_cached(input, IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(uint8_t));
	vbx_output    = (uint8_t *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(uint8_t));
	vbx_output_masked  = (uint8_t *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(uint8_t));
	scalar_output = (uint8_t *)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(uint8_t));

	printf("Threshold = %d\n", THRESHOLD);
	printf("Resolution = %dx%d\n", IMAGE_WIDTH, IMAGE_HEIGHT);
    printf("Initializing data\n");
	vbx_timestamp_start();
    for(l=0; l<3; l++){
        char *isrc;
        char *idst;
        if(l==0){
            load_img(scalar_input, IMAGE_HEIGHT, IMAGE_WIDTH);
  					vbx_dcache_flush_all();
            printf("\nLenna\n");
            isrc = "lenna_src";
            idst = "lenna_dst";
        }else if(l==1){
            uint8_t *src  = (uint8_t *)vbx_shared_malloc(TILE_WIDTH*TILE_HEIGHT*sizeof(uint8_t));
            test_zero_array_byte(src, TILE_WIDTH*TILE_HEIGHT);
            generate_tiles(scalar_input, src, TILE_HEIGHT, TILE_WIDTH, TILES);
  					vbx_dcache_flush_all();
            printf("\nSquare\n");
            isrc = "square_src";
            idst = "square_dst";
        }else if(l==2){
            test_zero_array_byte(scalar_input, IMAGE_WIDTH*IMAGE_HEIGHT);
  					vbx_dcache_flush_all();
            printf("\nblank\n");
            isrc = "blank_src";
            idst = "blank_dst";
        }
        test_zero_array_byte(scalar_output, IMAGE_WIDTH*IMAGE_HEIGHT);

#if DEBUG
        test_print_matrix_byte(scalar_input, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_WIDTH);
#endif
#if PRINT
        print_python_array(scalar_input, isrc);
#endif

        time_start = vbx_timestamp();
        scalar_fast9(scalar_output, scalar_input, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH, THRESHOLD);
        time_stop = vbx_timestamp();
        scalar_time = vbx_print_scalar_time(time_start, time_stop);
#if DEBUG
        test_print_matrix_byte(scalar_output, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_WIDTH);
#endif
#if PRINT
        print_python_array(scalar_output, idst);
#endif

				int print_errors = MAX_PRINT_ERRORS;
        for(mode=0; mode<3; mode++){
            sync0 = mode > 0 ? 1 : 0;
            sync1 = mode > 1 ? 1 : 0;
            test_zero_array_byte(vbx_output, IMAGE_WIDTH*IMAGE_HEIGHT);
            printf("\nVector\t\tSync: %d,%d", sync0, sync1);
            time_start = vbx_timestamp();
            vector_fast9((uint8_t *)vbx_output, (uint8_t *)input,
                         IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH, THRESHOLD, sync0, sync1);
            time_stop = vbx_timestamp();
            vbx_time = vbx_print_vector_time(time_start, time_stop, scalar_time);
#if DEBUG
            test_print_matrix_byte(vbx_output, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_WIDTH);
#endif
            for (j = 3; j < IMAGE_HEIGHT-3; j++) {
                for (i = 3; i < IMAGE_WIDTH-3; i++) {
                    if(scalar_output[j*IMAGE_WIDTH+i] != vbx_output[j*IMAGE_WIDTH+i]){
                        if (errors < print_errors) {
                            printf("Vector Error at %d, %d: Expected = %02X, got = %02X\n",
                                    j, i, scalar_output[j*IMAGE_WIDTH+i], vbx_output[j*IMAGE_WIDTH+i]);
                        }
                        errors++;
                    }
                }
            }
						print_errors = errors+MAX_PRINT_ERRORS;
        }
        for(mode=0; mode<3; mode++){
            sync0 = mode > 0 ? 1 : 0;
            sync1 = mode > 1 ? 1 : 0;
            test_zero_array_byte(vbx_output_masked, IMAGE_WIDTH*IMAGE_HEIGHT);
            printf("\nVector masked\tSync: %d,%d", sync0, sync1);
            time_start = vbx_timestamp();
            vector_fast9_masked((uint8_t *)vbx_output_masked, (uint8_t *)input,
                                IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH, THRESHOLD, sync0, sync1);
            time_stop = vbx_timestamp();
            vbx_time_masked = vbx_print_vector_time(time_start, time_stop, scalar_time);
#if DEBUG
            test_print_matrix_byte(vbx_output_masked, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_WIDTH);
#endif

            for (j = 3; j < IMAGE_HEIGHT-3; j++) {
                for (i = 3; i < IMAGE_WIDTH-3; i++) {
                    if(scalar_output[j*IMAGE_WIDTH+i] != vbx_output_masked[j*IMAGE_WIDTH+i]){
                        if (errors < print_errors) {
                            printf("Masked Error at %d, %d: Expected = %02X, got = %02X\n",
                                    j, i, scalar_output[j*IMAGE_WIDTH+i], vbx_output_masked[j*IMAGE_WIDTH+i]);
                        }
                        errors++;
                    }
                }
            }
						print_errors = errors+MAX_PRINT_ERRORS;
        }
    }

	VBX_TEST_END(errors);
	return errors;
}
