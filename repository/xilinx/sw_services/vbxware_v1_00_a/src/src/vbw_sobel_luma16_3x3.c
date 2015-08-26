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

/**@file*/
#include "vbx_copyright.h"
VBXCOPYRIGHT(vbw_sobel_luma16_3x3)

#include "vbx.h"
#include "vbw_mtx_sobel.h"
#include "vbw_exit_codes.h"
#include "vbw_buffer.h"
#define FILTER_HEIGHT 3
/// Apply [1 2 1] low-pass filter to raw input row
/// NB: Last two output pixels are not meaningful
static inline void vbw_sobel_3x3_row(vbx_uhalf_t *lpf, vbx_uhalf_t *raw, const short image_width)
{
	vbx_set_vl(image_width-1);
	vbx(VVHU, VADD, lpf, raw, raw+1);
	vbx_set_vl(image_width-2);
	vbx(VVHU, VADD, lpf, lpf, lpf+1);
}

/** Luma Edge Detection.
 *
 * @brief 3x3 Sobel edge detection with 16-bit luma image
 *
 * @param[out] output      32-bit aRGB edge-intensity output
 * @param[in] input        16-bit luma input
 * @param[in] image_width  Image width in pixels
 * @param[in] image_height Image height in pixels
 * @param[in] image_pitch  Distance in pixels between the start of subsequent rows. usually equal to image_width
 * @param[in] renorm       Number of bits to shift the final intensity by to the right
 * @returns Negative on error condition. See vbw_exit_codes.h
 */
int vbw_sobel_luma16_3x3(unsigned *output, unsigned short *input, const short image_width, const short image_height, const short image_pitch, const short renorm)
{
	int y;

	vbx_uhalf_t *v_luma_top, *v_luma_mid, *v_luma_bot;
	vbx_uword_t *v_row_out;

	vbx_uhalf_t *v_sobel_row_top, *v_sobel_row_mid, *v_sobel_row_bot;
	vbx_uhalf_t *v_gradient_x, *v_gradient_y;
	vbx_uhalf_t *v_tmp;

	void *tmp_ptr;

	vbx_sp_push();

	// Allocate space in scratchpad for vectors
	rotating_prefetcher_t v_luma=rotating_prefetcher(3,image_width*sizeof(vbx_uhalf_t),
	                                                 input,input+image_width*image_pitch,
	                                                 image_pitch*sizeof(vbx_uhalf_t));
	v_sobel_row_top = (vbx_uhalf_t *)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_sobel_row_mid = (vbx_uhalf_t *)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_sobel_row_bot = (vbx_uhalf_t *)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_gradient_x    = (vbx_uhalf_t *)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_gradient_y    = (vbx_uhalf_t *)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_row_out       = (vbx_uword_t *)vbx_sp_malloc(image_width*sizeof(vbx_uword_t));
	if(v_row_out==NULL) {
		vbx_sp_pop();
		return VBW_ERROR_SP_ALLOC_FAILED;
	}

	// Transfer the first 3 input rows and interleave first 2 sobel row calculations
	rp_fetch(&v_luma);
	rp_fetch(&v_luma);
	v_luma_top=rp_get_buffer(&v_luma, 0);
	vbw_sobel_3x3_row(v_sobel_row_top, v_luma_top,image_width);
	rp_fetch(&v_luma);
	v_luma_mid=rp_get_buffer(&v_luma, 1);
	vbw_sobel_3x3_row(v_sobel_row_mid, v_luma_mid, image_width);

	// Set top output row to 0
	vbx_set_vl(image_width);
	vbx(SVWU, VMOV, v_row_out, 0, 0);
	vbx_dma_to_host(output, v_row_out, image_width*sizeof(vbx_uword_t));

	// Calculate edges
	for (y = 0; y < image_height-(FILTER_HEIGHT-1); y++) {
		// Transfer the next input row while processing
		rp_fetch(&v_luma);
		v_luma_top=rp_get_buffer(&v_luma,0);
		v_luma_mid=rp_get_buffer(&v_luma,1);
		v_luma_bot=rp_get_buffer(&v_luma,2);
		// Start calculating gradient_x
		vbx_set_vl(image_width);
		vbx(SVHU, VSHL, v_gradient_x, 1, v_luma_mid); // multiply by 2

		// Calculate gradient_y
		// Apply [1 2 1] matrix to last row in window and calculate absolute difference with pre-computed first row
		vbw_sobel_3x3_row(v_sobel_row_bot, v_luma_bot, image_width);
		vbx(VVH, VABSDIFF, (vbx_half_t*)v_gradient_y, (vbx_half_t*)v_sobel_row_top, (vbx_half_t*)v_sobel_row_bot);

		// Re-use v_sobel_row_top
		v_tmp = v_sobel_row_top;

		// Finish calculating gradient_x
		// Apply [1 2 1]T matrix to all columns
		vbx_set_vl(image_width);
		vbx(VVHU,  VADD, v_tmp, v_luma_top, v_luma_bot);
		vbx(VVHU,  VADD, v_tmp, v_tmp,      v_gradient_x);
		// For each column, calculate absolute difference with 2nd column to the right
		vbx_set_vl(image_width-2);
		vbx(VVH, VABSDIFF, (vbx_half_t*)v_gradient_x, (vbx_half_t*)v_tmp, (vbx_half_t*)v_tmp+2);

		// sum of absoute gradients
		vbx_set_vl(image_width-2);
		vbx(VVHU, VADD, v_tmp, v_gradient_x,  v_gradient_y);
		vbx(SVHU, VSHR, v_tmp, renorm, v_tmp);

		// Threshold
		vbx(SVHU, VSUB,     v_gradient_y, 255, v_tmp);
		vbx(SVHU, VCMV_LTZ, v_tmp,        255, v_gradient_y);

		// Copy the result to the low byte of the output row
		// Trick to copy the low byte (b) to the middle two bytes as well
		// Note that first and last columns are 0
		vbx_set_vl(image_width-2);
		vbx(SVHWU, VMULLO, v_row_out+1, 0x00010101, v_tmp);

		// DMA the result to the output
		vbx_dma_to_host(output+(y+1)*image_pitch, v_row_out, image_width*sizeof(vbx_uword_t));

		/* // Rotate input row buffers */
		/* tmp_ptr      = (void *)v_luma_top; */
		/* v_luma_top   = v_luma_mid; */
		/* v_luma_mid   = v_luma_bot; */
		/* v_luma_bot   = v_luma_nxt; */
		/* v_luma_nxt   = (vbx_uhalf_t *)tmp_ptr; */

		// Rotate v_sobel_row buffers (for gradient_y)
		tmp_ptr         = (void *)v_sobel_row_top;
		v_sobel_row_top = v_sobel_row_mid;
		v_sobel_row_mid = v_sobel_row_bot;
		v_sobel_row_bot = (vbx_uhalf_t *)tmp_ptr;
	}

	// Set bottom row to 0
	vbx_set_vl(image_width);
	vbx(SVWU, VMOV, v_row_out, 0, 0);
	vbx_dma_to_host(output+(image_height-1)*image_pitch, v_row_out, image_width*sizeof(vbx_uword_t));

	vbx_sync();
	vbx_sp_pop();

	return VBW_SUCCESS;
}
