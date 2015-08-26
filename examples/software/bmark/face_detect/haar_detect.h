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


#ifndef __HAAR_DETECT_H
#define __HAAR_DETECT_H

#include "demo.h"
#include <stdio.h>
#include <math.h>
#include "draw.h"

#define LBP_CI          0
#define LUT_CI          0
#define USE_BYTES       1
#define USE_RESTRICTED  1
#define USE_LBP         1

#define DEBUG        0
#define DRAW_FACES   1
#define PRINT_FACES  0
#define PRINT_MERGED 0
#define PRINT_ASCII  0

#if DEBUG
extern int stage_count[22];
extern int prev_frame;
#endif

//1 - blank, 2 - lenna, 3 - ms
#define LOAD_IMAGE 0

#if LOAD_IMAGE
#define SCALE_FACTOR ((int) 1000.0 * 1.1)
#define INITIAL_ZOOM  ((int) 1000.0 * 1.0)
#define BIN 1
#else
#define SCALE_FACTOR ((int) 1000.0 * 1.125)
#define INITIAL_ZOOM  ((int) 1000.0 * 5.0)
#define BIN 4
#endif
#define Y_STEP 1
#define MIN_NEIGHBORS 4
#define LBP_NEIGHBORS 4


#define USE_MASKED             (VBX_GET_THIS_MXP()->mask_partitions)
#define HALFWORD_INTERMEDIATES 1
#define WAVES_2D               24
#define SQRT_CI                0
#define SQRT_FXP16             0
#define SCAN_CI                0
#define SKIP_HAAR_STAGES       0
#define SKIP_HAAR_COMPUTE      0
#define SKIP_HAAR              0
#define SKIP_INTEGRALS         USE_RESTRICTED
#define SKIP_RESIZE            0
#define SKIP_APPEND_FEATURE    0
#define SKIP_MERGE_FEATURE     0

#define SWAP(x1,x2,tmp) do { tmp=x1; x1=x2; x2=tmp; } while(0)
typedef vbx_uword_t* vptr_uword;
typedef vbx_uhalf_t* vptr_uhalf;
typedef vbx_ubyte_t* vptr_ubyte;
typedef vbx_word_t* vptr_word;
typedef vbx_half_t* vptr_half;
typedef vbx_byte_t* vptr_byte;

feat* vector_face_detect(pixel *input, const int image_width, const int image_height, const int image_pitch, short use_masked, char *str, const int return_features);

//dynamically add features to the feature set -- implemented as a linked list
feat* append_feature(feat* features, int x0, int y0, int w0);

//free all features that had been dynamically allocated
void free_features(feat* features);

feat* pop_biggest(feat* feature);

//check if two features overlap, indicating they may point to the same object
int overlapped_features( int ax, int ay, int aw , int bx, int by, int bw );

//merge overlapping features, producing a reduced feature list where overlapped features are averaged together
feat* merge_features(feat* raw, feat* merged, const int min_neighbors);
void print_merged(feat* merged, char *str);
void print_ascii(feat* feature, int const width, const int height);

//find and display the features found in an image using a haar cascade
feat* scalar_face_detect_luma(unsigned short *input, pixel *output, const int image_width, const int image_height, const int image_pitch, char* str, const int return_features);
#endif //__HAAR_DETECT_H
