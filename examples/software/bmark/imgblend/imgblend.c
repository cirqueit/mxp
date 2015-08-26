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
VBXCOPYRIGHT( mtx_imgblend )

#include "vbx.h"

#include "imgblend.h"

//rgb to greyscale conversion for scaler processor
void scalar_blend(
	output_pointer img_out, input_pointer img_in1, input_pointer img_in2,
	unsigned int num_row, unsigned int num_column, intermediate_type blending_const )
{
	int i,j;

	intermediate_type blending_const_bar;
	blending_const_bar = 256-blending_const;
	for( i=0; i<num_row; i++ ) {
		for( j=0; j<num_column; j++ ) {
			*img_out++ = (input_type)((blending_const*(*img_in1++) + blending_const_bar*(*img_in2++)) >> 8);
		}
	}
	img_out -= num_row*num_column;
	img_in1 -= num_row*num_column;
	img_in2 -= num_row*num_column;
}





//vector version of rgb converter
void vector_blend(
	output_pointer img_out, input_pointer img_in1, input_pointer img_in2,
	unsigned int num_row, unsigned int num_column, intermediate_type blending_const )
{
	intermediate_type *v_img1[2];
	input_type        *v_img2[2];
	intermediate_type *v_temp;

	intermediate_type blending_const_bar = 256-blending_const;
	int j;

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	const int VBX_WIDTH_BYTES     = this_mxp->vector_lanes * sizeof(int);
	const int VBX_DMA_ALIGNMENT   = this_mxp->dma_alignment_bytes;

	unsigned int chunk_size = VBX_SCRATCHPAD_SIZE/((3*sizeof(intermediate_type))+(2*sizeof(input_type)));
	chunk_size = VBX_PAD_UP( chunk_size-(VBX_WIDTH_BYTES-1), VBX_DMA_ALIGNMENT );

	unsigned int chunk_size_old    = chunk_size;
	unsigned int vector_length     = chunk_size;
	unsigned int vector_length_old = vector_length;

	v_img1[0] = (intermediate_type *)vbx_sp_malloc( chunk_size*sizeof(intermediate_type) );
	v_img1[1] = (intermediate_type *)vbx_sp_malloc( chunk_size*sizeof(intermediate_type) );
	v_img2[0] = (input_type        *)vbx_sp_malloc( chunk_size*sizeof(input_type) );
	v_img2[1] = (input_type        *)vbx_sp_malloc( chunk_size*sizeof(input_type) );
	v_temp    = (intermediate_type *)vbx_sp_malloc( chunk_size*sizeof(intermediate_type) );

	if( v_temp == NULL ) {
		VBX_EXIT(0xBADDEAD);
	}

	int bufselect = 0;

	vbx_dma_to_vector( v_img1[bufselect], img_in1, chunk_size*sizeof(input_type) );
	vbx_dma_to_vector( v_img2[bufselect], img_in2, chunk_size*sizeof(input_type) );

	for( j=0; j<num_row*num_column; j+=vector_length_old ) {
		vbx_set_vl(vector_length);

		if( j > 0 ) {
			vbx_dma_to_host( img_out+j-vector_length_old, v_img1[1-bufselect], chunk_size_old*sizeof(output_type) );
		} 

		if( (j+vector_length_old) < (num_row*num_column-1) ) {
			if( (j+vector_length_old*2) >= num_row*num_column ) {
				vector_length =  num_row*num_column - j - vector_length_old;
				chunk_size = vector_length;
			}
			vbx_dma_to_vector( v_img1[1-bufselect], img_in1+j+vector_length_old, chunk_size*sizeof(input_type) );
			vbx_dma_to_vector( v_img2[1-bufselect], img_in2+j+vector_length_old, chunk_size*sizeof(input_type) );
		} 		 		       

		vbx( SVBHU, VMULLO, v_temp,            blending_const,     v_img1[bufselect] );
		vbx( SVBHU, VMULLO, v_img1[bufselect], blending_const_bar, v_img2[bufselect] );
		vbx( VVHU,  VADD,   v_img1[bufselect], v_img1[bufselect],  v_temp );
		vbx( SVHBU, VSHR,   v_img1[bufselect], 8,                  v_img1[bufselect] );

		bufselect = 1-bufselect;
	}

	vbx_dma_to_host( img_out+j-vector_length_old, v_img1[1-bufselect], chunk_size*sizeof(output_type) );
	vbx_sp_free();
	vbx_sync();
}
