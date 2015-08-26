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

#include "lbp.h"
#include "haar_detect.h"

int LBPPassCascade(image_t img, lbp_stage_t *cascade, pair_t p0, int max_stage);
int LBPPassStage(image_t img, lbp_stage_t stage, pair_t p0);
unsigned char SATBinaryPattern(image_t img, lbp_feat_t *feature, const pair_t p0);
unsigned int SATValue(image_t img, const cell_t cell, const pair_t p0);
unsigned int SATNormalizedValue(image_t img, const cell_t cell, const pair_t p0);
int CheckLUT(unsigned int *lut, unsigned char value);

vptr_word vector_row_lbp_2D(vptr_word v_int, vptr_word v_tmp, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage);
vptr_word vector_row_lbp_masked(vptr_word v_int, vptr_word v_tmp, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage);

unsigned char** LBPRestrictedSums(unsigned short *img, const unsigned width, const unsigned height, const unsigned log);
unsigned char** LBPRestrictedPatterns(unsigned char **sums, const unsigned width, const unsigned height, const unsigned log);
vptr_word vector_row_lbp_restricted_2D(vptr_ubyte *v_lbp, vptr_word v_tmp, int offset, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage);
vptr_word vector_row_lbp_restricted_masked(vptr_ubyte *v_lbp, vptr_word v_tmp, int offset, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage);

unsigned short** LBPRestrictedSums2(unsigned short *img, const unsigned width, const unsigned height, const unsigned log);
unsigned char** LBPRestrictedPatterns2(unsigned short *img, unsigned short **sums, const unsigned width, const unsigned height, const unsigned log);
unsigned char** LBPRestricted(unsigned short *img, const unsigned width, const unsigned height, const unsigned log);
unsigned short** ScalarLBPRestrictedSums(unsigned short* img, const unsigned width, const unsigned height, const unsigned log);
unsigned char** ScalarLBPRestrictedPatterns(unsigned short **sums, const unsigned width, const unsigned height, const unsigned log);
