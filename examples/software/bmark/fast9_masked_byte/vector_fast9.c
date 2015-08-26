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

#include "vbx.h"
#include "vbx_test.h"
#include "fast9.h"

#define FAST9_MASKED_VECTORS 13

void vector_fast9_masked(uint8_t *dst, uint8_t *src, int height, int width, int pitch, int threshold, int sync0, int sync1)
{
    int j, k;
#if DEBUG
    int early_exit_1 = 0, early_exit_2 = 0;
    int row_early_exit_1;
#endif
	int mask_status;
	vbx_get_mask_status(&mask_status);

	const int support_vl       = (6*width)+6;
	const int image_size       = height*width;
  const vbx_mxp_t *this_mxp  = VBX_GET_THIS_MXP();
	const int row_buffer_space = VBX_PAD_UP(support_vl*sizeof(vbx_ubyte_t), (this_mxp->vector_lanes)*4);
	const int max_supported    =
		VBX_PAD_UP(((this_mxp->scratchpad_size-row_buffer_space) / ((2+FAST9_MASKED_VECTORS)*sizeof(vbx_ubyte_t)))-((this_mxp->vector_lanes)*4)+1, (this_mxp->vector_lanes)*4);
	int next_max_vl = this_mxp->max_masked_vector_length;
	if(next_max_vl > max_supported){
		next_max_vl = max_supported;
	}
	if(next_max_vl > image_size-support_vl){
		next_max_vl = image_size-support_vl;
	}

	vbx_ubyte_t *v_src	= (vbx_ubyte_t*)vbx_sp_malloc((support_vl+next_max_vl)*sizeof(vbx_ubyte_t));
	//dma initial rows in
	vbx_dma_to_vector(v_src+next_max_vl, src, support_vl*sizeof(vbx_ubyte_t));

	vbx_ubyte_t *v_next_src = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_dma_to_vector(v_next_src, src+support_vl*sizeof(vbx_ubyte_t), next_max_vl*sizeof(vbx_ubyte_t));

	//allocate other
	vbx_ubyte_t *v_dark =    (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_bright =  (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_dark1 =   (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_bright1 = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_d_count = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_b_count = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t0 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t1 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t2 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t3 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_result =  (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_exit =    (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));

	vbx_ubyte_t *v_p[16];
	vbx_ubyte_t *v_p0;

	v_p0 = v_src+(3*width)+3;
	for(k=0; k<16; k++){
		v_p[k] = v_src+((3+y[k])*width)+3+x[k];
	}

	int max_vl = next_max_vl;
	for(j = support_vl; j < image_size; j+= max_vl){
#if DEBUG
		row_early_exit_1 = 0;
#endif

		//Move rows up
		vbx_set_vl(support_vl);
		vbx(VVBU, VMOV, v_src, v_src+max_vl, NULL);

		max_vl = next_max_vl;
		vbx_set_vl(max_vl);
		vbx(VVBU, VMOV, v_src+support_vl, v_next_src, NULL);

		//If not at end, dma next rows in
		if(j + max_vl < image_size){
			if(j + max_vl + next_max_vl >= image_size){
				next_max_vl = image_size - (j + max_vl);
			}
			vbx_dma_to_vector(v_next_src, src + j + max_vl, next_max_vl*sizeof(vbx_ubyte_t));
		}

		// early exit #1 - if 1 or 9 is not brighter/darker than threshold
		vbx(SVBU, VMOV, v_exit, 0, 0);
		vbx(VVBU, VABSDIFF, v_t0, v_p0, v_p[0]); // p0 - p1
		vbx(VVBU, VABSDIFF, v_t1, v_p0, v_p[8]); // p0 - p9
		vbx(SVBU, VSUB, v_t0, threshold, v_t0); // threshold - abs(p0 - p1)
		vbx(SVBU, VSUB, v_t1, threshold, v_t1); // threshold - abs(p0 - p1)

		//if either is greater than threshold, don't exit -- 0 is exit
		vbx(SVBU, VCMV_LTZ, v_exit, 1, v_t0); // threshold - abs(p0 - p1) < 0
		vbx(SVBU, VCMV_LTZ, v_exit, 1, v_t1); // threshold - abs(p0 - p9) < 0
		vbx_setup_mask(VCMV_GTZ, v_exit);
		if(sync0){
			vbx_sync();
			vbx_get_mask_status(&mask_status);
			if( !mask_status ) {
				continue;
			}
		}
#if DEBUG
		vbx_acc(VVBU, VMOV, v_exit, v_exit, 0);
		vbx_sync();
		row_early_exit_1 = width-3-3-v_exit[0];
		early_exit_1 += width-3-3-v_exit[0];
#endif
		// early exit #2 - at least two must be brighter or darker
		vbx_masked(SVBU, VMOV, v_dark, 0, 0);
		vbx_masked(SVBU, VMOV, v_bright, 0, 0);
		vbx_masked(SVBU, VMOV, v_dark1, 0, 0);
		vbx_masked(SVBU, VMOV, v_bright1, 0, 0);
		vbx_masked(SVBU, VMOV, v_d_count, 0, 0);
		vbx_masked(SVBU, VMOV, v_b_count, 0, 0);

		for(k=0; k<16; k+=4){
			if(k<8){
				// darker
				vbx_masked(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - p0 > threshold
				vbx_masked(SVBU, VMOV, v_t1, 0, 0);
				vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
				vbx_masked(VVBU, VADD, v_d_count, v_d_count, v_t1);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
				vbx_masked(VVBU, VADD, v_dark, v_dark, v_t1);

				// brighter
				vbx_masked(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
				vbx_masked(SVBU, VMOV, v_t1, 0, 0);
				vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
				vbx_masked(VVBU, VADD, v_b_count, v_b_count, v_t1);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
				vbx_masked(VVBU, VADD, v_bright, v_bright, v_t1);
			}else{
				// darker
				vbx_masked(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
				vbx_masked(SVBU, VMOV, v_t1, 0, 0);
				vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
				vbx_masked(VVBU, VADD, v_d_count, v_d_count, v_t1);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
				vbx_masked(VVBU, VADD, v_dark1, v_dark1, v_t1);

				// brighter
				vbx_masked(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
				vbx_masked(SVBU, VMOV, v_t1, 0, 0);
				vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
				vbx_masked(VVBU, VADD, v_b_count, v_b_count, v_t1);
				vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
				vbx_masked(VVBU, VADD, v_bright1, v_bright1, v_t1);
			}
		}
		vbx_masked(SVBU, VMOV, v_exit, 0, 0);
		vbx_masked(SVB, VADD, v_d_count, -1, v_d_count);
		vbx_masked(SVB, VADD, v_b_count, -1, v_b_count);
		vbx_masked(SVB, VCMV_GTZ, v_exit, 1, v_d_count);
		vbx_masked(SVB, VCMV_GTZ, v_exit, 1, v_b_count);
		vbx_setup_mask_masked(VCMV_GTZ, v_exit);
		if(sync1){
			vbx_sync();
			vbx_get_mask_status(&mask_status);
			if( !mask_status ) {
				continue;
			}
		}
#if DEBUG
		vbx_acc(VVBU, VMOV, v_exit, v_exit, 0);
		vbx_sync();
		early_exit_2 += width-3-3-v_exit[0] - row_early_exit_1;
#endif
		// otherwise calculate brighter / darker
		for(k=0; k<16; k++){
			if(k%4){
				if(k<8){
					// darker
                    vbx_masked(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
                    vbx_masked(SVBU, VMOV, v_t1, 0, 0);
                    vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
					vbx_masked(VVBU, VADD, v_dark, v_dark, v_t1);
					// brighter
                    vbx_masked(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
                    vbx_masked(SVBU, VMOV, v_t1, 0, 0);
                    vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
					vbx_masked(VVBU, VADD, v_bright, v_bright, v_t1);
				}else{
					// darker
                    vbx_masked(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
                    vbx_masked(SVBU, VMOV, v_t1, 0, 0);
                    vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
					vbx_masked(VVBU, VADD, v_dark1, v_dark1, v_t1);
					// brighter
                    vbx_masked(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
                    vbx_masked(SVBU, VMOV, v_t1, 0, 0);
                    vbx_masked(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx_masked(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx_masked(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
					vbx_masked(VVBU, VADD, v_bright1, v_bright1, v_t1);
				}
			}
		}
		vbx(SVBU, VMOV, v_result, 0, 0);
		for(k=0; k<16; k++){
			vbx_masked(SVBU, VAND, v_t0, r0[k], v_dark);
			vbx_masked(SVBU, VAND, v_t2, r1[k], v_dark1);
			vbx_masked(SVBU, VAND, v_t1, r0[k], v_bright);
			vbx_masked(SVBU, VAND, v_t3, r1[k], v_bright1);
			vbx_masked(SVBU, VSUB, v_t0, r0[k], v_t0);
			vbx_masked(SVBU, VSUB, v_t2, r1[k], v_t2);
			vbx_masked(SVBU, VSUB, v_t1, r0[k], v_t1);
			vbx_masked(SVBU, VSUB, v_t3, r1[k], v_t3);
			vbx_masked(VVBU, VOR, v_t0, v_t0, v_t2);
			vbx_masked(VVBU, VOR, v_t1, v_t1, v_t3);
			vbx_masked(SVBU, VCMV_Z, v_result, 1, v_t0);
			vbx_masked(SVBU, VCMV_Z, v_result, 1, v_t1);
		}
		vbx_dma_to_host(dst+j-((3*width)+3), v_result, max_vl*sizeof(vbx_ubyte_t));
	}
#if DEBUG
	printf("early exit totals:  #1 = %d\t#2 = %d\n", early_exit_1, early_exit_2);
	printf("early exit percent: #1 = %3.2f\t#2 = %3.2f\n",
				 (1.0*early_exit_1)/((width-3-3)*(height-3-3))*100,
				 (1.0*early_exit_2)/((width-3-3)*(height-3-3))*100);
#endif
	vbx_sp_free();
	vbx_sync();
}

void vector_fast9(uint8_t *dst, uint8_t *src, int height, int width, int pitch, int threshold, int sync0, int sync1)
{
    int j, k;
#if DEBUG
    int early_exit_1 = 0, early_exit_2 = 0;
    int row_early_exit_1;
#endif

	const int support_vl       = (6*width)+6;
	const int image_size       = height*width;
  const vbx_mxp_t *this_mxp  = VBX_GET_THIS_MXP();
	const int row_buffer_space = VBX_PAD_UP(support_vl*sizeof(vbx_ubyte_t), (this_mxp->vector_lanes)*4);
	const int max_supported    =
		VBX_PAD_UP(((this_mxp->scratchpad_size-row_buffer_space) / ((2+FAST9_MASKED_VECTORS)*sizeof(vbx_ubyte_t)))-((this_mxp->vector_lanes)*4)+1, (this_mxp->vector_lanes)*4);
	int next_max_vl = max_supported;
    if(sync0 || sync1){
      if(next_max_vl > this_mxp->vector_lanes*4*24){
              next_max_vl = this_mxp->vector_lanes*4*24;
      }
    }
	if(next_max_vl > image_size-support_vl){
		next_max_vl = image_size-support_vl;
	}

	vbx_ubyte_t *v_src	= (vbx_ubyte_t*)vbx_sp_malloc((support_vl+next_max_vl)*sizeof(vbx_ubyte_t));
	//dma initial rows in
	vbx_dma_to_vector(v_src+next_max_vl, src, support_vl*sizeof(vbx_ubyte_t));

	vbx_ubyte_t *v_next_src = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_dma_to_vector(v_next_src, src+support_vl*sizeof(vbx_ubyte_t), next_max_vl*sizeof(vbx_ubyte_t));

	//allocate other
	vbx_ubyte_t *v_dark =    (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_bright =  (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_dark1 =   (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_bright1 = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_d_count = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_b_count = (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t0 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t1 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t2 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_t3 =      (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_p0_u =    (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_result =  (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_ubyte_t *v_exit   =  (vbx_ubyte_t*)vbx_sp_malloc(next_max_vl*sizeof(vbx_ubyte_t));
	vbx_uword_t *v_exit_w =  (vbx_uword_t*)v_exit;

	vbx_ubyte_t *v_p[16];
	vbx_ubyte_t *v_p0;

	v_p0 = v_src+(3*width)+3;
	for(k=0; k<16; k++){
		v_p[k] = v_src+((3+y[k])*width)+3+x[k];
	}

	int max_vl = next_max_vl;
	for(j = support_vl; j < image_size; j+= max_vl){
#if DEBUG
		row_early_exit_1 = 0;
#endif

		//Move rows up
		vbx_set_vl(support_vl);
		vbx(VVBU, VMOV, v_src, v_src+max_vl, NULL);

		max_vl = next_max_vl;
		vbx_set_vl(max_vl);
		vbx(VVBU, VMOV, v_src+support_vl, v_next_src, NULL);

		//If not at end, dma next rows in
		if(j + max_vl < image_size){
			if(j + max_vl + next_max_vl >= image_size){
				next_max_vl = image_size - (j + max_vl);
			}
			vbx_dma_to_vector(v_next_src, src + j + max_vl, next_max_vl*sizeof(vbx_ubyte_t));
		}

		// early exit #1 - if 1 or 9 is not brighter/darker than threshold
		vbx(SVBU, VADD, v_p0_u,  threshold, v_p0); // p0 + threshold
		if(sync0 || sync1){
			vbx(SVBU, VMOV, v_exit, 0, 0);
			vbx(VVBU, VABSDIFF, v_t0, v_p0, v_p[0]); // p0 - p1
			vbx(VVBU, VABSDIFF, v_t1, v_p0, v_p[8]); // p0 - p9
			vbx(SVBU, VSUB, v_t0, threshold, v_t0); // threshold - abs(p0 - p1)
			vbx(SVBU, VSUB, v_t1, threshold, v_t1); // threshold - abs(p0 - p1)

			//if either is greater than threshold, don't exit -- 0 is exit
			vbx(SVBU, VCMV_LTZ, v_exit, 1, v_t0); // threshold - abs(p0 - p1) < 0
			vbx(SVBU, VCMV_LTZ, v_exit, 1, v_t1); // threshold - abs(p0 - p9) < 0
			vbx_acc(VVBWU, VMOV, v_exit, v_exit, 0);
			vbx_sync();
			if(v_exit_w[0] == 0){
				continue;
			}
#if DEBUG
			row_early_exit_1 = width-3-3-v_exit[0];
			early_exit_1 += width-3-3-v_exit[0];
#endif
		}
		// early exit #2 - at least two must be brighter or darker
		vbx(SVBU, VMOV, v_dark, 0, 0);
		vbx(SVBU, VMOV, v_bright, 0, 0);
		vbx(SVBU, VMOV, v_dark1, 0, 0);
		vbx(SVBU, VMOV, v_bright1, 0, 0);
		if(sync1){
			vbx(SVBU, VMOV, v_d_count, 0, 0);
			vbx(SVBU, VMOV, v_b_count, 0, 0);
		}

		for(k=0; k<16; k+=4){
			if(k<8){
				// darker
				vbx(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
				vbx(SVBU, VMOV, v_t1, 0, 0);
				vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx(SVBU, VSUB, v_t0, threshold, v_t0);
				if(sync1){
					vbx(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
					vbx(VVBU, VADD, v_d_count, v_d_count, v_t1);
				}
				vbx(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0); // if p0 - threshold - pk > 0 then 1<<i
				vbx(VVBU, VADD, v_dark, v_dark, v_t1);

				// brighter
				vbx(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
				vbx(SVBU, VMOV, v_t1, 0, 0);
				vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx(SVBU, VSUB, v_t0, threshold, v_t0);
				if(sync1){
					vbx(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
					vbx(VVBU, VADD, v_b_count, v_b_count, v_t1);
				}
				vbx(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
				vbx(VVBU, VADD, v_bright, v_bright, v_t1);
			}else{
				// darker
				vbx(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
				vbx(SVBU, VMOV, v_t1, 0, 0);
				vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx(SVBU, VSUB, v_t0, threshold, v_t0);
				if(sync1){
					vbx(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
					vbx(VVBU, VADD, v_d_count, v_d_count, v_t1);
				}
				vbx(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0); // if p0 - threshold - pi > 0 then 1<<i
				vbx(VVBU, VADD, v_dark1, v_dark1, v_t1);

				// brighter
				vbx(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
				vbx(SVBU, VMOV, v_t1, 0, 0);
				vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
				vbx(SVBU, VSUB, v_t0, threshold, v_t0);
				if(sync1){
					vbx(SVBU, VCMV_LTZ, v_t1, 1, v_t0);
					vbx(VVBU, VADD, v_b_count, v_b_count, v_t1);
				}
				vbx(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
				vbx(VVBU, VADD, v_bright1, v_bright1, v_t1);
			}
		}
		if(sync1){
			vbx(SVBU, VMOV, v_exit, 0, 0);
			vbx(SVB, VADD, v_d_count, -1, v_d_count);
			vbx(SVB, VADD, v_b_count, -1, v_b_count);
			vbx(SVB, VCMV_GTZ, v_exit, 1, v_d_count);
			vbx(SVB, VCMV_GTZ, v_exit, 1, v_b_count);
			vbx_acc(VVBWU, VMOV, v_exit, v_exit, 0);
			vbx_sync();
			if(v_exit_w[0] == 0){
				continue;
			}
#if DEBUG
			early_exit_2 += width-3-3-v_exit[0] - row_early_exit_1;
#endif
		}
		// otherwise calculate brighter / darker
		for(k=0; k<16; k++){
			if(k%4){
				if(k<8){
					// darker
                    vbx(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
                    vbx(SVBU, VMOV, v_t1, 0, 0);
                    vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
					vbx(VVBU, VADD, v_dark, v_dark, v_t1);
					// brighter
                    vbx(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
                    vbx(SVBU, VMOV, v_t1, 0, 0);
                    vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx(SVBU, VCMV_LTZ, v_t1, 1<<k, v_t0);
					vbx(VVBU, VADD, v_bright, v_bright, v_t1);
				}else{
					// darker
                    vbx(VVBU, VSUB, v_t0, v_p0, v_p[k]); //p0 - pk > threshold
                    vbx(SVBU, VMOV, v_t1, 0, 0);
                    vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
					vbx(VVBU, VADD, v_dark1, v_dark1, v_t1);
					// brighter
                    vbx(VVBU, VSUB, v_t0, v_p[k], v_p0); //pk - p0 > threshold
                    vbx(SVBU, VMOV, v_t1, 0, 0);
                    vbx(SVBU, VCMV_LTZ, v_t0, 0, v_t0);
                    vbx(SVBU, VSUB, v_t0, threshold, v_t0);
					vbx(SVBU, VCMV_LTZ, v_t1, 1<<(k-8), v_t0);
					vbx(VVBU, VADD, v_bright1, v_bright1, v_t1);
				}
			}
		}
		vbx(SVBU, VMOV, v_result, 0, 0);
		for(k=0; k<16; k++){
			vbx(SVBU, VAND, v_t0, r0[k], v_dark);
			vbx(SVBU, VAND, v_t2, r1[k], v_dark1);
			vbx(SVBU, VAND, v_t1, r0[k], v_bright);
			vbx(SVBU, VAND, v_t3, r1[k], v_bright1);
			vbx(SVBU, VSUB, v_t0, r0[k], v_t0);
			vbx(SVBU, VSUB, v_t2, r1[k], v_t2);
			vbx(SVBU, VSUB, v_t1, r0[k], v_t1);
			vbx(SVBU, VSUB, v_t3, r1[k], v_t3);
			vbx(VVBU, VOR, v_t0, v_t0, v_t2);
			vbx(VVBU, VOR, v_t1, v_t1, v_t3);
			vbx(SVBU, VCMV_Z, v_result, 1, v_t0);
			vbx(SVBU, VCMV_Z, v_result, 1, v_t1);
		}
		vbx_dma_to_host(dst+j-((3*width)+3), v_result, max_vl*sizeof(vbx_ubyte_t));
	}
#if DEBUG
	if(!sync0 || !sync1){
		printf("early exit requires sync0 and sync1 to be on\n");
	} else {
		printf("early exit totals:  #1 = %d\t#2 = %d\n", early_exit_1, early_exit_2);
		printf("early exit percent: #1 = %3.2f\t#2 = %3.2f\n",
					 (1.0*early_exit_1)/((width-3-3)*(height-3-3))*100,
					 (1.0*early_exit_2)/((width-3-3)*(height-3-3))*100);
	}
#endif
	vbx_sp_free();
	vbx_sync();
}
