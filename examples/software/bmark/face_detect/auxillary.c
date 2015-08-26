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

#include "auxillary.h"

void print_python_array(int32_t *dst, char* str, int width, int height)
{
    int i, j;
    printf("%s = [", str);
	for (j = 0; j < height; j++) {
		for (i = 0; i < width; i++) {
            if(!(i%32)){
                printf("\n");
            }
            printf("%d, ", dst[j*width+i]);
        }
        printf("\n");
    }
    printf("]\n");

}

void print_python_pixel(pixel *dst, char* str, int width, int height)
{
    int i, j;
    printf("%s = [", str);
	for (j = 0; j < height; j++) {
		for (i = 0; i < width; i++) {
            if(!(i%32)){
                printf("\n");
            }
            printf("%d, ", dst[j*width+i].r);
            printf("%d, ", dst[j*width+i].g);
            printf("%d, ", dst[j*width+i].b);
        }
        printf("\n");
    }
    printf("]\n");

}

int match_array_pixel(pixel *a, pixel *b, char *str, int width, int height, int max_print_errors, int joffset)
{
    int i, j;
    int errors = 0;
    for (j = 0; j < height; j++) {
        for (i = 0; i < width; i++) {
            if(a[j*width+i].r != b[j*width+i].r ||
               a[j*width+i].g != b[j*width+i].g ||
               a[j*width+i].b != b[j*width+i].b){
                if (errors < max_print_errors) {
                    printf("Error in %s at %d, %d: Expected = %d,%d,%d, got = %d,%d,%d\n",
                            str, j+joffset, i,
                            a[j*width+i].r,
                            a[j*width+i].g,
                            a[j*width+i].b,
                            b[j*width+i].r,
                            b[j*width+i].g,
                            b[j*width+i].b);
                }
                errors++;
            }
        }
    }
    return errors;
}

int match_array_word(unsigned int *a, unsigned int *b, char *str, int width, int height, int max_print_errors, int joffset)
{
    int i, j;
    int errors = 0;
    for (j = 0; j < height; j++) {
        for (i = 0; i < width; i++) {
            if(a[j*width+i] != b[j*width+i]){
                if (errors < max_print_errors) {
                    printf("Error in %s at %d, %d: Expected = %d, got = %d\n",
                            str, j+joffset, i, a[j*width+i], b[j*width+i]);
                }
                errors++;
            }
        }
    }
    return errors;
}

int match_array_half(unsigned short *a, unsigned short *b, char *str, int width, int height, int max_print_errors, int joffset)
{
    int i, j;
    int errors = 0;
    for (j = 0; j < height; j++) {
        for (i = 0; i < width; i++) {
            if(a[j*width+i] != b[j*width+i]){
                if (errors < max_print_errors) {
                    printf("Error in %s at %d, %d: Expected = %d, got = %d\n",
                            str, j+joffset, i, a[j*width+i], b[j*width+i]);
                }
                errors++;
            }
        }
    }
    return errors;
}

int match_array_byte(unsigned char *a, unsigned char *b, char *str, int width, int height, int max_print_errors, int bits, int joffset)
{
    int i, j, y;
    int errors = 0;
    for (j = 0; j < height; j++) {
        for (i = 0; i < width; i++) {
            if(a[j*width+i] != b[j*width+i]){
                if (errors < max_print_errors) {
                    if(bits){
                        printf("Error in %s at %d, %d: Expected = ", str, j+joffset, i);
                        for(y=0; y<8; y++){
                            printf("%d", (a[j*width+i] & (1<<(7-y)))>>(7-y));
                        }
                        printf(", got = ");
                        for(y=0; y<8; y++){
                            printf("%d", (b[j*width+i] & (1<<(7-y)))>>(7-y));
                        }
                        printf("\n");
                    } else {
                        printf("Error in %s at %d, %d: Expected = %d, got = %d\n",
                            str, j+joffset, i, a[j*width+i], b[j*width+i]);
                    }
                }
                errors++;
            }
        }
    }
    return errors;
}
