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
VBXCOPYRIGHT(vbw_sobel_argb32_3x3)

#include "vbx.h"
#include "vbx_port.h"
#include "vbw_mtx_sobel.h"
#include "vbw_exit_codes.h"
#include "vbw_buffer.h"
#define FILTER_HEIGHT 3
/// Convert a row of aRGB pixels into luma values
/// v_luma should not equal v_row_in
/// Trashes v_temp
static void vbw_rgb2luma(vbx_uhalf_t *v_luma, vbx_uword_t *v_row_in, vbx_uhalf_t *v_temp, const int image_width)
{
	vbx_set_vl(image_width);

	// Move weighted B into v_luma
	vbx(SVWHU, VAND, v_temp, 0xFF,   v_row_in);
	vbx(SVHU,  VMUL, v_luma, 25,     v_temp);

	// Move weighted G into v_temp and add it to v_luma
	vbx(SVWHU, VAND, v_temp, 0xFF,   (vbx_uword_t*)(((vbx_ubyte_t *)v_row_in)+1));
	vbx(SVHU,  VMUL, v_temp, 129,    v_temp);
	vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

	// Move weighted R into v_temp and add it to v_luma
	vbx(SVWHU, VAND, v_temp, 0xFF,   (vbx_uword_t*)(((vbx_ubyte_t *)v_row_in)+2));
	vbx(SVHU,  VMUL, v_temp, 66,     v_temp);
	vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

	vbx(SVHU,  VADD, v_luma, 128,    v_luma); // for rounding
	vbx(SVHU,  VSHR, v_luma, 8,      v_luma);
}


/// Apply [1 2 1] low-pass filter to raw input row
/// NB: Last two output pixels are not meaningful
inline static void vbw_sobel_3x3_row(vbx_uhalf_t *lpf, vbx_uhalf_t *raw, const short image_width)
{
	vbx_set_vl(image_width-1);
	vbx(VVHU, VADD, lpf, raw, raw+1);
	vbx_set_vl(image_width-2);
	vbx(VVHU, VADD, lpf, lpf, lpf+1);
}


/** Luma Edge Detection
 *
 * @brief 3x3 Sobel edge detection with 32-bit aRGB image
 *
 * @param[out] output      32-bit aRGB edge-intensity output
 * @param[in] input        32-bit aRGB input
 * @param[in] image_width  Image width in pixels
 * @param[in] image_height Image height in pixels
 * @param[in] image_pitch  Distance in pixels between the start of subsequent rows. usually equal to image_width
 * @param[in] renorm       Number of bits to shift the final intensity by to the right
 * @returns Negative on error condition. See vbw_exit_codes.h
 */
int vbw_sobel_argb32_3x3_partial(unsigned *output, unsigned *input, const short image_width, const short image_height, const short image_pitch, const short renorm)
{

	int y;

	vbx_uword_t *v_row_in;
	vbx_uhalf_t *v_luma_top, *v_luma_mid, *v_luma_bot;
	vbx_uword_t *v_row_out;

	vbx_uhalf_t *v_sobel_row_top, *v_sobel_row_mid, *v_sobel_row_bot;
	vbx_uhalf_t *v_gradient_x, *v_gradient_y;
	vbx_uhalf_t *v_tmp;

	void *tmp_ptr;

	vbx_sp_push();

	// Allocate space in scratchpad for vectors
	struct rotating_prefetcher_t v_row_db=rotating_prefetcher(1,image_width*sizeof(vbx_uword_t),
	                                                          input,input+image_pitch*image_width,
	                                                          image_pitch*sizeof(vbx_uword_t));

	v_luma_top      = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_luma_mid      = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_luma_bot      = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_sobel_row_top = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_sobel_row_mid = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_sobel_row_bot = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	v_row_out       = (vbx_uword_t*)vbx_sp_malloc(image_width*sizeof(vbx_uword_t));

	if(v_row_out==NULL){
		vbx_sp_pop();
		return VBW_ERROR_SP_ALLOC_FAILED;
	}

	// Re-use v_sobel_row_bot as v_tmp
	v_tmp = v_sobel_row_bot;

	// Transfer the first 3 input rows and interleave first 2 rgb2luma and first 2 sobel row calculations
	rp_fetch(&v_row_db);
	rp_fetch(&v_row_db);
	v_row_in=rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma(v_luma_top, v_row_in, v_tmp, image_width);                                          // 1st luma row


	vbw_sobel_3x3_row(v_sobel_row_top, v_luma_top, image_width);                                     // 1st partial sobel row
	rp_fetch(&v_row_db);
	v_row_in=rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma(v_luma_mid, v_row_in, v_tmp, image_width);                               // 2nd luma row
	vbw_sobel_3x3_row(v_sobel_row_mid, v_luma_mid, image_width);                                     // 2nd partial sobel row

	// Set top output row to 0
	vbx_set_vl(image_width);
	vbx(SVWU, VMOV, v_row_out, 0, 0);
	vbx_dma_to_host(output, v_row_out, image_width*sizeof(vbx_uword_t));

	// Calculate edges
	for (y = 0; y < image_height-(FILTER_HEIGHT-1); y++) {
		// Transfer the next input row while processing
		rp_fetch(&v_row_db);
		v_row_in=rp_get_buffer(&v_row_db,0);
// Re-use v_sobel_row_bot as v_tmp
		v_tmp = v_sobel_row_bot;

		// Convert aRGB input to luma
		vbw_rgb2luma(v_luma_bot, v_row_in, v_tmp, image_width);
		// Done with v_row_in; re-use for v_gradient_x and v_gradient_y (be careful!)
		v_gradient_x = (vbx_uhalf_t *)v_row_in;
		v_gradient_y = (vbx_uhalf_t *)v_row_in + image_width;

		// Calculate gradient_x
		// Apply [1 2 1]T matrix to all columns
		vbx_set_vl(image_width);
		vbx(SVHU, VSHL, v_gradient_x, 1,          v_luma_mid); // multiply by 2
		vbx(VVHU, VADD, v_tmp,        v_luma_top, v_luma_bot);
		vbx(VVHU, VADD, v_tmp,        v_tmp,      v_gradient_x);
		// For each column, calculate absolute difference with 2nd column to the right
		vbx_set_vl(image_width-2);
		vbx(VVH, VABSDIFF, (vbx_half_t*)v_gradient_x, (vbx_half_t*)v_tmp, (vbx_half_t*)v_tmp+2);

		// Calculate gradient_y
		// Apply [1 2 1] matrix to last row in window and calculate absolute difference with pre-computed first row
		vbw_sobel_3x3_row(v_sobel_row_bot, v_luma_bot, image_width);
		vbx(VVH, VABSDIFF, (vbx_half_t*)v_gradient_y, (vbx_half_t*)v_sobel_row_top, (vbx_half_t*)v_sobel_row_bot);

		// Re-use v_sobel_row_top as v_tmp
		v_tmp = v_sobel_row_top;

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

		// DMA the result to the output (minus the outside two pixels
		vbx_dma_to_host(output+(y+1)*image_pitch+1, v_row_out+1, (image_width-2)*sizeof(vbx_uword_t));

		// Rotate luma buffers
		tmp_ptr      = (void *)v_luma_top;
		v_luma_top   = v_luma_mid;
		v_luma_mid   = v_luma_bot;
		v_luma_bot   = (vbx_uhalf_t *)tmp_ptr;

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

	vbx_sp_pop();

	return VBW_SUCCESS;
}

int vbw_sobel_argb32_3x3(unsigned *output, unsigned *input, const short image_width, const short image_height, const short image_pitch, const short renorm)
{
	size_t free_sp=vbx_sp_getfree();
	size_t vectors_needed=8;
	size_t partial_width=free_sp/(vectors_needed*sizeof(vbx_uword_t));
	if(partial_width>image_width){
		vbw_sobel_argb32_3x3_partial(output, input, image_width, image_height, image_pitch,renorm);
	}else{
		//can do entire row at a time, so do partial_width at a time
		size_t partial_step=partial_width-2;
		int i;
		for(i=0;;i+=partial_step){
			//account for last tile being smaller
			if(i+partial_width > image_width){
				partial_width=image_width-i;
			}

			vbw_sobel_argb32_3x3_partial(output+i, input+i, partial_width, image_height, image_pitch,renorm);

			if(i+partial_width == image_width){
				//that was the last tile, so break,
				//I don't believe that this can be in the for statement
				break;
			}
		}
	}
	vbx_sp_push();
	vbx_word_t* side=vbx_sp_malloc(sizeof(vbx_word_t));
	vbx_set_vl(1);
	vbx(SVW,VMOV,side,0,0);
	vbx_dma_to_host_2D(output,/*host_ptr*/
	                   side,/*sp_ptr*/
	                   sizeof(vbx_word_t),/*row len*/
	                   image_height,/*num rows*/
	                   image_pitch*sizeof(vbx_word_t),/*host_incr*/
	                   0);/*sp incr*/
	vbx_dma_to_host_2D(output+image_width-1,/*host_ptr*/
	                   side,/*sp_ptr*/
	                   sizeof(vbx_word_t),/*row len*/
	                   image_height,/*num rows*/
	                   image_pitch*sizeof(vbx_word_t),/*host_incr*/
	                   0);/*sp incr*/
	vbx_sp_pop();
	vbx_sync();

}
