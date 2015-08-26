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
VBXCOPYRIGHT( test_vec_copy )

/*
  Vector Copy - Scalar version and Vector version
*/

//#define VBX_SKIP_ALL_CHECKS 0

#include <stdio.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbx_test.h"
#include "scalar_vec_copy.h"
#include "vbw_vec_copy.h"

#define VBX_TEMPLATE_T   VBX_HALFSIZE_DEF
// signed   VBX_BYTESIZE_DEF    VBX_HALFSIZE_DEF    VBX_WORDSIZE_DEF
// unsigned VBX_UBYTESIZE_DEF   VBX_UHALFSIZE_DEF   VBX_UWORDSIZE_DEF
#include "vbw_template_t.h"

#define DEBUG_MAKE_SP_FULL 0
#define TEST_DEEP_SP 1
#define TEST_DEEP_SP_NUM_TESTS 10000
#define TEST_DEEP_MM 1
//For some reason the mm test hangs on arm (zedboard), so don't run it.
#if __ARM_ARCH_7A__
#define TEST_DEEP_MM_NUM_TESTS 0
#else
#define TEST_DEEP_MM_NUM_TESTS 100
#endif



#if (VBX_TEMPLATE_T == VBX_BYTESIZE_DEF | VBX_TEMPLATE_T == VBX_UBYTESIZE_DEF)
	#define MSK 0xFF
#elif (VBX_TEMPLATE_T == VBX_HALFSIZE_DEF | VBX_TEMPLATE_T == VBX_UHALFSIZE_DEF)
	#define MSK 0xFFFF
#else
	#define MSK 0x7FFFFFFF
#endif

double test_vector( vbx_sp_t *v_out, vbx_sp_t *v_in, int N, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting vector copy...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = VBX_T(vbw_vec_copy)( v_out, v_in, N );
	vbx_sync();
	time_stop = vbx_timestamp();

	printf( "...done. retval: %X\n", retval );
	return vbx_print_vector_time(time_start, time_stop, scalar_time);
}

double test_vector_ext( vbx_mm_t *out, vbx_mm_t *in, int N, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting vector copy (ext)...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = VBX_T(vbw_vec_copy_ext)( out, in, N );
	vbx_sync();
	time_stop = vbx_timestamp();

	printf( "...done. retval: %X\n", retval );
	return vbx_print_vector_time(time_start, time_stop, scalar_time);
}

double test_scalar( vbx_mm_t *scalar_out, vbx_mm_t *scalar_in, int N )
{
	vbx_timestamp_t time_start, time_stop;
	printf( "\nExecuting scalar copy...\n" );

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	VBX_T(scalar_vec_copy)( scalar_out, scalar_in, N );
	time_stop = vbx_timestamp();

	printf( "...done\n" );
	return vbx_print_scalar_time( time_start, time_stop );
}

///////////////////////////////////////////////////////////////////////////
int verify_copy(vbx_mm_t *v, int A, int B, int tgt, char *position)
{
	int i;
	int errors = 0;

	for (i = A; i < B; i++) {
		vbx_mm_t target = (tgt+i) & MSK;
		if (v[i] != target) {
			if (errors++ < 10) {
				printf("verify %s error, found 0x%08x expected 0x%08x at position %08d\n",
				       position, v[i], target, (tgt)+i);
			}
		}
	}

	return errors;
}

///////////////////////////////////////////////////////////////////////////
int deep_vector_copy_test()
{
	int retval;
	int num_test;
	int total_errors = 0;
	const int NUM_TESTS = TEST_DEEP_SP_NUM_TESTS;
	const int NB = vbx_sp_getfree();

	int NT = NB / sizeof(vbx_sp_t);

	vbx_sp_push();
	vbx_sp_t *v = vbx_sp_malloc( NB );

	srand( 0x1a84c92a );

	for( num_test=0; num_test < NUM_TESTS ; num_test++ ) {

		// initialize entire available scratchpad
		vbx_set_vl( NT );
		vbx( SE(T), VAND, v, MSK, 0 );

		// choose random src/dest/length:
		// -- randomly pick the dest
		// -- set a window size of 2*K around the dest
		// -- randomly pick the src within the window
		// -- randomly pick the length, subject to end-of-scratchpad
		// -- this 'window' rule increases probability of overlaps
		// -- rough distribution: 30% short (pipeline) overlaps, 20% long overlaps, 50% no overlap

		int K, N1, N2, NN;
		N1 = rand() % NT;
		K  = 1 + rand() % ((N1 > 0)? min(min(N1, NT-N1), 1024): min(NT, 1024));
		N2 = N1 - K + rand() % (2*K);
		NN = rand() % (NT - max(N1,N2));
		vbx_sp_t *dst = v + N1;
		vbx_sp_t *src = v + N2;

		printf("test:%d src:0x%08x dst:0x%08x len:%08d", num_test, N1, N2, NN );

		// do the copy
		retval = VBX_T(vbw_vec_copy)( dst, src, NN );
		vbx_sync();
		printf(" retval:0x%04x\n",retval);

		// ensure the copy was done properly
		int errors = verify_copy((vbx_mm_t *)v,     0,    N1,       0, "head")
		           + verify_copy((vbx_mm_t *)v,    N1, NN+N1, (N2-N1), "copy")
		           + verify_copy((vbx_mm_t *)v, NN+N1,    NT,       0, "tail");
		total_errors += errors;
		if( errors ) {
			//break;
		}
	}

	vbx_sp_pop();
	return total_errors;
}

int deep_vector_copy_ext_test()
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int retval;
	int num_test;
	int total_errors = 0;
	const int NUM_TESTS = TEST_DEEP_MM_NUM_TESTS;
	int NB = this_mxp->scratchpad_size * 10;
	int NT = NB / sizeof(vbx_mm_t);

	vbx_mm_t *v = vbx_shared_malloc( NB );

	srand( 0x1a84c92a );

	int i;

	for( num_test=0; num_test < NUM_TESTS ; num_test++ ) {

		//	initialize the whole working space
		for( i=0; i<NT; i++ ) {
			v[i] = i & MSK;
		}

		// choose random src/dest/length:
		// -- randomly pick the dest
		// -- set a window size of 2*K around the dest
		// -- randomly pick the src within the window
		// -- randomly pick the length, subject to end-of-scratchpad
		// -- this 'window' rule increases probability of overlaps
		// -- rough distribution: 30% short (pipeline) overlaps, 20% long overlaps, 50% no overlap

		int K, N1, N2, NN;
		N1 = rand() % NT;
		K  = 1 + rand() % ((N1 > 0)? min(min(N1, NT-N1), 1024): min(NT, 1024));
		N2 = N1 - K + rand() % (2*K);
		NN = rand() % (NT - max(N1,N2));
		vbx_mm_t *dst = v + N1;
		vbx_mm_t *src = v + N2;
		printf("test:%d src:0x%08x dst:0x%08x len:%08d", num_test, N1, N2, NN );

		// do the copy
		retval = VBX_T(vbw_vec_copy_ext)( dst, src, NN );
		vbx_sync();
		printf(" retval:0x%04x\n",retval);

		// ensure the copy was done properly
		int errors = verify_copy(v,     0,    N1,       0, "head")
		           + verify_copy(v,    N1, NN+N1, (N2-N1), "copy")
		           + verify_copy(v, NN+N1,    NT,       0, "tail");
		total_errors += errors;
		if( errors ) {
			//break;
		}
	}

	return total_errors;
}

///////////////////////////////////////////////////////////////////////////
int main(void)
{
	vbx_test_init();

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	const int required_vectors = 4;

	int N = VBX_PAD_DN(VBX_SCRATCHPAD_SIZE / sizeof(vbx_mm_t) / required_vectors, this_mxp->scratchpad_alignment_bytes);

	int PRINT_LENGTH = min( N, MAX_PRINT_LENGTH );

	double scalar_time, vector_time;
	int errors=0;

	vbx_mxp_print_params();
	printf( "\nVector copy test...\n" );
	printf( "Vector length: %d\n", N );

	vbx_mm_t *scalar_in  = malloc( N*sizeof(vbx_mm_t) );
	vbx_mm_t *scalar_out = malloc( N*sizeof(vbx_mm_t) );

	vbx_mm_t *vector_in  = vbx_shared_malloc( N*sizeof(vbx_mm_t) );
	vbx_mm_t *vector_out = vbx_shared_malloc( N*sizeof(vbx_mm_t) );

	vbx_sp_t *v_out = vbx_sp_malloc( N*sizeof(vbx_sp_t) );
	vbx_sp_t *v_in = vbx_sp_malloc( N*sizeof(vbx_sp_t) );

	VBX_T(test_zero_array)( scalar_in, N );
	VBX_T(test_zero_array)( vector_in, N );

	VBX_T(test_init_array)( scalar_in, N, 1 );
	VBX_T(test_copy_array)( vector_in, scalar_in, N );

	scalar_time = test_scalar( scalar_out, scalar_in, N );
	VBX_T(test_print_array)( scalar_out, PRINT_LENGTH );

	vbx_dma_to_vector( v_in, vector_in, N*sizeof(vbx_sp_t) );
	vector_time = test_vector( v_out, v_in, N, scalar_time );
	vbx_dma_to_host(vector_out, v_out, N*sizeof(vbx_sp_t) );
	vbx_sync();
	VBX_T(test_print_array)( vector_out, PRINT_LENGTH );

	errors += VBX_T(test_verify_array)( scalar_out, vector_out, N );

	vbx_sp_free();

#if TEST_DEEP_SP
	errors += deep_vector_copy_test();
#endif

#if DEBUG_MAKE_SP_FULL
	vbx_sp_malloc(vbx_sp_getfree());
#endif

#if TEST_DEEP_MM
	errors += deep_vector_copy_ext_test();
#endif

	VBX_TEST_END(errors);

	return 0;
}
