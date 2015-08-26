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
VBXCOPYRIGHT(vbw_rgb2luma16)

#include "vbx.h"
#include "vbw_exit_codes.h"

/**Convert RGB frame to 16-bit luma
 * @brief Convert RGB frame to 16-bit luma using Bt.601 coefficients.
 * @pre needs at least 14*image_width (more depending on SP width) bytes available scratch.
 *
 * @param[out] luma         16-bit luma pixel output
 * @param[in] rgb          32-bit aRGB pixel input
 * @param[in] image_width  input/output image width
 * @param[in] image_height input/output image height
 * @param[in] image_pitch  input/output image pitch
 *
 * @returns negative on error condition. See vbw_exit_codes.h
 */
int vbw_rgb2luma16(unsigned short *luma, unsigned *rgb, const short image_width, const short image_height, const short image_pitch)
{
	vbx_uword_t *v_row_in, *v_row_in_next, *tmp_ptr;
	vbx_uhalf_t *v_row_out;
	vbx_uhalf_t *v_luma, *v_temp;
	int          i;

	int vector_bytes = image_width*sizeof(vbx_uword_t);

	vbx_set_vl(image_width);



	vbx_sp_push();

	// Allocate scratchpad memory for vectors
	v_row_in      = (vbx_uword_t *)vbx_sp_malloc(vector_bytes);
	v_row_in_next = (vbx_uword_t *)vbx_sp_malloc(vector_bytes);
	v_luma        = (vbx_uhalf_t *)vbx_sp_malloc(vector_bytes>>1);
	v_temp        = (vbx_uhalf_t *)vbx_sp_malloc(vector_bytes>>1);
	v_row_out     = (vbx_uhalf_t *)vbx_sp_malloc(vector_bytes>>1);
	if(v_row_out == NULL){
		vbx_sp_pop();
		return VBW_ERROR_SP_ALLOC_FAILED;
	}

	// Transfer the first input row to scratchpad
	vbx_dma_to_vector(v_row_in, rgb, vector_bytes);

	// Convert rows of RGB to luma
	for (i = 0; i < image_height; i++) {
		// Transfer the next input row to scratchpad while processing
		if ((i+1) < image_height)
			vbx_dma_to_vector(v_row_in_next, rgb + (i+1)*image_pitch, vector_bytes);

		// Move weighted B into v_luma
		vbx(SVWHU, VAND, v_temp,   0xFF, v_row_in);
		vbx(SVHU,  VMUL, v_luma,     25, v_temp);

		// Move weighted G into v_temp and add it to v_luma
        vbx(SVWHU, VAND, v_temp,   0xFF, (vbx_uword_t*)(((vbx_ubyte_t *)v_row_in)+1));
		vbx(SVHU,  VMUL, v_temp,    129, v_temp);
		vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

		// Move weighted R into v_temp and add it to v_luma
        vbx(SVWHU, VAND, v_temp,   0xFF, (vbx_uword_t*)(((vbx_ubyte_t *)v_row_in)+2));
		vbx(SVHU,  VMUL, v_temp,     66, v_temp);
		vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

		// Round and normalize
		vbx(SVHU,  VADD, v_luma,  128, v_luma);
		vbx(SVHU,  VSHR, v_row_out, 8, v_luma);

		// Transfer from scratchpad memory to output
		vbx_dma_to_host(luma + i*image_pitch, v_row_out, vector_bytes>>1);

		// Swap scratchpad input buffer pointers
		tmp_ptr       = v_row_in;
		v_row_in      = v_row_in_next;
		v_row_in_next = tmp_ptr;
	}

	vbx_sp_pop();
	return VBW_SUCCESS;
}
