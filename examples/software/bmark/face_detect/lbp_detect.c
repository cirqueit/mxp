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

#include "lbp_detect.h"

unsigned short** ScalarLBPRestrictedSums(unsigned short* img, const unsigned width, const unsigned height, const unsigned log)
{
	int i, j, l, n, m, offset, sum;
    unsigned short **sums = (unsigned short**)malloc((log+1)*sizeof(unsigned short*));

    for (l=0; l < log+1; l++) {
        sums[l] = (unsigned short*)vbx_shared_malloc(height*width*sizeof(unsigned short));
    }

    for(l = 0; l < log+1; l++) {
        offset = (1 << l);
        for (j = 0; j < height - (offset-1); j++) {
            for (i = 0; i < width - (offset-1); i++) {
                sum = 0;
                for (n = 0; n < offset; n++) {
                    for (m = 0; m < offset; m++) {
                        sum += img[(j+n)*width+(i+m)];
                    }
                }
                sums[l][j*width + i] = sum;
            }
        }
    }
    return sums;
}

unsigned char** ScalarLBPRestrictedPatterns(unsigned short **sums, const unsigned width, const unsigned height, const unsigned log)
{
	int i, j, l, n, cell, center, neighbor;
    unsigned char pattern;

    int coeff_x[8] = {0, 1, 2, 2, 2, 1, 0, 0};
    int coeff_y[8] = {0, 0, 0, 1, 2, 2, 2, 1};

    unsigned char **patterns = (unsigned char**)malloc((log+1)*sizeof(unsigned char*));

    for (l=0; l<log+1; l++) {
        patterns[l] = (unsigned char*)vbx_shared_malloc(height*width*sizeof(unsigned char));
    }

    for(l = 0; l < log+1; l++) {
        cell = 1 << l;

        for (j = 0; j < height - cell*2; j++) {
            for (i = 0; i < width - cell*2; i++) {
                pattern = 0;
                center = sums[l][(j+cell)*width + (i+cell)];

                for (n = 0; n < 8; n++) {
                    neighbor = sums[l][(j+coeff_y[n]*cell)*width + (i+coeff_x[n]*cell)];

                    if (neighbor >= center) {
                        pattern += 1 << (7-n);
                    }
                }
                patterns[l][j*width+i] = pattern;
            }
        }
    }
    return patterns;
}

unsigned char** LBPRestrictedSums(unsigned short* img, const unsigned width, const unsigned height, const unsigned log)
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int i, j, offset, rows, max_rows;


    unsigned short *tmp = (unsigned short*)vbx_shared_malloc(height*width*sizeof(unsigned short));
    unsigned char **sums = (unsigned char**)malloc((log+1)*sizeof(unsigned char*));
    for (i=0; i<log+1; i++) {
        sums[i] = (unsigned char*)vbx_shared_malloc(height*width*sizeof(unsigned char));
    }

    max_rows = this_mxp->scratchpad_size/(width*(sizeof(vbx_uhalf_t)+sizeof(vbx_ubyte_t)));
    if (max_rows > height) {
        max_rows = height;
    }
    vbx_uhalf_t *v_x = (vbx_uhalf_t*)vbx_sp_malloc(max_rows*width*sizeof(vbx_uhalf_t));
    vbx_ubyte_t *v_b = (vbx_ubyte_t*)vbx_sp_malloc(max_rows*width*sizeof(vbx_ubyte_t));

    for(i = 0; i < log; i++) {
        offset = 1<<i;
        rows = max_rows - offset;

        for (j = 0; j < height; j = j+rows) {
            if(j+rows >= height) {
                rows = height - j;
            }
            if (i == 0) {
                vbx_dma_to_vector(v_x, img + j*width, (rows+offset)*width*sizeof(unsigned short));
                vbx_set_vl(width*rows);
                vbx(VVHBU, VMOV, v_b, v_x, 0);
                vbx_dma_to_host(sums[0]+ j*width, v_b, rows*width*sizeof(vbx_ubyte_t));
            } else {
                vbx_dma_to_vector(v_x, tmp + j*width, (rows+offset)*width*sizeof(unsigned short));
            }
            vbx_set_vl(width);
            /* requires loading in *offset* extra rows */
            vbx_set_2D(rows+offset, width*sizeof(vbx_half_t), width*sizeof(vbx_half_t), width*sizeof(vbx_half_t));
            vbx_2D(VVHU, VADD, v_x, v_x, v_x + offset);
            vbx_set_2D(rows, width*sizeof(vbx_half_t), width*sizeof(vbx_half_t), width*sizeof(vbx_half_t));
            vbx_2D(VVHU, VADD, v_x, v_x, v_x + offset*width);
            if (i < log - 1) {
                vbx_dma_to_host(tmp + j*width, v_x, rows*width*sizeof(vbx_uhalf_t));
            }
            vbx_set_2D(rows, width*sizeof(vbx_byte_t), 0, width*sizeof(vbx_half_t));
            vbx_2D(SVHBU, VSHR, v_b, 2*offset, v_x);
            vbx_dma_to_host(sums[i+1]+ j*width, v_b, rows*width*sizeof(vbx_ubyte_t));
        }
    }
    vbx_sync();
    vbx_sp_free();
    vbx_shared_free(tmp);

    return sums;
}

unsigned char** LBPRestrictedPatterns(unsigned char **sums, const unsigned width, const unsigned height, const unsigned log)
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int i, j, n, rows, max_rows, cell;

    int coeff_x[8] = {0, 1, 2, 2, 2, 1, 0, 0};
    int coeff_y[8] = {0, 0, 0, 1, 2, 2, 2, 1};

    unsigned char **patterns = (unsigned char**)malloc((log+1)*sizeof(unsigned char*));

    for (i=0; i<log+1; i++) {
        patterns[i] = (unsigned char*)vbx_shared_malloc(height*width*sizeof(unsigned char));
    }

    max_rows = this_mxp->scratchpad_size/(4*width*sizeof(vbx_ubyte_t));
    if (max_rows > height) {
        max_rows = height;
    }

    vbx_ubyte_t *v_row =   (vbx_ubyte_t*)vbx_sp_malloc(max_rows*width*sizeof(vbx_ubyte_t));
    vbx_ubyte_t *v_cmp =   (vbx_ubyte_t*)vbx_sp_malloc(max_rows*width*sizeof(vbx_ubyte_t));
    vbx_ubyte_t *v_shift = (vbx_ubyte_t*)vbx_sp_malloc(max_rows*width*sizeof(vbx_ubyte_t));
    vbx_ubyte_t *v_lbp =   (vbx_ubyte_t*)vbx_sp_malloc(max_rows*width*sizeof(vbx_ubyte_t));

    for(i = 0; i < log+1; i++) {
        cell = 1<<i;
        rows = max_rows - 2*(1<<i);
        for (j = 0; j < height; j = j + rows) {
            if(j+rows >= height) {
                rows = height - j;
            }
            vbx_dma_to_vector(v_row, sums[i]+j*width, (rows+2*cell)*width*sizeof(vbx_ubyte_t));
            vbx_set_vl(width);
            vbx_set_2D(rows, width*sizeof(vbx_byte_t), width*sizeof(vbx_byte_t), width*sizeof(vbx_byte_t));

            vbx_2D(SVBU, VMOV, v_lbp, 0, 0);

            for (n = 0; n < 8; n++) {
                vbx_2D(SVBU, VMOV, v_shift, 0, 0);
                vbx_2D(VVBU, VSUB, v_cmp, v_row + coeff_x[n]*cell + coeff_y[n]*cell*width, v_row + width*cell + cell);
                vbx_2D(SVBU, VCMV_GEZ, v_shift, 1<<(7-n), v_cmp);
                vbx_2D(VVBU, VADD, v_lbp, v_lbp, v_shift);
            }
            vbx_dma_to_host(patterns[i]+j*width, v_lbp, rows*width*sizeof(vbx_ubyte_t));
        }
    }
    vbx_sync();
    vbx_sp_free();

    return patterns;
}

unsigned short** LBPRestrictedSums2(unsigned short* img, const unsigned width, const unsigned height, const unsigned log)
{
	int i, j, k, offset;

    unsigned short **sums = (unsigned short**)malloc((log+1)*sizeof(unsigned short*));
    for (i=0; i<log+1; i++) {
        sums[i] = (unsigned short*)vbx_shared_malloc(height*width*sizeof(unsigned short));
    }
    vbx_uhalf_t **v_x = (vbx_uhalf_t**)vbx_shared_malloc(3*sizeof(vbx_uhalf_t*));
    for (i=0; i<log+1; i++) {
        v_x[i] = (vbx_uhalf_t*)vbx_sp_malloc(width*sizeof(vbx_uhalf_t));
    }
    vbx_uhalf_t *v_in = (vbx_uhalf_t*)vbx_sp_malloc(width*sizeof(vbx_uhalf_t));
    vbx_uhalf_t *v_out = (vbx_uhalf_t*)vbx_sp_malloc(width*sizeof(vbx_uhalf_t));
    vbx_uhalf_t *v_tmp;

    for(i = 0; i < log; i++) {
        offset = 1<<i;
        vbx_set_vl(width - (offset-1));

        for(k=0; k < offset+1; k++) {
            if(i == 0) {
                vbx_dma_to_vector(v_x[k], img + k*width, width*sizeof(unsigned short));
            } else {
                vbx_dma_to_vector(v_x[k], sums[i] + k*width, width*sizeof(unsigned short));
            }
        }

        for(k=0; k < offset+1; k++) {
            vbx(VVHU, VADD, v_x[k], v_x[k], v_x[k] + offset);
        }

        for (j = 0; j < height-(offset-1); j++) {
            if(i == 0) {
                vbx_dma_to_vector(v_in, img + (j+offset+1)*width, width*sizeof(unsigned short));
            } else {
                vbx_dma_to_vector(v_in, sums[i] + (j+offset+1)*width, width*sizeof(unsigned short));
            }
            vbx(VVHU, VADD, v_x[0], v_x[0], v_x[offset]);
            vbx(VVHU, VADD, v_in, v_in, v_in + offset);
            vbx_dma_to_host(sums[i+1] + j*width, v_x[0], width*sizeof(vbx_uhalf_t));

            v_tmp = v_out;
            v_out = v_x[0];
            for(k=0; k < offset; k++) {
                v_x[k] = v_x[k+1];
            }
            v_x[offset] = v_in;
            v_in = v_out;
        }
    }
    vbx_sync();
    vbx_sp_free();
    vbx_shared_free(v_x);

    return sums;
}

unsigned char** LBPRestrictedPatterns2(unsigned short* img, unsigned short **sums, const unsigned width, const unsigned height, const unsigned log)
{
	int l, j, n, cell;

    int coeff_x[8] = {0, 1, 2, 2, 2, 1, 0, 0};
    int coeff_y[8] = {0, 0, 0, 1, 2, 2, 2, 1};

    unsigned char **patterns = (unsigned char**)malloc((log+1)*sizeof(unsigned char*));

    for (l=0; l<log+1; l++) {
        patterns[l] = (unsigned char*)vbx_shared_malloc(height*width*sizeof(unsigned char));
    }

    vbx_ubyte_t *v_cmp =   (vbx_ubyte_t*)vbx_sp_malloc(width*sizeof(vbx_ubyte_t));
    vbx_ubyte_t *v_shift = (vbx_ubyte_t*)vbx_sp_malloc(width*sizeof(vbx_ubyte_t));
    vbx_ubyte_t *v_lbp =   (vbx_ubyte_t*)vbx_sp_malloc(width*sizeof(vbx_ubyte_t));
    vbx_uhalf_t *v_row =   (vbx_uhalf_t*)vbx_sp_malloc(12*width*sizeof(vbx_uhalf_t));

    for(l = 0; l < log+1; l++) {
        cell = 1 << l;
        for (j = 0; j < height - (3*cell-1); j++) {
            if(l == 0) {
                vbx_dma_to_vector(v_row, img+j*width, (3*cell)*width*sizeof(vbx_uhalf_t));
            } else {
                vbx_dma_to_vector(v_row, sums[l]+j*width, (3*cell)*width*sizeof(vbx_uhalf_t));
            }
            vbx_set_vl(width - (3*cell-1));

            vbx(SVBU, VMOV, v_lbp, 0, 0);

            for (n = 0; n < 8; n++) {
                vbx(SVBU, VMOV, v_shift, 0, 0);
                vbx(VVHBU, VSUB, v_cmp, v_row + coeff_x[n]*cell + coeff_y[n]*cell*width, v_row + width*cell + cell);
                vbx(SVBU, VCMV_GEZ, v_shift, 1<<(7-n), v_cmp);
                vbx(VVBU, VADD, v_lbp, v_lbp, v_shift);
            }
            vbx_dma_to_host(patterns[l]+j*width, v_lbp, width*sizeof(vbx_ubyte_t));
        }
    }
    vbx_sync();
    vbx_sp_free();

    return patterns;
}

unsigned char** LBPRestricted(unsigned short *img, const unsigned width, const unsigned height, const unsigned log)
{
    int coeff_x[8] = {0, 1, 2, 2, 2, 1, 0, 0};
    int coeff_y[8] = {0, 0, 0, 1, 2, 2, 2, 1};

    int i, j, l, n, x, y;

    unsigned char **patterns = (unsigned char**)malloc((log+1)*sizeof(unsigned char*));
    for (l=0; l<log+1; l++) {
        patterns[l] = (unsigned char*)vbx_shared_malloc(height*width*sizeof(unsigned char));
    }


    int num_in, num_dbl, num_row;
    num_in = 4;

    vbx_uhalf_t ***v_dbl, ***v_row, **v_in, *v_tmp;
    vbx_ubyte_t *v_lbp, *v_cmp, *v_shift;

    v_in = (vbx_uhalf_t**)malloc(num_in*sizeof(vbx_uhalf_t*));
    v_dbl = (vbx_uhalf_t***)malloc(log*sizeof(vbx_uhalf_t**));
    v_row = (vbx_uhalf_t***)malloc(log*sizeof(vbx_uhalf_t**));

    v_in[0] = (vbx_uhalf_t*)vbx_sp_malloc(num_in*width*sizeof(vbx_uhalf_t));
    for(j=1; j< num_in; j++){
        v_in[j] = v_in[0] + j*width;
    }

    for(l=0; l<log; l++){
        num_dbl = 3 + l; //2x2 needs 0 1, 2   4x4 needs 0 1 2, 3
        v_dbl[l] = (vbx_uhalf_t**)malloc(num_dbl*sizeof(vbx_uhalf_t*));
        v_dbl[l][0] = (vbx_uhalf_t*)vbx_sp_malloc(num_dbl*width*sizeof(vbx_uhalf_t));
        for(j=1; j<num_dbl; j++){
            v_dbl[l][j] = v_dbl[l][0] + j*width;
        }
        num_row = 6 + 4*l; //2x2 needs 6   4x4 needs 10
        v_row[l] = (vbx_uhalf_t**)malloc(num_row*sizeof(vbx_uhalf_t*));
        v_row[l][0] = (vbx_uhalf_t*)vbx_sp_malloc(num_row*width*sizeof(vbx_uhalf_t));
        for(j=1; j<num_row; j++){
            v_row[l][j] = v_row[l][0] + j*width;
        }
    }

    v_lbp = (vbx_ubyte_t*)vbx_sp_malloc((log+1)*width*sizeof(vbx_ubyte_t));
    v_cmp = (vbx_ubyte_t*)vbx_sp_malloc((log+1)*width*sizeof(vbx_ubyte_t));
    v_shift = (vbx_ubyte_t*)vbx_sp_malloc((log+1)*width*sizeof(vbx_ubyte_t));

    /* setup initial rows */
    vbx_dma_to_vector(v_in[0], img, 3*width*sizeof(vbx_uhalf_t));

    vbx_set_vl(width);
    vbx_set_2D(2, width*sizeof(vbx_ubyte_t), width*sizeof(vbx_ubyte_t), width*sizeof(vbx_ubyte_t));

    for(j = 0; j < 16; j++) {
        if (j >= 0){
            if (j < 2){
                vbx(VVHU, VADD, v_dbl[0][j], v_in[j], v_in[j] + 1);
            } else {
                vbx(VVHU, VADD, v_dbl[0][2], v_in[2], v_in[2] + 1);
            }
        }

        if (j >= 2) {
            vbx_dma_to_vector(v_in[3], img+(j+1)*width, width*sizeof(vbx_uhalf_t));

            if(j < 7){
                vbx(SVBU, VMOV, v_lbp, 0, 0);
                for (n = 0; n < 8; n++) {
                    y = coeff_y[n];
                    x = coeff_x[n];
                    vbx(SVBU, VMOV, v_shift, 0, 0);
                    vbx(VVHBU, VSUB, v_cmp, v_in[y] + x, v_in[1] + 1);
                    vbx(SVBU, VCMV_GEZ, v_shift, 1<<(7-n), v_cmp);
                    vbx(VVBU, VADD, v_lbp, v_lbp, v_shift);
                }
            }

            if (j < 7) {
                vbx(VVHU, VADD, v_row[0][j-2], v_dbl[0][0], v_dbl[0][0+1]);
            } else {
                vbx(VVHU, VADD, v_row[0][5], v_dbl[0][0], v_dbl[0][0+1]);
            }
        }

        if (j >= 4) {
            if (j < 7) {
                vbx(VVHU, VADD, v_dbl[1][j-4], v_row[0][j-4], v_row[0][j-4] + 2);
            } else {
                vbx(VVHU, VADD, v_dbl[1][3], v_row[0][3], v_row[0][3] + 2);
            }
        }

        if (j >= 7) {
            vbx(VVHU, VADD, v_row[1][j-7], v_dbl[1][0], v_dbl[1][0+2]);

            vbx_2D(SVBU, VMOV, v_lbp, 0, 0);
            for (n = 0; n < 8; n++) {
                y = coeff_y[n];
                x = coeff_x[n];
                vbx_2D(SVBU, VMOV, v_shift, 0, 0);
                vbx(VVHBU, VSUB, v_cmp,       v_in[y] + x, v_in[1] + 1);
                vbx(VVHBU, VSUB, v_cmp+width, v_row[0][y*2] + x*2, v_row[0][2] + 2);
                vbx_2D(SVBU, VCMV_GEZ, v_shift, 1<<(7-n), v_cmp);
                vbx_2D(VVBU, VADD, v_lbp, v_lbp, v_shift);
            }
        }
        /* pointer swaps and dma out results*/
        if (j >= 2){
            vbx_dma_to_host(patterns[0]+(j-2)*width, v_lbp, width*sizeof(vbx_ubyte_t));

            v_tmp = v_in[0];
            v_in[0] = v_in[1];
            v_in[1] = v_in[2];
            v_in[2] = v_in[3];
            v_in[3] = v_tmp;

            v_tmp = v_dbl[0][0];
            v_dbl[0][0] = v_dbl[0][1];
            v_dbl[0][1] = v_dbl[0][2];
            v_dbl[0][2] = v_tmp;
        }
        if (j >= 7){
            vbx_dma_to_host(patterns[1]+(j-7)*width, v_lbp+width, width*sizeof(vbx_ubyte_t));

            v_tmp = v_row[0][0];
            for(i = 0; i < 5; i++){
                v_row[0][i] = v_row[0][i+1];
            }
            v_row[0][5] = v_tmp;

            v_tmp = v_dbl[1][0];
            v_dbl[1][0] = v_dbl[1][1];
            v_dbl[1][1] = v_dbl[1][2];
            v_dbl[1][2] = v_dbl[1][3];
            v_dbl[1][3] = v_tmp;
        }
    }

    vbx_set_2D(3, width*sizeof(vbx_ubyte_t), width*sizeof(vbx_ubyte_t), width*sizeof(vbx_ubyte_t));

    for (j = 16; j < height + 5; j++) {
        if(j < height - 1) {
        vbx_dma_to_vector(v_in[3], img+(j+1)*width, width*sizeof(vbx_uhalf_t));
        }

        vbx_2D(SVBU, VMOV, v_lbp, 0, 0);
        for (n = 0; n < 8; n++) {
            y = coeff_y[n];
            x = coeff_x[n];
            vbx_2D(SVBU, VMOV, v_shift, 0, 0);
            vbx(VVHBU, VSUB, v_cmp+2*width,       v_in[y] + x, v_in[1] + 1);
            vbx(VVHBU, VSUB, v_cmp+width, v_row[0][y*2] + x*2, v_row[0][2] + 2);
            vbx(VVHBU, VSUB, v_cmp, v_row[1][y*4] + x*4, v_row[1][4] + 4);
            vbx_2D(SVBU, VCMV_GEZ, v_shift, 1<<(7-n), v_cmp);
            vbx_2D(VVBU, VADD, v_lbp, v_lbp, v_shift);
        }

        vbx(VVHU, VADD, v_dbl[0][2], v_in[2], v_in[2] + 1);
        vbx(VVHU, VADD, v_row[0][5], v_dbl[0][0], v_dbl[0][0+1]);
        vbx(VVHU, VADD, v_dbl[1][3], v_row[0][3], v_row[0][3] + 2);
        vbx(VVHU, VADD, v_row[1][9], v_dbl[1][0], v_dbl[1][0+2]);

        if(j < height){
            vbx_dma_to_host(patterns[0]+(j-2)*width, v_lbp+2*width, width*sizeof(vbx_ubyte_t));
        }
        if(j < height + 2){
            vbx_dma_to_host(patterns[1]+(j-7)*width, v_lbp+width, width*sizeof(vbx_ubyte_t));
        }
        vbx_dma_to_host(patterns[2]+(j-16)*width, v_lbp, width*sizeof(vbx_ubyte_t));

        /* swap pointers */
        v_tmp = v_in[0];
        v_in[0] = v_in[1];
        v_in[1] = v_in[2];
        v_in[2] = v_in[3];
        v_in[3] = v_tmp;

        v_tmp = v_dbl[0][0];
        v_dbl[0][0] = v_dbl[0][1];
        v_dbl[0][1] = v_dbl[0][2];
        v_dbl[0][2] = v_tmp;

        v_tmp = v_row[0][0];
        for(i = 0; i < 5; i++){
            v_row[0][i] = v_row[0][i+1];
        }
        v_row[0][5] = v_tmp;

        v_tmp = v_row[1][0];
        for(i = 0; i < 9; i++){
            v_row[1][i] = v_row[1][i+1];
        }
        v_row[1][9] = v_tmp;

        v_tmp = v_dbl[1][0];
        v_dbl[1][0] = v_dbl[1][1];
        v_dbl[1][1] = v_dbl[1][2];
        v_dbl[1][2] = v_dbl[1][3];
        v_dbl[1][3] = v_tmp;
    }

    vbx_sync();
    vbx_sp_free();
    for(l=0; l<log; l++){
        free(v_dbl[l]);
        free(v_row[l]);
    }
    free(v_in);
    free(v_dbl);
    free(v_row);

    return patterns;
}

int LBPPassCascade(image_t img, lbp_stage_t *cascade, pair_t p0, int max_stage)
{
	int i;

	for (i = 0; i < max_stage; i++) {
        if (!LBPPassStage(img, cascade[i], p0)) {
            return 0;
        }
    }

    return 1;
}

int LBPPassStage(image_t img, lbp_stage_t stage, pair_t p0)
{
	int i, sum_stage = 0;

	for (i = 0; i < stage.count; i++) {
		if (CheckLUT((unsigned int *)stage.feats[i].lut, SATBinaryPattern(img, &stage.feats[i], p0))) {
			sum_stage = sum_stage + stage.feats[i].fail;
        } else {
			sum_stage = sum_stage + stage.feats[i].pass;
        }
	}

	if (sum_stage >= stage.stageThreshold) {
		return 1;
	}

	return 0;
}

/* compute all rectangular neighbor sections of a given feature */
unsigned char SATBinaryPattern(image_t img, lbp_feat_t *feature, const pair_t p0)
{
    unsigned int n, neighbor, center;
    unsigned char pattern = 0;
    pair_t coeff[8] = {{0, 0}, {1, 0}, {2, 0}, {2, 1}, {2, 2}, {1, 2}, {0, 2}, {0, 1}};

    pair_t pc = {p0.x + feature->pos.size.x,
                 p0.y + feature->pos.size.y};
    center = SATValue(img, feature->pos, pc);

    for (n = 0; n < 8; n++) {
        pair_t p = {p0.x + coeff[n].x * feature->pos.size.x,
                    p0.y + coeff[n].y * feature->pos.size.y};
        neighbor = SATValue(img, feature->pos, p);

        if (neighbor >= center) {
            pattern += 1 << (7-n);
        }
    }

    return pattern;
}

/*
 *  a ---- b
 *  |      |
 *  d ---- c
 */
unsigned int SATValue(image_t img, const cell_t cell, const pair_t p0)
{
    unsigned int a, b, c, d;
    int left = p0.x + cell.src.x - 1;
    int top = p0.y + cell.src.y - 1;

    if (left < 0 || top < 0) {
        a = 0;
    } else {
        a = img.src[top * img.size.x + left];
    }

    if (top < 0) {
        b = 0;
    } else {
        b = img.src[top * img.size.x + left + cell.size.x];
    }

    c = img.src[(top + cell.size.y) * img.size.x + left + cell.size.x];

    if (left < 0) {
        d = 0;
    } else {
        d = img.src[(top + cell.size.y) * img.size.x + left];
    }

    return (a + c) - (b + d);
}

unsigned int SATNormalizedValue(image_t img, const cell_t cell, const pair_t p0)
{
    return SATValue(img, cell, p0) / (cell.size.x * cell.size.y);
}

int CheckLUT(unsigned int *lut, unsigned char value)
{
    unsigned char group = value >> 5;
    unsigned char index = value & 0x1f;

    return (lut[group] >> index) & 1;
}

vptr_word vector_row_lbp_2D(vptr_word v_int, vptr_word v_tmp, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage)
{
	vptr_word v_add   = v_tmp + 0*image_width*vector_2D; // Holds pass or fail values to be added to stage sum
	vptr_word v_stage = v_tmp + 1*image_width*vector_2D; // Holds sum of features in a stages
	vptr_word v_final = v_tmp + 2*image_width*vector_2D; // Holds binary value if passed all stages
	vptr_word v_accum = v_tmp + 3*image_width*vector_2D; // Holds accumulated binary values if stages have been passed, used to exit early
	vptr_uword v_lut   = (vptr_uword)v_tmp + 4*image_width*vector_2D;
	vptr_uword v_lbp   = (vptr_uword)v_tmp + 5*image_width*vector_2D;
	vptr_word v_top   = v_tmp + 6*image_width*vector_2D;
	vptr_word v_bot   = v_tmp + 7*image_width*vector_2D;
	vptr_word v_p0    = v_tmp + 8*image_width*vector_2D;

    /* check for stage threshold */
	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));

	//Zero components
	vbx_2D(SVW, VMOV, v_final, 1, NULL);

	//Run through stages
	int stage;
	for (stage=0; stage < max_stage; stage++) {

		//Zero out temporary binary stage pass
        vbx_2D(SVW, VMOV, v_stage, 0, NULL);

		int n, f;
		for (f = 0; f < cascade[stage].count; f++) {
            lbp_feat_t feat = cascade[stage].feats[f];

            vbx_2D(SVWU, VMOV, v_lbp,  0, NULL);
            vbx_2D(SVWU, VMOV, v_lut,  0, NULL);
			/* initalize values to be added to default fail value */
			vbx_2D(SVW, VMOV, v_add, (int)feat.fail, NULL);

            int dx = feat.pos.src.x;
            int dy = feat.pos.src.y;
            int dw = feat.pos.size.x;
            int dh = feat.pos.size.y;
            vptr_word v_a = v_int + image_width * (dy + dh - 1)   + (dx + dw - 1);
            vptr_word v_b = v_int + image_width * (dy + dh - 1)   + (dx + 2*dw - 1);
            vptr_word v_c = v_int + image_width * (dy + 2*dh - 1) + (dx + 2*dw - 1);
            vptr_word v_d = v_int + image_width * (dy + 2*dh - 1) + (dx + dw - 1);

            /* Aliases */
            vptr_uword v_shift = (vptr_uword)v_top;
            vptr_word v_sel = v_top;
            vptr_word v_group = v_bot;
            vptr_uword v_idx = (vptr_uword)v_bot;
            vptr_word v_px = (vptr_word)v_lut;

            int coeff_x[8] = {0, 1, 2, 2, 2, 1, 0, 0};
            int coeff_y[8] = {0, 0, 0, 1, 2, 2, 2, 1};
            int x, y;

            /* calc center */
            /* p0 = (a + c) - (b + d) */
            vbx_2D(VVW, VADD, v_top, v_a, v_c);
            vbx_2D(VVW, VADD, v_bot, v_b, v_d);
            vbx_2D(VVW, VSUB, v_p0, v_top, v_bot);

            /* calc each neighbor with center, and shift in to lbp */
            for (n = 0; n < 8; n++) {
                x = (dx + (coeff_x[n])*dw - 1);
                y = (dy + (coeff_y[n])*dh - 1);

                v_a = v_int + image_width * y + x;
                v_b = v_int + image_width * y + (x + dw);
                v_c = v_int + image_width * (y + dh) + (x + dw);
                v_d = v_int + image_width * (y + dh) + x;

                if(x >= 0 && y >= 0) {
                    vbx_2D(VVW, VADD, v_top, v_a, v_c);
                    vbx_2D(VVW, VADD, v_bot, v_b, v_d);
                    vbx_2D(VVW, VSUB, v_px, v_top, v_bot);
                } else if (x >= 0 && y < 0)  {
                    vbx_2D(VVW, VSUB, v_px, v_c, v_d);
                } else if (x < 0 && y >= 0)  {
                    vbx_2D(VVW, VSUB, v_px, v_c, v_b);
                } else {
                    vbx_2D(VVW, VMOV, v_px, v_c, NULL);
                }
                vbx_2D(VVW, VSUB, v_px, v_px, v_p0);

                vbx_2D(SVWU, VMOV, v_shift, 0, NULL);
                vbx_2D(SVW, VCMV_GEZ, (vptr_word)v_shift, 1 << (7-n), v_px);
                vbx_2D(VVWU, VADD, v_lbp, v_lbp, v_shift);
            }

            /* check if pattern is in lut */
            vbx_2D(SVWU, VSHR, (vptr_uword)v_group, 5, v_lbp);
            for (n = 0; n < 8; n++) {
                vbx_2D(SVW, VADD, v_sel, -n, v_group);
                vbx_2D(SVW, VCMV_Z, (vptr_word)v_lut, feat.lut[n], v_sel);
            }

            vbx_2D(SVWU, VAND, v_idx, 0x1f, v_lbp);
            vbx_2D(VVWU, VSHR, v_lut, v_idx, v_lut);
            vbx_2D(SVWU, VAND, v_lut, 1, v_lut);

			/* add either pass or fail sum to running stage total */
			vbx_2D(SVW, VCMV_LEZ, v_add, (int)feat.pass, (vptr_word)v_lut);
			vbx_2D(VVW, VADD, v_stage, v_stage, v_add);
		}

		/* final stage result */
		vbx_2D(SVW, VSUB, v_stage, cascade[stage].stageThreshold, v_stage);
		vbx_2D(SVW, VCMV_GTZ, v_final, 0, v_stage);

		/* exit early if entire group of rows has failed */
		vbx_acc_2D(VVW, VMOV, v_accum, v_final, NULL);
		vbx_sync();
		int accumulated = 0;
		for (n = 0; n < vector_2D; n++) {
			accumulated  = accumulated + v_accum[n*image_width];
		}
#if DEBUG
		if (!accumulated) {
			stage_count[stage] = stage_count[stage]+1;
			break;
		} else if (stage == max_stage-1) {
			stage_count[stage] = stage_count[stage]+1;
		}
#else
		if (!accumulated) break;
#endif
	}

	//Accumulate if the row has any valid pixels in the last pixel of the row
	//(the last 'window' pixels are unused)
	vbx_acc_2D(VVW, VMOV, v_final + image_width - 1, v_final, NULL);
	return v_final;
}

vptr_word vector_row_lbp_masked(vptr_word v_int, vptr_word v_tmp, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage)
{
	vptr_word v_add   = v_tmp + 0*image_width*vector_2D; // Holds pass or fail values to be added to stage sum
	vptr_word v_stage = v_tmp + 1*image_width*vector_2D; // Holds sum of features in a stages
	vptr_word v_final = v_tmp + 2*image_width*vector_2D; // Holds binary value if passed all stages
	/* vptr_word v_accum = v_tmp + 3*image_width*vector_2D; // Holds accumulated binary values if stages have been passed, used to exit early */
	vptr_word v_lut   = v_tmp + 4*image_width*vector_2D;
	vptr_word v_lbp   = v_tmp + 5*image_width*vector_2D;
	vptr_word v_top   = v_tmp + 6*image_width*vector_2D;
	vptr_word v_bot   = v_tmp + 7*image_width*vector_2D;
	vptr_word v_p0    = v_tmp + 8*image_width*vector_2D;

	// clear mask status register in case previous valid data somehow
	int mask_status;
	vbx_get_mask_status(&mask_status);

	//create mask; nothing set in the image_width-win area
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	vbx_set_vl(image_width-search_width);
	vbx_2D(SVW, VMOV, v_final+search_width, 1, NULL);
	vbx_set_vl(search_width);
	vbx_2D(SVW, VMOV,   v_final, 0, NULL);
	vbx_set_vl(image_width*vector_2D);
	vbx_setup_mask(VCMV_Z, v_final);

	//run through stages
	int stage;
	for(stage=0; stage < max_stage; stage++){


		//Zero out temporary binary stage pass
        vbx_masked(SVW, VMOV, v_stage, 0, NULL);

		int n, f;
		for (f = 0; f < cascade[stage].count; f++) {
            lbp_feat_t feat = cascade[stage].feats[f];

            vbx_masked(SVW, VMOV, v_lbp,  0, NULL);
            vbx_masked(SVW, VMOV, v_lut,  0, NULL);
			/* initalize values to be added to default fail value */
			vbx_masked(SVW, VMOV, v_add, (int)feat.fail, NULL);

            int dx = feat.pos.src.x;
            int dy = feat.pos.src.y;
            int dw = feat.pos.size.x;
            int dh = feat.pos.size.y;
            vptr_word v_a = v_int + image_width * (dy + dh - 1)   + (dx + dw - 1);
            vptr_word v_b = v_int + image_width * (dy + dh - 1)   + (dx + 2*dw - 1);
            vptr_word v_c = v_int + image_width * (dy + 2*dh - 1) + (dx + 2*dw - 1);
            vptr_word v_d = v_int + image_width * (dy + 2*dh - 1) + (dx + dw - 1);

            /* Aliases */
            vptr_word v_shift = v_top;
            vptr_word v_sel = v_top;
            vptr_word v_group = v_bot;
            vptr_word v_idx = v_bot;
            vptr_word v_px = v_lut;

            int coeff_x[8] = {0, 1, 2, 2, 2, 1, 0, 0};
            int coeff_y[8] = {0, 0, 0, 1, 2, 2, 2, 1};
            int x, y;

            /* calc center */
            /* p0 = (a + c) - (b + d) */
            vbx_masked(VVW, VADD, v_top, v_a, v_c);
            vbx_masked(VVW, VADD, v_bot, v_b, v_d);
            vbx_masked(VVW, VSUB, v_p0, v_top, v_bot);

            /* calc each neighbor with center, and shift in to lbp */
            for (n = 0; n < 8; n++) {
                x = (dx + (coeff_x[n])*dw - 1);
                y = (dy + (coeff_y[n])*dh - 1);

                v_a = v_int + image_width * y + x;
                v_b = v_int + image_width * y + (x + dw);
                v_c = v_int + image_width * (y + dh) + (x + dw);
                v_d = v_int + image_width * (y + dh) + x;

                if(x >= 0 && y >= 0) {
                    vbx_masked(VVW, VADD, v_top, v_a, v_c);
                    vbx_masked(VVW, VADD, v_bot, v_b, v_d);
                    vbx_masked(VVW, VSUB, v_px, v_top, v_bot);
                } else if (x >= 0 && y < 0)  {
                    vbx_masked(VVW, VSUB, v_px, v_c, v_d);
                } else if (x < 0 && y >= 0)  {
                    vbx_masked(VVW, VSUB, v_px, v_c, v_b);
                } else {
                    vbx_masked(VVW, VMOV, v_px, v_c, NULL);
                }
                vbx_masked(VVW, VSUB, v_px, v_px, v_p0);

                vbx_masked(SVW, VMOV, v_shift, 0, NULL);
                vbx_masked(SVW, VCMV_GEZ, v_shift, 1 << (7-n), v_px);
                vbx_masked(VVWU, VADD, (vptr_uword)v_lbp, (vptr_uword)v_lbp, (vptr_uword)v_shift);
            }

            vbx_masked(SVW, VSHR, v_group, 5, v_lbp);
            for (n = 0; n < 8; n++) {
                vbx_masked(SVW, VADD, v_sel, -n, v_group);
                vbx_masked(SVW, VCMV_Z, v_lut, feat.lut[n], v_sel);
            }

            vbx_masked(SVW, VAND, v_idx, 0x1f, v_lbp);
            vbx_masked(VVW, VSHR, v_lut, v_idx, v_lut);
            vbx_masked(SVW, VAND, v_lut, 1, v_lut);

			/* add either pass or fail sum to running stage total */
			vbx_masked(SVW, VCMV_LEZ, v_add, (int)feat.pass, v_lut);
			vbx_masked(VVW, VADD, v_stage, v_stage, v_add);
		}

		//final stage result
		vbx_masked(SVW, VSUB, v_stage, cascade[stage].stageThreshold, v_stage);
		//update mask with new existant values
		vbx_setup_mask_masked(VCMV_LEZ, v_stage);

		//exit early if entire group of rows has failed
		vbx_sync();
		vbx_get_mask_status(&mask_status);

#if DEBUG
		if (!mask_status) {
			stage_count[stage] = stage_count[stage]+1;
			break;
		} else if (stage == max_stage-1) {
			stage_count[stage] = stage_count[stage]+1;
		}
#else
		if (!mask_status) break;
#endif
	}
	//set to 1 anything still left
	vbx_masked(SVW, VMOV, v_final, 1, NULL);

	//accumulate if the row has any valid pixels in the last pixel of the row
	//(the last 'window' pixels are unused)
	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	vbx_acc_2D(VVW, VMOV, v_final+image_width-1, v_final, NULL);
	return v_final;
}

vptr_word vector_row_lbp_restricted_masked(vptr_ubyte *v_lbp, vptr_word v_tmp, int offset, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage)
{
#if !USE_BYTES
	vptr_word v_add   = v_tmp + 0*image_width*vector_2D; // Holds pass or fail values to be added to stage sum
	vptr_word v_stage = v_tmp + 1*image_width*vector_2D; // Holds sum of features in a stages
	vptr_word v_final = v_tmp + 2*image_width*vector_2D; // Holds binary value if passed all stages
	vptr_word v_lut   = v_tmp + 3*image_width*vector_2D;
#if !LUT_CI
	vptr_word v_idx   = v_tmp + 4*image_width*vector_2D;
	vptr_word v_sel   = v_tmp + 5*image_width*vector_2D;
    /* Aliases */
    vptr_word v_group = v_idx;
#endif
#else
    vptr_byte v_tmp_b = (vptr_byte)v_tmp;
	vptr_byte v_stage = v_tmp_b + 0*image_width*vector_2D; // Holds sum of features in a stages
	vptr_byte v_final = v_tmp_b + 1*image_width*vector_2D; // Holds binary value if passed all stages
	vptr_byte v_lut   = v_tmp_b + 2*image_width*vector_2D;
#if !LUT_CI
	vptr_byte v_add   = v_tmp_b + 6*image_width*vector_2D; // Holds pass or fail values to be added to stage sum
	vptr_byte v_idx   = v_tmp_b + 7*image_width*vector_2D;
	vptr_byte v_sel   = v_tmp_b + 11*image_width*vector_2D;
    /* Aliases */
    vptr_word v_group = (vptr_word)v_idx;
#endif
#endif
    vptr_ubyte v_pattern;

    lbp_feat_t feat;
    int f, dx, dy, dw, stage, total = 0;

	// clear mask status register in case previous valid data somehow
	int mask_status;
	vbx_get_mask_status(&mask_status);

	//create mask; nothing set in the image_width-win area
#if !USE_BYTES
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	vbx_set_vl(image_width-search_width);
	vbx_2D(SVW, VMOV, v_final+search_width, 1, NULL);
	vbx_set_vl(search_width);
	vbx_2D(SVW, VMOV,   v_final, 0, NULL);
	vbx_set_vl(image_width*vector_2D);
	vbx_setup_mask(VCMV_Z, v_final);
#else
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_byte_t), image_width*sizeof(vbx_byte_t), image_width*sizeof(vbx_byte_t));
	vbx_set_vl(image_width-search_width);
	vbx_2D(SVB, VMOV, ((vptr_byte)v_final)+search_width, 1, NULL);
	vbx_set_vl(search_width);
	vbx_2D(SVB, VMOV,   v_final, 0, NULL);
	vbx_set_vl(image_width*vector_2D);
	vbx_setup_mask(VCMV_Z, (vptr_byte)v_final);
#endif

	//run through stages
	for(stage=0; stage < max_stage; stage++){

		//Zero out temporary binary stage pass
#if !USE_BYTES
        vbx_masked(SVW, VMOV, v_stage, 0, NULL);
#else
        vbx_masked(SVB, VMOV, v_stage, 0, NULL);
#endif

		for (f = 0; f < cascade[stage].count; f++) {
            feat = cascade[stage].feats[f];
            dx = feat.pos.src.x;
            dy = feat.pos.src.y;
            dw = feat.pos.size.x;

            /* quick hack, won't hold for 2^3 */
            v_pattern = v_lbp[dw>>1]+(dy*image_width+dx+offset);

			/* initalize values to be added to default fail value */
#if !USE_BYTES
			vbx_masked(SVW, VMOV, v_add, (int)feat.fail, NULL);
#else
#if !LUT_CI
			vbx_masked(SVB, VMOV, v_add, feat.fail, NULL);
#endif
#endif
#if LUT_CI
            vbx_masked(SVBU, VCUSTOM0, (vptr_ubyte)v_lut, total+f, v_pattern);
#else
            /* check if pattern is in lut */
            vbx_masked(SVBU, VSHR, (vptr_ubyte)v_group, 5, v_pattern);
            int n;
            for (n = 0; n < 8; n++) {
                vbx_masked(SVB, VADD, (vptr_byte)v_sel, -n, (vptr_byte)v_group);
                vbx_masked(SVBW, VCMV_Z, (vptr_word)v_lut, feat.lut[n], (vptr_byte)v_sel);
            }

            vbx_masked(SVBWU, VAND, (vptr_uword)v_idx, 0x1f, v_pattern);
            vbx_masked(VVWB, VSHR, (vptr_byte)v_lut, (vptr_word)v_idx, (vptr_word)v_lut);
            vbx_masked(SVB, VAND, (vptr_byte)v_lut, 1, (vptr_byte)v_lut);
#endif
			/* add either pass or fail sum to running stage total */
#if !USE_BYTES
			vbx_masked(SVBW, VCMV_LEZ, v_add, (int)feat.pass, (vptr_byte)v_lut);
			vbx_masked(VVW, VADD, v_stage, v_stage, v_add);
#else
#if !LUT_CI
			vbx_masked(SVB, VCMV_LEZ, v_add, feat.pass, v_lut);
			vbx_masked(VVB, VADD, v_stage, v_stage, v_add);
#else
			vbx_masked(VVB, VADD, v_stage, v_stage, v_lut);
#endif
#endif
		}
        total += cascade[stage].count;

		//final stage result
#if !USE_BYTES
		vbx_masked(SVW, VSUB, v_stage, cascade[stage].stageThreshold, v_stage);

		//update mask with new existant values
		vbx_setup_mask_masked(VCMV_LEZ, v_stage);
#else
		//update mask with new existant values
		vbx_setup_mask_masked(VCMV_GEZ, ((vptr_byte)v_stage));
#endif

		//exit early if entire group of rows has failed
		vbx_sync();
		vbx_get_mask_status(&mask_status);

#if DEBUG
		if (!mask_status) {
			stage_count[stage] = stage_count[stage]+1;
			break;
		} else if (stage == max_stage-1) {
			stage_count[stage] = stage_count[stage]+1;
		}
#else
		if (!mask_status) break;
#endif
	}
#if !USE_BYTES
	//set to 1 anything still left
	vbx_masked(SVW, VMOV, v_final, 1, NULL);

	//accumulate if the row has any valid pixels in the last pixel of the row
	//(the last 'window' pixels are unused)
	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	vbx_acc_2D(VVW, VMOV, v_final+image_width-1, v_final, NULL);
#else
	vbx_masked(SVB, VMOV, v_final, 1, NULL);
	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_byte_t), image_width*sizeof(vbx_byte_t), image_width*sizeof(vbx_byte_t));
	vbx_acc_2D(VVB, VMOV, ((vptr_byte)v_final)+image_width-1, (vptr_byte)v_final, NULL);
#endif
	return (vptr_word)v_final;
}

vptr_word vector_row_lbp_restricted_2D(vptr_ubyte *v_lbp, vptr_word v_tmp, int offset, int search_width, int image_width, int vector_2D, lbp_stage_t *cascade, short max_stage)
{
	vptr_word v_add   = v_tmp + 0*image_width*vector_2D; // Holds pass or fail values to be added to stage sum
	vptr_word v_stage = v_tmp + 1*image_width*vector_2D; // Holds sum of features in a stages
	vptr_word v_final = v_tmp + 2*image_width*vector_2D; // Holds binary value if passed all stages
	vptr_word v_accum = v_tmp + 3*image_width*vector_2D; // Holds accumulated binary values if stages have been passed, used to exit early
	vptr_word v_lut   = v_tmp + 4*image_width*vector_2D;
#if !LUT_CI
	vptr_word v_idx   = v_tmp + 5*image_width*vector_2D;
	vptr_word v_sel   = v_tmp + 6*image_width*vector_2D;
    /* Aliases */
    vptr_word v_group = v_idx;
#endif
    vptr_ubyte v_pattern;

    lbp_feat_t feat;
    int n, f, dx, dy, dw, dh, stage, total = 0;

    /* check for stage threshold */
	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));

	//Zero components
	vbx_2D(SVW, VMOV, v_final, 1, NULL);

	//Run through stages
	for (stage=0; stage < max_stage; stage++) {

		//Zero out temporary binary stage pass
        vbx_2D(SVW, VMOV, v_stage, 0, NULL);

		for (f = 0; f < cascade[stage].count; f++) {
            feat = cascade[stage].feats[f];
            dx = feat.pos.src.x;
            dy = feat.pos.src.y;
            dw = feat.pos.size.x;
            dh = feat.pos.size.y;

            /* quick hack, won't hold for >= 2^3 */
            v_pattern = v_lbp[dw>>1]+(dy*image_width+dx+offset);

			/* initalize values to be added to default fail value */
			vbx_2D(SVW, VMOV, v_add, (int)feat.fail, NULL);
#if LUT_CI
            vbx_2D(SVBU, VCUSTOM0, (vptr_ubyte)v_lut, total+f, v_pattern);
#else
            /* check if pattern is in lut */
            vbx_2D(SVBU, VSHR, (vptr_ubyte)v_group, 5, v_pattern);
            for (n = 0; n < 8; n++) {
                vbx_2D(SVB, VADD, (vptr_byte)v_sel, -n, (vptr_byte)v_group);
                vbx_2D(SVBW, VCMV_Z, v_lut, feat.lut[n], (vptr_byte)v_sel);
            }

            vbx_2D(SVBWU, VAND, (vptr_uword)v_idx, 0x1f, v_pattern);
            vbx_2D(VVWB, VSHR, (vptr_byte)v_lut, v_idx, v_lut);
            vbx_2D(SVBU, VAND, (vptr_ubyte)v_lut, 1, (vptr_ubyte)v_lut);
#endif
			/* add either pass or fail sum to running stage total */
			vbx_2D(SVBW, VCMV_LEZ, v_add, (int)feat.pass, (vptr_byte)v_lut);
			vbx_2D(VVW, VADD, v_stage, v_stage, v_add);
		}
        total += cascade[stage].count;

		/* final stage result */
		vbx_2D(SVW, VSUB, v_stage, cascade[stage].stageThreshold, v_stage);
		vbx_2D(SVW, VCMV_GTZ, v_final, 0, v_stage);

		/* exit early if entire group of rows has failed */
		vbx_acc_2D(VVW, VMOV, v_accum, v_final, NULL);
		vbx_sync();
		int accumulated = 0;
		for (n = 0; n < vector_2D; n++) {
			accumulated  = accumulated + v_accum[n*image_width];
		}
#if DEBUG
		if (!accumulated) {
			stage_count[stage] = stage_count[stage]+1;
			break;
		} else if (stage == max_stage-1) {
			stage_count[stage] = stage_count[stage]+1;
		}
#else
		if (!accumulated) break;
#endif
	}

	//Accumulate if the row has any valid pixels in the last pixel of the row
	//(the last 'window' pixels are unused)
	vbx_acc_2D(VVW, VMOV, v_final + image_width - 1, v_final, NULL);
	return v_final;
}
