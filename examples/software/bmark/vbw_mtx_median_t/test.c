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
VBXCOPYRIGHT( test_mtx_median )

/*
 * Matrix Median - Scalar version and vector version
 */

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "scalar_mtx_median.h"
#include "vbw_mtx_median.h"

#define test_type byte
#define vbx_mm_t vbx_byte_t
#define _wrap_func(name,type) name##_##type
#define wrap_func(name,type) _wrap_func(name,type)
#define FILTER_HEIGHT 5
#define FILTER_WIDTH 5
#define IMAGE_HEIGHT 128
#define IMAGE_WIDTH 256
#define IMAGE_PITCH (IMAGE_WIDTH*2)

double test_vector( vbx_mm_t *vector_out, vbx_mm_t *vector_in, int filter_height,
		int filter_width, int image_height, int image_width, int image_pitch, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP matrix median...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval =  wrap_func(vbw_mtx_median_ext,test_type )( vector_out, vector_in, filter_height,
	                filter_width, image_height, image_width, image_pitch );
	time_stop = vbx_timestamp();

	printf( "...done. retval = %08X \n", retval );
	return vbx_print_vector_time(time_start, time_stop, scalar_time);
}

double test_scalar( vbx_mm_t *scalar_out, vbx_mm_t *scalar_in, int filter_height,
                    int filter_width, int image_height, int image_width, int image_pitch )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting scalar matrix median...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	wrap_func( scalar_mtx_median,test_type) ( scalar_out, scalar_in, filter_height, filter_width,
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
	wrap_func(test_zero_array,test_type)( scalar_out, TEST_LENGTH );
	wrap_func(test_zero_array,test_type)( vector_out, TEST_LENGTH );

	wrap_func(test_init_matrix,test_type)( scalar_in, IMAGE_HEIGHT, IMAGE_PITCH, -2 );
	wrap_func(test_copy_array,test_type)( vector_in, scalar_in, TEST_LENGTH );
	wrap_func(test_print_matrix,test_type)( scalar_in+110*IMAGE_PITCH, PRINT_HEIGHT, PRINT_WIDTH, IMAGE_PITCH );

	scalar_time = test_scalar( scalar_out, scalar_in, FILTER_HEIGHT, FILTER_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH);
	wrap_func(test_print_matrix,test_type)(scalar_out+110*IMAGE_PITCH, PRINT_RESULT_HEIGHT, PRINT_RESULT_WIDTH, IMAGE_PITCH);

	vector_time = test_vector( vector_out, vector_in, FILTER_HEIGHT, FILTER_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH, scalar_time );
	wrap_func(test_print_matrix,test_type)(vector_out+110*IMAGE_PITCH, PRINT_RESULT_HEIGHT, PRINT_RESULT_WIDTH, IMAGE_PITCH);

	int i;
	for(i=0; i<IMAGE_HEIGHT-FILTER_HEIGHT; i++){
		errors += wrap_func(test_verify_array,test_type)( scalar_out+i*IMAGE_PITCH, vector_out+i*IMAGE_PITCH, IMAGE_WIDTH-FILTER_WIDTH);
	}

	VBX_TEST_END(errors);
	return 0;
}
