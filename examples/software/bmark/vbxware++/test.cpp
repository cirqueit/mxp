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
VBXCOPYRIGHT(test_rgb2luma)

// This test currently requires at least 32KB of scratchpad memory.

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "pixel.h"
#include "scalar_mtx_sobel.h"
#include "vbw_mtx_sobel.hpp"
#include "vbw_mtx_sobel.h"

#define MAX_PRINT_ERRORS  20

void init_matrix(pixel *input, const int image_width, const int image_height)
{
	int i    = image_width * image_height;
	int lfsr = -2;

	// Load data for each frame...
	while (i-- > 0) {
		input->r = lfsr & 0xFF; lfsr = lfsr_32(lfsr);
		input->g = lfsr & 0xFF; lfsr = lfsr_32(lfsr);
		input->b = lfsr & 0xFF; lfsr = lfsr_32(lfsr);
		input->a = lfsr & 0x00; lfsr = lfsr_32(lfsr);
		input++;
	}
}

int test_sobel_argb(){
	int IMAGE_WIDTH   = 19200;
	int IMAGE_HEIGHT  = 108;
	int IMAGE_PITCH   = IMAGE_WIDTH;
	int RENORM_AMOUNT = 2;

	pixel *input;
	pixel *scalar_input;

	unsigned short *scalar_luma;

	pixel *vbx_output;
	pixel *scalar_output;

	vbx_timestamp_t time_start, time_stop;
	double scalar_time;
	int x, y;
	int errors = 0;


	input         = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_input  = (pixel *)vbx_remap_cached(input, IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_luma   = (unsigned short *)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(unsigned short));
	vbx_output    = (pixel *)vbx_shared_malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));
	scalar_output = (pixel *)malloc(IMAGE_WIDTH*IMAGE_HEIGHT*sizeof(pixel));

	init_matrix(input, IMAGE_WIDTH, IMAGE_HEIGHT);

	printf("Starting Sobel 3x3 edge-detection test\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_rgb2luma(scalar_luma, scalar_input, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH);
	scalar_sobel_argb32_3x3(scalar_output, scalar_luma, IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH, RENORM_AMOUNT);
	time_stop = vbx_timestamp();
	scalar_time = vbx_print_scalar_time(time_start, time_stop);

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw::sobel_argb32_3x3((vbx_uword_t*)vbx_output, (vbx_uword_t *)input,
	                      IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH, RENORM_AMOUNT);
	time_stop = vbx_timestamp();
	printf("vbxware++ c++ algorithm\n");
	vbx_print_vector_time(time_start, time_stop, scalar_time);

	for (y = 0; y < IMAGE_HEIGHT; y++) {
		for (x = 0; x < IMAGE_WIDTH; x++) {
			if (scalar_output[y*IMAGE_WIDTH+x].r != vbx_output[y*IMAGE_WIDTH+x].r) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("R Error at %d, %d: Expected = %02X, got = %02X\n",
					       y, x, scalar_output[y*IMAGE_WIDTH+x].r, vbx_output[y*IMAGE_WIDTH+x].r);
				}
				errors++;
			}
			if (scalar_output[y*IMAGE_WIDTH+x].g != vbx_output[y*IMAGE_WIDTH+x].g) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("G Error at %d, %d: Expected = %02X, got = %02X\n",
					       y, x, scalar_output[y*IMAGE_WIDTH+x].g, vbx_output[y*IMAGE_WIDTH+x].g);
				}
				errors++;
			}
			if (scalar_output[y*IMAGE_WIDTH+x].b != vbx_output[y*IMAGE_WIDTH+x].b) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("B Error at %d, %d: Expected = %02X, got = %02X\n",
					       y, x, scalar_output[y*IMAGE_WIDTH+x].b, vbx_output[y*IMAGE_WIDTH+x].b);
				}
				errors++;
			}
		}
	}
	for(int i=0;i<IMAGE_WIDTH*IMAGE_HEIGHT;i++){
		((vbx_word_t*)vbx_output)[i]=0;
	}
	vbx_timestamp_start();
	time_start = vbx_timestamp();

	vbw_sobel_argb32_3x3((unsigned*)vbx_output, (unsigned *)input,
	                     IMAGE_WIDTH, IMAGE_HEIGHT, IMAGE_PITCH, RENORM_AMOUNT);

	vbx_sync();
	time_stop = vbx_timestamp();
	printf("vbxware c algorithm\n");
	vbx_print_vector_time(time_start, time_stop, scalar_time);

	for (y = 0; y < IMAGE_HEIGHT; y++) {
		for (x = 0; x < IMAGE_WIDTH; x++) {
			if (scalar_output[y*IMAGE_WIDTH+x].r != vbx_output[y*IMAGE_WIDTH+x].r) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("R Error at %d, %d: Expected = %02X, got = %02X\n",
					       y, x, scalar_output[y*IMAGE_WIDTH+x].r, vbx_output[y*IMAGE_WIDTH+x].r);
				}
				errors++;
			}
			if (scalar_output[y*IMAGE_WIDTH+x].g != vbx_output[y*IMAGE_WIDTH+x].g) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("G Error at %d, %d: Expected = %02X, got = %02X\n",
					       y, x, scalar_output[y*IMAGE_WIDTH+x].g, vbx_output[y*IMAGE_WIDTH+x].g);
				}
				errors++;
			}
			if (scalar_output[y*IMAGE_WIDTH+x].b != vbx_output[y*IMAGE_WIDTH+x].b) {
				if (errors < MAX_PRINT_ERRORS) {
					printf("B Error at %d, %d: Expected = %02X, got = %02X\n",
					       y, x, scalar_output[y*IMAGE_WIDTH+x].b, vbx_output[y*IMAGE_WIDTH+x].b);
				}
				errors++;
			}
		}
	}

	vbx_shared_free(input);
	free(scalar_luma);
	vbx_shared_free(vbx_output);
	free(scalar_output);
	return errors;


}


#include "scalar_vec_fir.h"
#include "vbw_vec_fir.h"
#include "vbw_vec_fir.hpp"
int test_vec_fir(){
	const int NTAPS=16;
	const int SAMP_SIZE=(64*1024);
	double scalar_time;
	vbx_timestamp_t time_start, time_stop;
	int errors=0;

	printf("\nVector FIR test...\n");

	vbx_word_t *scalar_sample = (vbx_word_t*)malloc( (SAMP_SIZE+NTAPS)*sizeof(vbx_word_t) );
	vbx_word_t *scalar_coeffs = (vbx_word_t*)malloc(             NTAPS*sizeof(vbx_word_t) );
	vbx_word_t *scalar_out    = (vbx_word_t*)malloc(         SAMP_SIZE*sizeof(vbx_word_t) );

	vbx_word_t *sample     = (vbx_word_t*)vbx_shared_malloc( (SAMP_SIZE+NTAPS)*sizeof(vbx_word_t) );
	vbx_word_t *coeffs     = (vbx_word_t*)vbx_shared_malloc(             NTAPS*sizeof(vbx_word_t) );
	vbx_word_t *vector_out = (vbx_word_t*)vbx_shared_malloc(         SAMP_SIZE*sizeof(vbx_word_t) );

	test_zero_array_word( scalar_out, SAMP_SIZE );
	test_zero_array_word( vector_out, SAMP_SIZE );

	test_init_array_word( scalar_sample, SAMP_SIZE, 0xff );
	test_copy_array_word( sample, scalar_sample, SAMP_SIZE );
	test_init_array_word( scalar_coeffs, NTAPS, 1 );
	test_copy_array_word( coeffs, scalar_coeffs, NTAPS );

	test_zero_array_word( scalar_sample+SAMP_SIZE, NTAPS );
	test_zero_array_word( sample+SAMP_SIZE, NTAPS );

	printf("\nExecuting scalar vector FIR...\n");
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_vec_fir_word( scalar_out, scalar_sample, scalar_coeffs, SAMP_SIZE, NTAPS );
	time_stop = vbx_timestamp();
	scalar_time = vbx_print_scalar_time( time_start, time_stop );


	printf("\nExecuting MXP vector FIR vbxware++....\n");
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw::vec_fir_ext( vector_out, sample, coeffs, SAMP_SIZE, NTAPS );
	time_stop = vbx_timestamp();
	vbx_print_vector_time( time_start, time_stop, scalar_time );
	errors += test_verify_array_word( scalar_out, vector_out, SAMP_SIZE-NTAPS );

	printf("\nExecuting MXP vector FIR vbxware....\n");
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw_vec_fir_ext_word( vector_out, sample, coeffs, SAMP_SIZE, NTAPS );
	time_stop = vbx_timestamp();
	vbx_print_vector_time( time_start, time_stop, scalar_time );
	errors += test_verify_array_word( scalar_out, vector_out, SAMP_SIZE-NTAPS );

	return errors;


}


#include "scalar_vec_power.h"
#include "vbw_vec_power.hpp"
#include "vbw_vec_power.h"

int test_vec_power(){

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	vbx_timestamp_t time_start, time_stop;

	int N = VBX_SCRATCHPAD_SIZE/sizeof(vbx_word_t)/12;
	N=1024;

	double scalar_time;
	int errors=0;

	printf("\nVector power test...\n");
	printf("Vector length: %d\n", N);

	vbx_word_t *scalar_in1 = (vbx_word_t*)malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *scalar_in2 = (vbx_word_t*)malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *scalar_out = (vbx_word_t*)malloc( N*sizeof(vbx_word_t) );

	vbx_word_t *vector_in1 = (vbx_word_t*)vbx_shared_malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *vector_in2 = (vbx_word_t*)vbx_shared_malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *vector_out = (vbx_word_t*)vbx_shared_malloc( N*sizeof(vbx_word_t) );

	if(vector_out==NULL){
		printf("malloc_failed\n");
		return 1;
	}

	test_zero_array_word( scalar_out, N );
	test_zero_array_word( vector_out, N );

	test_init_array_word( scalar_in1, N, 5 );
	test_copy_array_word( vector_in1, scalar_in1, N );
	test_init_array_word( scalar_in2, N, 112 );
	test_copy_array_word( vector_in2, scalar_in2, N );

	{
		printf("\nExecuting scalar power...");

		time_start = vbx_timestamp();
		scalar_vec_power_word( scalar_out, scalar_in1, scalar_in2, N);
		time_stop = vbx_timestamp();

		scalar_time = vbx_print_scalar_time(time_start, time_stop);
	}

	{
		printf("\nExecuting MXP vector software power vbxware++...");
		VBX::Vector<vbx_word_t> v_out(N);
		VBX::Vector<vbx_word_t> v_in1(N);
		VBX::Vector<vbx_word_t> v_in2(N);
		v_in1.dma_read(vector_in1);
		v_in2.dma_read(vector_in2);

		time_start = vbx_timestamp();
		vbw::vec_power( v_out, v_in1, v_in2);
		time_stop = vbx_timestamp();
		v_out.dma_write(vector_out);
		vbx_sync();

		vbx_print_vector_time(time_start, time_stop, scalar_time);
		errors += test_verify_array_word( scalar_out, vector_out, N );
	}

	{
		vbx_sp_push();
		printf("\nExecuting MXP vector software power vbxware...");
		vbx_word_t *v_out = (vbx_word_t*)vbx_sp_malloc( N*sizeof(vbx_word_t) );
		vbx_word_t *v_in1 = (vbx_word_t*)vbx_sp_malloc( N*sizeof(vbx_word_t) );
		vbx_word_t *v_in2 = (vbx_word_t*)vbx_sp_malloc( N*sizeof(vbx_word_t) );
		vbx_dma_to_vector( v_in1, vector_in1, N*sizeof(vbx_word_t) );
		vbx_dma_to_vector( v_in2, vector_in2, N*sizeof(vbx_word_t) );

		time_start = vbx_timestamp();
		vbw_vec_power_word( v_out, v_in1, v_in2, N );
		vbx_sync();
		time_stop = vbx_timestamp();
		vbx_dma_to_host( vector_out, v_out, N*sizeof(vbx_word_t) );
		vbx_sync();
		vbx_sp_pop();

		vbx_print_vector_time(time_start, time_stop, scalar_time);
		errors += test_verify_array_word( scalar_out, vector_out, N );
	}



	return errors;

}

#include "scalar_mtx_fir.h"
#include "vbw_mtx_fir.h"
#include "vbw_mtx_fir.hpp"
int test_mtx_fir(){
	const int TEST_ROWS = 256;
	const int TEST_COLS = 256;
	const int NTAP_ROWS = 3;
	const int NTAP_COLS = 3;

	const int TEST_LENGTH = TEST_ROWS*TEST_COLS;
	const int NTAP_LENGTH = NTAP_ROWS*NTAP_COLS;

	vbx_timestamp_t time_start, time_stop;
	double scalar_time;
	int errors=0;

	printf( "\nMatrix FIR test...\n" );

	vbx_half_t  *scalar_in   = (vbx_half_t*)malloc( TEST_LENGTH*sizeof(vbx_half_t) );
	vbx_half_t  *vector_in   = (vbx_half_t*)vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_half_t) );

	int32_t *scalar_filt = (int32_t*)malloc( NTAP_LENGTH*sizeof(int32_t) );
	int32_t *vector_filt = (int32_t*)vbx_shared_malloc( NTAP_LENGTH*sizeof(int32_t) );

	vbx_half_t  *scalar_out  = (vbx_half_t*)malloc( TEST_LENGTH*sizeof(vbx_half_t) );
	vbx_half_t  *vector_out  = (vbx_half_t*)vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_half_t) );

	test_zero_array_half( scalar_out, TEST_LENGTH );
	test_zero_array_half( vector_out, TEST_LENGTH );

	test_init_array_half( scalar_in, TEST_LENGTH, 1 );
	test_copy_array_half( vector_in, scalar_in, TEST_LENGTH );

	test_init_array_word( scalar_filt, NTAP_LENGTH, 1 );
	test_copy_array_word( vector_filt, scalar_filt, NTAP_LENGTH );
	// test_print_matrix_half(scalar_in,TEST_ROWS,TEST_COLS,TEST_COLS);
	// test_print_matrix_word(scalar_filt,NTAP_ROWS,NTAP_COLS,NTAP_COLS);
	printf("\nExecuting scalar matrix FIR...\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_mtx_2Dfir_half( scalar_out, scalar_in, scalar_filt, TEST_ROWS, TEST_COLS, NTAP_ROWS, NTAP_COLS );
	time_stop = vbx_timestamp();
	scalar_time = vbx_print_scalar_time( time_start, time_stop );
	printf( "\nExecuting MXP matrix FIR vbxware...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw_mtx_2Dfir_half( vector_out, vector_in, vector_filt, TEST_ROWS, TEST_COLS, NTAP_ROWS, NTAP_COLS );
	time_stop = vbx_timestamp();
	vbx_print_vector_time( time_start, time_stop, scalar_time );
	errors += test_verify_array_half( scalar_out, vector_out,TEST_COLS*TEST_ROWS);
	// test_print_matrix_half(vector_out,TEST_ROWS,TEST_COLS,TEST_COLS);

	test_zero_array_half( vector_out, TEST_LENGTH );
	printf( "\nExecuting MXP matrix FIR vbxware++...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw::mtx_2Dfir( vector_out, vector_in, vector_filt, TEST_ROWS, TEST_COLS, NTAP_ROWS, NTAP_COLS );
	time_stop = vbx_timestamp();
	// test_print_matrix_half(vector_out,TEST_ROWS,TEST_COLS,TEST_COLS);
	vbx_print_vector_time( time_start, time_stop, scalar_time );
	errors += test_verify_array_half( scalar_out, vector_out,TEST_COLS*TEST_ROWS);
	return errors;
}

#include "vbw_mtx_motest.h"
#include "scalar_mtx_motest.h"
#include "vbw_mtx_motest.hpp"
#define MOTEST_BLOCK_HEIGHT  16
#define MOTEST_BLOCK_WIDTH   16
#define MOTEST_IMAGE_WIDTH   256
#define MOTEST_IMAGE_HEIGHT  256
#define MOTEST_SEARCH_WIDTH  64
#define MOTEST_SEARCH_HEIGHT 64
#define MOTEST_RESULT_SIZE (MOTEST_SEARCH_WIDTH*MOTEST_SEARCH_HEIGHT*sizeof(output_type))
void init_motest(input_type *x_input, output_type *result)
{
	int i,j,temp;

	//Load data for each frame...
	for(j=0; j<MOTEST_BLOCK_HEIGHT+MOTEST_SEARCH_HEIGHT; j++){
		x_input[j*MOTEST_IMAGE_WIDTH] = j+1;
		for(i=1; i<MOTEST_BLOCK_WIDTH+MOTEST_SEARCH_WIDTH; i++){
			temp = x_input[j*MOTEST_IMAGE_WIDTH+i-1];
			x_input[j*MOTEST_IMAGE_WIDTH+i] = (((temp>>7)^(temp>>5)^(temp>>4)^(temp>>3))&0x1)|((temp<<1)&0x7E);
		}
	}

	for(j=0; j<MOTEST_SEARCH_HEIGHT; j++){
		for(i=0; i<MOTEST_SEARCH_WIDTH; i++){
			result[j*MOTEST_SEARCH_WIDTH+i] = 0;
		}
	}

}
int test_mtx_motest()
{
	input_type  *vector_x_input;
	input_type  *scalar_x_input;
	output_type *vector_result;
	output_type *scalar_result;

	vbw_motest_t m;

	m.image_width   = MOTEST_IMAGE_WIDTH;
	m.image_height  = MOTEST_IMAGE_HEIGHT;
	m.block_width   = MOTEST_BLOCK_WIDTH;
	m.block_height  = MOTEST_BLOCK_HEIGHT;
	m.search_width  = MOTEST_SEARCH_WIDTH;
	m.search_height = MOTEST_SEARCH_HEIGHT;

	int errors=0;
	int setup_rc;

	vbx_timestamp_t time_start, time_stop;
	double scalar_time;

	int total_errors = 0;

	printf("\nMotion estimation test...\n");

	// uncached versions
	vector_x_input = (input_type  *)vbx_shared_malloc( MOTEST_IMAGE_WIDTH*MOTEST_IMAGE_HEIGHT*sizeof(input_type) );
	vector_result  = (output_type *)vbx_shared_malloc( MOTEST_RESULT_SIZE );
	init_motest(  vector_x_input, vector_result );

	// cached versions
	scalar_x_input = (input_type  *)malloc( MOTEST_IMAGE_WIDTH* MOTEST_IMAGE_HEIGHT*sizeof(input_type)  );
	scalar_result  = (output_type *)malloc( MOTEST_SEARCH_WIDTH*MOTEST_SEARCH_HEIGHT*sizeof(output_type) );


	init_motest( scalar_x_input, scalar_result );
	printf( "Finished loading input data.\n" );

	printf( "\nExecuting Scalar Motion Estimation Test...\n" );
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	test_zero_array_uword((vbx_uword_t*)scalar_result,MOTEST_SEARCH_HEIGHT* MOTEST_SEARCH_WIDTH);
	vbw_mtx_motest_scalar_byte(scalar_result, scalar_x_input, scalar_x_input, &m);

	time_stop = vbx_timestamp();
	//test_print_matrix_uword( scalar_result,min(10,MOTEST_SEARCH_WIDTH),min(10,MOTEST_SEARCH_HEIGHT),MOTEST_SEARCH_WIDTH);

	scalar_time = vbx_print_scalar_time(time_start, time_stop);

	printf( "\nExecuting Vector Motion Estimation Test (2D) vbxware...\n" );

	vbx_sp_push();
	setup_rc = vbw_mtx_motest_byte_setup( &m );

	if(setup_rc == VBW_SUCCESS){
		test_zero_array_uword((vbx_uword_t*)vector_result,MOTEST_SEARCH_HEIGHT* MOTEST_SEARCH_WIDTH);
		vbx_timestamp_start();
		time_start = vbx_timestamp();
		vbw_mtx_motest_byte( vector_result, vector_x_input, vector_x_input, &m );
		vbx_sync();
		time_stop = vbx_timestamp();
		//	test_print_matrix_uword( vector_result,min(10,MOTEST_SEARCH_WIDTH),min(10,MOTEST_SEARCH_HEIGHT),MOTEST_SEARCH_WIDTH);

		vbx_print_vector_time(time_start, time_stop, scalar_time);

		vbx_sync();

		errors = test_verify_array_uword( (vbx_uword_t*)scalar_result, (vbx_uword_t*)vector_result,
		                                  MOTEST_SEARCH_HEIGHT* MOTEST_SEARCH_WIDTH );

		total_errors += errors;

	} else {
		printf( "\nSetup failed with retval %08X, skipping test.\n", setup_rc );
		total_errors++;
	}

	vbx_sp_pop();

	printf( "\nExecuting Vector Motion Estimation Test (2D) vbxware++...\n" );
	//surround with push and pop because we don't actually use the allocated sp space
	vbx_sp_push();
	setup_rc = vbw_mtx_motest_byte_setup( &m );
	vbx_sp_pop();

	if(setup_rc == VBW_SUCCESS){
		test_zero_array_uword((vbx_uword_t*)vector_result,MOTEST_SEARCH_HEIGHT* MOTEST_SEARCH_WIDTH);
		vbx_timestamp_start();
		time_start = vbx_timestamp();
		vbw::mtx_motest_byte( vector_result, vector_x_input, vector_x_input, &m );
		vbx_sync();
		time_stop = vbx_timestamp();

		vbx_print_vector_time(time_start, time_stop, scalar_time);
		//test_print_matrix_uword( vector_result,min(10,MOTEST_SEARCH_WIDTH),min(10,MOTEST_SEARCH_HEIGHT),MOTEST_SEARCH_WIDTH);

		errors = test_verify_array_uword( (vbx_uword_t*)scalar_result, (vbx_uword_t*)vector_result,
		                                  MOTEST_SEARCH_HEIGHT* MOTEST_SEARCH_WIDTH );

		total_errors += errors;

	} else {
		printf( "\nSetup failed with retval %08X, skipping test.\n", setup_rc );
		total_errors++;
	}

	return total_errors;
}

#include "scalar_mtx_median.h"
#include "vbw_mtx_median.h"
#include "vbw_mtx_median.hpp"
int test_mtx_median(){
	int FILTER_HEIGHT = 3;
	int FILTER_WIDTH = 3;
	int IMAGE_HEIGHT = 480 ;
	int IMAGE_WIDTH = 640 ;
	int IMAGE_PITCH = (IMAGE_WIDTH);

	int TEST_LENGTH = IMAGE_HEIGHT*IMAGE_PITCH;

	//int RESULT_WIDTH =  IMAGE_WIDTH -FILTER_WIDTH;
	//int RESULT_HEIGHT = IMAGE_HEIGHT-FILTER_HEIGHT;

	vbx_timestamp_t time_start, time_stop;
	double scalar_time;
	int errors=0;

	printf( "\nMatrix median test...\n" );

	vbx_word_t *scalar_in   = (vbx_word_t*)malloc( TEST_LENGTH*sizeof(vbx_word_t) );
	vbx_word_t *scalar_out  = (vbx_word_t*)malloc( TEST_LENGTH*sizeof(vbx_word_t) );

	vbx_word_t *vector_in   = (vbx_word_t*)vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_word_t) );
	vbx_word_t *vector_out  = (vbx_word_t*)vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_word_t) );
	test_zero_array_word( scalar_out, TEST_LENGTH );
	test_zero_array_word( vector_out, TEST_LENGTH );

	test_init_matrix_word( scalar_in, IMAGE_HEIGHT, IMAGE_PITCH, -2 );
	for(int i=0;i<TEST_LENGTH;i++){
		scalar_in[i]=i;
	}
	test_copy_array_word( vector_in, scalar_in, TEST_LENGTH );

	// printf("input mat:\n");test_print_matrix_word( scalar_in, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH );


	printf( "\nExecuting scalar matrix median...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_mtx_median_word( scalar_out, scalar_in, FILTER_HEIGHT, FILTER_WIDTH,
	                        IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH );
	time_stop = vbx_timestamp();
	scalar_time= vbx_print_scalar_time(time_start, time_stop);
	// printf("scalar:\n");test_print_matrix_word(scalar_out, RESULT_HEIGHT, RESULT_WIDTH, RESULT_WIDTH);

	printf( "\nExecuting MXP matrix median (vbxware)...\n" );
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw_mtx_median_ext_word( vector_out, vector_in, FILTER_HEIGHT,
	                         FILTER_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH );
	time_stop = vbx_timestamp();
	vbx_print_vector_time(time_start, time_stop, scalar_time);
	// printf("vbxware:\n");test_print_matrix_word(vector_out, RESULT_HEIGHT, RESULT_WIDTH, RESULT_WIDTH);
	errors += test_verify_array_word( scalar_out, vector_out, TEST_LENGTH);

	printf( "\nExecuting MXP matrix median (vbxware++)...\n" );
	test_zero_array_word( vector_out, TEST_LENGTH );
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw::mtx_median_ext( vector_out, vector_in, FILTER_HEIGHT,
	                     FILTER_WIDTH, IMAGE_HEIGHT, IMAGE_WIDTH, IMAGE_PITCH );
	time_stop = vbx_timestamp();
	vbx_print_vector_time(time_start, time_stop, scalar_time);
	// printf("vbxware++\n");test_print_matrix_word(vector_out, RESULT_HEIGHT, RESULT_WIDTH, RESULT_WIDTH);

	errors += test_verify_array_word( scalar_out, vector_out, TEST_LENGTH);

	return errors;
}

#include "scalar_mtx_xp.h"
#include "vbw_mtx_xp.hpp"
#include "vbw_mtx_xp.h"
int test_mtx_xp()
{
	int MTX_HEIGHT = 512;
	int MTX_WIDTH = 512;

	int TEST_LENGTH = MTX_HEIGHT*MTX_WIDTH;

	// int PRINT_WIDTH = min( IMAGE_PITCH, MAX_PRINT_LENGTH );
	// int PRINT_HEIGHT = min( IMAGE_HEIGHT, MAX_PRINT_LENGTH );
	// int PRINT_RESULT_WIDTH = min( IMAGE_WIDTH-FILTER_WIDTH, MAX_PRINT_LENGTH );
	// int PRINT_RESULT_HEIGHT = min( IMAGE_HEIGHT-FILTER_HEIGHT, MAX_PRINT_LENGTH );

	vbx_timestamp_t time_start, time_stop;
	double scalar_time;
	int errors=0;

	printf( "\nMatrix transpose test...\n" );

	vbx_word_t *scalar_in   = (vbx_word_t*)malloc( TEST_LENGTH*sizeof(vbx_word_t) );
	vbx_word_t *scalar_out  = (vbx_word_t*)malloc( TEST_LENGTH*sizeof(vbx_word_t) );

	vbx_word_t *vector_in   = (vbx_word_t*)vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_word_t) );
	vbx_word_t *vector_out  = (vbx_word_t*)vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_word_t) );
	test_zero_array_word( scalar_out, TEST_LENGTH );
	test_zero_array_word( vector_out, TEST_LENGTH );

	test_init_matrix_word( scalar_in, MTX_HEIGHT, MTX_WIDTH, -1 );
	for(int i=0;i<TEST_LENGTH;i++){
		scalar_in[i]=i;
	}
	test_copy_array_word( vector_in, scalar_in, TEST_LENGTH );

	printf( "\nExecuting scalar matrix transpose...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_mtx_xp_word( scalar_out, scalar_in,MTX_HEIGHT,MTX_WIDTH);
	time_stop = vbx_timestamp();
	scalar_time= vbx_print_scalar_time(time_start, time_stop);

	printf( "\nExecuting MXP matrix transpose (vbxware)...\n" );
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw_mtx_xp_ext_word( vector_out, vector_in,MTX_HEIGHT,MTX_WIDTH);
	time_stop = vbx_timestamp();
	vbx_print_vector_time(time_start, time_stop, scalar_time);
	errors += test_verify_array_word( scalar_out, vector_out, TEST_LENGTH);

	printf( "\nExecuting MXP matrix transpose (vbxware++)...\n" );
	test_zero_array_word( vector_out, TEST_LENGTH );
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw::mtx_xp_ext( vector_out, vector_in,MTX_WIDTH,MTX_HEIGHT);
	time_stop = vbx_timestamp();

	vbx_print_vector_time(time_start, time_stop, scalar_time);
	// printf("mtx in\n");
	// test_print_matrix_word(scalar_in,MTX_HEIGHT,MTX_WIDTH,MTX_WIDTH);
	// printf("scalar out\n");
	// test_print_matrix_word(scalar_out,MTX_WIDTH,MTX_HEIGHT,MTX_HEIGHT);
	// printf("vector out\n");
	// test_print_matrix_word(vector_out,MTX_WIDTH,MTX_HEIGHT,MTX_HEIGHT);

	errors += test_verify_array_word( scalar_out, vector_out, TEST_LENGTH);

	return errors;


}
int main(void)
{
	int errors=0;
	vbx_test_init();
	vbx_mxp_print_params();

	vbxsim_set_dma_type(IMMEDIATE);

	errors+=test_sobel_argb();
	errors+=test_vec_fir();
	errors+=test_vec_power();
	errors+=test_mtx_fir();
	errors+=test_mtx_motest();
	errors+=test_mtx_median();
	errors+=test_mtx_xp();
	VBX_TEST_END(errors);
}
