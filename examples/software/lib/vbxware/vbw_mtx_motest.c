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
VBXCOPYRIGHT( mtx_motest )

//
// Motion Estimation
// Scalar NIOS version and vbx VECTOR version
//

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbw_mtx_motest.h"
#include "vbw_exit_codes.h"



/** Setup function before running VBX Motion Estimation.
 *  It is the responsibility of the caller to do a vbx_sp_push() before calling this function
 *  and then to do a vbx_sp_pop() when motion estimation is no longer needed.
 *  @pre m.image_width, m.image_height, m.block_width, m.block_height, m.search_width,
 *       and m.search_height are all properly initialized.
 *  @post space is allocated on the scratchpad for m.v_bloc, m.v_img, m.v_result,
 *        m.v_img_sub, and m.v_absdiff.
 * @param[in,out] m
 * @returns negative on error condition. See vbw_exit_codes.h
*/
int vbw_mtx_motest_byte_setup( vbw_motest_t *m )
{

	int sub_block_width      = m->block_width+m->search_width;

	m->result_size = m->search_width * m->search_height*sizeof(output_type);


	// 2D and 3D
	m->v_block  = (input_type  *)vbx_sp_malloc(  m->block_height                   * sub_block_width*sizeof(input_type) );
	m->v_img    = (input_type  *)vbx_sp_malloc( (m->block_height+m->search_height) * sub_block_width*sizeof(input_type) );
	m->v_result = (output_type *)vbx_sp_malloc(  m->result_size );
	// 2D
	m->v_img_sub = (input_type  *)vbx_sp_malloc( (m->block_height+m->search_height) * m->block_width * sizeof(input_type) );
	m->v_absdiff = (input_type  *)vbx_sp_malloc(  m->block_width * m->block_height                   * sizeof(input_type) );

	// check to make sure we don't have any null pointers after sp_malloc
	if( !m->v_block || !m->v_img || !m->v_result || !m->v_img_sub || !m->v_absdiff ) {
		return VBW_ERROR_SP_ALLOC_FAILED;
	}
	return VBW_SUCCESS;
}


/** VBX Motion Estimation.
 *  Similar to the scalar version but scans vertically as it makes it easier to align vectors.
 *  vbw_mtx_motest_byte_setup should be run prior to running this function.
 *
 *  @param[out] result
 *  @param[in] x
 *  @param[in] y
 *  @param[in] m
 *  @returns negative on error condition. See vbw_exit_codes.h
 */
int vbw_mtx_motest_byte(output_type *result, input_type *x, input_type *y, vbw_motest_t *m)
{
	int  j;

	int sub_block_width      = m->block_width+m->search_width;

	for( j = 0; j < m->block_height; j++ ) {
		vbx_dma_to_vector( m->v_block+j*sub_block_width, x+j*m->image_width, sub_block_width*sizeof(input_type) );
	}

	for( j = 0; j < m->block_height+m->search_height; j++ ) {
		vbx_dma_to_vector( m->v_img  +j*sub_block_width, y+j*m->image_width, sub_block_width*sizeof(input_type) );
	}

	// column-ize the reference block
	vbx_set_vl( m->block_width );
	vbx_set_2D( m->block_height, m->block_width*sizeof(input_type), sub_block_width*sizeof(input_type), 0 );
	vbx_2D( VVB, VMOV, (vbx_byte_t*)m->v_block, (vbx_byte_t*)m->v_block, 0 );

	//Do column by column

	for( j=0; j < m->search_width; j++ )
	{
		// column-ize the search image
		vbx_set_vl( m->block_width );
		vbx_set_2D( m->block_height+m->search_height,  m->block_width*sizeof(input_type), sub_block_width*sizeof(input_type), 0 );
		vbx_2D( VVBU, VMOV, m->v_img_sub, m->v_img+j, 0 );

		// search the image columnwise
		vbx_set_vl( m->block_width*m->block_height );
		vbx_set_2D( m->search_height, m->search_width*sizeof(output_type), 0,  m->block_width*sizeof(input_type) );
		vbx_acc_2D( VVBWU, VABSDIFF, (vbx_uword_t*)m->v_result+j, m->v_block, m->v_img_sub );
	}

	// Write back result
	vbx_dma_to_host( result, m->v_result, m->result_size );

	return VBW_SUCCESS;
}

/** Setup function before running VBX Motion Estimation, using vbx_3d ops.
 *  It is the responsibility of the caller to do a vbx_sp_push() before calling this function
 *  and then to do a vbx_sp_pop() when motion estimation is no longer needed.
 *  @pre m.image_width, m.image_height, m.block_width, m.block_height, m.search_width,
 *       and m.search_height are all properly initialized.
 *  @pre m.block_height is an even number.
 *  @post space is allocated on the scratchpad for m.v_bloc, m.v_img, m.v_row_sad, and m.v_result.

 *  @param[in,out] m
 *  @returns negative on error condition. See vbw_exit_codes.h
 */
int vbw_mtx_motest_3d_byte_setup(vbw_motest_t *m)
{

	m->result_size = m->search_width*m->search_height*sizeof(output_type);

	m->v_block   = (input_type        *)vbx_sp_malloc( m->block_height*m->block_width*sizeof(input_type) );
	m->v_img     = (input_type        *)vbx_sp_malloc( (m->block_height+m->search_height)*(m->block_width+m->search_width)*sizeof(input_type) );
	m->v_row_sad = (intermediate_type *)vbx_sp_malloc( m->block_height*m->search_width*sizeof(intermediate_type) );
	m->v_result  = (output_type       *)vbx_sp_malloc( m->result_size );

	// check to make sure we don't have any null pointers after sp_malloc
	if( !m->v_block || !m->v_img || !m->v_row_sad || !m->v_result ) {
		return VBW_ERROR_SP_ALLOC_FAILED;
	}

	return VBW_SUCCESS;
}

/** VBX Motion Estimation, using vbx_3d ops.
 * vbw_mtx_motest_3D_byte_setup should be run prior to running this function.
 * Using bytes as input data. block_height must be an even number.
 *
 * @param[out] result
 * @param[in] x
 * @param[in] y
 * @param[in] m
 * @returns negative on error condition. See vbw_exit_codes.h
 */
int vbw_mtx_motest_3d_byte(output_type *result, input_type* x, input_type *y, vbw_motest_t *m)
{

	int  l,j;
	int sub_block_width      = m->block_width+m->search_width;

	for( j = 0; j < m->block_height; j++ ) {
		vbx_dma_to_vector( m->v_block+j*m->block_width, x+j*m->image_width, m->block_width*sizeof(input_type) );
	}
	for( j = 0; j < m->block_height+m->search_height; j++ ) {
		vbx_dma_to_vector( m->v_img+j*sub_block_width, y+j*m->image_width, sub_block_width*sizeof(input_type) );
	}

	vbx_set_3D( m->search_width, m->block_height*sizeof(intermediate_type), sizeof(input_type), 0 );

	for( l = 0; l < m->search_height; l++ ) {
		//Accumulate each row into a vbx of row SADs
		vbx_set_vl( m->block_width );
		vbx_set_2D( m->block_height, sizeof(intermediate_type), sub_block_width*sizeof(input_type), m->block_width*sizeof(input_type) );
		vbx_acc_3D( VVBHU, VABSDIFF, m->v_row_sad, m->v_img+l*sub_block_width, m->v_block );

		//Accumulate the SADs
		vbx_set_vl( m->block_height/2 );
		vbx_set_2D( m->search_width, sizeof(output_type), m->block_height*sizeof(intermediate_type), m->block_height*sizeof(intermediate_type) );
		vbx_acc_2D( VVHWU, VADD, (vbx_uword_t*)m->v_result+l*m->search_width, m->v_row_sad, m->v_row_sad+(m->block_height/2) );

		//Transfer the line to host
		vbx_dma_to_host( result+l*m->search_width, m->v_result+l*m->search_width, m->search_width*sizeof(output_type) );

	}

	return VBW_SUCCESS;
}
