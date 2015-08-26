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
VBXCOPYRIGHT( test_motest )


//
// Motion Estimation
//
// This test requires at least 32KB of scratchpad memory
// (using a 16x16 search window size).


#if 0 // BENCHMARK SETTINGS

#define BLOCK_HEIGHT  16
#define BLOCK_WIDTH   16
#define IMAGE_WIDTH   96
#define IMAGE_HEIGHT  96
#define SEARCH_WIDTH  16
#define SEARCH_HEIGHT 16

#else // TESTING SETTINGS

#define BLOCK_HEIGHT  16
#define BLOCK_WIDTH   16
#define IMAGE_WIDTH   256
#define IMAGE_HEIGHT  256
#define SEARCH_WIDTH  64
#define SEARCH_HEIGHT 64

#endif
#define RESULT_SIZE (SEARCH_WIDTH*SEARCH_HEIGHT*sizeof(output_type))

#define USE_2D
//#define USE_3D

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbx_port.h"
#include "vbx_test.h"
#include "vbw_mtx_motest.h"
#include "scalar_mtx_motest.h"

#include "vbx_common.h"
#include "vbw_exit_codes.h"


void init_motest(input_type *x_input, output_type *result)
{
	int i,j,temp;

	//Load data for each frame...
	for(j=0; j<BLOCK_HEIGHT+SEARCH_HEIGHT; j++){
		x_input[j*IMAGE_WIDTH] = j+1;
		for(i=1; i<BLOCK_WIDTH+SEARCH_WIDTH; i++){
			temp = x_input[j*IMAGE_WIDTH+i-1];
			x_input[j*IMAGE_WIDTH+i] = (((temp>>7)^(temp>>5)^(temp>>4)^(temp>>3))&0x1)|((temp<<1)&0x7E);
		}
	}

	for(j=0; j<SEARCH_HEIGHT; j++){
		for(i=0; i<SEARCH_WIDTH; i++){
			result[j*SEARCH_WIDTH+i] = 0;
		}
	}

}



void print_matrix_input( input_type *image, int height, int width )
{
	int i,j;

	const int MAX_I = min( 8, width  );
	const int MAX_J = min( 8, height );

	for( j=0; j<MAX_J; j++ ) {
		for( i=0; i<MAX_I; i++ ) {
			printf( "%8X ", image[ j*width + i ] );
		}
		printf( "\n" );
	}
}



void print_matrix_output( output_type *image, int height, int width )
{
	int i,j;

	const int MAX_I = min( 8, width  );
	const int MAX_J = min( 8, height );

	for( j=0; j<MAX_J; j++ ) {
		for( i=0; i<MAX_I; i++ ) {
			printf( "%8X ", image[ j*width + i ] );
		}
		printf( "\n" );
	}
}




int compare_matrix( output_type *vector_image, output_type *scalar_image, int height, int width )
{
	int i,j;
	int errors = 0;
	for( j=0; j<height; j++ ) {
		for( i=0; i<width; i++ ) {
			output_type vpixel = vector_image[ j*width + i ];
			output_type spixel = scalar_image[ j*width + i ];
			if( vpixel != spixel ) {
				if( !errors ) {
					printf( "Mismatch at y=%d x=%d!\nScalar: %08X\nVector: %08X\n", j, i, spixel, vpixel );
				}
				errors++;
			}
		}
	}
	return errors;
}



int main(void)
{
	input_type  *vector_x_input;
	input_type  *scalar_x_input;
	output_type *vector_result;
	output_type *scalar_result;

	vbw_motest_t m;

	m.image_width   = IMAGE_WIDTH;
	m.image_height  = IMAGE_HEIGHT;
	m.block_width   = BLOCK_WIDTH;
	m.block_height  = BLOCK_HEIGHT;
	m.search_width  = SEARCH_WIDTH;
	m.search_height = SEARCH_HEIGHT;

	int errors=0;
	int error_rc;

	vbx_timestamp_t time_start, time_stop;
	double scalar_time, vbx_time;

	int total_errors = 0;

	vbx_test_init();

	vbx_mxp_print_params();

	printf("\nMotion estimation test...\n");

	// uncached versions
	vector_x_input = (input_type  *)vbx_shared_malloc( IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(input_type) );
	vector_result  = (output_type *)vbx_shared_malloc( RESULT_SIZE );
	init_motest(  vector_x_input, vector_result );
	print_matrix_input( vector_x_input, IMAGE_HEIGHT, IMAGE_WIDTH );

	// cached versions
	scalar_x_input = (input_type  *)malloc(  IMAGE_WIDTH* IMAGE_HEIGHT*sizeof(input_type)  );
	scalar_result  = (output_type *)malloc( SEARCH_WIDTH*SEARCH_HEIGHT*sizeof(output_type) );
	init_motest( scalar_x_input, scalar_result );
	printf( "Finished loading input data.\n" );

	printf( "\nExecuting Scalar Motion Estimation Test...\n" );
	vbx_timestamp_start();
	time_start = vbx_timestamp();

	// These scalar calls mean the same thing.
#if 0
	scalar_mtx_motest_byte( (uint32_t *)scalar_result, (uint8_t *)scalar_x_input, (uint8_t *)scalar_x_input,
	                         SEARCH_HEIGHT, SEARCH_WIDTH, BLOCK_HEIGHT, BLOCK_WIDTH, IMAGE_WIDTH );
#else
	vbw_mtx_motest_scalar_byte(scalar_result, scalar_x_input, scalar_x_input, &m);
#endif

	time_stop = vbx_timestamp();

	print_matrix_output( scalar_result, SEARCH_HEIGHT, SEARCH_WIDTH );

	scalar_time = vbx_print_scalar_time(time_start, time_stop);

#ifdef USE_2D
	printf( "\nExecuting Vector Motion Estimation Test (2D)...\n" );

	vbx_sp_push();
	error_rc = vbw_mtx_motest_byte_setup( &m );

	if(error_rc == VBW_SUCCESS){
		vbx_timestamp_start();
		time_start = vbx_timestamp();
		error_rc = vbw_mtx_motest_byte( vector_result, vector_x_input, vector_x_input, &m );
		vbx_sync();
		time_stop = vbx_timestamp();

		if( error_rc >= 0 ) {

			print_matrix_output( vector_result, SEARCH_HEIGHT, SEARCH_WIDTH );

			vbx_time = vbx_print_vector_time(time_start, time_stop, scalar_time);

			vbx_sync();

			printf( "\nChecking results...\n" );
			errors = compare_matrix( vector_result, scalar_result, SEARCH_HEIGHT, SEARCH_WIDTH );

			printf( "%d errors\n", errors );
			total_errors += errors;

		}
	} else {
		printf( "\nSetup failed with retval %08X, skipping test.\n", error_rc );
		total_errors++;
	}

	vbx_sp_pop();

#endif //USE_2D

#ifdef USE_3D
	printf( "\nExecuting Vector Motion Estimation Test (3D)...\n" );

	vbx_sp_push();
	error_rc = vbw_mtx_motest_3d_byte_setup( &m );

	if(error_rc == VBW_SUCCESS){
		vbx_timestamp_start();
		time_start = vbx_timestamp();
		error_rc = vbw_mtx_motest_3d_byte(vector_result, vector_x_input, vector_x_input, &m );
		vbx_sync();
		time_stop = vbx_timestamp();

		if( error_rc >= 0 ) {

			print_matrix_output( vector_result, SEARCH_HEIGHT, SEARCH_WIDTH );

			vbx_time = vbx_print_vector_time(time_start, time_stop, scalar_time);

			vbx_sync();

			printf( "\nChecking results...\n" );
			errors = compare_matrix( vector_result, scalar_result,
															 SEARCH_HEIGHT, SEARCH_WIDTH );
			printf( "%d errors\n", errors );
			total_errors += errors;
		}
	} else {
		printf( "\nSetup failed with retval %08X, skipping test.\n", error_rc );
		total_errors++;
	}

	vbx_sp_pop();

#endif //USE_3D

	printf( "\nMotest finished\n" );

	VBX_TEST_END( total_errors );

	return 0;
}
