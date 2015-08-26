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
VBXCOPYRIGHT( test_vec_fir )

/*
 * Finite Impulse Response Filter - Scalar version and Vector version
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbx_port.h"
#include "vbx_common.h"
#include "vbx_test.h"

#include "scalar_vec_fir.h"
#include "vbw_vec_fir.h"

#define VBX_TEMPLATE_T   VBX_BYTESIZE_DEF
// signed   VBX_BYTESIZE_DEF    VBX_HALFSIZE_DEF    VBX_WORDSIZE_DEF
// unsigned VBX_UBYTESIZE_DEF   VBX_UHALFSIZE_DEF   VBX_UWORDSIZE_DEF
#include "vbw_template_t.h"

#define USE_TRANSPOSE
#define USE_2D

#define NTAPS     16
#define SAMP_SIZE 0x1000


double test_vector_transpose( vbx_mm_t *vector_out, vbx_mm_t *sample, vbx_mm_t *coeffs, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf("\nExecuting MXP vector transpose FIR.... \n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = VBX_T(vbw_vec_fir_transpose_ext)( vector_out, sample, coeffs, SAMP_SIZE, NTAPS );
	time_stop = vbx_timestamp();

	printf("...done retval:%X\n", retval);
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}


double test_vector( vbx_mm_t *vector_out, vbx_mm_t *sample, vbx_mm_t *coeffs, double scalar_time )
{
	int retval;
	vbx_timestamp_t time_start, time_stop;
	printf("\nExecuting MXP vector FIR with Accum 2D....\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	retval = VBX_T(vbw_vec_fir_ext)( vector_out, sample, coeffs, SAMP_SIZE, NTAPS );
	time_stop = vbx_timestamp();

	printf("...done retval:%X\n", retval);
	return vbx_print_vector_time( time_start, time_stop, scalar_time );
}


double test_scalar( vbx_mm_t *scalar_out, vbx_mm_t *scalar_sample, vbx_mm_t *scalar_coeffs)
{
	vbx_timestamp_t time_start, time_stop;
	printf("\nExecuting scalar vector FIR...\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	VBX_T(scalar_vec_fir)( scalar_out, scalar_sample, scalar_coeffs, SAMP_SIZE, NTAPS );
	time_stop = vbx_timestamp();

	printf("...done\n");
	return vbx_print_scalar_time( time_start, time_stop );
}



int main(void)
{
	double scalar_time, vector_time;
	int errors=0;

	vbx_test_init();

	vbx_mxp_print_params();
	printf("\nVector FIR test...\n");

	vbx_mm_t *scalar_sample = malloc( (SAMP_SIZE+NTAPS)*sizeof(vbx_mm_t) );
	vbx_mm_t *scalar_coeffs = malloc(             NTAPS*sizeof(vbx_mm_t) );
	vbx_mm_t *scalar_out    = malloc(         SAMP_SIZE*sizeof(vbx_mm_t) );

	vbx_mm_t *sample     = vbx_shared_malloc( (SAMP_SIZE+NTAPS)*sizeof(vbx_mm_t) );
	vbx_mm_t *coeffs     = vbx_shared_malloc(             NTAPS*sizeof(vbx_mm_t) );
	vbx_mm_t *vector_out = vbx_shared_malloc(         SAMP_SIZE*sizeof(vbx_mm_t) );

	VBX_T(test_zero_array)( scalar_out, SAMP_SIZE );
	VBX_T(test_zero_array)( vector_out, SAMP_SIZE );

	VBX_T(test_init_array)( scalar_sample, SAMP_SIZE, 0xff );
	VBX_T(test_copy_array)( sample, scalar_sample, SAMP_SIZE );
	VBX_T(test_init_array)( scalar_coeffs, NTAPS, 1 );
	VBX_T(test_copy_array)( coeffs, scalar_coeffs, NTAPS );

	VBX_T(test_zero_array)( scalar_sample+SAMP_SIZE, NTAPS );
	VBX_T(test_zero_array)( sample+SAMP_SIZE, NTAPS );

	printf("\nSamples:\n");
	VBX_T(test_print_array)( scalar_sample, min(SAMP_SIZE,MAX_PRINT_LENGTH) );
	printf("\nCoefficients:\n");
	VBX_T(test_print_array)( scalar_coeffs, min(NTAPS,MAX_PRINT_LENGTH) );

	scalar_time = test_scalar( scalar_out, scalar_sample, scalar_coeffs);
	VBX_T(test_print_array)( scalar_out,  min(SAMP_SIZE,MAX_PRINT_LENGTH) );


	#ifdef USE_TRANSPOSE
	vector_time = test_vector_transpose( vector_out, sample, coeffs, scalar_time );
	VBX_T(test_print_array)( vector_out,  min(SAMP_SIZE,MAX_PRINT_LENGTH) );
	errors += VBX_T(test_verify_array)( scalar_out, vector_out, SAMP_SIZE-NTAPS );
	#endif //USE_TRANSPOSE

	#ifdef USE_2D
	vector_time = test_vector( vector_out, sample, coeffs, scalar_time );
	VBX_T(test_print_array)( vector_out,  min(SAMP_SIZE,MAX_PRINT_LENGTH) );
	errors += VBX_T(test_verify_array)( scalar_out, vector_out, SAMP_SIZE-NTAPS );
	#endif //USE_2D

	VBX_TEST_END(errors);
	return 0;
}
