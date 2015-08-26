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

#ifndef __TEST_H
#define __TEST_H

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "haar.h"
#include "lbp.h"

#include "blank_small.h"
#include "lenna.h"
#include "ms_small.h"

#define PRINT 0
#define UNIT 1
#define IMAGE_WIDTH 320
#define IMAGE_HEIGHT 240
#define MAX_PRINT_ERRORS 10
#define DEBUG 0

int compare_scalar_rgb2luma_to_vbw_rgb2luma16(unsigned short *img, unsigned short *vbx_img, pixel *vbx_input, int width, int height, int stride, int max_print_errors);
int compate_vbx_lut_to_vbx_lut_ci(int sz, int max_print_errors);
int compare_LBPRestrictedSums_to_test_scalar_sums_byte(unsigned short* vbx_img, int log, int width, int height, int max_print_errors);
int compare_LBPRestrictedSums2_to_test_scalar_sums_half(unsigned short* vbx_img, int log, int width, int height, int max_print_errors);
int compare_ScalarLBPRestrictedSums_to_test_scalar_sums_half(unsigned short* vbx_img, int log, int width, int height, int max_print_errors);
int compare_LBPRestrictedPatterns_to_test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height, int max_print_errors);
int compare_LBPRestricted_to_test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height, int max_print_errors);
int compare_LBPPassStage_to_restricted(unsigned short *vbx_img, int log, lbp_stage_t lbp_stage, int window, int width, int height, int max_print_errors);

unsigned char** test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height);
unsigned char** test_scalar_sums_byte(unsigned short* vbx_img, int log, int width, int height);
unsigned short** test_scalar_sums_half(unsigned short* vbx_img, int log, int width, int height);

#endif //__TEST_H
