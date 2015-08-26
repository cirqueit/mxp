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
VBXCOPYRIGHT( vector_haar_detect )

#include "demo.h"
#include "haar_detect.h"
#include "lbp_detect.h"
#include "sqrtLUT.h"

//Determined by the number of intermediates needed
#define ROW_HAAR_VECTORS (use_masked ? 12 : 15)
#define ROW_LBP_VECTORS (use_masked ? 8 : 9)
#define ROW_RESTRICTED_VECTORS (use_masked ? 6 : 7)
#define ROW_RESTRICTED_VECTORS_B (use_masked ? 4 : 7)

int stage_count[22];
int prev_frame = 999;

void print_features(feat *merged){
	feat* current;

	int num = 0;
	current = merged;
	while(current){
		printf("Feature @ %d,%d, (%d,%d)\n", current->x, current->y, current->w, current->w);
		num++;
		current = current->next;
	}
	printf("%d features found\n", num);
}


void vector_row_to_integrals(vptr_uword v_luma, vptr_uword v_luma2, vptr_uword v_prev_int, vptr_uword v_prev_int2, vptr_uword v_int, vptr_uword v_int2, int num_rows, int width, int squared)
{
	int i;

	vptr_uword v_temp, v_temp2;
	v_temp  = v_int;
	v_temp2 = v_int2;

#if SCAN_CI
	vbx_set_vl(width);
	for(i = 0; i < num_rows; i++){
		vbx(VVWU, VCUSTOM2, v_int+i*width,  v_luma+i*width,  v_luma+i*width);
        if (squared) {
            vbx(VVWU, VCUSTOM2, v_int2+i*width, v_luma2+i*width, v_luma2+i*width);
        }
	}
#else
	//Move first positon of luma and squared luma values into integral and square rows
	vbx_set_vl(1);
	vbx_set_2D(num_rows, sizeof(vbx_uword_t)*width, sizeof(vbx_uword_t)*width, sizeof(vbx_uword_t)*width);
	vbx_2D(VVWU, VMOV, v_int,  v_luma,  NULL);
    if (squared) {
        vbx_2D(VVWU, VMOV, v_int2, v_luma2, NULL);
    }

	//Add elementwise along the rows
	vbx_set_vl(1);
	vbx_set_2D(num_rows, sizeof(vbx_uword_t)*width, sizeof(vbx_uword_t)*width, sizeof(vbx_uword_t)*width);
	for( i=0; i<width-1; i++){
		vbx_2D(VVWU, VADD, v_int+i+1, v_int+i,  v_luma+i+1);
        if (squared) {
            vbx_2D(VVWU, VADD,  v_int2+i+1,  v_int2+i, v_luma2+i+1);
        }
	}
#endif

	//Add row primitives to compose integral image, save last row for next batch
	vbx_set_vl(width);
	vbx(VVWU, VADD, v_int, v_int, v_prev_int);
    if (squared) {
        vbx(VVWU, VADD, v_int2, v_int2, v_prev_int2);
    }
	for(i=1;i<num_rows;i++){
		vbx(VVWU, VADD, v_int+width*i, v_int+width*i, v_int+width*(i-1));
        if (squared) {
            vbx(VVWU, VADD, v_int2+width*i, v_int2+width*i, v_int2+width*(i-1));
        }
	}
	vbx(VVWU, VMOV, v_prev_int,  v_int+width*(num_rows-1),   NULL);
    if (squared) {
        vbx(VVWU, VMOV, v_prev_int2, v_int2 +width*(num_rows-1), NULL);
    }
}

vptr_word vector_row_haar_masked(vptr_word v_int, vptr_word v_int2_0, vptr_word v_int2_end, vptr_word v_tmp, int win, int search_width, int image_width, int vector_2D, stage *cascade, short max_stage, int one_over_win2)
{
	vptr_word v_var2  = v_tmp + 0*image_width*vector_2D; //Holds variance*win^2
	vptr_word v_thr   = v_tmp + 1*image_width*vector_2D; //Holds variance*win^2*feature threshold
	vptr_word v_feat  = v_tmp + 2*image_width*vector_2D; //Holds sum of rectangles in feature
	vptr_word v_add   = v_tmp + 3*image_width*vector_2D; //Holds pass or fail values to be added to stage sum
	vptr_word v_stage = v_tmp + 4*image_width*vector_2D; //Holds sum of features in a stages
	vptr_word v_final = v_tmp + 5*image_width*vector_2D; //Holds binary value if passed all stages
	vptr_word v_a     = v_tmp + 6*image_width*vector_2D;
	vptr_word v_b     = v_tmp + 7*image_width*vector_2D;
	vptr_word v_c     = v_tmp + 8*image_width*vector_2D;
	vptr_word v_d     = v_tmp + 9*image_width*vector_2D;
	vptr_word v_e     = v_tmp + 10*image_width*vector_2D;
	vptr_word v_f     = v_tmp + 11*image_width*vector_2D;
#if HALFWORD_INTERMEDIATES
	vptr_half v_ah    = (vptr_half)v_a;
	vptr_half v_bh    = (vptr_half)v_b;
	vptr_half v_ch    = (vptr_half)v_c;
	vptr_half v_dh    = (vptr_half)v_d;
	vptr_half v_eh    = (vptr_half)v_e;
	vptr_half v_fh    = (vptr_half)v_f;
#endif

	// Clear mask status register in case previous valid data somehow
	int mask_status;
	vbx_get_mask_status(&mask_status);

	//Create mask; nothing set in the image_width-win area
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	vbx_set_vl(image_width-search_width);
	vbx_2D(SVW, VMOV, v_final+search_width, 1, NULL);
	vbx_set_vl(search_width);
	vbx_2D(SVW, VMOV,   v_final, 0, NULL);
	vbx_set_vl(image_width*vector_2D);
	vbx_setup_mask(VCMV_Z, v_final);

	//Compute Variance
	vbx_masked(VVW, VSUB, v_a, v_int+win,                 v_int);                 //b-a
	vbx_masked(VVW, VSUB, v_b, v_int+win*image_width+win, v_int+win*image_width); //c-d
	vbx_masked(VVW, VSUB, v_b, v_b,                       v_a);                   //c-d-b+a

	vbx_masked(SVW, VMULFXP, v_b, one_over_win2, v_b);

	vbx_masked(VVW, VMUL, v_b, v_b, v_b); //mean squared

	vbx_masked(VVW, VSUB, v_c, v_int2_0+win,   v_int2_0);
	vbx_masked(VVW, VSUB, v_d, v_int2_end+win, v_int2_end);
	vbx_masked(VVW, VSUB, v_d, v_d,            v_c);

	vbx_masked(SVW, VMULFXP, v_d, one_over_win2, v_d);

	vbx_masked(VVW, VSUB, v_d, v_d, v_b); //var-mean^2

	//var2 < 6000 var > 0
	vbx_masked(SVW, VSUB,     v_c, 6000, v_d);
	vbx_masked(SVW, VCMV_LEZ, v_d, 5999, v_c);
	vbx_masked(SVW, VCMV_LEZ, v_d, 1,    v_d);

#if SQRT_CI
#if SQRT_FXP16
	vbx_masked(SVW, VSHL, v_var2, 16, v_d);
	vbx_set_vl(image_width*vector_2D+16*(VBX_GET_THIS_MXP()->vcustom1_lanes));
	vbx(VVW, VCUSTOM1, v_var2, v_var2, v_var2);
	vbx_set_vl(image_width*vector_2D);
	vbx_masked(SVW, VSHR, v_var2, 16, v_var2);
#else //SQRT_FXP16
	vbx_masked(VVW, VCUSTOM1, v_var2, v_d, NULL);
#endif //SQRT_FXP16
#else
	vbx_sync();
	int v;
	for(v = 0; v < vector_2D; v++){
		int i;
		for(i = 0; i < search_width; i++){
			int var = v_d[v*image_width + i];
			v_var2[v*image_width + i] = sqrtLUT[var];
		}
	}
#endif

	//Multiply var by win*win, used for feature thresholding
	vbx_masked(SVW, VMUL, v_var2, win*win, v_var2);

#if SKIP_HAAR_STAGES
	vbx_set_vl(image_width*vector_2D);
	vbx(SVW, VMOV, v_final, 0, NULL);
	return v_final;
#endif

	//Run through stages
	int stage;
	for(stage=0; stage < max_stage; stage++){

		short *pthresh = cascade[stage].thresh;
		short *pfail   = cascade[stage].fail;
		short *ppass   = cascade[stage].pass;

		int i;
		for(i=0; i< cascade[stage].size; i++){
			const unsigned char endj = cascade[stage].num[i];
			const short idx          = cascade[stage].start[i];
			const rect *prect1       = &cascade[stage].rects[idx];
			const rect *prect2       = &cascade[stage].rects[idx+1];
			const rect *prect3       = &cascade[stage].rects[idx+2];

			if( endj == 2) {
				vbx_word_t *v_a1 = v_int + image_width*(prect1->y) + prect1->x;
				vbx_word_t *v_b1 = v_int + image_width*(prect1->y) + prect1->w;
				vbx_word_t *v_d1 = v_int + image_width*(prect1->h) + prect1->x;
				vbx_word_t *v_c1 = v_int + image_width*(prect1->h) + prect1->w;
				vbx_word_t *v_a2 = v_int + image_width*(prect2->y) + prect2->x;
				vbx_word_t *v_b2 = v_int + image_width*(prect2->y) + prect2->w;
				vbx_word_t *v_d2 = v_int + image_width*(prect2->h) + prect2->x;
				vbx_word_t *v_c2 = v_int + image_width*(prect2->h) + prect2->w;

#if HALFWORD_INTERMEDIATES
				vbx_masked(VVWH, VSUB, v_ah, v_b1, v_a1);// b-a
				vbx_masked(VVWH, VSUB, v_ch, v_b2, v_a2);// b-a
				vbx_masked(VVWH, VSUB, v_bh, v_c1, v_d1);// c-d
				vbx_masked(VVWH, VSUB, v_dh, v_c2, v_d2);// c-d

				vbx_masked(VVH,  VSUB, v_bh,    v_bh,               v_ah); //c-d-b+a
				vbx_masked(VVH,  VSUB, v_dh,    v_dh,               v_ch); //c-d-b+a
				vbx_masked(SVH,  VMUL, v_ah,    (int)prect1->value, v_bh); //total * feature weight
				vbx_masked(SVH,  VMUL, v_ch,    (int)prect2->value, v_dh); //total * feature weight
				vbx_masked(VVHW, VADD, v_feat, v_ch,                v_ah); //add to feature total
#else //HALFWORD_INTERMEDIATES
				vbx_masked(VVW, VSUB, v_a, v_b1, v_a1);// b-a
				vbx_masked(VVW, VSUB, v_c, v_b2, v_a2);// b-a
				vbx_masked(VVW, VSUB, v_b, v_c1, v_d1);// c-d
				vbx_masked(VVW, VSUB, v_d, v_c2, v_d2);// c-d

				vbx_masked(VVW, VSUB, v_b,    v_b,                v_a); //c-d-b+a
				vbx_masked(VVW, VSUB, v_d,    v_d,                v_c); //c-d-b+a
				vbx_masked(SVW, VMUL, v_a,    (int)prect1->value, v_b); //total * feature weight
				vbx_masked(SVW, VMUL, v_c,    (int)prect2->value, v_d); //total * feature weight
				vbx_masked(VVW, VADD, v_feat, v_c,                v_a); //add to feature total
#endif //HALFWORD_INTERMEDIATES
			}	else if( endj == 3) {
				vbx_word_t *v_a1 = v_int + image_width*(prect1->y) + prect1->x;
				vbx_word_t *v_b1 = v_int + image_width*(prect1->y) + prect1->w;
				vbx_word_t *v_d1 = v_int + image_width*(prect1->h) + prect1->x;
				vbx_word_t *v_c1 = v_int + image_width*(prect1->h) + prect1->w;
				vbx_word_t *v_a2 = v_int + image_width*(prect2->y) + prect2->x;
				vbx_word_t *v_b2 = v_int + image_width*(prect2->y) + prect2->w;
				vbx_word_t *v_d2 = v_int + image_width*(prect2->h) + prect2->x;
				vbx_word_t *v_c2 = v_int + image_width*(prect2->h) + prect2->w;
				vbx_word_t *v_a3 = v_int + image_width*(prect3->y) + prect3->x;
				vbx_word_t *v_b3 = v_int + image_width*(prect3->y) + prect3->w;
				vbx_word_t *v_d3 = v_int + image_width*(prect3->h) + prect3->x;
				vbx_word_t *v_c3 = v_int + image_width*(prect3->h) + prect3->w;

#if HALFWORD_INTERMEDIATES
				vbx_masked(VVWH, VSUB, v_ah, v_b1, v_a1);// b-a
				vbx_masked(VVWH, VSUB, v_ch, v_b2, v_a2);// b-a
				vbx_masked(VVWH, VSUB, v_eh, v_b3, v_a3);// b-a
				vbx_masked(VVWH, VSUB, v_bh, v_c1, v_d1);// c-d
				vbx_masked(VVWH, VSUB, v_dh, v_c2, v_d2);// c-d
				vbx_masked(VVWH, VSUB, v_fh, v_c3, v_d3);// c-d

				vbx_masked(VVH,  VSUB, v_bh,   v_bh,               v_ah); //c-d-b+a
				vbx_masked(VVH,  VSUB, v_dh,   v_dh,               v_ch); //c-d-b+a
				vbx_masked(VVH,  VSUB, v_fh,   v_fh,               v_eh); //c-d-b+a
				vbx_masked(SVH,  VMUL, v_ah,   (int)prect1->value, v_bh); //total * feature weight
				vbx_masked(SVH,  VMUL, v_ch,   (int)prect2->value, v_dh); //total * feature weight
				vbx_masked(SVH,  VMUL, v_eh,   (int)prect3->value, v_fh); //total * feature weight
				vbx_masked(VVH,  VADD, v_dh,   v_ah,               v_ch); //add to feature total
				vbx_masked(VVHW, VADD, v_feat, v_eh,               v_dh); //add to feature total
#else //HALFWORD_INTERMEDIATES
				vbx_masked(VVW, VSUB, v_a, v_b1, v_a1);// b-a
				vbx_masked(VVW, VSUB, v_c, v_b2, v_a2);// b-a
				vbx_masked(VVW, VSUB, v_e, v_b3, v_a3);// b-a
				vbx_masked(VVW, VSUB, v_b, v_c1, v_d1);// c-d
				vbx_masked(VVW, VSUB, v_d, v_c2, v_d2);// c-d
				vbx_masked(VVW, VSUB, v_f, v_c3, v_d3);// c-d

				vbx_masked(VVW, VSUB, v_b,    v_b,                v_a); //c-d-b+a
				vbx_masked(VVW, VSUB, v_d,    v_d,                v_c); //c-d-b+a
				vbx_masked(VVW, VSUB, v_f,    v_f,                v_e); //c-d-b+a
				vbx_masked(SVW, VMUL, v_a,    (int)prect1->value, v_b); //total * feature weight
				vbx_masked(SVW, VMUL, v_c,    (int)prect2->value, v_d); //total * feature weight
				vbx_masked(SVW, VMUL, v_e,    (int)prect3->value, v_f); //total * feature weight
				vbx_masked(VVW, VADD, v_d,    v_a,                v_c); //add to feature total
				vbx_masked(VVW, VADD, v_feat, v_e,                v_d); //add to feature total
#endif //HALFWORD_INTERMEDIATES
			}

			//get features threshold value
			vbx_masked(SVW, VMUL, v_thr, (int)*pthresh++, v_var2);

			//if feature is greater than threshold, switch add from default fail to pass values
			vbx_masked(SVW, VSHL, v_feat, 12,    v_feat);
			vbx_masked(VVW, VSUB, v_thr,  v_thr, v_feat);

			if(i==0){
				//Set initial stage total
				vbx_masked(SVW, VMOV,     v_stage, (int)*pfail++, NULL);
				vbx_masked(SVW, VCMV_GTZ, v_stage, (int)*ppass++, v_thr);
			} else {
				vbx_masked(SVW, VMOV,     v_add, (int)*pfail++, NULL);
				vbx_masked(SVW, VCMV_GTZ, v_add, (int)*ppass++, v_thr);

				//add either pass or fail sum to running stage total
				vbx_masked(VVW, VADD, v_stage, v_stage, v_add);
			}
		}

		//final stage result
		vbx_masked(SVW, VSUB, v_stage, cascade[stage].value, v_stage);

		//Update mask with new existant values
		vbx_setup_mask_masked(VCMV_LEZ, v_stage);

		//Exit early if entire group of rows has failed
		vbx_sync();
		vbx_get_mask_status(&mask_status);

#if DEBUG
		if(! mask_status){
			stage_count[stage] = stage_count[stage]+1;
			break;
		}else if (stage == max_stage-1){
			stage_count[stage] = stage_count[stage]+1;
		}
#else
		if(! mask_status) break;
#endif
	}
	//Set to 1 anything still left
	vbx_masked(SVW, VMOV, v_final, 1, NULL);

	//Accumulate if the row has any valid pixels in the last pixel of the row
	//(the last 'window' pixels are unused)
	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	vbx_acc_2D(VVW, VMOV, v_final+image_width-1, v_final, NULL);
	return v_final;
}

vptr_word vector_row_haar_2D(vptr_word v_int, vptr_word v_int2_0, vptr_word v_int2_end, vptr_word v_tmp, int win, int search_width, int image_width, int vector_2D, stage *cascade, short max_stage, int one_over_win2)
{
	vptr_word v_out   = v_tmp + 0*image_width*vector_2D;  //Holds values to be DMAed out (var & pass)
	vptr_word v_var2  = v_tmp + 1*image_width*vector_2D;  //Holds variance*win^2
	vptr_word v_thr   = v_tmp + 2*image_width*vector_2D;  //Holds variance*win^2*feature threshold
	vptr_word v_feat  = v_tmp + 3*image_width*vector_2D;  //Holds sum of rectangles in feature
	vptr_word v_add   = v_tmp + 4*image_width*vector_2D;  //Holds pass or fail values to be added to stage sum
	vptr_word v_stage = v_tmp + 5*image_width*vector_2D;  //Holds sum of features in a stages
	vptr_word v_pass  = v_tmp + 6*image_width*vector_2D;  //Holds binary values if passed current stage
	vptr_word v_final = v_tmp + 7*image_width*vector_2D;  //Holds binary value if passed all stages
	vptr_word v_accum = v_tmp + 8*image_width*vector_2D; //Holds accumulated binary values if stages have been passed, used to exit early
	vptr_word v_a    = v_tmp + 9*image_width*vector_2D;
	vptr_word v_b    = v_tmp + 10*image_width*vector_2D;
	vptr_word v_c    = v_tmp + 11*image_width*vector_2D;
	vptr_word v_d    = v_tmp + 12*image_width*vector_2D;
	vptr_word v_e    = v_tmp + 13*image_width*vector_2D;
	vptr_word v_f    = v_tmp + 14*image_width*vector_2D;
#if HALFWORD_INTERMEDIATES
	vptr_half v_ah    = (vptr_half)v_a;
	vptr_half v_bh    = (vptr_half)v_b;
	vptr_half v_ch    = (vptr_half)v_c;
	vptr_half v_dh    = (vptr_half)v_d;
	vptr_half v_eh    = (vptr_half)v_e;
	vptr_half v_fh    = (vptr_half)v_f;
#endif

	vbx_set_vl(search_width);
	vbx_set_2D(vector_2D, image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t), image_width*sizeof(vbx_word_t));
	//Zero components
	vbx_2D(SVW, VMOV, v_out,   0, NULL);
	vbx_2D(SVW, VMOV, v_final, 1, NULL);

	vbx_2D(SVW, VMOV, v_var2, 0, NULL);
	vbx_2D(SVW, VMOV, v_add,  0, NULL);

	//Compute Variance
	vbx_2D(VVW, VSUB, v_a, v_int+win,                 v_int);                 //b-a
	vbx_2D(VVW, VSUB, v_b, v_int+win*image_width+win, v_int+win*image_width); //c-d
	vbx_2D(VVW, VSUB, v_b, v_b,                       v_a);                   //c-d-b+a

	vbx_2D(SVW, VMULFXP, v_b, one_over_win2, v_b);

	vbx_2D(VVW, VMUL, v_b, v_b, v_b); //mean squared

	vbx_2D(VVW, VSUB, v_c, v_int2_0+win,   v_int2_0);
	vbx_2D(VVW, VSUB, v_d, v_int2_end+win, v_int2_end);
	vbx_2D(VVW, VSUB, v_d, v_d,            v_c);

	vbx_2D(SVW, VMULFXP, v_d, one_over_win2, v_d);

	vbx_2D(VVW, VSUB, v_d, v_d, v_b); //var-mean^2

	//var2 < 6000 var > 0
	vbx_2D(SVW, VSUB,     v_c, 6000, v_d);
	vbx_2D(SVW, VCMV_LEZ, v_d, 5999, v_c);
	vbx_2D(SVW, VCMV_LEZ, v_d, 1,    v_d);

#if SQRT_CI
#if SQRT_FXP16
	vbx_2D(SVW, VSHL, v_var2, 16, v_d);
	vbx_set_vl(image_width*vector_2D+16*(VBX_GET_THIS_MXP()->vcustom1_lanes));
	vbx(VVW, VCUSTOM1, v_var2, v_var2, v_var2);
	vbx_set_vl(search_width);
	vbx_2D(SVW, VSHR, v_var2, 16, v_var2);
#else //SQRT_FXP16
	vbx_2D(VVW, VCUSTOM1, v_var2, v_d, NULL);
#endif //SQRT_FXP16
#else
	vbx_sync();
	int v;
	for(v = 0; v < vector_2D; v++){
		int i;
		for(i = 0; i < search_width; i++){
			int var = v_d[v*image_width + i];
			v_var2[v*image_width + i] = sqrtLUT[var];
		}
	}
#endif

	//Multiply var by win*win, used for feature thresholding
	vbx_2D(SVW, VMUL, v_var2, win*win, v_var2);

#if SKIP_HAAR_STAGES
	vbx_set_vl(image_width*vector_2D);
	vbx(SVW, VMOV, v_final, 0, NULL);
	return v_final;
#endif

	//Run through stages
	int stage;
	for(stage=0; stage < max_stage; stage++){

		//Zero out temporary binary stage pass
		vbx_2D(SVW, VMOV, v_pass,  0, NULL);
		//Zero out stage sumation
		vbx_2D(SVW, VMOV, v_stage, 0, NULL);

		short *pthresh = cascade[stage].thresh;
		short *pfail   = cascade[stage].fail;
		short *ppass   = cascade[stage].pass;

		int i;
		for(i=0; i< cascade[stage].size; i++){
			//get features threshold value
			vbx_2D(SVW, VMUL, v_thr, (int)*pthresh++, v_var2);
			//Initalize values to be added to default fail value
			vbx_2D(SVW, VMOV, v_add, (int)*pfail++,   NULL);

			const unsigned char endj = cascade[stage].num[i];
			const short idx          = cascade[stage].start[i];
			const rect *prect1       = &cascade[stage].rects[idx];
			const rect *prect2       = &cascade[stage].rects[idx+1];
			const rect *prect3       = &cascade[stage].rects[idx+2];

			if( endj == 2) {
				vbx_word_t *v_a1 = v_int +image_width*(prect1->y) + prect1->x;
				vbx_word_t *v_b1 = v_int +image_width*(prect1->y) + prect1->w;
				vbx_word_t *v_d1 = v_int +image_width*(prect1->h) + prect1->x;
				vbx_word_t *v_c1 = v_int +image_width*(prect1->h) + prect1->w;
				vbx_word_t *v_a2 = v_int +image_width*(prect2->y) + prect2->x;
				vbx_word_t *v_b2 = v_int +image_width*(prect2->y) + prect2->w;
				vbx_word_t *v_d2 = v_int +image_width*(prect2->h) + prect2->x;
				vbx_word_t *v_c2 = v_int +image_width*(prect2->h) + prect2->w;

#if HALFWORD_INTERMEDIATES
				vbx_2D(VVWH, VSUB, v_ah, v_b1, v_a1); //b-a
				vbx_2D(VVWH, VSUB, v_ch, v_b2, v_a2); //b-a
				vbx_2D(VVWH, VSUB, v_bh, v_c1, v_d1); //c-d
				vbx_2D(VVWH, VSUB, v_dh, v_c2, v_d2); //c-d

				vbx_2D(VVH,  VSUB, v_bh,   v_bh,               v_ah); //c-d-b+a
				vbx_2D(VVH,  VSUB, v_dh,   v_dh,               v_ch); //c-d-b+a
				vbx_2D(SVH,  VMUL, v_ah,   (int)prect1->value, v_bh); //total * feature weight
				vbx_2D(SVH,  VMUL, v_ch,   (int)prect2->value, v_dh); //total * feature weight
				vbx_2D(VVHW, VADD, v_feat, v_ch,               v_ah); //add to feature total
#else
				vbx_2D(VVW, VSUB, v_a, v_b1, v_a1); //b-a
				vbx_2D(VVW, VSUB, v_c, v_b2, v_a2); //b-a
				vbx_2D(VVW, VSUB, v_b, v_c1, v_d1); //c-d
				vbx_2D(VVW, VSUB, v_d, v_c2, v_d2); //c-d

				vbx_2D(VVW, VSUB, v_b,    v_b,                v_a); //c-d-b+a
				vbx_2D(VVW, VSUB, v_d,    v_d,                v_c); //c-d-b+a
				vbx_2D(SVW, VMUL, v_a,    (int)prect1->value, v_b); //total * feature weight
				vbx_2D(SVW, VMUL, v_c,    (int)prect2->value, v_d); //total * feature weight
				vbx_2D(VVW, VADD, v_feat, v_c,                v_a); //add to feature total
#endif
			} else if( endj == 3) {
				vbx_word_t *v_a1 = v_int +image_width*(prect1->y) + prect1->x;
				vbx_word_t *v_b1 = v_int +image_width*(prect1->y) + prect1->w;
				vbx_word_t *v_d1 = v_int +image_width*(prect1->h) + prect1->x;
				vbx_word_t *v_c1 = v_int +image_width*(prect1->h) + prect1->w;
				vbx_word_t *v_a2 = v_int +image_width*(prect2->y) + prect2->x;
				vbx_word_t *v_b2 = v_int +image_width*(prect2->y) + prect2->w;
				vbx_word_t *v_d2 = v_int +image_width*(prect2->h) + prect2->x;
				vbx_word_t *v_c2 = v_int +image_width*(prect2->h) + prect2->w;
				vbx_word_t *v_a3 = v_int +image_width*(prect3->y) + prect3->x;
				vbx_word_t *v_b3 = v_int +image_width*(prect3->y) + prect3->w;
				vbx_word_t *v_d3 = v_int +image_width*(prect3->h) + prect3->x;
				vbx_word_t *v_c3 = v_int +image_width*(prect3->h) + prect3->w;

#if HALFWORD_INTERMEDIATES
				vbx_2D(VVWH, VSUB, v_ah, v_b1, v_a1); //b-a
				vbx_2D(VVWH, VSUB, v_ch, v_b2, v_a2); //b-a
				vbx_2D(VVWH, VSUB, v_eh, v_b3, v_a3); //b-a
				vbx_2D(VVWH, VSUB, v_bh, v_c1, v_d1); //c-d
				vbx_2D(VVWH, VSUB, v_dh, v_c2, v_d2); //c-d
				vbx_2D(VVWH, VSUB, v_fh, v_c3, v_d3); //c-d

				vbx_2D(VVH,  VSUB, v_bh,   v_bh,               v_ah); //c-d-b+a
				vbx_2D(VVH,  VSUB, v_dh,   v_dh,               v_ch); //c-d-b+a
				vbx_2D(VVH,  VSUB, v_fh,   v_fh,               v_eh); //c-d-b+a
				vbx_2D(SVH,  VMUL, v_ah,   (int)prect1->value, v_bh); //total * feature weight
				vbx_2D(SVH,  VMUL, v_ch,   (int)prect2->value, v_dh); //total * feature weight
				vbx_2D(SVH,  VMUL, v_eh,   (int)prect3->value, v_fh); //total * feature weight
				vbx_2D(VVH,  VADD, v_dh,   v_ah,               v_ch); //add to feature total
				vbx_2D(VVHW, VADD, v_feat, v_eh,               v_dh); //add to feature total
#else
				vbx_2D(VVW, VSUB, v_a, v_b1, v_a1); //b-a
				vbx_2D(VVW, VSUB, v_c, v_b2, v_a2); //b-a
				vbx_2D(VVW, VSUB, v_e, v_b3, v_a3); //b-a
				vbx_2D(VVW, VSUB, v_b, v_c1, v_d1); //c-d
				vbx_2D(VVW, VSUB, v_d, v_c2, v_d2); //c-d
				vbx_2D(VVW, VSUB, v_f, v_c3, v_d3); //c-d

				vbx_2D(VVW, VSUB, v_b,    v_b,                v_a); //c-d-b+a
				vbx_2D(VVW, VSUB, v_d,    v_d,                v_c); //c-d-b+a
				vbx_2D(VVW, VSUB, v_f,    v_f,                v_e); //c-d-b+a
				vbx_2D(SVW, VMUL, v_a,    (int)prect1->value, v_b); //total * feature weight
				vbx_2D(SVW, VMUL, v_c,    (int)prect2->value, v_d); //total * feature weight
				vbx_2D(SVW, VMUL, v_e,    (int)prect3->value, v_f); //total * feature weight
				vbx_2D(VVW, VADD, v_d,    v_a,                v_c); //add to feature total
				vbx_2D(VVW, VADD, v_feat, v_e,                v_d); //add to feature total
#endif
			}

			//if feature is greater than threshold, switch add from default fail to pass values
			vbx_2D(SVW, VSHL,     v_feat, 12,            v_feat);
			vbx_2D(VVW, VSUB,     v_thr,  v_thr,         v_feat);
			vbx_2D(SVW, VCMV_GTZ, v_add,  (int)*ppass++, v_thr);

			//add either pass or fail sum to running stage total
			vbx_2D(VVW, VADD, v_stage, v_stage, v_add);
		}

		//final stage result
		vbx_2D(SVW, VSUB,     v_stage, cascade[stage].value, v_stage);
		vbx_2D(SVW, VCMV_LEZ, v_pass,  1,                    v_stage);
		vbx_2D(SVW, VCMV_LEZ, v_final, 0,                    v_pass);

		//Exit early if entire group of rows has failed
		vbx_acc_2D( VVW, VMOV, v_accum, v_final, NULL);
		vbx_sync();
		int accumulated = 0;
		for(i = 0; i < vector_2D; i++){
			accumulated  = accumulated + v_accum[i*image_width];
		}
#if DEBUG
		if(! accumulated){
			stage_count[stage] = stage_count[stage]+1;
			break;
		}else if (stage == max_stage-1){
			stage_count[stage] = stage_count[stage]+1;
		}
#else
		if(! accumulated) break;
#endif
	}

	//Accumulate if the row has any valid pixels in the last pixel of the row
	//(the last 'window' pixels are unused)
	vbx_acc_2D(VVW, VMOV, v_final+image_width-1, v_final, NULL);
	return v_final;
}

void vector_get_img(unsigned short *idest, int *iImg, int *iiImg, pixel *isrc, short bin, const int image_width, const int image_height, const int image_pitch, int squared)
{

	const int scaled_width  = image_width/bin;
	const int scaled_height = image_height/bin;

	vptr_uword v_next, v_in, v_reduced;
	vptr_uhalf v_temp, v_out, v_luma;
	vptr_uword v_tmp_word;
	vptr_uhalf v_tmp_half;

	vptr_uword v_in2, v_int, v_int2, v_prev, v_prev2;

	v_in    = (vptr_uword)vbx_sp_malloc(image_width*sizeof(vbx_uword_t));
	v_next  = (vptr_uword)vbx_sp_malloc(image_width*sizeof(vbx_uword_t));
    if(bin != 1){
        v_reduced  = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
    }else{
        v_reduced  = v_in;
    }
	v_int   = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	v_prev  = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
    if(squared){
        v_in2   = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
        v_int2  = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
        v_prev2 = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
    }
	v_temp  = (vptr_uhalf)vbx_sp_malloc(scaled_width*sizeof(vbx_uhalf_t));
	v_luma  = (vptr_uhalf)vbx_sp_malloc(scaled_width*sizeof(vbx_uhalf_t));
	v_out   = (vptr_uhalf)vbx_sp_malloc(scaled_width*sizeof(vbx_uhalf_t));
	if(v_out == NULL){
		exit(-1);
	}

	/* vbx_dma_to_vector(v_next, isrc+image_pitch, image_width*sizeof(vbx_uword_t)); */
	vbx_dma_to_vector(v_next, isrc, image_width*sizeof(vbx_uword_t));
	vbx_set_vl(scaled_width);
	vbx(SVWU, VMOV, v_prev,  0, NULL);
    if(squared){
        vbx(SVWU, VMOV, v_prev2, 0, NULL);
    }

	int y;
	for(y = 0; y < scaled_height; y++){
	  // transfer in row of camera input
      SWAP(v_next, v_in, v_tmp_word);
	  vbx_dma_to_vector(v_next, isrc+(bin*(y+1))*image_pitch, image_width*sizeof(vbx_uword_t));

	  // bin image: for IMAGE_WIDTH / bin times, transfer a pixel, move over bin pixels
		if(bin != 1){
			vbx_set_vl(1);
			vbx_set_2D(scaled_width, sizeof(vbx_uword_t), bin*sizeof(vbx_uword_t),0);
			vbx_2D(VVWU, VMOV, v_reduced, v_in, NULL);
		} else {
            v_reduced = v_in;//FIXME added for case bin=1, otherwise out of step
        }

		vbx_set_vl(scaled_width);

		//Move the b component into v_luma
		vbx(SVWHU, VAND, v_temp, 0xFF,   v_reduced);
		vbx(SVHU,  VMUL, v_luma, 25,     v_temp);

		//Move g into v_temp and add it to v_luma
		vbx(SVWHU, VAND, v_temp, 0xFF,   (vptr_uword)(((vptr_ubyte)v_reduced)+1));
		vbx(SVHU,  VMUL, v_temp, 129,    v_temp);
		vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

		//Move r into v_temp and add it to v_luma
		vbx(SVWHU, VAND, v_temp, 0xFF,   (vptr_uword)(((vptr_ubyte)v_reduced)+2));
		vbx(SVHU,  VMUL, v_temp, 66,     v_temp);
		vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

		vbx(SVHU,  VADD, v_luma, 128,      v_luma);//FIXME make same as scalar_rgb2luma
		vbx(SVHU,  VSHR, v_luma, 8,      v_luma);

        // transfer binned image out
        SWAP(v_out, v_luma, v_tmp_half);
        vbx_dma_to_host(idest+y*scaled_width, v_out, scaled_width*sizeof(vbx_uhalf_t));

#if !SKIP_INTEGRALS
		//Generate integral images
		vbx(VVHWU, VMOV, v_in, v_out, NULL);
#if SCAN_CI
        vbx(VVWU, VCUSTOM2, v_int, v_in,  v_in);
        vbx(VVWU, VADD,     v_int, v_int, v_prev);
        vbx_dma_to_host(iImg+y*scaled_width, v_int, scaled_width*sizeof(vbx_uword_t));
        SWAP(v_int, v_prev, v_tmp_word);
        if(squared) {
            vbx(VVWU, VMUL,     v_in2,   v_in,   v_in);
            vbx(VVWU, VCUSTOM2, v_int2,  v_in2,  v_in2);
            vbx(VVWU, VADD,     v_int2,  v_int2, v_prev2);
            vbx_dma_to_host(iiImg+y*scaled_width, v_int2, scaled_width*sizeof(vbx_uword_t));
            SWAP(v_int2, v_prev2, v_tmp_word);
        }
#else  //SCAN_CI
      if(squared) {
          vbx(VVWU, VMUL, v_in2, v_in, v_in);
      }
      vector_row_to_integrals(v_in, v_in2, v_prev, v_prev2, v_int, v_int2, 1, scaled_width, squared);
	  vbx_dma_to_host(iImg+y*scaled_width,  v_int,  scaled_width*sizeof(vbx_uword_t));
      if(squared) {
          vbx_dma_to_host(iiImg+y*scaled_width, v_int2, scaled_width*sizeof(vbx_uword_t));
      }
#endif //SCAN_CI
#endif //!SKIP_INTEGRALS
	}

	vbx_sp_free();
}

void vector_BLIP(unsigned short* img, short height, short width, unsigned short* scaled_img, int *iImg, int *iiImg, short scaled_height, short scaled_width, short value, short squared)
{
	int y, i, scale, y_scaled;

	vptr_uhalf v_x        = (vptr_uhalf)vbx_sp_malloc((value+1)*width*sizeof(vbx_uhalf_t));
	vptr_uhalf v_x_next   = (vptr_uhalf)vbx_sp_malloc((value+1)*width*sizeof(vbx_uhalf_t));
	vptr_uhalf v_out      = (vptr_uhalf)vbx_sp_malloc(scaled_width*sizeof(vbx_uhalf_t));
	vptr_uhalf v_out_next = (vptr_uhalf)vbx_sp_malloc(scaled_width*sizeof(vbx_uhalf_t));
	vptr_uhalf v_x0, v_x1, v_temp;

#if !SKIP_INTEGRALS
	vptr_uword v_in    = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_int   = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_prev  = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_in2   = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_int2  = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_prev2 = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
#endif

	vptr_uhalf v_coeff_a = (vptr_uhalf)vbx_sp_malloc(value*sizeof(vbx_uhalf_t));
	vptr_uhalf v_coeff_b = (vptr_uhalf)vbx_sp_malloc(value*sizeof(vbx_uhalf_t));

	vptr_uword v_a = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_b = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_c = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));
	vptr_uword v_d = (vptr_uword)vbx_sp_malloc(scaled_width*sizeof(vbx_uword_t));

	if(v_d == NULL){
		printf("In vector_BLIP : not enough space in scratch!\n");
	}

	scale = 128;
	for(i = 0; i < value; i++){
		v_coeff_a[i]= scale - i * scale / value;
		v_coeff_b[i]= i * scale / value;
	}
	y_scaled=0;
	vbx_dma_to_vector(v_x_next, img, (value+1)*width*sizeof(vbx_uhalf_t));
	vbx_set_vl(scaled_width);
#if !SKIP_INTEGRALS
	vbx(SVWU, VMOV, v_prev,  0, NULL);
	vbx(SVWU, VMOV, v_prev2, 0, NULL);
#endif

	for(y=0;y<height-1;y++){
		const int y_mod_valp1 = y%(value+1);
		if(y_mod_valp1 == 0){
			SWAP(v_x_next,v_x, v_temp);
			vbx_dma_to_vector(v_x_next, img+width*(y+(value+1)), (value+1)*width*sizeof(vbx_uhalf_t));
		}
		if(y_mod_valp1 != value){
			v_x0 = v_x + width*y_mod_valp1;
			v_x1 = v_x0 + width;

			vbx_set_vl(value);
			vbx_set_2D(width/(value+1), value*sizeof(vbx_uword_t), (value+1)*sizeof(vbx_uhalf_t), 0);
			vbx_2D(VVHWU, VMUL, v_a,   v_x0,    v_coeff_a); //*scaled
			vbx_2D(VVHWU, VMUL, v_b,   v_x0+1,  v_coeff_b);
			vbx_2D(VVHWU, VMUL, v_c,   v_x1,    v_coeff_a);
			vbx_2D(VVHWU, VMUL, v_d,   v_x1+1,  v_coeff_b);


			vbx_set_vl(scaled_width);
			vbx(VVWU, VADD,   v_a,   v_a,   v_b);
			vbx(VVWU, VADD,   v_c,   v_c,   v_d);

			vbx(SVWU,  VMUL, v_a,   scale-y_mod_valp1*scale/value, v_a); //*scaled
			vbx(SVWU,  VMUL, v_c,   y_mod_valp1*scale/value,       v_c);
			vbx(VVWU,  VADD, v_a,   v_a,                           v_c);
			vbx(SVWU,  VSHR, v_a,   14,                            v_a); //scale == 128 == 2^7, shift back 14
			vbx(VVWHU, VMOV, v_out, v_a,                           NULL);

			SWAP(v_out_next, v_out, v_temp);
			vbx_dma_to_host(scaled_img+scaled_width*y_scaled, v_out_next, scaled_width*sizeof(vbx_uhalf_t));

#if !SKIP_INTEGRALS
			//Generate integral images
			vbx(VVHWU, VMOV, v_in, v_out_next, NULL);
#if SCAN_CI
            vptr_uword v_tmp_word;
			vbx(VVWU, VCUSTOM2, v_int, v_in,  v_in);
			vbx(VVWU, VADD,     v_int, v_int, v_prev);
			vbx_dma_to_host(iImg+y_scaled*scaled_width, v_int, scaled_width*sizeof(vbx_uword_t));
			SWAP(v_int, v_prev, v_tmp_word);
            if(squared){
                vbx(VVWU, VMUL,   v_in2,  v_in,   v_in);
                vbx(VVWU, VCUSTOM2, v_int2, v_in2,  v_in2);
                vbx(VVWU, VADD,     v_int2, v_int2, v_prev2);
                vbx_dma_to_host(iiImg+y_scaled*scaled_width, v_int2, scaled_width*sizeof(vbx_uword_t));
                SWAP(v_int2, v_prev2, v_tmp_word);
            }
#else  //SCAN_CI
            if(squared){
                vbx(VVWU, VMUL, v_in2, v_in, v_in);
            }
			vector_row_to_integrals(v_in, v_in2, v_prev, v_prev2, v_int, v_int2, 1, scaled_width, squared);
			vbx_dma_to_host(iImg+y_scaled*scaled_width,  v_int,  scaled_width*sizeof(vbx_uword_t));
            if(squared){
                vbx_dma_to_host(iiImg+y_scaled*scaled_width, v_int2, scaled_width*sizeof(vbx_uword_t));
            }
#endif //SCAN_CI
#endif //!SKIP_INTEGRALS

			y_scaled++;
		}
	}
	vbx_sp_free();
}

feat* vector_get_haar_features_image_scaling_2D(stage *cascade, lbp_stage_t *lbp_cascade, unsigned short* img, int* iImg, int* iiImg, feat* features, int min_scale, int scale_inc, short reduce, short width , short height, short window, short max_stage, short lbp_window, short lbp_max_stage, short use_masked)
{
#if USE_LBP
    window = lbp_window;
#endif

	unsigned short *rimg = (unsigned short *)vbx_shared_malloc(width*height*sizeof(unsigned short));
    unsigned short *original_rimg = rimg;
	unsigned short *tmp;

#if USE_RESTRICTED
    int m, log = 2;
#endif

    const vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();

#if !USE_LBP
	const int one_over_win2 = fix16_from_float(1.0/(window*window));
#endif

	int max_vl;
	if(use_masked){
		max_vl = this_mxp->max_masked_vector_length;
	} else {
		max_vl = this_mxp->vector_lanes*WAVES_2D;
	}

	float scaled = 1.0;
	while(width > (window + 1) && height > (window + 1) ){
		int x_max = width - (window + 1);
		int y_max = height - (window + 1);

#if USE_RESTRICTED
#if  USE_BYTES
		int vector_2D = ((this_mxp->scratchpad_size/ width) - ((window+1)*(log+1)*sizeof(vbx_byte_t))) / ((ROW_RESTRICTED_VECTORS_B *sizeof(vbx_uword_t)) + (log+1)*sizeof(vbx_byte_t));
#else
		int vector_2D = ((this_mxp->scratchpad_size/ width) - ((window+1)*(log+1)*sizeof(vbx_byte_t))) / ((ROW_RESTRICTED_VECTORS*sizeof(vbx_uword_t)) + (log+1)*sizeof(vbx_byte_t));
#endif
#elif !USE_LBP
		int vector_2D = ((this_mxp->scratchpad_size / sizeof(vbx_uword_t) /width) -(window+1)) / (3+ROW_HAAR_VECTORS);
#else
		int vector_2D = ((this_mxp->scratchpad_size / sizeof(vbx_uword_t) /width) -(window+1)) / (1+ROW_LBP_VECTORS);
#endif
		if (vector_2D > max_vl/width) {
			vector_2D = max_vl/width;
		}
		if(vector_2D > y_max) {
			vector_2D = y_max;
		}
		if(vector_2D < 1) {
			vector_2D = 1;
		}
		int old_vector_2D = vector_2D;

		if(scaled*1000*reduce >= min_scale){
#if USE_RESTRICTED
#if 0
            unsigned char **sums, **patterns;
            sums = LBPRestrictedSums(img, width, height, log);
            patterns = LBPRestrictedPatterns(sums, width, height, log);
#else

            /* unsigned short **sums; */
            /* unsigned char **patterns; */
            /* sums = LBPRestrictedSums2(img, width, height, log); */
            /* patterns = LBPRestrictedPatterns2(img, sums, width, height, log); */
            unsigned char **patterns;
            patterns = LBPRestricted(img, width, height, log);
#endif
#endif

#if !SKIP_HAAR
#if USE_RESTRICTED
            vptr_ubyte v_lbp[log+1];
            for (m=0; m<log+1; m++) {
                v_lbp[m] = (vptr_ubyte)vbx_sp_malloc((window+1+vector_2D)*width*sizeof(vbx_ubyte_t));
            }
#if USE_BYTES
			vptr_word v_temp     = (vptr_word)vbx_sp_malloc(ROW_RESTRICTED_VECTORS_B*vector_2D*width*sizeof(vbx_uword_t));
#else
			vptr_word v_temp     = (vptr_word)vbx_sp_malloc(ROW_RESTRICTED_VECTORS*vector_2D*width*sizeof(vbx_uword_t));
#endif
#else //USE_RESTRICTED
			vptr_word v_integral = (vptr_word)vbx_sp_malloc((window+1+vector_2D)*width*sizeof(vbx_uword_t));
#if !USE_LBP
			vptr_word v_int2_0   = (vptr_word)vbx_sp_malloc(vector_2D*width*sizeof(vbx_uword_t));
			vptr_word v_int2_end = (vptr_word)vbx_sp_malloc(vector_2D*width*sizeof(vbx_uword_t));
			vptr_word v_temp     = (vptr_word)vbx_sp_malloc(ROW_HAAR_VECTORS*vector_2D*width*sizeof(vbx_uword_t));
#else
			vptr_word v_temp     = (vptr_word)vbx_sp_malloc(ROW_LBP_VECTORS*vector_2D*width*sizeof(vbx_uword_t));
#endif
			if (v_temp == NULL || v_integral == NULL){
				printf("In getHaarVector : not enough space in scratch!\n");
			}
#endif //USE_RESTRICTED

			/* initiate row */
			// total required = window + vector_2D
			// every loop bring in vector_2D
#if USE_RESTRICTED
            for (m=0; m<log+1; m++) {
                vbx_dma_to_vector(v_lbp[m]+vector_2D*width, patterns[m], (window+1)*width*sizeof(vbx_ubyte_t));
            }
#else
			vbx_dma_to_vector(v_integral+vector_2D*width, iImg, (window+1)*width*sizeof(vbx_uword_t));
#endif

			int y;
			for(y = 0; y < y_max; y = y + vector_2D){
				if(y + vector_2D > y_max){
					vector_2D = y_max - y;
				}

#if USE_RESTRICTED
                for (m=0; m<log+1; m++) {
                    vbx_set_vl((window + 1)*width);
                    vbx(VVBU, VMOV, v_lbp[m], v_lbp[m] + old_vector_2D*width, NULL);
                    old_vector_2D = vector_2D;
                    vbx_dma_to_vector(v_lbp[m] + (window + 1)*width, patterns[m] + (y + (window + 1))*width, vector_2D*width*sizeof(vbx_ubyte_t));
                }
#else //USE_RESTRICTED
				/* move all rows to take on the value of rows 'vector_2D' above ie 0->1 1->2 .. */
                /* everything but first rows shift up */
				vbx_set_vl((window + 1)*width);
				vbx(VVW, VMOV, v_integral, v_integral + old_vector_2D*width, NULL);
				old_vector_2D = vector_2D;
				vbx_dma_to_vector(v_integral + (window + 1)*width, iImg + (y + (window + 1))*width, vector_2D*width*sizeof(vbx_uword_t));

#if !USE_LBP
				/* bring in top and bottom rows of squared integral, required for calculating the variance */
				vbx_dma_to_vector(v_int2_0,   iiImg + (y + 0)*width,      width*vector_2D*sizeof(vbx_uword_t));
				vbx_dma_to_vector(v_int2_end, iiImg + (y + window)*width, width*vector_2D*sizeof(vbx_uword_t));
#endif
#endif //USE_RESTRICTED

				int vector_1D = max_vl / vector_2D;
				int x;
				for(x = 0; x < x_max; x += vector_1D){
					if(x + vector_1D > x_max){
						vector_1D = x_max - x;
					}

#if !SKIP_HAAR_COMPUTE
					vptr_word v_row_pass;
#if USE_RESTRICTED
					if(use_masked){
                        v_row_pass = vector_row_lbp_restricted_masked(v_lbp, v_temp, x, vector_1D, width, vector_2D, lbp_cascade, lbp_max_stage);
                    } else {
                        v_row_pass = vector_row_lbp_restricted_2D(v_lbp, v_temp, x, vector_1D, width, vector_2D, lbp_cascade, lbp_max_stage);
					}
#elif !USE_LBP
					if(use_masked){
						v_row_pass = vector_row_haar_masked(v_integral + x, v_int2_0 + x, v_int2_end + x, v_temp, window, vector_1D, width, vector_2D, cascade, max_stage, one_over_win2);
					} else {
						v_row_pass = vector_row_haar_2D(v_integral + x, v_int2_0 + x, v_int2_end + x, v_temp, window, vector_1D, width, vector_2D, cascade, max_stage, one_over_win2);
					}
#else //!USE_LBP
					if(use_masked){
                        v_row_pass = vector_row_lbp_masked(v_integral + x, v_temp, vector_1D, width, vector_2D, lbp_cascade, lbp_max_stage);
                    } else {
                        v_row_pass = vector_row_lbp_2D(v_integral + x, v_temp, vector_1D, width, vector_2D, lbp_cascade, lbp_max_stage);
                    }
#endif
#else //!SKIP_HAAR_COMPUTE
					vptr_word v_row_pass = v_temp;
					vbx_set_vl(width*vector_2D);
					vbx(SVW, VMOV, v_row_pass, 0, NULL);
#endif //!SKIP_HAAR_COMPUTE

#if !SKIP_APPEND_FEATURE
					vbx_sync(); //Reading v_row_pass
					int v;
					for(v = 0; v < vector_2D; v++){
#if USE_BYTES
                        vptr_byte v_row_pass_b = (vptr_byte)v_row_pass;
						if(v_row_pass_b[v * width + width - 1]){
							int u;
							for(u = 0; u < vector_1D; u++){
								if(v_row_pass_b[v * width + u]){
									int sx = (int)(scaled*reduce*(x + u));
									int sy = (int)(scaled*reduce*(y + v));
									int sw = (int)(scaled*reduce*window);
									features = append_feature(features, sx, sy, sw);
								}
							}
						}
#else
						if(v_row_pass[v * width + width - 1]){
							int u;
							for(u = 0; u < vector_1D; u++){
								if(v_row_pass[v * width + u]){
									int sx = (int)(scaled*reduce*(x + u));
									int sy = (int)(scaled*reduce*(y + v));
									int sw = (int)(scaled*reduce*window);
									features = append_feature(features, sx, sy, sw);
								}
							}
						}
#endif
					}
#endif //!SKIP_APPEND_FEATURE
				}
			}
            vbx_sp_free();
#if USE_RESTRICTED
            for(m=0; m<log+1; m++){
                /* vbx_shared_free(sums[m]); */
                vbx_shared_free(patterns[m]);
            }
            /* free(sums); */
            free(patterns);
#endif
#endif
		}

		//reduce image
		SWAP(img, rimg, tmp);
		short orig_width = width;
		short orig_height = height;
		short f;
		if(scale_inc == 2000){
			f=1;
		}else if(scale_inc == 1500){
			f=2;
		}else if(scale_inc == 1333){
			f=3;
		}else if(scale_inc == 1250){
			f=4;
		}else if(scale_inc == 1200){
			f=5;
		}else if(scale_inc == 1125){
			f=8;
		}else if(scale_inc == 1100){
			f=10;
		}else{
			printf("Not a valid scaling factor!\n");
			exit(-1);
		}

		width = width * f / (f + 1);
		height = height * f / (f + 1);
		if (height >= window && width >= window){
#if !SKIP_RESIZE
#if USE_RESTRICTED
			vector_BLIP(rimg, orig_height, orig_width, img, iImg, iiImg, height, width, f, 0);
#elif !USE_LBP
			vector_BLIP(rimg, orig_height, orig_width, img, iImg, iiImg, height, width, f, 1);
#else
			vector_BLIP(rimg, orig_height, orig_width, img, iImg, iiImg, height, width, f, 0);
#endif
#endif
		}
		//increase scaled
		scaled = scaled * scale_inc / 1000;
	}

	vbx_shared_free(original_rimg);

	return features;
}

feat* vector_face_detect(pixel *input, const int image_width, const int image_height, const int image_pitch, short use_masked, char *str, const int return_features)
{

#if DEBUG
	{
		int i;
		for(i=0; i<22; i++){
			stage_count[i]=0;
		}
	}
#endif

	pixel *color =(pixel*)malloc(sizeof(pixel));
	feat* features = NULL;
	feat* merged = NULL;

	unsigned short* img = (unsigned short*)vbx_shared_malloc((image_width/BIN) * (image_height/BIN) * sizeof(unsigned short));
	int* iImg  = (int*)vbx_shared_malloc((image_width/BIN) * (image_height/BIN) * sizeof(int));
	int* iiImg = (int*)vbx_shared_malloc((image_width/BIN) * (image_height/BIN) * sizeof(int));

#if !USE_LBP
	vector_get_img(img, iImg, iiImg, input, BIN, image_width, image_height, image_pitch, 1);
#else
	vector_get_img(img, iImg, iiImg, input, BIN, image_width, image_height, image_pitch, 0);
#endif

	features = vector_get_haar_features_image_scaling_2D(face_alt, face_lbp, img, iImg, iiImg, features, INITIAL_ZOOM, SCALE_FACTOR, BIN, image_width/BIN, image_height/BIN, 20, 22, 20, 13, use_masked);

	vbx_shared_free(img);
	vbx_shared_free(iImg);
	vbx_shared_free(iiImg);

#if !SKIP_MERGE_FEATURE
#if !USE_LBP
	merged = merge_features(features, merged, MIN_NEIGHBORS);
#else
	merged = merge_features(features, merged, LBP_NEIGHBORS);
#endif
#endif//!SKIP_MERGE_FEATURE

	if(!return_features && merged != NULL){
#if PRINT_MERGED
	  print_merged(merged, str);
#endif
#if PRINT_ASCII
      print_ascii(merged, image_width, image_height);
#endif
	  color->r = 0;color->b = 0;color->g = 255;
#if DRAW_FACES
	  draw_features(merged , color, input, image_width, image_height, image_pitch);
#endif
#if PRINT_FACES
	  print_features(merged);
#endif
	  free_features(features);
      features = NULL;
	  free_features(merged);
	  merged = NULL;
 	}

    if(features != NULL){
#if DEBUG
	  color->r = 0;color->b = 0;color->g = 75;
	  /* draw_features( features , color, input, image_width, image_height, image_pitch); */
#endif
	  free_features(features);
	}

	free(color);

#if DEBUG
	{
		int i;
		int total = 0;
		int running_total=0;

		for(i=0; i<22; i++){
			total = total + stage_count[i];
		}
		for(i=0; i<22; i++){
			running_total = running_total + stage_count[i];
			printf("%2.1f\t",100.0*running_total/total);
		}
		printf("\n");
	}
#endif

	return merged;
}
