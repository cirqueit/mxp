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
VBXCOPYRIGHT( test_libfix_math )

#include <stdio.h>
#include <stdlib.h>
#include "vbx.h"
#include "vbx_test.h"
#include "fixmath.h"
#include "vbw_fix16.h"

#if !VBX_SIMULATOR
#define USE_HARDWARE 1
#else
#define USE_HARDWARE 0
#endif
#define RANGE_SQRT (65536/256)
#define RANGE_DIV 1

#define VBX_TEMPLATE_T   VBX_WORDSIZE_DEF
#include "vbw_template_t.h"


double test_vector_sqrt(vbx_word_t *v_out, vbx_word_t  *v_in, int TEST_SIZE, double scalar_time, int hardware, int hardware_offset)
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP libfixmath sqrt..." );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbx_set_vl(TEST_SIZE);
	if(hardware){
		vbw_fix16_sqrt_hw( v_out, v_in, TEST_SIZE, hardware_offset );
	}else{
		vbw_fix16_sqrt( v_out, v_in, TEST_SIZE );
	}
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}

double test_scalar_sqrt( int32_t  *scalar_out, int32_t  *scalar_in, int TEST_SIZE )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting scalar libfixmath sqrt...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	int i;
	for(i=0;i<TEST_SIZE;i++){
		scalar_out[i]  = fix16_sqrt(scalar_in[i]);
	}
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_scalar_time( time_start, time_stop );
}

double test_vector_div(vbx_word_t *v_out, vbx_word_t  *v_in1, vbx_word_t *v_in2, int TEST_SIZE, double scalar_time, int hardware, int hardware_offset)
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP libfixmath div..." );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbx_set_vl(TEST_SIZE);
	if(hardware){
		vbw_fix16_div_hw( v_out, v_in1, v_in2, TEST_SIZE, hardware_offset );
	}else{
		vbw_fix16_div( v_out, v_in1, v_in2, TEST_SIZE );
	}
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}

double test_scalar_div( int32_t  *scalar_out, int32_t *scalar_in1, int32_t *scalar_in2, int TEST_SIZE )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting scalar libfixmath div...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	int i;
	for(i=0;i<TEST_SIZE;i++){
		scalar_out[i]  = fix16_div( scalar_in1[i], scalar_in2[i] );
	}
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_scalar_time( time_start, time_stop );
}

int main(void)
{
	vbx_test_init();

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	int word_frac_bits = this_mxp->fxp_word_frac_bits;

#if __NIOS2__
	const int CUSTOM_DIVIDE_OFF = (32+1+word_frac_bits)*this_mxp->vcustom0_lanes;
	const int CUSTOM_SQRT_OFF = 16*this_mxp->vcustom1_lanes;
#else
	// Xilinx LogiCORE blocks have longer latency.
	const int CUSTOM_DIVIDE_OFF = (32+1+word_frac_bits+4)*this_mxp->vcustom0_lanes;
	const int CUSTOM_SQRT_OFF = (16+(word_frac_bits/2)+1)*this_mxp->vcustom1_lanes;
#endif

	int N = VBX_SCRATCHPAD_SIZE / sizeof(int32_t );
	N = 1000;

	int PRINT_LENGTH = min( N, MAX_PRINT_LENGTH );

	double scalar_time, vector_time;
	int errors = 0;
	int hardware = USE_HARDWARE;

	vbx_mxp_print_params();
	printf( "\nLibfixmath test...\n" );
	printf( "Vector length: %d\n", N );

	int32_t  *scalar_in1 = malloc( N*sizeof(int32_t ) );
	int32_t  *scalar_in2 = malloc( N*sizeof(int32_t ) );
	int32_t  *scalar_out = malloc( N*sizeof(int32_t ) );
	int32_t  *vector_in1 = vbx_shared_malloc( N*sizeof(int32_t ) );
	int32_t  *vector_in2 = vbx_shared_malloc( N*sizeof(int32_t ) );
	int32_t  *vector_out = vbx_shared_malloc( N*sizeof(int32_t ) );
	vbx_word_t  *v_in1 = vbx_sp_malloc( N*sizeof(vbx_word_t ) );
	vbx_word_t  *v_in2 = vbx_sp_malloc( N*sizeof(vbx_word_t ) );
	vbx_word_t  *v_out = vbx_sp_malloc( N*sizeof(vbx_word_t ) );

	VBX_T(test_zero_array)(scalar_out, N );
	VBX_T(test_zero_array)(vector_out, N );

	VBX_T(test_inc_array)( scalar_in1, N, fix16_from_int(-32), fix16_from_int(3));
	VBX_T(test_copy_array)( vector_in1, scalar_in1, N );
	VBX_T(test_inc_array)( scalar_in2, N, fix16_from_int(3200), fix16_from_int(11));
	VBX_T(test_copy_array)( vector_in2, scalar_in2, N );


	vbx_dma_to_vector(v_in1, vector_in1, N*sizeof(vbx_word_t));
	vbx_dma_to_vector(v_in2, vector_in2, N*sizeof(vbx_word_t));
	vbx_sync();

	printf( "\nLibfixmath sqrt test...\n" );
	//VBX_T(test_print_array)( scalar_in2, PRINT_LENGTH );
	scalar_time = test_scalar_sqrt( scalar_out, scalar_in2, N);
	//VBX_T(test_print_array)( scalar_out, PRINT_LENGTH );

	vector_time = test_vector_sqrt( v_out, v_in2, N, scalar_time, 0, CUSTOM_SQRT_OFF);
	vbx_dma_to_host(vector_out, v_out, N*sizeof(vbx_word_t));
	vbx_sync();
	//VBX_T(test_print_array)( vector_out, PRINT_LENGTH );
	errors += VBX_T(test_range_array)( scalar_out, vector_out, N, RANGE_SQRT );

	if(hardware){
		printf( "\nLibfixmath sqrt_hw test...\n" );
		vector_time = test_vector_sqrt( v_out, v_in2, N, scalar_time, 1, CUSTOM_SQRT_OFF);
		vbx_dma_to_host(vector_out, v_out, N*sizeof(vbx_word_t));
		vbx_sync();
		errors += VBX_T(test_range_array)( scalar_out, vector_out, N, RANGE_SQRT );
	}

	printf( "\nLibfixmath div test...\n" );
	//VBX_T(test_print_array)( scalar_in1, PRINT_LENGTH );
	//VBX_T(test_print_array)( scalar_in2, PRINT_LENGTH );
	scalar_time = test_scalar_div( scalar_out, scalar_in2, scalar_in1, N);
	//VBX_T(test_print_array)( scalar_out, PRINT_LENGTH );

	vector_time = test_vector_div( v_out, v_in2, v_in1, N, scalar_time, 0, CUSTOM_DIVIDE_OFF);
	vbx_dma_to_host(vector_out, v_out, N*sizeof(vbx_word_t));
	vbx_sync();
	//VBX_T(test_print_array)( vector_out, PRINT_LENGTH );
	errors += VBX_T(test_range_array)( scalar_out, vector_out, N, RANGE_DIV );

	if(hardware){
		printf( "\nLibfixmath div_hw test...\n" );
		vector_time = test_vector_div( v_out, v_in2, v_in1, N, scalar_time, 1, CUSTOM_DIVIDE_OFF);
		vbx_dma_to_host(vector_out, v_out, N*sizeof(vbx_word_t));
		vbx_sync();
		errors += VBX_T(test_range_array)( scalar_out, vector_out, N, RANGE_DIV );
	}

	VBX_TEST_END(errors);
	return 0;
}
