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
VBXCOPYRIGHT( test_mtx_mm )

/*
  Matrix Multiply
  Scalar version and VECTOR version
*/

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "scalar_mtx_mm.h"
#include "scalar_mtx_xp.h"
#include "vbw_mtx_xp.h"
#include "vbw_mtx_mm.h"

template<typename vbx_mm_t>
double test_vector(vbx_mm_t *vector_out, vbx_mm_t  *vector_in1, int IN1ROWS, int IN1COLS, vbx_mm_t  *vector_in2, int IN2ROWS, int IN2COLS, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP matrix multiply... src1[%dx%d] src2[%dx%d]\n",IN1ROWS, IN1COLS,IN2ROWS, IN2COLS );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = vbw_mtx_mm_ext( vector_out, vector_in1, IN1ROWS, IN1COLS, vector_in2, IN2ROWS, IN2COLS );
	time_stop = vbx_timestamp();

	printf( "...done. retval:0x%08X\n", retval );
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}

template<typename vbx_mm_t>
double test_vector_trans(vbx_mm_t *vector_out, vbx_mm_t  *vector_in1, int IN1ROWS, int IN1COLS, vbx_mm_t  *vector_in2, int IN2ROWS, int IN2COLS, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP matrix multiply... src1[%dx%d] src2[%dx%d]\n",IN1ROWS, IN1COLS,IN2ROWS, IN2COLS );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = vbw_mtx_mm_trans_ext( vector_out, vector_in1, IN1ROWS, IN1COLS, vector_in2, IN2ROWS, IN2COLS );
	time_stop = vbx_timestamp();

	printf( "...done. retval:0x%08X\n", retval );
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}

template<typename vbx_mm_t>
double test_vector_sp(vbx_mm_t *vector_out, vbx_mm_t  *vector_in1, int IN1ROWS, int IN1COLS, vbx_mm_t  *vector_in2, int IN2ROWS, int IN2COLS, double scalar_time )
{
	typedef vbx_mm_t vbx_sp_t;
	int retval=-1;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP matrix multiply... src1[%dx%d] src2[%dx%d]\n",IN1ROWS, IN1COLS,IN2ROWS, IN2COLS );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbx_sp_push();
	vbx_sp_t* v_in1=(vbx_sp_t*)vbx_sp_malloc(sizeof(vbx_sp_t)*IN1ROWS*IN1COLS);
	vbx_sp_t* v_in2=(vbx_sp_t*)vbx_sp_malloc(sizeof(vbx_sp_t)*IN2ROWS*IN2COLS);
	vbx_sp_t* v_out=(vbx_sp_t*)vbx_sp_malloc(sizeof(vbx_sp_t)*IN1ROWS*IN2COLS);
	if(v_out!=NULL){
		vbx_dma_to_vector(v_in1,vector_in1,sizeof(vbx_sp_t)*IN1ROWS*IN1COLS);
		vbx_dma_to_vector(v_in2,vector_in2,sizeof(vbx_sp_t)*IN2ROWS*IN2COLS);
		retval = vbw_mtx_mul( v_out, v_in1, IN1ROWS, IN1COLS, v_in2, IN2ROWS, IN2COLS );
		vbx_dma_to_host(vector_out,v_out,sizeof(vbx_sp_t)*IN1ROWS*IN2COLS);
		vbx_sync();
	}else{
		printf("not enough sp space for sp test");
	}
	time_stop = vbx_timestamp();
	printf( "...done. retval:0x%08X\n", retval );
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}

template<typename vbx_mm_t>
double test_scalar( vbx_mm_t  *scalar_out, vbx_mm_t *scalar_in1, int IN1ROWS, int IN1COLS, vbx_mm_t *scalar_in2, int IN2ROWS, int IN2COLS )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting scalar matrix multiply...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vbw_mtx_mul_scalar_ext_word( scalar_out, scalar_in1,  IN1ROWS, IN1COLS, scalar_in2, IN2ROWS, IN2COLS );
	time_stop = vbx_timestamp();

	printf( "...done.\n" );
	return vbx_print_scalar_time( time_start, time_stop );
}

int main(void)
{
	vbx_test_init();
	typedef vbx_word_t vbx_mm_t;
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	int N = VBX_SCRATCHPAD_SIZE / sizeof(vbx_mm_t );
	N = 20;
	int M = 20;

	int PRINT_LENGTH =  N<MAX_PRINT_LENGTH ? N : MAX_PRINT_LENGTH ;
	//	int PRINT_ROWS = PRINT_LENGTH;
	int PRINT_ROWS = M<MAX_PRINT_LENGTH ? N : MAX_PRINT_LENGTH;
	int PRINT_COLS = PRINT_LENGTH;

	double scalar_time, vector_time,vector2_time;
	int errors=0;

	vbx_mxp_print_params();
	printf( "\nMatrix multiply test...\n" );
	printf( "Matrix dimensions: %d,%d\n", N, M );


	vbx_mm_t  *scalar_in1 = (vbx_mm_t*)malloc( M*N*sizeof(vbx_mm_t ) );
	vbx_mm_t  *scalar_in2 = (vbx_mm_t*)malloc( M*N*sizeof(vbx_mm_t ) );
	vbx_mm_t  *scalar_out = (vbx_mm_t*)malloc( N*N*sizeof(vbx_mm_t ) );
	vbx_mm_t  *vector_in1 = (vbx_mm_t*)vbx_shared_malloc( M*N*sizeof(vbx_mm_t ) );
	vbx_mm_t  *vector_in2 = (vbx_mm_t*)vbx_shared_malloc( M*N*sizeof(vbx_mm_t ) );
	vbx_mm_t  *vector_out = (vbx_mm_t*)vbx_shared_malloc( N*N*sizeof(vbx_mm_t ) );
	if ( scalar_in1 == NULL ||
	     scalar_in2 == NULL ||
	     scalar_out == NULL ||
	     vector_in1 == NULL ||
	     vector_in2 == NULL ||
	     vector_out == NULL ){
		printf("Malloc failed\n");
		VBX_TEST_END(1);
		return 0;
	}



	test_zero_array_word(scalar_out, N*N );
	test_zero_array_word(vector_out, N*N );

	test_init_array_word( scalar_in1, M*N, 1 );
	test_copy_array_word( vector_in1, scalar_in1, M*N );
	test_init_array_word( scalar_in2, M*N, 999 );
	//scalar_mtx_xp_MN_word( vector_in2, scalar_in2, N, N );
	test_copy_array_word( vector_in2, scalar_in2, M*N );

	test_print_matrix_word( scalar_in1, PRINT_COLS, PRINT_ROWS, M );
	test_print_matrix_word( scalar_in2, PRINT_ROWS, PRINT_COLS, N );

	//change print sizes for outputs
	PRINT_ROWS=PRINT_COLS=N<PRINT_LENGTH?N:PRINT_LENGTH;

	scalar_time = test_scalar( scalar_out, scalar_in1, N, M, scalar_in2, M, N);
	test_print_matrix_word( scalar_out, PRINT_COLS, PRINT_ROWS, N );


	vector_time = test_vector( vector_out, vector_in1, N, M, vector_in2, M, N, scalar_time );
	test_print_matrix_word( vector_out, PRINT_COLS, PRINT_ROWS, N );
	errors += test_verify_array_word( scalar_out, vector_out, N*N);

	vector2_time = test_vector_trans( vector_out, vector_in1, N, M, vector_in2, M, N, scalar_time );
	test_print_matrix_word( vector_out, PRINT_COLS, PRINT_ROWS, N );
	errors += test_verify_array_word( scalar_out, vector_out, N*N);

	vector2_time = test_vector_sp( vector_out, vector_in1, N, M, vector_in2, M, N, scalar_time );
	test_print_matrix_word( vector_out, PRINT_COLS, PRINT_ROWS, N );
	errors += test_verify_array_word( scalar_out, vector_out, N*N);

	vbx_shared_free(vector_out);
	vbx_shared_free(vector_in2);
	vbx_shared_free(vector_in1);
	free(scalar_out);
	free(scalar_in2);
	free(scalar_in1);

	//errors += orig_test();

	VBX_TEST_END(errors);
	return 0;
}
