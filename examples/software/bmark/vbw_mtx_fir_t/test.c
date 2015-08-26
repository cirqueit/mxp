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
VBXCOPYRIGHT( test_mtx_fir )

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "scalar_mtx_fir.h"
#include "scalar_mtx_xp.h"
#include "vbw_mtx_fir.h"

#define VBX_TEMPLATE_T   VBX_BYTESIZE_DEF
// signed   VBX_BYTESIZE_DEF    VBX_HALFSIZE_DEF    VBX_WORDSIZE_DEF
// unsigned VBX_UBYTESIZE_DEF   VBX_UHALFSIZE_DEF   VBX_UWORDSIZE_DEF
#include "vbw_template_t.h"

#define TEST_ROWS 256
#define TEST_COLS 256
#define NTAP_ROWS 3
#define NTAP_COLS 3

double test_vector( vbx_mm_t *out, vbx_mm_t *in, int32_t *coeffs, int test_row, int test_col, int ntaps_row, int ntaps_col, double scalar_time )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting MXP matrix FIR...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	VBX_T(vbw_mtx_2Dfir)( out, in, coeffs, test_row, test_col, ntaps_row, ntaps_col );
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}

double test_scalar( vbx_mm_t *scalar_out, vbx_mm_t *scalar_in, int32_t *coeffs, int test_row, int test_col, int ntaps_row, int ntaps_col)
{
	vbx_timestamp_t time_start, time_stop;
	printf("\nExecuting scalar matrix FIR...\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	VBX_T(scalar_mtx_2Dfir)( scalar_out, scalar_in, coeffs, test_row, test_col, ntaps_row, ntaps_col );
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_scalar_time( time_start, time_stop );
}

int main(void)
{

	vbx_test_init();

#if 0
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	int N = VBX_SCRATCHPAD_SIZE/sizeof(vbx_mm_t)/8;
#endif

	int TEST_LENGTH = TEST_ROWS*TEST_COLS;
	int NTAP_LENGTH = NTAP_ROWS*NTAP_COLS;

	int PRINT_COLS = min( TEST_COLS, MAX_PRINT_LENGTH );
	int PRINT_ROWS = min( TEST_ROWS, MAX_PRINT_LENGTH );

	double scalar_time, vector_time;
	int errors=0;

	vbx_mxp_print_params();
	printf( "\nMatrix FIR test...\n" );
	printf( "Matrix dimensions: %d,%d\n", TEST_ROWS, TEST_COLS );

	vbx_mm_t  *scalar_in   = malloc( TEST_LENGTH*sizeof(vbx_mm_t) );
	vbx_mm_t  *vector_in   = vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_mm_t) );

	int32_t *scalar_filt = malloc( NTAP_LENGTH*sizeof(int32_t) );
	int32_t *vector_filt = vbx_shared_malloc( NTAP_LENGTH*sizeof(int32_t) );

	vbx_mm_t  *scalar_out  = malloc( TEST_LENGTH*sizeof(vbx_mm_t) );
	vbx_mm_t  *vector_out  = vbx_shared_malloc( TEST_LENGTH*sizeof(vbx_mm_t) );

	VBX_T(test_zero_array)( scalar_out, TEST_LENGTH );
	VBX_T(test_zero_array)( vector_out, TEST_LENGTH );

	VBX_T(test_init_array)( scalar_in, TEST_LENGTH, 1 );
	VBX_T(test_copy_array)( vector_in, scalar_in, TEST_LENGTH );

	test_init_array_word( scalar_filt, NTAP_LENGTH, 1 );
	test_copy_array_word( vector_filt, scalar_filt, NTAP_LENGTH );

	VBX_T(test_print_matrix)( scalar_in, PRINT_ROWS, PRINT_COLS, TEST_COLS );
	test_print_matrix_word( scalar_filt, NTAP_ROWS, NTAP_COLS, NTAP_COLS );

	scalar_time = test_scalar( scalar_out, scalar_in, scalar_filt,
			TEST_ROWS, TEST_COLS, NTAP_ROWS, NTAP_COLS);
	VBX_T(test_print_matrix)( scalar_out, PRINT_COLS, PRINT_ROWS, TEST_COLS );

	vector_time = test_vector( vector_out, vector_in, vector_filt,
			TEST_ROWS, TEST_COLS, NTAP_ROWS, NTAP_COLS, scalar_time );
	VBX_T(test_print_matrix)( vector_out, PRINT_COLS, PRINT_ROWS, TEST_COLS );

	int i;
	for(i=0; i<TEST_ROWS-NTAP_ROWS; i++){
		errors += VBX_T(test_verify_array)( scalar_out+i*TEST_COLS, vector_out+i*TEST_COLS, TEST_COLS-NTAP_COLS );
	}

	VBX_TEST_END(errors);
	return 0;
}
