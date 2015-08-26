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
VBXCOPYRIGHT( test_unaligned_dma )

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbx_common.h"
#include "vbx_test.h"

/* set divisor > 1 to speed testing */
#define SCRATCHPAD_DIVISOR 1


int unaligned_dma_test( char *dma_test_str, int test_to_host )
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE     = this_mxp->scratchpad_size;
	const int VBX_DMA_ALIGNMENT_BYTES = this_mxp->dma_alignment_bytes;
	const int TEST_LENGTH = this_mxp->vector_lanes * sizeof(int);

	const int MAX_N = (VBX_SCRATCHPAD_SIZE-VBX_DMA_ALIGNMENT_BYTES)/2/SCRATCHPAD_DIVISOR;
	int total_errors = 0;

	uint8_t *buf1 = vbx_shared_malloc( 2*MAX_N );
	uint8_t *buf2 = vbx_shared_malloc( 2*MAX_N );

	vbx_ubyte_t *v1 = vbx_sp_malloc( 2*MAX_N );

	int i, j, k, N;
	for( i=0; i<2*MAX_N; i++ )
		buf1[i] = i & 0xff;

	printf("\nTesting unaligned %s.\n", dma_test_str );
	printf("Long dma\n");
	for( N=MAX_N; N>=0; N-- ) { // shrink length
		for( i=0; i < min(N,VBX_DMA_ALIGNMENT_BYTES); i++ ) {          // change src buffer offset amount
			printf("N = %d, i = %d\n", N, i);
			for( j=0; j < min(N,VBX_DMA_ALIGNMENT_BYTES); j++ ) {  // change dst buffer offset amount

				// clear target buffers
				vbx_set_vl( 2*MAX_N );
				vbx( VVB, VXOR, v1,   v1, v1 );
				vbx( SVB, VXOR, v1, 0xaa, v1 );
				for( k=0; k < 2*MAX_N; k++ ) buf2[k] = 0x55;

				if( test_to_host ) {
					vbx_dma_to_vector(   v1  , buf1  , 2*N );
					vbx_dma_to_host  ( buf2+j,   v1+i,   N );
				} else {
					vbx_dma_to_vector(   v1+j, buf1+i,   N );
					vbx_dma_to_host  ( buf2  ,   v1  , 2*N );
				}

				// test that the data was correctly transfered
				vbx_sync();
				int errors = 0;
				for( k=0; k < N; k++ ) {
					if( buf1[i+k] != buf2[j+k] ) {
						if( errors++ < 1 ) {
							printf( "Error N=%d ( i%d, j%d ) at k %d, "
							        "buf1[i+k]=%d buf2[j+k]=%d\n",
							        N, i, j, k, buf1[i+k], buf2[j+k] );
						}
					}
				}

				uint8_t     *source  = test_to_host ? buf1 : buf1+i;
				vbx_ubyte_t *target  = test_to_host ? buf2 :  v1  ;
				vbx_ubyte_t *scratch = test_to_host ?   v1 :  v1+j;
				uint8_t     sentinel = test_to_host ? 0x55 :  0xaa;
				int         test_len = test_to_host ?  2*N :     N;

				// ensure the do-not-touch head region has not been disturbed
				for( k=0; k < j; k++ ) {
					if( target[k] != sentinel ) {
						if( errors++ < 10 ) printf("Error head 0x%2x N=%d ( i%d, j%d ) at k %d\n", sentinel, N, i, j, k );
					}
				}
				// ensure the do-not-touch tail region has not been disturbed
				for( k=N+j; k < 2*MAX_N; k++ ) {
					if( target[k] != sentinel ) {
						if( errors   < 10 ) printf("i%d j%d target[%d]=0x%x\n", i, j, k, target[k] );
						if( errors++ <  5 ) printf("Error tail 0x%2x N=%d ( i%d, j%d ) at k %d\n", sentinel, N, i, j, k );
					}
				}
				// ensure the scratchpad vector has not been scrambled
				for( k=0; k < test_len; k++ ) {
					if( source[k] != scratch[k] ) {
						if( errors++ < 5 ) printf("Error scramble N=%d ( i%d, j%d ) at k %d\n", N, i, j, k );
					}
				}

				if( !errors ) {
					//printf("Case N=%d ( i%d, j%d ) passed.\n", N, i, j );
				} else {
					total_errors += errors;
				}
			}
		}
		// if( (N & 15) == 0 ) printf(".");
		if( total_errors > 0 ) break;

		// accelerate the decreasing sizes
		if( N == MAX_N-TEST_LENGTH ) { N =           2049; printf("\nMedium dma\n"); }
		if( N ==  2049-TEST_LENGTH ) { N =  TEST_LENGTH+1; printf("\nShort dma\n"); }

	}
	printf("\n");

	if( total_errors > 0 )
		printf("Unaligned %s test FAILED.\n", dma_test_str );
	else
		printf("Unaligned %s test passed.\n", dma_test_str );

	vbx_shared_free( buf1 );
	vbx_shared_free( buf2 );
	vbx_sp_free();
	return total_errors;
}

int main()
{
	int errors = 0;

	vbx_test_init();

	if( !errors )
		errors += unaligned_dma_test( "dma-to-host"  , 1 );

	if( !errors )
		errors += unaligned_dma_test( "dma-to-vector", 0 );

	VBX_TEST_END(errors);

	return 0;
}
