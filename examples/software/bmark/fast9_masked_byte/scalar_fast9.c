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

#include "fast9.h"

int y[16] = {-3, -3, -2, -1, 0, 1, 2, 3, 3,  3,  2,  1,  0, -1, -2, -3};
int x[16] = { 0,  1,  2,  3, 3, 3, 2, 1, 0, -1, -2, -3, -3, -3, -2, -1};
int r[16] = {0x01ff, 0x03fe, 0x07fc, 0x0ff8,
             0x1ff0, 0x3fe0, 0x7fc0, 0xff80,
             0xff01, 0xfe03, 0xfc07, 0xf80f,
             0xf01f, 0xe03f, 0xc07f, 0x80ff};

uint8_t r0[16] = {0xff, 0xfe, 0xfc, 0xf8,
                  0xf0, 0xe0, 0xc0, 0x80,
                  0x01, 0x03, 0x07, 0x0f,
                  0x1f, 0x3f, 0x7f, 0xff};

uint8_t r1[16] = {0x01, 0x03, 0x07, 0x0f,
                  0x1f, 0x3f, 0x7f, 0xff,
                  0xff, 0xfe, 0xfc, 0xf8,
                  0xf0, 0xe0, 0xc0, 0x80};

void generate_tiles(uint8_t *dst, uint8_t *src, int height, int width, int tiles)
{
    int jt, it, j, i;
    int value;
    for(jt=0; jt<tiles; jt++){
        for(j=0; j<height; j++){
            for(it=0; it<tiles; it++){
                for(i=0; i<width; i++){
                    value = src[j*width+i];
                    if((it%2 && jt%2)){
                        value = 100 - value;
                    }
                    dst[((jt*height)+j)*(tiles*width)+(it * width)+i] = value;
                }
            }
        }
    }
}

void highlight_matrix(uint8_t *src, int height, int width, int pitch, int x0, int y0)
{
    int i, j, k;
    int px[16];
    int py[16];
    for(k=0; k<16; k++){
        px[k] = x0 + x[k];
        py[k] = y0 + y[k];
    }
    int is_special;

    for(j=0; j<height; j++){
        for(i=0; i<width; i++){
            is_special = 0;

            for(k=0; k<16; k++){
                if(x0 == i && y0 == j){
                    is_special = 1;
                    break;
                }
                if(px[k] == i && py[k] == j){
                    is_special = 1;
                    break;
                }
            }
            if(is_special){
                printf("%3d_", src[j*pitch+i]);
            } else {
                printf("%3d ", src[j*pitch+i]);
            }
        }
        printf("\n");
    }
    printf("\n");
}

void scalar_fast9(uint8_t *dst, uint8_t *src, int height, int width, int pitch, int threshold)
{
    int i, j, k;
    uint8_t p[16];
    uint8_t p0;
    int darker_count, brighter_count;
    unsigned short darker, brighter;
    int early_exit_1 = 0, early_exit_2 = 0;

    for(j=3; j<height-3; j++){
        for(i=3; i<width-3; i++){
            darker = brighter = 0;
            darker_count = brighter_count = 0;
            p0 = src[j*pitch+i];
            // early exit #1 - if 1 or 9 is not brighter/darker than threshold
            if(abs(p0 - src[(j+y[0])*pitch+(i+x[0])]) <= threshold){
                if(abs(p0 - src[(j+y[8])*pitch+(i+x[8])]) <= threshold){
                    early_exit_1++;
                    continue;
                }
            }

            // early exit #2 - at least two must be brighter or darker
            for(k=0; k<16; k+=4){
                p[k]  = src[(j+y[k])*pitch+(i+x[k])];
                if(p0 - p[k] > threshold){
                    darker |= 1<<k;
                    darker_count++;
                } else if(p[k] - p0 > threshold){
                    brighter |= 1<<k;
                    brighter_count++;
                }
            }
            if(brighter_count < 2 && darker_count < 2){
                early_exit_2++;
                continue;
            }

            // otherwise calculate brighter / darker
            for(k=0; k<16; k++){
                if(k%4){
                    p[k]  = src[(j+y[k])*pitch+(i+x[k])];
                    if(p0 - p[k] > threshold){
                        darker |= 1<<k;
                    } else if(p[k] - p0 > threshold){
                        brighter |= 1<<k;
                    }
                }
            }
            for(k = 0; k<16; k++){
                if(r[k] == (darker & r[k])){
                    dst[j*pitch+i] = 1;
                    break;
                } else if(r[k] == (brighter & r[k])){
                    dst[j*pitch+i] = 1;
                    break;
                }
            }
        }
    }
#if nDEBUG
    printf("early exit totals:  #1 = %d\t#2 = %d\n", early_exit_1, early_exit_2);
    printf("early exit percent: #1 = %3.2f\t#2 = %3.2f\n",
           (1.0*early_exit_1)/((width-3-3)*(height-3-3))*100,
           (1.0*early_exit_2)/((width-3-3)*(height-3-3))*100);
#endif
}
