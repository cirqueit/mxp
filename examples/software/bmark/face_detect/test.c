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
VBXCOPYRIGHT(test_haar)

#include "test.h"
#include "auxillary.h"

//FIXME stride for match not implemented

int compare_LBPPassStage_to_restricted(unsigned short *vbx_img, int log, lbp_stage_t lbp_stage, int window, int width, int height, int max_print_errors)
{
    int l, i, j, cell, errors = 0;

    unsigned char** scalar_patterns = test_scalar_patterns(vbx_img, log, width, height);

    unsigned char *pass, *vbx_pass;
    pass = (unsigned char*)vbx_shared_malloc(width*height*sizeof(unsigned char));
    vbx_pass = (unsigned char*)vbx_shared_malloc(width*height*sizeof(unsigned char));
    
    vbx_byte_t** v_lbp =(vbx_byte_t**)vbx_shared_malloc((log+1)*sizeof(vbx_byte_t*));
    for (l=0; l<log+1; l++) {
        v_lbp[l] = (vbx_byte_t*)vbx_sp_malloc((window+1)*width*sizeof(vbx_byte_t)); 
    }
    vbx_byte_t* v_lut = (vbx_byte_t*)vbx_sp_malloc(width*sizeof(vbx_byte_t)); 
    vbx_byte_t* v_stage = (vbx_byte_t*)vbx_sp_malloc(width*sizeof(vbx_byte_t)); 
    vbx_byte_t* v_pattern;
    lbp_feat_t feat;
    int dx, dy, dw, f;

    for (l=0; l<log+1; l++) {
        vbx_dma_to_vector(v_lbp[l]+width, scalar_patterns[l], (window)*width*sizeof(unsigned char));
    }
    vbx_sync();
    for(j=0; j < height-(window+1); j++) {
        for (l=0; l<log+1; l++) {
            vbx_set_vl(width * window);
            vbx(VVB, VMOV, v_lbp[l], v_lbp[l]+width, NULL);
            vbx_dma_to_vector(v_lbp[l] + window*width, scalar_patterns[l]+(j+window)*width, width*sizeof(unsigned char));
        }

        vbx_set_vl(width-(window+1));
        vbx(SVB, VMOV, v_stage, 0, NULL);
        for (f = 0; f < lbp_stage.count; f++) {
            feat = lbp_stage.feats[f];
            dx = feat.pos.src.x;
            dy = feat.pos.src.y;
            dw = feat.pos.size.x;
            v_pattern = v_lbp[dw>>1]+(dy*width+dx);

            vbx(SVBU, VCUSTOM0, v_lut, f, v_pattern);
            vbx(VVB, VADD, v_stage, v_stage, v_lut);
        }
        vbx(SVB, VMOV, v_lut, 0, NULL);
        vbx(SVB, VCMV_GEZ, v_lut, 1, v_stage);
        vbx_dma_to_host(vbx_pass + j*width, v_lut, (width-(window+1))*sizeof(unsigned char));
        vbx_sync();
    }


    unsigned int *iImg, *iiImg;
    iImg = (unsigned int *)vbx_shared_malloc(width*height*sizeof(unsigned int));
    iiImg = (unsigned int *)vbx_shared_malloc(width*height*sizeof(unsigned int));

    gen_integrals(vbx_img, iImg, iiImg, width, height);

    image_t lbp_img = {iImg, {width, height}};
    for (j = 0; j < height - (window + 1); j++) {
        for (i = 0; i < width - (window + 1); i++) {
            pair_t lbp_p = {i, j};
            pass[j*width+i] = LBPPassStage(lbp_img, lbp_stage, lbp_p);
        }
    }

    /* test pass vs vbx pass */
    for (j = 0; j < height - (window + 1); j++) {
        errors += match_array_byte(vbx_pass + j*width, pass + j*width, "pass stage", width - (window + 1), 1, max_print_errors, 1, j);
        if (errors > max_print_errors){
            max_print_errors = 0;
        }
    }
    return errors;
}
int compare_scalar_BLIP2_to_vector_BLIP(unsigned short* img, pixel* vbx_input, int width, int height, int max_print_errors)
{
    int j, errors = 0;
    int value, scaled_width, scaled_height;

    /* scale facetor v/v+1, v is between 1-10 */
    value = 3; //BAD 2,5,6,8
    scaled_width = width*value/(value+1);
    scaled_height= height*value/(value+1);

    unsigned short *scaled_img, *vbx_img, *vbx_scaled_img;
    unsigned int *iImg, *iiImg, *vbx_iImg, *vbx_iiImg;

    scaled_img = (unsigned short*)vbx_shared_malloc(scaled_width*scaled_height*sizeof(unsigned short));

    iImg = (unsigned int*)vbx_shared_malloc(scaled_width*scaled_height*sizeof(unsigned int));
    iiImg = (unsigned int*)vbx_shared_malloc(scaled_width*scaled_height*sizeof(unsigned int));

    vbx_scaled_img = (unsigned short*)vbx_shared_malloc(scaled_width*scaled_height*sizeof(unsigned short));
    vbx_img = (unsigned short*)vbx_shared_malloc(width*height*sizeof(unsigned short));

    vbx_iImg = (unsigned int*)vbx_shared_malloc(width*height*sizeof(unsigned int));
    vbx_iiImg = (unsigned int*)vbx_shared_malloc(width*height*sizeof(unsigned int));


    scalar_BLIP2(img, height, width, scaled_img, scaled_height, scaled_width, value);
    gen_integrals(scaled_img, iImg, iiImg, scaled_width, scaled_height);

	vector_get_img(vbx_img, vbx_iImg, vbx_iiImg, vbx_input, 1, width, height, width, 1);
    vector_BLIP(vbx_img, height, width, vbx_scaled_img, vbx_iImg, vbx_iiImg, scaled_height, scaled_width, value, 1);

    /* test greyscale image */
    for (j = 0; j < height; j++) {
        errors += match_array_half(img+j*width, vbx_img+j*width, "greyscale", width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }

    /* test scaled image */
    for (j = 0; j < scaled_height; j++) {
        errors += match_array_half(scaled_img+j*scaled_width, vbx_scaled_img+j*scaled_width, "scaled greyscale", scaled_width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }

    /* test scaled_integral image */
    for (j = 0; j < scaled_height; j++) {
        errors += match_array_word(iImg+j*scaled_width, vbx_iImg+j*scaled_width, "scaled integral", scaled_width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }

    /* test scaled squared integral image */
    for (j = 0; j < scaled_height; j++) {
        errors += match_array_word(iiImg+j*scaled_width, vbx_iiImg+j*scaled_width, "scaled squared", scaled_width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }
    return errors;
}
int compare_gen_integrals_to_vector_get_img(unsigned short* img, unsigned int* iImg, unsigned int* iiImg, unsigned short* vbx_img, unsigned int* vbx_iImg, unsigned int* vbx_iiImg, pixel* vbx_input, int width, int height, int max_print_errors)
{
    int j, errors = 0;

    gen_integrals(img, iImg, iiImg, width, height);
    /* bin is 1*/
	vector_get_img(vbx_img, vbx_iImg, vbx_iiImg, vbx_input, 1, width, height, width, 1);

    /* test greyscale image */
    for (j = 0; j < height; j++) {
        errors += match_array_half(img+j*width, vbx_img+j*width, "greyscale", width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }

    /* test integral image */
    for (j = 0; j < height; j++) {
        errors += match_array_word(iImg+j*width, vbx_iImg+j*width, "integral", width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }

    /* test squared integral image */
    for (j = 0; j < height; j++) {
        errors += match_array_word(iiImg+j*width, vbx_iiImg+j*width, "squared", width, 1, max_print_errors, j);
        if(errors > max_print_errors) {
            max_print_errors = 0;
        }
    }
    return errors;
}

int compare_LBPRestricted_to_test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int j, l, cell, errors = 0;

    /* generate patterns */
    unsigned char **patterns = LBPRestricted(vbx_img, width, height, log);
    unsigned char** scalar_patterns = test_scalar_patterns(vbx_img, log, width, height);


    /* test sums vs scalar sums */
    for (l=0; l<log+1; l++) {
        cell = 1 << l;
        for (j = 0; j < height - (3*cell-1); j++) {
            errors += match_array_byte(scalar_patterns[l]+j*width, patterns[l]+j*width, "restricted patterns", width - (3*cell-1), 1, max_print_errors, 1, j);
            if(errors > max_print_errors) {
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_LBPRestrictedPatterns2_to_test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int cell, errors = 0;
    int i, j;

    /* generate patterns */
    unsigned short **sums = LBPRestrictedSums2(vbx_img, width, height, log);
    unsigned char **patterns = LBPRestrictedPatterns2(vbx_img, sums, width, height, log);

    unsigned char** scalar_patterns = test_scalar_patterns(vbx_img, log, width, height);

    /* test sums vs scalar sums */
    for (j=0; j<log+1; j++) {
        cell = 1 << j;
        for (i = 0; i < height - (3*cell-1); i++) {
            errors += match_array_byte(scalar_patterns[j]+i*width, patterns[j]+i*width, "patterns", width - (3*cell-1), 1, max_print_errors, 1, i);
            if(errors > max_print_errors) {
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_LBPRestrictedPatterns_to_test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int cell, errors = 0;
    int i, j;

    /* generate patterns */
    unsigned char **sums = LBPRestrictedSums(vbx_img, width, height, log);
    unsigned char **patterns = LBPRestrictedPatterns(sums, width, height, log);

    unsigned char** scalar_patterns = test_scalar_patterns(vbx_img, log, width, height);

    /* test patterns vs scalar patterns */
    for (j=0; j<log+1; j++) {
        cell = (1 << j);
        for (i = 0; i < height - (3*cell-1); i++) {
            errors += match_array_byte(scalar_patterns[j]+i*width, patterns[j]+i*width, "patterns", width - (3*cell-1), 1, max_print_errors, 1, i);
            if(errors > max_print_errors) {
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_ScalarLBPRestrictedPatterns_to_SATBinaryPattern(unsigned short *vbx_img, int log, int width, int height, int max_print_errors)
{
    int l, i, j, cell, errors = 0;

    /* generate patterns */
    unsigned short **sums = ScalarLBPRestrictedSums(vbx_img, width, height, log);
    unsigned char **patterns = ScalarLBPRestrictedPatterns(sums, width, height, log);

    unsigned char **sat_patterns = (unsigned char**)vbx_shared_malloc((log+1)*sizeof(unsigned char*));
    for (l=0; l<log+1; l++) {
        sat_patterns[l] = (unsigned char*)vbx_shared_malloc(width*height*sizeof(unsigned char));
    }

    unsigned int *iImg, *iiImg;
    iImg = (unsigned int *)vbx_shared_malloc(width*height*sizeof(unsigned int));
    iiImg = (unsigned int *)vbx_shared_malloc(width*height*sizeof(unsigned int));
    gen_integrals(vbx_img, iImg, iiImg, width, height);

    image_t lbp_img = {iImg, {width, height}};
    for (l=0; l<log+1; l++) {
        cell = 1 << l;
        lbp_feat_t lbp_feat = {{{0, 0}, {cell, cell}}, 0, 0, {0, 0, 0, 0, 0, 0, 0, 0}};
        for (j = 0; j < height - (3*cell-1); j++) {
            for (i = 0; i < width - (3*cell-1); i++) {
                pair_t lbp_p = {i, j};
                sat_patterns[l][j*width+i] = SATBinaryPattern(lbp_img, &lbp_feat, lbp_p);
            }
        }
    }

    /* test patterns vs sat binary patterns */
    for (l=0; l<log+1; l++) {
        cell = 1 << l;
        for (j = 0; j < height - (3*cell-1); j++) {
            errors += match_array_byte(patterns[l] + j*width, sat_patterns[l] + j*width, "patterns", width - (3*cell-1), 1, max_print_errors, 1, j);
            if (errors > max_print_errors){
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_SATBinaryPattern_to_test_scalar_patterns(unsigned short *vbx_img, int log, int width, int height, int max_print_errors)
{
    int l, i, j, cell, errors = 0;

    unsigned char** scalar_patterns = test_scalar_patterns(vbx_img, log, width, height);

    unsigned char **sat_patterns = (unsigned char**)vbx_shared_malloc((log+1)*sizeof(unsigned char*));
    for (l=0; l<log+1; l++) {
        sat_patterns[l] = (unsigned char*)vbx_shared_malloc(width*height*sizeof(unsigned char));
    }

    unsigned int *iImg, *iiImg;
    iImg = (unsigned int *)vbx_shared_malloc(width*height*sizeof(unsigned int));
    iiImg = (unsigned int *)vbx_shared_malloc(width*height*sizeof(unsigned int));
    gen_integrals(vbx_img, iImg, iiImg, width, height);

    image_t lbp_img = {iImg, {width, height}};
    for (l=0; l<log+1; l++) {
        cell = 1 << l;
        lbp_feat_t lbp_feat = {{{0, 0}, {cell, cell}}, 0, 0, {0, 0, 0, 0, 0, 0, 0, 0}};
        for (j = 0; j < height - (3*cell-1); j++) {
            for (i = 0; i < width - (3*cell-1); i++) {
                pair_t lbp_p = {i, j};
                sat_patterns[l][j*width+i] = SATBinaryPattern(lbp_img, &lbp_feat, lbp_p);
            }
        }
    }

    /* test patterns vs sat binary patterns */
    for (l=0; l<log+1; l++) {
        cell = 1 << l;
        for (j = 0; j < height - (3*cell-1); j++) {
            errors += match_array_byte(scalar_patterns[l] + j*width, sat_patterns[l] + j*width, "patterns", width - (3*cell-1), 1, max_print_errors, 1, j);
            if (errors > max_print_errors){
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_ScalarLBPRestrictedPatterns_to_test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int i, j, cell, errors = 0;

    /* generate patterns */
    unsigned short **sums = ScalarLBPRestrictedSums(vbx_img, width, height, log);
    unsigned char **patterns = ScalarLBPRestrictedPatterns(sums, width, height, log);

    unsigned char** scalar_patterns = test_scalar_patterns(vbx_img, log, width, height);

    /* test patterns vs scalar patterns */
    for (j=0; j<log+1; j++) {
        cell = 1 << j;
        for (i = 0; i < height - (3*cell-1); i++) {
            errors += match_array_byte(scalar_patterns[j] + i*width, patterns[j] + i*width, "patterns", width - (3*cell-1), 1, max_print_errors, 1, i);
            if (errors > max_print_errors){
                max_print_errors = 0;
            }
        }
    }
    return errors;
}
int compare_ScalarLBPRestrictedSums_to_test_scalar_sums_half(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int i, j, cell, errors = 0;

    /* generate sums */
    unsigned short **sums = ScalarLBPRestrictedSums(vbx_img, width, height, log);
    unsigned short **scalar_sums = test_scalar_sums_half(vbx_img, log, width, height);

    /* test sums vs scalar sums */
    for (j=0; j<log+1; j++) {
        cell = 1 << j;
        for (i = 0; i < height - (cell-1); i++) {
            errors += match_array_half(scalar_sums[j] + i*width, sums[j] + i*width, "sum", width - (cell-1), 1, max_print_errors, i);
            if (errors > max_print_errors){
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_LBPRestrictedSums2_to_test_scalar_sums_half(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int cell, errors = 0;
    int i, j;

    /* generate sums */
    unsigned short **sums = LBPRestrictedSums2(vbx_img, width, height, log);
    unsigned short **scalar_sums = test_scalar_sums_half(vbx_img, log, width, height);

    /* test sums vs scalar sums */
    for (j=1; j<log+1; j++) {
        cell = 1 << j;
        for (i = 0; i < height - (cell - 1); i++) {
            errors += match_array_half(scalar_sums[j]+i*width, sums[j]+i*width, "sum", width - (cell - 1), 1, max_print_errors, i);
            if (errors > max_print_errors){
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

int compare_LBPRestrictedSums_to_test_scalar_sums_byte(unsigned short* vbx_img, int log, int width, int height, int max_print_errors)
{
    int cell, errors = 0;
    int i, j;

    /* generate sums */
    unsigned char **sums = LBPRestrictedSums(vbx_img, width, height, log);
    unsigned char **scalar_sums = test_scalar_sums_byte(vbx_img, log, width, height);

    /* test sums vs scalar sums */
    for (j=0; j<log+1; j++) {
        cell = 1 << j;
        for (i = 0; i < height - (cell-1); i++) {
            errors += match_array_byte(scalar_sums[j]+i*width, sums[j]+i*width, "sum", width - (cell-1), 1, max_print_errors, 0, i);
            if (errors > max_print_errors){
                max_print_errors = 0;
            }
        }
    }
    return errors;
}

unsigned char** test_scalar_patterns(unsigned short* vbx_img, int log, int width, int height)
{
    int k, j, i, n, m;
    unsigned char** scalar_patterns = (unsigned char**)malloc((log+1) * sizeof(unsigned char*));
    for (k = 0; k < log+1; k++){
        scalar_patterns[k] = (unsigned char*)malloc(width*height*sizeof(unsigned char));
        
    }
    int p, p0, px, cell, pattern;
    int coeff_x[] = {0, 1, 2, 2, 2, 1, 0, 0};
    int coeff_y[] = {0, 0, 0, 1, 2, 2, 2, 1};
    for (k = 0; k < log+1; k++){
        cell = 1 << k;
        for (j = 0; j < height - (3*cell-1); j++){
            for (i = 0; i < width - (3*cell-1); i++){
                /* calculate center */
                p0 = 0;
                for (n = 0; n < cell; n++) {
                    for (m = 0; m < cell; m++){
                        p0 += vbx_img[(j+n+cell)*width+(i+m+cell)];
                    }
                }
                pattern = 0;
                for (p = 0; p < 8; p++){
                    px = 0;
                    for (n = 0; n < cell; n++){
                        for (m = 0; m < cell; m++){
                            px += vbx_img[(j+n+coeff_y[p]*cell)*width+(i+m+coeff_x[p]*cell)];
                        }
                    }
                    if(px >= p0){
                        pattern += 1 << (7-p);
                    }
                }
                scalar_patterns[k][j*width+i] = pattern;
            }
        }
    }
    return scalar_patterns;
}

unsigned char** test_scalar_sums_byte(unsigned short* vbx_img, int log, int width, int height)
{
    int k, j, i, n, m, cell;
    unsigned char** scalar_sums = (unsigned char**)malloc((log+1) * sizeof(unsigned char*));
    for (k = 0; k < log+1; k++){
        scalar_sums[k] = (unsigned char*)vbx_shared_malloc(width*height*sizeof(unsigned char));
    }
    for (k = 0; k < log+1; k++){
        cell = 1 << k;
        for (j = 0; j < height - (cell-1); j++){
            for (i = 0; i < width - (cell-1); i++){
                unsigned total = 0;
                for (n = 0; n < cell; n++){
                    for (m = 0; m < cell; m++){
                        total += vbx_img[(j+n)*width+(i+m)];
                    }
                }
                scalar_sums[k][j*width+i] = total >> (2*k);
            }
        }
    }
    return scalar_sums;
}

unsigned short** test_scalar_sums_half(unsigned short* vbx_img, int log, int width, int height)
{
    int k, j, i, n, m, cell;
    unsigned short** scalar_sums = (unsigned short**)malloc((log+1) * sizeof(unsigned short*));
    for (k = 0; k < log+1; k++){
        scalar_sums[k] = (unsigned short*)vbx_shared_malloc(width*height*sizeof(unsigned short));
    }
    for (k = 0; k < log+1; k++){
        cell = 1 << k;
        for (j = 0; j < height - (cell - 1); j++){
            for (i = 0; i < width - (cell - 1); i++){
                unsigned total = 0;
                for (n = 0; n < cell; n++){
                    for (m = 0; m < cell; m++){
                        total += vbx_img[(j+n)*width+(i+m)];
                    }
                }
                scalar_sums[k][j*width+i] = total;
            }
        }
    }
    return scalar_sums;
}

int compare_scalar_rgb2luma_to_vbw_rgb2luma16(unsigned short *img, unsigned short *vbx_img, pixel *vbx_input, int width, int height, int stride, int max_print_errors)
{
    int errors;
    scalar_rgb2luma(img, vbx_input, width, height, stride);
    vbw_rgb2luma16(vbx_img, vbx_input, width, height, stride);
    vbx_sync();

    errors = match_array_half(img, vbx_img, "greyscale", width, height, max_print_errors, 0);
    return errors;
}

int compare_vbx_lbp_ci_to_scalar_patterns(unsigned short* img, int width, int height, int max_print_errors)
{
    int j, errors = 0;
    unsigned char** scalar_patterns = test_scalar_patterns(img, 0, width, height);

    vbx_ubyte_t* v_in = (vbx_ubyte_t*)vbx_sp_malloc(3*width*sizeof(vbx_word_t));
    vbx_ubyte_t* v_top = (vbx_byte_t*)vbx_sp_malloc(width*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_bot = (vbx_byte_t*)vbx_sp_malloc(width*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_lbp = v_bot;

    unsigned char* lbp = (unsigned char*)vbx_shared_malloc(width*sizeof(unsigned char));

    vbx_set_vl(width);
    for(j=0; j < height - 2; j++){
        vbx_dma_to_vector(v_in, img+j*width, 3*width*sizeof(unsigned char));
        vbx(VVHU, VCUSTOM1, v_top, v_in, v_in+width); 
        vbx(VVHU, VCUSTOM1, v_bot, v_in+width, v_in+2*width); 
        vbx(SVHBU, VAND, v_top, 0xf0, v_top);
        vbx(SVHBU, VAND, v_bot, 0x0f, v_bot);
        vbx(VVBU, VADD, v_lbp, v_bot, v_top); 
        vbx_dma_to_host(lbp, v_lbp, width*sizeof(unsigned char));
        vbx_sync();

        errors = match_array_byte(lbp, scalar_patterns[0]+j*width, "custom_lbp", width-2, 1, max_print_errors, 1, j);

    }
    vbx_sp_free();
    vbx_shared_free(lbp);
    return errors;
}

int compare_vbx_lut_to_vbx_lut_ci(int sz, int max_print_errors)
{
    int f, n, errors;

    vbx_byte_t* v_pass = (vbx_byte_t*)vbx_sp_malloc(sz*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_pattern = (vbx_ubyte_t*)vbx_sp_malloc(sz*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_lutc = (vbx_ubyte_t*)vbx_sp_malloc(sz*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_group = (vbx_ubyte_t*)vbx_sp_malloc(sz*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_sel = (vbx_ubyte_t*)vbx_sp_malloc(sz*sizeof(vbx_byte_t));
    vbx_ubyte_t* v_lut = (vbx_ubyte_t*)vbx_sp_malloc(sz*sizeof(vbx_word_t));
    vbx_ubyte_t* v_idx = (vbx_ubyte_t*)vbx_sp_malloc(sz*sizeof(vbx_word_t));

    unsigned char* lut = (unsigned char*)vbx_shared_malloc(sz*sizeof(unsigned char));
    unsigned char* lut_c = (unsigned char*)vbx_shared_malloc(sz*sizeof(unsigned char));

    for (n = 0; n < sz; n++) {
        v_pattern[n] = n & 0xff;
    }

    int s, stage = 11;
    for (f = 0; f < face_lbp[stage].count; f++) {
        lbp_feat_t feat = face_lbp[stage].feats[f];

        vbx_set_vl(sz);
        int total = f;
        s = 0;
        while(s < stage){
            total += face_lbp[s].count;
            s++;
        }
        vbx(SVBU, VCUSTOM0, v_lutc, total, v_pattern);

        vbx(SVB, VMOV, v_pass, feat.fail, 0);
        /* check if pattern is in lut */
        vbx(SVBU, VSHR, v_group, 5, v_pattern);
        for (n = 0; n < 8; n++) {
            vbx(SVB, VADD, v_sel, -n, v_group);
            vbx(SVBW, VCMV_Z, v_lut, feat.lut[n], v_sel);
        }

        vbx(SVBWU, VAND, v_idx, 0x1f, v_pattern);
        vbx(VVWB, VSHR, v_lut, v_idx, v_lut);
        vbx(SVB, VAND, v_lut, 1, v_lut);
        vbx(SVB, VCMV_LEZ, v_pass, feat.pass, v_lut);

        vbx_dma_to_host(lut_c, v_lutc, sz*sizeof(unsigned char));
        vbx_dma_to_host(lut, v_pass, sz*sizeof(unsigned char));
        vbx_sync();

        errors = match_array_byte(lut_c, lut, "custom_lut", sz, 1, max_print_errors, 0, 0);

    }
    vbx_sp_free();
    vbx_shared_free(lut);
    vbx_shared_free(lut_c);
    return errors;
}

int main(void)
{

	vbx_timestamp_t time_start, time_stop;
	double scalar_time, vbx_time, vbx_time_masked;
	int i, j, k, l, m, n;
	int errors = 0;

	vbx_test_init();
	vbx_mxp_print_params();
    pixel *input, *scalar_input, *vbx_input, *vbx_input_masked;
    uint16_t *scalar_short;

	input         = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_input  = (pixel *)vbx_remap_cached(input, IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_short  = (uint16_t *)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(uint16_t));
	vbx_input    = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	vbx_input_masked  = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));

#if UNIT
    unsigned short *img, *vbx_img;
    unsigned int *iImg, *vbx_iImg;
    unsigned int *iiImg, *vbx_iiImg;
    img = (unsigned short*)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned short));
    vbx_img = (unsigned short*)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned short));

    iImg = (unsigned int*)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned int));
    vbx_iImg = (unsigned int*)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned int));

    iiImg = (unsigned int*)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned int));
    vbx_iiImg = (unsigned int*)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned int));
#endif//UNIT

	printf("Resolution = %dx%d\n", IMAGE_WIDTH, IMAGE_HEIGHT);
    printf("Initializing data\n");
	vbx_timestamp_start();
    for(l = 0; l < 1; l++){
        char *src;
        char *sdst;
        char *vdst;
        char *mdst;
        if(l == 0){
            load_lenna(input, IMAGE_WIDTH, IMAGE_HEIGHT);
            load_lenna(vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT);
            load_lenna(vbx_input_masked, IMAGE_WIDTH, IMAGE_HEIGHT);
            printf("\nLenna\n");
            src = "lenna";
            sdst = "s_lenna";
            vdst = "v_lenna";
            mdst = "m_lenna";
        }else if(l == 1){
            load_ms(input, IMAGE_WIDTH, IMAGE_HEIGHT);
            load_ms(vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT);
            load_ms(vbx_input_masked, IMAGE_WIDTH, IMAGE_HEIGHT);
            printf("\nMicrosoft\n");
            src = "ms";
            sdst = "s_ms";
            vdst = "v_ms";
            mdst = "m_ms";
        }else if(l == 2){
            load_blank(input, IMAGE_WIDTH, IMAGE_HEIGHT);
            load_blank(vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT);
            load_blank(vbx_input_masked, IMAGE_WIDTH, IMAGE_HEIGHT);
            printf("\nblank\n");
            src = "blank";
            sdst = "s_blank";
            vdst = "v_blank";
            mdst = "m_blank";
        }
#if UNIT
    int window = 20;
    int log=0;
    while(((window/3)>>log) >= 2) log++;

#if LUT_CI
    /* errors += compare_vbx_lut_to_vbx_lut_ci(1024, MAX_PRINT_ERRORS); */
#endif
#if LBP_CI
    errors += compare_vbx_lbp_ci_to_scalar_patterns(vbx_img, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);
#endif
    errors += compare_scalar_rgb2luma_to_vbw_rgb2luma16(img, vbx_img, vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, MAX_PRINT_ERRORS);
    /* errors += compare_LBPRestrictedSums_to_test_scalar_sums_byte(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS); */
    /* errors += compare_LBPRestrictedSums2_to_test_scalar_sums_half(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS); */
    /* errors += compare_ScalarLBPRestrictedSums_to_test_scalar_sums_half(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS); */
    /* errors += compare_ScalarLBPRestrictedPatterns_to_test_scalar_patterns(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS); */
    /* errors += compare_LBPRestrictedPatterns2_to_test_scalar_patterns(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS); */
    errors += compare_LBPRestricted_to_test_scalar_patterns(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);
#if 0
    /* overflow issues -- using bytes changes lbp pattern */
    errors += compare_LBPRestrictedPatterns_to_test_scalar_patterns(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);

    /* requires SKIP_INTEGRALS 0 */
    errors += compare_gen_integrals_to_vector_get_img(img, iImg, iiImg, vbx_img, vbx_iImg, vbx_iiImg, vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);

    /* currently last values have errors if the scaled images size is not an integer, width * f/ (f+1) */
    errors += compare_scalar_BLIP2_to_vector_BLIP(img, vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);

    /* redundant test, compare to test_scalar_patterns instead */
    errors += compare_ScalarLBPRestrictedPatterns_to_SATBinaryPattern(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);

    errors += compare_SATBinaryPattern_to_test_scalar_patterns(vbx_img, log, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);

#endif
    errors += compare_LBPPassStage_to_restricted(vbx_img, log, face_lbp[0], window, IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS);
#else // UNIT

#if PRINT
        print_python_pixel(scalar_input, src, IMAGE_WIDTH, IMAGE_HEIGHT);
#endif

        time_start = vbx_timestamp();
        scalar_rgb2luma(scalar_short, input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH);
        scalar_face_detect_luma(scalar_short, input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, sdst);
        time_stop = vbx_timestamp();
        scalar_time = vbx_print_scalar_time(time_start, time_stop);
#if PRINT
        print_python_pixel(scalar_input, sdst, IMAGE_WIDTH, IMAGE_HEIGHT);
#endif
        printf("\nVector");
        time_start = vbx_timestamp();
        vector_face_detect((pixel *)vbx_input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, 0, vdst);
        time_stop = vbx_timestamp();
        vbx_time = vbx_print_vector_time(time_start, time_stop, scalar_time);
#if PRINT
        print_python_pixel(vbx_input, vdst, IMAGE_WIDTH, IMAGE_HEIGHT);
#endif

        printf("\nVector Masked");
        time_start = vbx_timestamp();
        vector_face_detect((pixel *)vbx_input_masked, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, 1, mdst);
        time_stop = vbx_timestamp();
        vbx_time_masked = vbx_print_vector_time(time_start, time_stop, scalar_time);
#if PRINT
        print_python_pixel(vbx_input_masked, mdst, IMAGE_WIDTH, IMAGE_HEIGHT);
#endif
        /* errors += match_array_pixel(input, vbx_input, "vector", IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS, 0); */
        /* errors += match_array_pixel(input, vbx_input_masked, "masked", IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS, 0); */
        errors += match_array_pixel(vbx_input, vbx_input_masked, "masked", IMAGE_WIDTH, IMAGE_HEIGHT, MAX_PRINT_ERRORS, 0);
#endif // UNIT
    }
	VBX_TEST_END(errors);
	return errors;
}
