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
VBXCOPYRIGHT( test_mtx_xp )

/*
 * Matrix Transpose - Scalar version and Vector version
 */

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "scalar_mtx_xp.h"
#include "vbw_mtx_xp.h"

#define VBX_TEMPLATE_T   VBX_BYTESIZE_DEF
// #define VBX_TEMPLATE_T   VBX_HALFSIZE_DEF
// #define VBX_TEMPLATE_T   VBX_WORDSIZE_DEF
// #define VBX_TEMPLATE_T   VBX_UBYTESIZE_DEF
// #define VBX_TEMPLATE_T   VBX_UHALFSIZE_DEF
// #define VBX_TEMPLATE_T   VBX_UWORDSIZE_DEF
// signed types:   VBX_BYTESIZE_DEF    VBX_HALFSIZE_DEF    VBX_WORDSIZE_DEF
// unsigned types: VBX_UBYTESIZE_DEF   VBX_UHALFSIZE_DEF   VBX_UWORDSIZE_DEF

#include "vbw_template_t.h"

#define TEST_ROWS_MIN 1                // Smallest number of rows to test
#define TEST_COLS_MIN 1                // Smallest number of columns to test
#define TEST_ROWS_MAX 512             // Largest number of rows to test
#define TEST_COLS_MAX 512             // Largest number of columns to test
#define REDUCE_SAMPLE_ROWS 1           // Choose only certain row numbers (e.g. pwr of 2, <10, <128 & %7, %131)
                                       // Exact selection criteria are written into the main function.
                                       // If this is set to 0, all row numbers from min to max will be tested.
#define REDUCE_SAMPLE_COLS 1           // Same, but for column numbers.

#define SAMPLE_INVERSE_DIMENSIONS 1    // 0 prevents sampling both NxM and MxN. Must set to 1 if using "REDUCE_" flags

#define NUMBER_OF_RUNS 1               // Run all samples, then start over until done this many times.

/** Only one "USE_" flag should be active at a time. Select which transpose function to use. **/
#define USE_XP 0                       // Input and output are in the scratchpad. No main memory transfers.
#define USE_XP_EXT 1                   // Input and output ar in main memory.
// #define USE_SCALAR_ALT 0            // Cache-friendly scalar function. Not currently implemented
#define USE_SCALAR_ONLY 0              // Input and ouput in main memory. Do not use the MXP.

#define VERBOSE_TIMING 0               // Turn this off if you are running a lot of samples

#define PRINT_SCALAR_TIME 0            // Print the scalar time to compare performance with other functions

#define SCALAR_FLUSH_CACHE 1           // Flushes the cache before running each sample.
// #define SCALAR_ALT_FLUSH_CACHE 1    // Not currently implemented.

#define DEBUG_PRINT_MATRIX_IN  0       // Print input matrix
#define DEBUG_PRINT_MATRIX_SCALAR 0    // Print scalar output matrix
#define DEBUG_PRINT_MATRIX_OUT 0       // Print vector output matrix


double test_vector_xp( vbx_sp_t *v_out, vbx_sp_t *v_in, int TEST_ROW, int TEST_COL, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;

	#if VERBOSE_TIMING
		printf( "\nExecuting MXP matrix transpose...\n" );
	#else
		printf( "MXP XP INT\t%i\t%i\t", TEST_ROW, TEST_COL );
	#endif

	vbx_sync();
	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = VBX_T(vbw_mtx_xp)( v_out, v_in, TEST_ROW, TEST_COL );
	vbx_sync();
	time_stop = vbx_timestamp();

	#if VERBOSE_TIMING
		printf( "...done. retval:%X\n",retval );
		return vbx_print_vector_time( time_start, time_stop, scalar_time );
	#else
		unsigned long long result = (unsigned long long)(time_stop - time_start);
		printf( "%llu\t0x%08X\n", result, retval );
		return (double)result;
	#endif

	return 0.0;
}

double test_vector_xp_ext( vbx_mm_t *out, vbx_mm_t *in, int TEST_ROW, int TEST_COL, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;

	#if VERBOSE_TIMING
		printf( "\nExecuting MXP matrix transpose - external memory...\n" );
	#else
		printf( "MXP XP EXT\t%i\t%i\t", TEST_ROW, TEST_COL );
	#endif

		vbx_sync();
		vbx_timestamp_start();
		time_start = vbx_timestamp();
		retval = VBX_T(vbw_mtx_xp_ext)( out, in, TEST_ROW, TEST_COL );
		vbx_sync();
		time_stop = vbx_timestamp();

	#if VERBOSE_TIMING
		printf( "...done. retval:%X\n", retval );
		return vbx_print_vector_time( time_start, time_stop, scalar_time );
	#else
		unsigned long long result = (unsigned long long)(time_stop - time_start);
		printf( "%llu\t0x%08X\n", result, retval );
		return (double)result;
	#endif

	return 0.0;
}

#if 0 // Not currently implemented
double test_scalar_alt( vbx_mm_t *vector_out, vbx_mm_t *vector_in, int TEST_ROW,
                        int TEST_COL, double scalar_time )
{
	vbx_timestamp_t time_start, time_stop;

	#if VERBOSE_TIMING
		printf( "\nExecuting alternate scalar xp...\n" );
	#else
		printf( "SCALAR ALT\t%i\t%i\t", TEST_ROW, TEST_COL );
	#endif

	vbx_timestamp_start();

	#if SCALAR_ALT_FLUSH_CACHE
		// vbx_dcache_flush(scalar_in,TEST_ROW*TEST_COL*sizeof(int));
		// vbx_dcache_flush(scalar_out,TEST_ROW*TEST_COL*sizeof(int));
		vbx_dcache_flush_all();
	#endif

	time_start = vbx_timestamp();
	VBX_T(scalar_mtx_xp_test)( vector_out, vector_in, TEST_ROW, TEST_COL );
	time_stop = vbx_timestamp();

	#if VERBOSE_TIMING
		printf( "...done\n" );
		return vbx_print_vector_time( time_start, time_stop, scalar_time );
	#else
		unsigned long long result = (unsigned long long)(time_stop - time_start);
		printf( "%llu\n", result );
		return (double)result;
	#endif

	return 0.0;
}
#endif

double test_scalar( vbx_mm_t *scalar_out, vbx_mm_t *scalar_in, int TEST_ROW, int TEST_COL )
{
	vbx_timestamp_t time_start, time_stop;
	#if VERBOSE_TIMING
		printf( "\nExecuting scalar xp...\n" );
	#else
		#if PRINT_SCALAR_TIME
			printf( "SCALAR\t%i\t%i\t", TEST_ROW, TEST_COL );
		#endif
	#endif

	vbx_timestamp_start();

	#if SCALAR_FLUSH_CACHE
		// vbx_dcache_flush(scalar_in,TEST_ROW*TEST_COL*sizeof(int));
		// vbx_dcache_flush(scalar_out,TEST_ROW*TEST_COL*sizeof(int));
		vbx_dcache_flush_all();
	#endif

	time_start = vbx_timestamp();
	VBX_T(scalar_mtx_xp)( scalar_out, scalar_in, TEST_ROW, TEST_COL );
	time_stop = vbx_timestamp();


	#if VERBOSE_TIMING
		printf( "...done\n" );
		return vbx_print_scalar_time( time_start, time_stop );
	#else
		unsigned long long result = (unsigned long long)(time_stop - time_start);
		#if PRINT_SCALAR_TIME
			printf( "%llu\n", result );
		#endif
		return (double)result;
	#endif

	return 0.0;
}

int main(void)
{
	vbx_test_init();

	int SP_SIZE = vbx_sp_getfree();

	int HALF_SP_SIZE = VBX_PAD_DN( SP_SIZE/2, VBX_GET_THIS_MXP()->scratchpad_alignment_bytes );

	int M = TEST_ROWS_MAX;
	int N = TEST_COLS_MAX;

	int PRINT_LENGTH = min( N, MAX_PRINT_LENGTH );
	int PRINT_COLS = PRINT_LENGTH;
	int PRINT_ROWS = min( M,MAX_PRINT_LENGTH );

	double scalar_time, vector_time;
	int errors=0;

	vbx_mxp_print_params();

	printf( "\nMatrix transpose test...\n" );
	printf( "Matrix dimensions: %d,%d\n", M, N );

	vbx_mm_t *scalar_in  = malloc( M*N*sizeof(vbx_mm_t) );
	vbx_mm_t *scalar_out = malloc( M*N*sizeof(vbx_mm_t) );

	vbx_mm_t *vector_in  = vbx_shared_malloc( M*N*sizeof(vbx_mm_t) );
	vbx_mm_t *vector_out = vbx_shared_malloc( M*N*sizeof(vbx_mm_t) );

	#if USE_XP
		vbx_sp_t *v_out = vbx_sp_malloc( HALF_SP_SIZE );
		vbx_sp_t *v_in  = vbx_sp_malloc( HALF_SP_SIZE );
	#endif

	VBX_T(test_zero_array)( scalar_out, M*N );
	VBX_T(test_zero_array)( vector_out, M*N );

	VBX_T(test_init_array)( scalar_in, M*N, 1 );
	VBX_T(test_copy_array)( vector_in, scalar_in, M*N );
	// VBX_T(test_print_matrix)( scalar_in, PRINT_ROWS, PRINT_COLS, N );

int q;
for(q=0;q<NUMBER_OF_RUNS;q++) {

	int colstart = TEST_COLS_MIN;
	int pwr2;

	for( M=TEST_ROWS_MIN; M<=TEST_ROWS_MAX; M++ ) {

		for(pwr2 = 1<<14; pwr2>0 && pwr2!=M; pwr2>>=1);    // if M is a power of 2: pwr2=M, otherwise pwr2=0

		#if REDUCE_SAMPLE_ROWS
			if( !( M%131==0 || ( M%7==0 && M<=128 ) || M<10 || M==pwr2) ) continue;
		#endif

		#if !SAMPLE_INVERSE_DIMENSIONS
			colstart = M;
		#endif

		for( N=colstart; N<=TEST_COLS_MAX; N++ ) {
			#if REDUCE_SAMPLE_COLS
				if( !( N%239==0 || ( N%7==0 && N<=128 && M<=128 ) || ( N<10 && M<10 ) || M==N ) ) continue;
			#endif

			#if DEBUG_PRINT_MATRIX_IN
				VBX_T(test_print_matrix)( scalar_in, PRINT_ROWS, PRINT_COLS, N );
			#endif

			#if USE_SCALAR_ONLY
				scalar_time = test_scalar( scalar_out, vector_in, M, N );
			#endif

			#if 0 // Not currently implemented
			#if USE_SCALAR_ALT
				scalar_time = test_scalar( scalar_out, vector_in, M, N );
				#if DEBUG_PRINT_MATRIX_SCALAR
					VBX_T(test_print_matrix)( scalar_out, PRINT_COLS, PRINT_ROWS, M );
				#endif

				// Even though this is testing a scalar algorith, we use the "vector" variables so we can test accuracy
				vector_time = test_scalar_alt( vector_out, vector_in, M, N );

				errors += VBX_T(test_verify_array)( scalar_out, vector_out, M*N );

				#if DEBUG_PRINT_MATRIX_OUT
					VBX_T(test_print_matrix)( vector_out, PRINT_COLS, PRINT_ROWS, M );
				#endif
			#endif
			#endif // Not implemented

			#if USE_XP
				if(M*N*sizeof(vbx_sp_t) <= HALF_SP_SIZE ) {
					scalar_time = test_scalar( scalar_out, vector_in, M, N );
					#if DEBUG_PRINT_MATRIX_SCALAR
						VBX_T(test_print_matrix)( scalar_out, PRINT_COLS, PRINT_ROWS, M );
					#endif

					vbx_dma_to_vector( v_in, vector_in, M*N*sizeof(vbx_sp_t) );

					vector_time = test_vector_xp( v_out, v_in, M, N, scalar_time );

					vbx_dma_to_host( vector_out, v_out, M*N*sizeof(vbx_sp_t) );
					vbx_sync();
					errors += VBX_T(test_verify_array)( scalar_out, vector_out, M*N );

					#if DEBUG_PRINT_MATRIX_OUT
						VBX_T(test_print_matrix)( vector_out, PRINT_COLS, PRINT_ROWS, M );
					#endif
				} else printf("\n");
			#endif

			#if USE_XP_EXT
				scalar_time = test_scalar( scalar_out, vector_in, M, N );
				#if DEBUG_PRINT_MATRIX_SCALAR
					VBX_T(test_print_matrix)( scalar_out, PRINT_COLS, PRINT_ROWS, M );
					// VBX_T(test_print_matrix)( vector_in, PRINT_ROWS, PRINT_COLS, N );
				#endif

				vector_time = test_vector_xp_ext( vector_out, vector_in, M, N, scalar_time );

				errors += VBX_T(test_verify_array)( scalar_out, vector_out, M*N );

				#if DEBUG_PRINT_MATRIX_OUT
					VBX_T(test_print_matrix)( vector_out, PRINT_COLS, PRINT_ROWS, M );
				#endif
			#endif

		} //for N
	} // for M
printf("\n----------\n");
} // for NUMBER_OF_RUNS
	VBX_TEST_END(errors);

	return 0;
}
