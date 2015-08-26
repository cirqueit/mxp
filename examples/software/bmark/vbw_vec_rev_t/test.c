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
VBXCOPYRIGHT( test_rev )

/*
 * Vector Reverse Testing - starting from SP or from MM
 */

	// This doesn't seem to matter here
#define VBX_SKIP_ALL_CHECKS 0

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>
#include "vbx.h"
#include "vbx_port.h"
#include "vbx_common.h"
#include "vbx_test.h"

#include "vbw_vec_rev.h"

//#define VBX_TEMPLATE_T   VBX_BYTESIZE_DEF
//#define VBX_TEMPLATE_T   VBX_HALFSIZE_DEF
//#define VBX_TEMPLATE_T   VBX_WORDSIZE_DEF
//#define VBX_TEMPLATE_T   VBX_UBYTESIZE_DEF
#define VBX_TEMPLATE_T   VBX_UHALFSIZE_DEF
//#define VBX_TEMPLATE_T   VBX_UWORDSIZE_DEF

// signed   VBX_BYTESIZE_DEF    VBX_HALFSIZE_DEF    VBX_WORDSIZE_DEF
// unsigned VBX_UBYTESIZE_DEF   VBX_UHALFSIZE_DEF   VBX_UWORDSIZE_DEF

#include "vbw_template_t.h"

#define VERIFY_VBWARE_ALGORITHM 1
#define VERIFY_SIMPLE_ALGORITHM 1

#define VBX_QUOTE(str) #str
#define VBX_EXPAND_AND_QUOTE(str) VBX_QUOTE(str) // Use this macro to stringify #defined values

// INTERNAL DEBUGGING ROUTINES
void VBX_T(print_vector) ( char *str,    void *V,  unsigned int N );
void VBX_T(verify_vector)( void *V1,     void *V2, unsigned int N );


/** Prints a vector of N elements, 15 elements per row.
 *
 *  @param[in] str A label to print first.
 *  @param[in] V   Vector to print *in scratch* or *in memory*.
 *  @param[in] N   Number of elements in the vector.
 **/
void VBX_T(print_vector)( char *str, void *V, unsigned int N )
{
	vbx_mm_t *v = (vbx_mm_t *)(V);
	unsigned int i;
	vbx_sync();
	printf( str );
	for( i=0; i<N; i++ ) {
		if( (i&15) == 0 ) printf("\n");
		#if   ( VBX_TEMPLATE_T == WORDSIZE_DEF | VBX_TEMPLATE_T == UWORDSIZE_DEF )
			printf( "%4"PRId32" ", v[i] );
		#else
			printf( "%d ", v[i] );
		#endif
	}
	printf("\n");
	vbx_sync();
}

//  INTERNAL VERIFICATION ROUTINES

/** Compares two vectors, element by element, to see if one is the reverses of other.
 *
 *  @param[in] V1  *in scratch* or *in memory* traverses backward from the end.
 *  @param[in] V2  *in scratch* or *in memory* traverses forward from the start.
 *  @param[in] N   Number of elements in each of the vectors.
 **/
void VBX_T(verify_vector)( void *V1, void *V2, unsigned int N )
{
	vbx_mm_t *v1 = (vbx_mm_t *)(V1);
	vbx_mm_t *v2 = (vbx_mm_t *)(V2);
	unsigned int i, num_error=0;
	vbx_sync();
	if( !v1 || !v2 ) return;
	for( i=0; i<N; i++ ) {
		if( v1[N-1-i] != v2[i] ) {
			if( ++num_error < 20000 ) {
				#if   ( VBX_TEMPLATE_T == WORDSIZE_DEF | VBX_TEMPLATE_T == UWORDSIZE_DEF )
					printf( "ERROR at %d/%d, v1=%"PRId32", v2=%"PRId32"\n", i, N, v1[N-1-i], v2[i] );
				#else
					printf( "ERROR at %d/%d, v1=%d, v2=%d,\n", i, N, v1[N-1-i], v2[i] );
				#endif
			}
		}
		else if( num_error ) {
			#if   ( VBX_TEMPLATE_T == WORDSIZE_DEF | VBX_TEMPLATE_T == UWORDSIZE_DEF )
				printf( "noerr at %d/%d, v1=%"PRId32", v2=%"PRId32"\n", i, N, v1[N-1-i], v2[i] );
			#else
				printf( "noerr at %d/%d, v1=%d, v2=%d\n", i, N, v1[N-1-i], v2[i] );
			#endif
		}
	}
	if( num_error ) { VBX_TEST_FAIL(num_error); exit(-1); }
	vbx_sync();
}

// TEST ROUTINES

int VBX_T(vbw_vec_reverse_test_mm)()
{
	unsigned int aN[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 15, 16, 17, 20, 25, 31, 32, 33, 35, 40, 48, 60, 61, 62, 63, 64, 64, 65,
	                      66, 67, 68, 70, 80, 90, 99, 100, 101, 110, 128, 128, 144, 144, 160, 160, 176, 176, 192, 192, 224, 224,
	                      256, 256, 288, 288, 320, 320, 352, 352, 384, 384, 400, 450, 512, 550, 600, 650, 700, 768, 768, 900,
	                      900, 1023, 1024, 1200, 1400, 1600, 1800, 2048, 2048, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800,
	                      2900, 3000, 3100, 3200, 3300, 3400, 3500, 3600, 3700, 3800, 3900, 4000, 4096, 4096, 4100, 4200, 4300,
	                      4400, 4500, 4600, 4700, 4800, 4900, 5000, 6000, 7000, 8000, 8192, 8192, 9000, 10000, 11000, 12000,
	                      13000, 14000, 15000, 16000, 16384, 16384, 20000, 25000, 30000, 32767, 32768, 32768, 35000, 40000,
	                      45000, 50000, 55000, 60000, 65000, 65535, 65536, 65536, 65537, 100000, 128000, 256000, 333333, 528374,
	                      528374 };

	int retval;
	unsigned int N;
	unsigned int NBYTES;
	unsigned int NREPS = 100;
	unsigned int NREPSFORLARGE = 10;
	unsigned int i,j,k;
	vbx_timestamp_t start=0,finish=0;

	for( i=0; i<sizeof(aN)/4; i++ ) {
		N = aN[i];
		//printf( "testing with vector size %d\n", N );

		if(N > 10000) NREPS = NREPSFORLARGE;

		NBYTES = N*sizeof(vbx_mm_t);

		vbx_mm_t *src = (vbx_mm_t *) vbx_shared_malloc( NBYTES );
		vbx_mm_t *dst = (vbx_mm_t *) vbx_shared_malloc( NBYTES );
		//printf("bytes alloc: %d\n", NBYTES );

		if( !src ) VBX_EXIT(-1);
		if( !dst ) VBX_EXIT(-1);

		for ( j=0; j<N; j++ ) {
			dst[j] = -1;                 // Fill the destination with -1
			src[j] = j;                  // Fill the source with enumerated values
		}

//			VBX_T(vbw_vec_reverse_ext)( dst, src, N );

		/** measure performance of function call **/
		start = vbx_timestamp();
		for(k=0; __builtin_expect(k<NREPS,1); k++ ) {
			retval = VBX_T(vbw_vec_reverse_ext)( dst, src, N );
		}
		finish = vbx_timestamp();
		printf( "length %d (%s):\tvbware mm f():\t%llu", N, VBX_EXPAND_AND_QUOTE(BYTEHALFWORD), (unsigned long long) vbx_mxp_cycles((finish-start)/NREPS) );

		#if VERIFY_VBWARE_ALGORITHM
			VBX_T(verify_vector)( src, dst, N );
		#else
			printf(" [VERIFY OFF]");
		#endif

		printf("\treturn value: %X", retval);

		/** measure performance of scalar **/
		vbx_mm_t *A = vbx_remap_cached( src, N*sizeof(vbx_mm_t) );   // Use cached pointers for better performance
		vbx_mm_t *B = vbx_remap_cached( dst, N*sizeof(vbx_mm_t) );
		start = vbx_timestamp();
		for(k=0; k<NREPS; k++ ) {
			unsigned int m;
			for(m=0; m<N; m++) {
				B[N-1-m]=A[m];
			}
		vbx_dcache_flush( A, N*sizeof(vbx_mm_t) );               // Make sure to read from main memory
		vbx_dcache_flush( B, N*sizeof(vbx_mm_t) );               // Make sure writes are committed to memory
		}
		finish = vbx_timestamp();

		printf( "\tscalar (cache friendly):\t%llu", (unsigned long long) vbx_mxp_cycles((finish-start)/NREPS) );

		#if VERIFY_SIMPLE_ALGORITHM
			VBX_T(verify_vector)( src, dst, N );
		#else
			printf(" [VERIFY OFF]");
		#endif
			printf("\tcycles\n");

			vbx_shared_free(src);
			vbx_shared_free(dst);
	}

	printf("All tests passed successfully.\n");

	return 0;
}


int VBX_T(vbw_vec_reverse_test)()
{
	unsigned int aN[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 15, 16, 17, 20, 25, 31, 32, 33, 35, 40, 48, 60, 61, 62, 63, 64, 64, 65,
	                      66, 67, 68, 70, 80, 90, 99, 100, 101, 110, 128, 128, 144, 144, 160, 160, 176, 176, 192, 192, 224, 224,
	                      256, 256, 288, 288, 320, 320, 352, 352, 384, 384, 400, 450, 512, 550, 600, 650, 700, 768, 768, 900,
	                      900, 1023, 1024, 1200, 1400, 1600, 1800, 2048, 2048, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800,
	                      2900, 3000, 3100, 3200, 3300, 3400, 3500, 3600, 3700, 3800, 3900, 4000, 4096, 4096, 4100, 4200, 4300,
	                      4400, 4500, 4600, 4700, 4800, 4900, 5000, 6000, 7000, 8000, 8192, 8192, 9000, 10000, 11000, 12000,
	                      13000, 14000, 15000, 16000, 16384, 16384, 20000, 25000, 30000, 32767, 32768, 32768, 35000, 40000,
	                      45000, 50000, 55000, 60000, 65000, 65535, 65536, 65536 };

	int retval;
	unsigned int N;
	unsigned int NBYTES;
	unsigned int NREPS = 100;
	unsigned int i,k;

	vbx_timestamp_t start=0,finish=0;

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const unsigned int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;

	for( i=0; i<sizeof(aN)/4; i++ ) {
		N = aN[i];
		//printf( "testing with vector size %d\n", N );

		NBYTES = sizeof(vbx_sp_t)*N;
		if( 2*NBYTES > VBX_SCRATCHPAD_SIZE ) continue;

		vbx_sp_t *vsrc = vbx_sp_malloc( NBYTES );
		vbx_sp_t *vdst = vbx_sp_malloc( NBYTES );
		//printf("bytes alloc: %d\n", NBYTES );

		if( !vsrc ) VBX_EXIT(-1);
		if( !vdst ) VBX_EXIT(-1);

		#if   ( VBX_TEMPLATE_T == BYTESIZE_DEF | VBX_TEMPLATE_T == UBYTESIZE_DEF )
			unsigned int mask = 0x007F;
		#elif ( VBX_TEMPLATE_T == HALFSIZE_DEF | VBX_TEMPLATE_T == UHALFSIZE_DEF )
			unsigned int mask = 0x7FFF;
		#else
			unsigned int mask = 0xFFFF;
		#endif

		vbx_set_vl( N );
		vbx( SV(T), VMOV, vdst,   -1, 0 );       // Fill the destination vector with -1
		vbx( SE(T), VAND, vsrc, mask, 0 );       // Fill the source vector with enumerated values
		//VBX_T(print_vector)( "vsrcInit", vsrc, N );
		//VBX_T(print_vector)( "vdstInit", vdst, N );

		/** measure performance of function call **/
		vbx_sync();
		start = vbx_timestamp();
		for(k=0; k<NREPS; k++ ) {
			retval = VBX_T(vbw_vec_reverse)( vdst, vsrc, N );
			vbx_sync();
		}
		finish = vbx_timestamp();
		printf( "length %d (%s):\tvbware sp f():\t%llu", N, VBX_EXPAND_AND_QUOTE(BYTEHALFWORD), (unsigned long long) vbx_mxp_cycles((finish-start)/NREPS) );
		//VBX_T(print_vector)( "vsrcPost", vsrc, N );
		//VBX_T(print_vector)( "vdstPost", vdst, N );

		#if VERIFY_VBWARE_ALGORITHM
			VBX_T(verify_vector)( vsrc, vdst, N );
		#else
			printf(" [VERIFY OFF]");
		#endif

		printf("\treturn value: %X", retval);

		vbx_set_vl( N );
		vbx( SE(T), VAND, vsrc, mask, 0 );       // Reset the source vector

		/** measure performance of simple algorithm **/
		vbx_sync();
		vbx_set_vl( 1 );
		vbx_set_2D( N, -sizeof(vbx_sp_t), sizeof(vbx_sp_t), 0 );

		start = vbx_timestamp();
		for(k=0; k<NREPS; k++ ) {
			vbx_2D( VV(T), VMOV, vdst+N-1, vsrc, 0 );
			vbx_sync();
		}
		finish = vbx_timestamp();

		printf( "\tsimple (vl=1):\t%llu", (unsigned long long) vbx_mxp_cycles((finish-start)/NREPS) );

		#if VERIFY_SIMPLE_ALGORITHM
			VBX_T(verify_vector)( vsrc, vdst, N );
		#else
			printf(" [VERIFY OFF]");
		#endif
			printf("\tcycles\n");

		vbx_sp_free();
	}

	vbx_sp_free();
	printf("All tests passed successfully.\n");

	return 0;
}

int main()
{
	unsigned int errors = 0;

	vbx_test_init();

	vbx_timestamp_start();

	// Requires > 64KB scratch:

//	printf(VBX_EXPAND_AND_QUOTE(VBX_CPU_DCACHE_LINE_SIZE));
	 errors += VBX_T(vbw_vec_reverse_test)();
	 errors += VBX_T(vbw_vec_reverse_test_mm)();

	VBX_TEST_END(errors);
	return 0;
}
