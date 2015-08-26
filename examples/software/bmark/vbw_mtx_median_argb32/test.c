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
VBXCOPYRIGHT(test_median_argb)

// This test currently requires at least 32KB of scratchpad memory.

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "scalar_mtx_median_argb32.h"
#include "vbw_mtx_median_argb32.h"

#define VBX_TEMPLATE_T   VBX_UWORDSIZE_DEF
// signed   VBX_BYTESIZE_DEF    VBX_HALFSIZE_DEF    VBX_WORDSIZE_DEF
// unsigned VBX_UBYTESIZE_DEF   VBX_UHALFSIZE_DEF   VBX_UWORDSIZE_DEF
#include "vbw_template_t.h"

#define FILTER_WIDTH    3
#define FILTER_HEIGHT   3
#define IMAGE_HEIGHT    (1080/2)
#define IMAGE_WIDTH     (1920/2)
#define IMAGE_PITCH     1920

double test_vector( vbx_mm_t *vector_in, int filter_height, int filter_width, int image_height,
                    int image_width, int image_pitch, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP matrix median...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = vbw_mtx_median_ext_argb32( (unsigned *)vector_in, (unsigned *)vector_in, filter_height,
	                                    filter_width, image_height, image_width, image_pitch );
	time_stop = vbx_timestamp();

	printf( "...done. retval = %08X \n", retval );
	return vbx_print_vector_time(time_start, time_stop, scalar_time);
}

double test_scalar( vbx_mm_t *scalar_in, int filter_height, int filter_width, int image_height,
                    int image_width, int image_pitch )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting scalar matrix median...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_mtx_median_argb32( (pixel *)scalar_in, filter_height, filter_width,
	                           image_height, image_width, image_pitch );
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_scalar_time(time_start, time_stop);
}

int main(void)
{
	vbx_test_init();

#if 0
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	int N = VBX_SCRATCHPAD_SIZE/sizeof(vbx_mm_t)/8;
#endif

	int TEST_LENGTH = IMAGE_HEIGHT*IMAGE_PITCH;

	int PRINT_WIDTH = min( IMAGE_PITCH, MAX_PRINT_LENGTH );
	int PRINT_HEIGHT = min( IMAGE_HEIGHT, MAX_PRINT_LENGTH );
	int PRINT_RESULT_WIDTH = min( IMAGE_WIDTH-FILTER_WIDTH, MAX_PRINT_LENGTH );
	int PRINT_RESULT_HEIGHT = min( IMAGE_HEIGHT-FILTER_HEIGHT, MAX_PRINT_LENGTH );

	double scalar_time, vector_time;
	int errors=0;

	vbx_mxp_print_params();
	printf( "\nMatrix median test...\n" );

	vbx_mm_t *scalar_in   = malloc( TEST_LENGTH*sizeof(vbx_mm_t) );
	vbx_mm_t *scalar_out  = malloc( TEST_LENGTH*sizeof(vbx_mm_t) );

	vbx_mm_t *vector_in   = vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_mm_t) );
	vbx_mm_t *vector_out  = vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_mm_t) );

	VBX_T(test_zero_array)( scalar_out, TEST_LENGTH );
	VBX_T(test_zero_array)( vector_out, TEST_LENGTH );

	VBX_T(test_init_matrix)( scalar_in, IMAGE_HEIGHT, IMAGE_PITCH, 0x090909 );
	VBX_T(test_copy_array)( vector_in, scalar_in, TEST_LENGTH );
	VBX_T(test_print_hex_matrix)( scalar_in, PRINT_HEIGHT, PRINT_WIDTH, IMAGE_PITCH );

	scalar_time = test_scalar( scalar_in, FILTER_HEIGHT, FILTER_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH); 
	VBX_T(test_print_hex_matrix)(scalar_in, PRINT_RESULT_HEIGHT, PRINT_RESULT_WIDTH, IMAGE_PITCH);

	vector_time = test_vector( vector_in, FILTER_HEIGHT, FILTER_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH, scalar_time ); 
	VBX_T(test_print_hex_matrix)(vector_in, PRINT_RESULT_HEIGHT, PRINT_RESULT_WIDTH, IMAGE_PITCH);

	int i;
	for(i=0; i<IMAGE_HEIGHT-FILTER_HEIGHT; i++){
		errors += VBX_T(test_verify_array)( scalar_in+i*IMAGE_PITCH, vector_in+i*IMAGE_PITCH, IMAGE_WIDTH-FILTER_WIDTH);
	}

	VBX_TEST_END(errors);
	return 0;
}
