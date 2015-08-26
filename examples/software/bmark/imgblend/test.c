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
VBXCOPYRIGHT( test_imgblend )

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbx_port.h"
#include "vbx_test.h"

#include "imgblend.h"


#define CONST_BLEND 26

#define NUM_OF_ROWS 240
#define NUM_OF_COLUMNS 320


//Initialize with test patterns
void init_img( input_pointer input1, input_pointer input2 )
{
	int i,j;

	for( j=0;j<NUM_OF_ROWS; j++ ) {
		for( i = 0; i < NUM_OF_COLUMNS; i++ ) {
			input1[j*NUM_OF_COLUMNS+i] = (i*53 + j*73) & 0xFF;
			input2[j*NUM_OF_COLUMNS+i] = (i*89 + j*29) & 0xFF;
		}
	}
}

int main(void)
{
	vbx_timestamp_t time_start, time_stop;
	double scalar_time, vector_time;

	input_pointer img1;
	input_pointer img2;
	input_pointer sc_img1;
	input_pointer sc_img2;
	output_pointer scalar_out;
	output_pointer vector_out;

	int i,j;

    int total_errors = 0;

    vbx_test_init();

	vbx_mxp_print_params();

	img1       = vbx_shared_malloc( NUM_OF_ROWS*NUM_OF_COLUMNS*sizeof(input_type)  );
	img2       = vbx_shared_malloc( NUM_OF_ROWS*NUM_OF_COLUMNS*sizeof(input_type)  );
	vector_out = vbx_shared_malloc( NUM_OF_ROWS*NUM_OF_COLUMNS*sizeof(output_type) );

	sc_img1    = malloc( NUM_OF_ROWS*NUM_OF_COLUMNS*sizeof(input_type)  );
	sc_img2    = malloc( NUM_OF_ROWS*NUM_OF_COLUMNS*sizeof(input_type)  );
	scalar_out = malloc( NUM_OF_ROWS*NUM_OF_COLUMNS*sizeof(output_type) );

	init_img( img1, img2 );
	init_img( sc_img1, sc_img2 );

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_VECTOR_BYTE_LANES = this_mxp->vector_lanes * sizeof(int);

	printf("\n");
	printf("Num of byte lanes: %d\n", VBX_VECTOR_BYTE_LANES);

	printf("Initialized data\n\n");
	printf("Executing Scalar Image Blend...\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	scalar_blend( scalar_out, sc_img1, sc_img2, NUM_OF_ROWS, NUM_OF_COLUMNS, CONST_BLEND );
	time_stop = vbx_timestamp();

	printf("Finished Scalar Image Blend\n");
	scalar_time = vbx_print_scalar_time(time_start, time_stop);

	printf("\nExecuting Vector Image Blend...\n");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	vector_blend( vector_out, img1, img2, NUM_OF_ROWS, NUM_OF_COLUMNS, CONST_BLEND);
	time_stop = vbx_timestamp();

	printf("Finished Vector Image Blend\n");

	vector_time = vbx_print_vector_time(time_start, time_stop, scalar_time);

	int errors = 0;
	for( j=0; j<NUM_OF_ROWS; j++ ) {
		for( i = 0; i < NUM_OF_COLUMNS; i++ ) {
			if( vector_out[j*NUM_OF_COLUMNS+i] != scalar_out[j*NUM_OF_COLUMNS+i] ) {
				if(errors < 5)
					printf( "\nFail at sample [%3d,%3d].  Scalar: %3d Vector: %3d Img1: %3d Img2: %3d",
						j, i, scalar_out[j*NUM_OF_COLUMNS+i],
						vector_out[j*NUM_OF_COLUMNS+i], img1[j*NUM_OF_COLUMNS+i], img2[j*NUM_OF_COLUMNS+i] );
				errors++;
			}
		}
	}
	printf("\n%d errors\n", errors);
    total_errors += errors;

    VBX_TEST_END(total_errors);

	return 0;
}
