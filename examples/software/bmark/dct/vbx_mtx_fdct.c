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
VBXCOPYRIGHT(mtx_fdct)


// --------------------------------------------------------------
// Decide on the block size

#define BLOCK16 0
#define BLOCK8  0 
#define BLOCK4  1


#if BLOCK16
// for 16x16
#define BLOCK_SIZE    16
#define NUM_TILE_X     8 
#define NUM_TILE_Y     1

#elif BLOCK8
// for 8x8
#define BLOCK_SIZE     8
#define NUM_TILE_X    32
#define NUM_TILE_Y     1

#else
// for 4x4
#define BLOCK_SIZE     4
#define NUM_TILE_X     128//256//32
#define NUM_TILE_Y     1//8
#endif

// ------------------------------------------------------
// Automatically decide which accumulation algorithm to use

#define USE_ACCUM_FLAGS (BLOCK_SIZE == 4)
	// set USE_ACCUM_FLAGS for block size of 4x4 (V16+), 8x8 (V32+), 16x16 (V64+)
	//#define USE_ACCUM_FLAGS ((BLOCK_SIZE == 4)||(BLOCK_SIZE == 8))


// ----------------------------------------------------
// Set aspects of the image size

#define IMAGE_WIDTH    1920
#define IMAGE_HEIGHT   1088
//#define IMAGE_HEIGHT   (NUM_TILE_Y*BLOCK_SIZE*8)

#define IMG_ACROSS         (IMAGE_WIDTH /(BLOCK_SIZE*NUM_TILE_X))
#define IMG_DOWN           (IMAGE_HEIGHT/(BLOCK_SIZE*NUM_TILE_Y))

#define DCT_SIZE     (BLOCK_SIZE*BLOCK_SIZE)
#define NUM_BLOCKS   ((IMAGE_WIDTH/BLOCK_SIZE)*(IMAGE_HEIGHT/BLOCK_SIZE))

// ---------------------------------------------------------------


//the following is to make data type change easier.
typedef short dt;

#define nDEBUG                 /*change to DEBUG to print input and output matrices */
#define MAX_RAND_NUMBER 150     //input range is -MAX_RAND_NUMBER ~ MAX_RAND_NUMBER
#define PI 3.14159265358979323846
#define SHIFT_DOUBLE 128.0
#define SHIFT_AMOUNT 7
#define F_OFFSET ((dt)(0.499999*SHIFT_DOUBLE))
#define DMA 0
#define DMA2 0
#define ACCUMULATE 0

// -------------------------------------------------------------------

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <sys/time.h>

#include "io.h"
#include "system.h"

#include "vbx.h"
#include "vbx_port.h"
#include "vbx_test.h"

// -------------------------------------------------------------------


static void GenerateSetImage( dt *image, int width, int height);
static void GenerateRandomImage( dt *image, int width, int height, int seed );


static dt     cs[BLOCK_SIZE][BLOCK_SIZE];
static double c2[BLOCK_SIZE][BLOCK_SIZE];


int test_tile()
{
	int i, j, k, l, base, block_num;
	int x, y;


	int time_start, time_stop;
	unsigned int cycles;
	double vbx_time, scalar_time;
	int wrong;

	int total_errors = 0;

	//all of the initialization can be hard coded without any computation
	vbx_mtx_fdct_t *v = vbx_mtx_fdct_init( coeff_v, image );
	vbx_timestamp_start();

	printf("\nGenerating initial data...\n");
	dt *image  = (dt *) vbx_shared_malloc( IMAGE_HEIGHT * IMAGE_WIDTH * sizeof(dt) );
	//GenerateSetImage( image, IMAGE_WIDTH, IMAGE_HEIGHT );
	GenerateRandomImage( image, IMAGE_WIDTH, IMAGE_HEIGHT, 3 );

	const int BIGTILE_SIZE = NUM_TILE_X * NUM_TILE_Y * DCT_SIZE;
	dt *block_s =                   malloc( IMAGE_HEIGHT * IMAGE_WIDTH * sizeof(dt) );
	dt *block_v = (dt *) vbx_shared_malloc( BIGTILE_SIZE * sizeof(dt) );
	dt *coeff_v = (dt *) vbx_shared_malloc( NUM_TILE_X * DCT_SIZE * sizeof(dt) );

	//Make an uncached 1D version of the coeff matrix
        for (j = 0; j < BLOCK_SIZE; j++) {         // row
		for (k = 0; k < NUM_TILE_X; k++) {     // col
		        for (l = 0; l < BLOCK_SIZE; l++) { // col
				coeff_v[ j*NUM_TILE_X*BLOCK_SIZE + k*BLOCK_SIZE + l] = cs[j][l];
			}
		}
	}

#ifdef DEBUG
	printf("\ninput image is:\n");
	for (i = 0; i < IMAGE_HEIGHT; i++) {
		base = i * IMAGE_WIDTH;
                for (j = 0; j < IMAGE_WIDTH; j++) {
			printf(" %4d", (int) image[base + j]);
		}
		printf("\n");
	}
	printf("\ncoeff matrix is:\n");
	for (i = 0; i < BLOCK_SIZE; i++) {
		for (k = 0; k < NUM_TILE_X; k++) {     // col
		        for (j = 0; j < BLOCK_SIZE; j++) {
			        printf(" %4d", (int) coeff_v[i*BLOCK_SIZE*NUM_TILE_X + k*BLOCK_SIZE + j]);
		        }
                }
		printf("\n");
	}

#endif
	printf("\nRunning Scalar DCT...\n");

	time_start = vbx_timestamp();
	for( y = 0; y < IMG_DOWN; y++ ) {
		for( x = 0; x < IMG_ACROSS; x++ ) {
			vbx_mtx_fdct_scalar( block_s, (dt*)cs, image, x/*start_x*/, y/*start_y*/, NUM_TILE_X, NUM_TILE_Y );
		}
	}
	time_stop = vbx_timestamp();

	cycles = time_stop - time_start;
	scalar_time = (double) cycles;
	scalar_time /= (double) vbx_timestamp_freq();
	scalar_time *= 1000.0;		//ms
	vbx_timestamp_t mxp_cycles = vbx_mxp_cycles(cycles);

	printf("%dx%d Block Size\n", BLOCK_SIZE, BLOCK_SIZE);
	printf("Finished, scalar CPU took %0.3f ms \n", scalar_time);
	printf(" CPU Cycles: %d\n", (int) mxp_cycles);
	printf(" CPU Cycles per block: %f\n", mxp_cycles / ((double) (NUM_BLOCKS)));

#ifdef DEBUG  
	printf("output matrix is:\n");
	for (i = 0; i < IMAGE_HEIGHT; i++) {
		base = i *IMAGE_WIDTH;
		for (j = 0; j < IMAGE_WIDTH; j++) {
			printf(" %4d", (int) block_s[base + j]);
		}
		printf("\n");
	}
#endif

	vbx_sync(); // wait for image to be prefetched in init()

#if 0
	printf("\ninput matrix is:\n");
	for (i = 0; i < NUM_TILE_Y*BLOCK_SIZE; i++) {
		base = i * NUM_TILE_X*BLOCK_SIZE;
		for (j = 0; j < NUM_TILE_X*BLOCK_SIZE; j++) {
			printf(" %3d", (int) vimage[db][base + j]);
		}
		printf("\n");
	}
	printf("\ncoeff matrix is:\n");
	for (i = 0; i < BLOCK_SIZE; i++) {
		for (k = 0; k < NUM_TILE_X; k++) {     // col
			for (j = 0; j < BLOCK_SIZE; j++) {
				printf(" %3d", (int) vcoeff[i*BLOCK_SIZE*NUM_TILE_X + k*BLOCK_SIZE + j]);
			}
		}
		printf("\n");
	}
#endif
        
	printf("\nRunning Vector DCT...\n");

	time_start = vbx_timestamp();
	for( y = 0; y < IMG_DOWN; y++ ) {
		for( x = 0; x < IMG_ACROSS; x++ ) {
			vbx_mtx_fdct( v, block_v, image, x/*start_x*/, y/*start_y*/, IMG_ACROSS-1,IMG_DOWN-1,NUM_TILE_X, NUM_TILE_Y );
		}
	}
	time_stop = vbx_timestamp();

	cycles = time_stop - time_start;
	vbx_time = (double) cycles;
	vbx_time /= (double) vbx_timestamp_freq();
	vbx_time *= 1000.0;			//ms
	mxp_cycles = vbx_mxp_cycles(cycles);

	printf("Finished, MXP took %0.3f ms \n", vbx_time);
	printf(" CPU Cycles: %d\n", (int) mxp_cycles);
	printf(" CPU Cycles per block: %f\n", mxp_cycles / ((double) (NUM_BLOCKS)));
	printf(" Speedup: %f\n", scalar_time / vbx_time);

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	double vbx_mbps = (double) (NUM_BLOCKS) * 1000 / vbx_time;	// blocks per second
	printf("V%d@%dMHz: %dx%d tile, %dx%d blocks, %f blocks/s, %f megapixel/s\n",
	       this_mxp->vector_lanes, this_mxp->core_freq / 1000000, 
	       NUM_TILE_Y, NUM_TILE_X, 
	       BLOCK_SIZE, BLOCK_SIZE,
	       vbx_mbps, (vbx_mbps * DCT_SIZE) / 1000000);

#if 0
	printf("\nChecking results...\n");


	wrong = 0;
	for (block_num = 0; block_num < NUM_BLOCKS; block_num++) {
		for (i = 0; i < BLOCK_SIZE; i++) {
			base = i * BLOCK_SIZE;
			for (j = 0; j < BLOCK_SIZE; j++) {
				if (block_s[block_num * DCT_SIZE + base + j] != block_v[block_num * DCT_SIZE + base + j]) {
					if (wrong < 5) {
						printf("\nError at %d [%d,%d], result is %d, should be %d\n",
							   block_num, i, j, (int) block_v[block_num * DCT_SIZE + base + j],
							   (int) block_s[block_num * DCT_SIZE + base + j]);
					}
					wrong++;
				}
			}
		}
	}

	printf("%d wrong\n\n", wrong);
	total_errors += wrong;
#endif
	free(block_s);
	vbx_shared_free(block_v);
	vbx_shared_free(coeff_v);
	vbx_shared_free(image);

	vbx_mtx_fdct_free( v );

	VBX_TEST_END(total_errors);

	return (0);
}

int main_tile()
{
	int i, j, k, l, base, block_num;
	int x, y;

	int time_start, time_stop;
	unsigned int cycles;
	double vbx_time, scalar_time;
	int wrong;

	int total_errors = 0;

	//all of the initialization can be hard coded without any computation
	vbx_mtx_fdct_t *v = vbx_mtx_fdct_init( coeff_v, image );
	vbx_timestamp_start();

	printf("\nGenerating initial data...\n");

	dt *image  = (dt *) malloc( IMAGE_WIDTH * IMAGE_HEIGHT * sizeof(dt) );
	GenerateRandomImage( image, IMAGE_WIDTH, IMAGE_HEIGHT, 0/*seed*/ );

	// Allocate memory to store results.
	// Results are computed BIGTILE_SIZE halfwords at a time.
	const int BIGTILE_SIZE = NUM_TILE_X * NUM_TILE_Y * DCT_SIZE;
	dt *block_s =                   malloc( BIGTILE_SIZE * sizeof(dt) );
	dt *block_v = (dt *) vbx_shared_malloc( BIGTILE_SIZE * sizeof(dt) );
	dt *coeff_v = (dt *) vbx_shared_malloc( BIGTILE_SIZE * sizeof(dt) );

	//Make an uncached 1D version of the coeff matrix
	for (i = 0; i < NUM_TILE_Y; i++) {             // row
		for (j = 0; j < BLOCK_SIZE; j++) {         // row
			for (k = 0; k < NUM_TILE_X; k++) {     // col
				for (l = 0; l < BLOCK_SIZE; l++) { // col
					coeff_v[i*NUM_TILE_X*DCT_SIZE + j*DCT_SIZE + k*BLOCK_SIZE + l] = cs[j][l];
				}
			}
		}
	}

#ifdef DEBUG
	printf("input matrix is:\n");
	for (i = 0; i < BLOCK_SIZE; i++) {
		base = i * BLOCK_SIZE;
		for (j = 0; j < BLOCK_SIZE; j++) {
			printf("%d ", (int) block_s[base + j]);
		}
		printf("\n");
	}
#endif

	printf("\nRunning DCT...\n");

	time_start = vbx_timestamp();
	for( y = 0; y < IMG_DOWN; y++ ) {
		for( x = 0; x < IMG_ACROSS; x++ ) {
			vbx_mtx_fdct_scalar( block_s, (dt*)cs, image, x/*start_x*/, y/*start_y*/, NUM_TILE_X, NUM_TILE_Y );
		}
	}
	time_stop = vbx_timestamp();

	cycles = time_stop - time_start;
	scalar_time = (double) cycles;
	scalar_time /= (double) vbx_timestamp_freq();
	scalar_time *= 1000.0;		//ms
	vbx_timestamp_t mxp_cycles = vbx_mxp_cycles(cycles);

	printf("%dx%d Block Size\n", BLOCK_SIZE, BLOCK_SIZE);
	printf("Finished, scalar CPU took %0.3f ms \n", scalar_time);
	printf(" CPU Cycles: %d\n", (int) mxp_cycles);
	printf(" CPU Cycles per block: %f\n", mxp_cycles / ((double) (NUM_BLOCKS)));

	vbx_sync(); // wait for image to be prefetched

	time_start = vbx_timestamp();
	for( y = 0; y < IMG_DOWN; y++ ) {
		for( x = 0; x < IMG_ACROSS; x++ ) {
			vbx_mtx_fdct( v, block_v, image, x/*start_x*/, y/*start_y*/, IMG_ACROSS-1,IMG_DOWN-1,NUM_TILE_X, NUM_TILE_Y );
		}
	}
	time_stop = vbx_timestamp();

	cycles = time_stop - time_start;
	vbx_time = (double) cycles;
	vbx_time /= (double) vbx_timestamp_freq();
	vbx_time *= 1000.0;			//ms
	mxp_cycles = vbx_mxp_cycles(cycles);

	printf("Finished, MXP took %0.3f ms \n", vbx_time);
	printf(" CPU Cycles: %d\n", (int) mxp_cycles);
	printf(" CPU Cycles per block: %f\n", mxp_cycles / ((double) (NUM_BLOCKS)));
	printf(" Speedup: %f\n", scalar_time / vbx_time);

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	double vbx_mbps = (double) (NUM_BLOCKS) * 1000 / vbx_time;	// blocks per second
	printf("V%d@%dMHz: %dx%d tile, %dx%d blocks, %f blocks/s, %f megapixel/s\n",
	       this_mxp->vector_lanes, this_mxp->core_freq / 1000000, 
	       NUM_TILE_Y, NUM_TILE_X, 
	       BLOCK_SIZE, BLOCK_SIZE,
	       vbx_mbps, (vbx_mbps * DCT_SIZE) / 1000000);

	printf("\nChecking results...\n");

	wrong = 0;
	for (block_num = 0; block_num < NUM_BLOCKS; block_num++) {
		for (i = 0; i < BLOCK_SIZE; i++) {
			base = i * BLOCK_SIZE;
			for (j = 0; j < BLOCK_SIZE; j++) {
				if (block_s[block_num * DCT_SIZE + base + j] != block_v[block_num * DCT_SIZE + base + j]) {
					if (wrong < 5) {
						printf("\nError at %d [%d,%d], result is %d, should be %d\n",
							   block_num, i, j, (int) block_v[block_num * DCT_SIZE + base + j],
							   (int) block_s[block_num * DCT_SIZE + base + j]);
					}
					wrong++;
				}
			}
		}
	}

	printf("wrong is %d\n\n", wrong);
	total_errors += wrong;

	free(block_s);
	vbx_shared_free(block_v);
	vbx_shared_free(coeff_v);

	vbx_mtx_fdct_free( v );

	VBX_TEST_END(total_errors);

	return (0);
}



void fdct_scalar( dt *block_s, dt *coeff_s, dt *image, int start_x, int start_y, int num_tile_x, int num_tile_y )
{
	int i, j, k;
	int x, y;
	dt s;
	dt tmp[DCT_SIZE];

	start_x *= NUM_TILE_X;
	start_y *= NUM_TILE_Y;

	for (y = 0; y < num_tile_y; y++) {
		for (x = 0; x < num_tile_x; x++) {
			for (i = 0; i < BLOCK_SIZE; i++) {
				for (j = 0; j < BLOCK_SIZE; j++) {
					s = 0;
					for (k = 0; k < BLOCK_SIZE; k++) {
						int imgcol = k + (x+start_x)*BLOCK_SIZE;
						int imgrow = i + (y+start_y)*BLOCK_SIZE;
						s += coeff_s[j*BLOCK_SIZE+k] * image[ imgrow * IMAGE_WIDTH + imgcol ];
					}
					tmp[BLOCK_SIZE * i + j] = (s) >> SHIFT_AMOUNT;
				}
			}
			for (i = 0; i < BLOCK_SIZE; i++) {
				for (j = 0; j < BLOCK_SIZE; j++) {
					s = 0;
					for (k = 0; k < BLOCK_SIZE; k++) {
						s += cs[i][k] * tmp[BLOCK_SIZE * k + j];
					}
					int blkcol = j + (x+start_x)*BLOCK_SIZE;
					int blkrow = i + (y+start_y)*BLOCK_SIZE;
					block_s[ blkrow * IMAGE_WIDTH + blkcol ] = (s) >> SHIFT_AMOUNT;
				}
			}
		}
	}
}


#define getBigTileImageY(vimage,image,row) \
	VBX_S{ \
		int y; \
		dt         * src = image  + row*IMAGE_WIDTH; \
		vbx_half_t *vdst = vimage + row*BLOCK_SIZE*NUM_TILE_X; \
		for(y=0;y<NUM_TILE_Y;y++)vbx_dma_to_vector( vdst + y*DCT_SIZE*NUM_TILE_X, src + y*IMAGE_WIDTH*BLOCK_SIZE, NUM_TILE_X*BLOCK_SIZE*sizeof(dt) ); \
	}VBX_E

#define getBigTileImage(vimage,image,row) \
	VBX_S{ \
		dt         * src = image  + row*IMAGE_WIDTH; \
		vbx_half_t *vdst = vimage + row*BLOCK_SIZE*NUM_TILE_X; \
		vbx_dma_to_vector( vdst, src, NUM_TILE_X*BLOCK_SIZE*sizeof(dt) ); \
	}VBX_E



void vbx_mtx_fdct_free( vbx_mtx_fdct_free *v )
{
	vbx_shared_free( v );
	vbx_sp_pop();
	//vbx_sync();  // don't wait for result to be written; let it run in the background
	vbx_sync();  // wait for all results?
}




vbx_mtx_fdct_t *
vbx_mtx_fdct_init( dt *coeff_v, dt *image )
{
	const int BIG_TILE_SIZE = NUM_TILE_X * NUM_TILE_Y * DCT_SIZE;
	const int num_bytes = BIG_TILE_SIZE * sizeof(dt);
	const int co_bytes = NUM_TILE_X* DCT_SIZE *sizeof(dt);

	//compute coeffs matrix in double and truncated to dt
	int i, j;
	double s;
	for (i = 0; i < BLOCK_SIZE; i++) {
		s = (i == 0) ? sqrt(0.125) : 0.5;
		for (j = 0; j < BLOCK_SIZE; j++) {
			c2[i][j] = s * cos((double) ((PI / 8.0) * i * j + 0.5));
			cs[i][j] = (dt) (c2[i][j] * SHIFT_DOUBLE + 0.499999);
		}
	}

	vbx_sp_push();

	vbx_mtx_fdct_t *v = vbx_shared_malloc( sizeof(vbx_mtx_fct_t) );

	v->vcoeff    = (vbx_half_t *)vbx_sp_malloc( co_bytes );
	v->vprods    = (vbx_half_t *)vbx_sp_malloc( num_bytes );
#if USE_ACCUM_FLAGS
	v->vaccum    = (vbx_half_t *)vbx_sp_malloc( num_bytes );
	v->vflags    = (vbx_half_t *)vbx_sp_malloc( num_bytes );
#endif

	// interleave ordering to ensure no false hazards
	v->vblock[2] = (vbx_half_t *)vbx_sp_malloc( num_bytes );

	v->vimage[0] = (vbx_half_t *)vbx_sp_malloc( num_bytes );
	v->vblock[0] = (vbx_half_t *)vbx_sp_malloc( num_bytes );
	v->vimage[1] = (vbx_half_t *)vbx_sp_malloc( num_bytes );
	v->vblock[1] = (vbx_half_t *)vbx_sp_malloc( num_bytes );
	if( !v->vblock[1] ) {
		VBX_PRINTF( "ERROR: out of memory.\n" );
		VBX_EXIT(-1);
	}
	vbx_dma_to_vector( v->vcoeff, coeff_v, co_bytes );

	int row;
	for( row=0; row < BLOCK_SIZE; row++ ) {
		getBigTileImageY(v->vimage[v->db],image,row);
	}
#if USE_ACCUM_FLAGS 
	// create a flag vector first element 0, next 'BLOCK_SIZE-1' element non-zero, etc
	vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE - (BLOCK_SIZE-1) );
	vbx( SEH, VAND,   v->vflags,       BLOCK_SIZE-1,      0 );
#endif

	return v;
}

// FDCT vector processing pipeline goes like this:
//
// inimage    -> vimageDMA (background)
// vblockDMA  -> outimage  (background)
//
// sequential { vimageVPU  -> vblockTMP, vblockTMP  -> vblockVPU, vblockVPU  -> outimage, swap VPU/DMA buffers }
//
// can get additional speedup by:
//     using one MXP for vimageVPU => vblockTMP, second MXP for vblockTMP => vblockVPU
//     note: adding second MXP above requires double-buffering of vblockTMP
//     if DMA is limiting speed, separate r/w DMA channels to operate full duplex (eg, 2 DRAM controllers)

void vbx_mtx_fdct( vbx_mtx_fdct_t *v, dt *block_v, dt *image,
	int start_x, int start_y, int end_x, int end_y,int num_tile_x, int num_tile_y )
{
//	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
//	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;
	const int BIG_TILE_SIZE = num_tile_x * num_tile_y * DCT_SIZE;

	int next_x=start_x+1;
	int next_y=start_y;
	int get_next=1;
	if( start_x == end_x   &&   start_y == end_y ) {
		get_next=0;
	}
	if( start_x == end_x ) {
		next_x = 0;
		next_y++;
	} 

	const vbx_half_t *vimageDMA = v->vimage[!v->db]; // dma
//	const vbx_half_t *vblockDMA = v->vblock[!v->db]; // dma // never used directly 

	const vbx_half_t *vimageVPU = v->vimage[ v->db]; // active
	const vbx_half_t *vblockVPU = v->vblock[ v->db]; // active

	const vbx_half_t *vblockTMP = v->vblock[ 2    ]; // temp

	const vbx_half_t *vcoeff    = v->vcoeff;
	const vbx_half_t *vprods    = v->vprods;
	const vbx_half_t *vaccum    = v->vaccum;
	const vbx_half_t *vflags    = v->vflags;

#if DMA
	// First, prefetch the next chunk of the next image for a future call to fdct_tile()
#if NUM_TILE_Y > 1
	if( get_next ) // get row 0
		getBigTileImageY( vimageDMA,
		        image+next_x*NUM_TILE_X*BLOCK_SIZE+next_y*IMAGE_WIDTH*NUM_TILE_Y*BLOCK_SIZE, 0 );
#else
	if( get_next ) // get row 0
		getBigTileImage( vimageDMA,
		        image+next_x*NUM_TILE_X*BLOCK_SIZE+next_y*IMAGE_WIDTH*NUM_TILE_Y*BLOCK_SIZE, 0 );
#endif
#endif

	int r;
	for( r=0; r < BLOCK_SIZE; r++ ) {
		// perform multiply of the whole BIG_TILE with row 'r' of the image matrix -- before had dct matrix switching
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE );                                                                                              // for the length of tiled rows
		vbx_set_2D( BLOCK_SIZE, NUM_TILE_X*BLOCK_SIZE*sizeof(dt),                                    0, NUM_TILE_X*BLOCK_SIZE*sizeof(dt) ); // for all rows of tiled coeffiencents
		vbx_set_3D( NUM_TILE_Y, NUM_TILE_X * DCT_SIZE*sizeof(dt),     NUM_TILE_X * DCT_SIZE*sizeof(dt),                               0  ); // for all groups Y
		vbx_3D( VVH, VMUL,                                vprods, vimageVPU + r*NUM_TILE_X*BLOCK_SIZE,                            vcoeff); // for all 'columns' of tiled data

#if ACCUMULATE
		// accumulate the multiply operations
#if 0 & USE_ACCUM_FLAGS 
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE - (BLOCK_SIZE-1) );
		vbx( VVH, VADD, vaccum, vprods+0, vprods+1 );
		vbx_set_2D( BLOCK_SIZE-2, 0, 0, sizeof(dt) );
		vbx_2D( VVH, VADD, vaccum, vaccum, vprods+2 );
		vbx( VVH, VCMV_Z, vblockTMP+r, vaccum, vflags );
#elif BLOCK4
                //case DCT 4
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE - (BLOCK_SIZE-1) );
		vbx( VVH, VADD, vaccum, vprods, vprods+1 );
		vbx( VVH, VADD, vaccum, vaccum, vprods+2 );
		vbx( VVH, VADD, vaccum, vaccum, vprods+3 );
		vbx( VVH, VCMV_Z, vblockTMP+r, vaccum, vflags );
#else
                //correct?
		vbx_set_vl( BLOCK_SIZE );
		vbx_set_2D( BLOCK_SIZE,   NUM_TILE_X*BLOCK_SIZE*sizeof(dt), NUM_TILE_X*BLOCK_SIZE*sizeof(dt), NUM_TILE_X*BLOCK_SIZE*sizeof(dt) );
		vbx_set_3D( NUM_TILE_X,   BLOCK_SIZE*sizeof(dt),            BLOCK_SIZE*sizeof(dt),            BLOCK_SIZE*sizeof(dt) );
#if NUM_TILE_Y == 1
		vbx_acc_3D( VVH, VOR,   vblockTMP + r,      vprods ,  vprods );
#else
		int y; 
		for (y=0; y< NUM_TILE_Y; y++){
			vbx_acc_3D( VVH, VOR,   vblockTMP + r + y*NUM_TILE_X*DCT_SIZE,      vprods+ y*NUM_TILE_X*DCT_SIZE,  vprods+ y*NUM_TILE_X*DCT_SIZE );
		}
#endif
#endif
#endif

#if 0
// dont do DMA READS here yet. a DMA WRITE may still be in progress, give it chance to finish
#if DMA
		// every other iteration, prefetch the next row of the next image
		// NB: with 2D DMA, we could issue this as a single DMA request at the top of the file
		// instead, we must intersperse these 1D DMA strips to ensure they don't block the instruction queue
#if NUM_TILE_Y > 1
		if( !(r&1) && get_next )
			getBigTileImageY( vimageDMA,
			                  image+next_x*NUM_TILE_X*BLOCK_SIZE+next_y*IMAGE_WIDTH*NUM_TILE_Y*BLOCK_SIZE,
			                  (1+((r-1)>>1)) ); //BLOCK_SIZE/2 rows added
#else
		if( !(r&1) && get_next )
			getBigTileImage( vimageDMA,
			                 image+next_x*NUM_TILE_X*BLOCK_SIZE+next_y*IMAGE_WIDTH*NUM_TILE_Y*BLOCK_SIZE,
			                 (1+((r-1)>>1)) ); //BLOCK_SIZE/2 rows added
#endif
#endif
#endif
	}

	vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE );
	vbx( SVH, VSHR, vblockTMP, SHIFT_AMOUNT, vblockTMP );

	// now do the transposed version

	for( r=0; r < BLOCK_SIZE; r++ ) {
		// perform multiply of the whole BIG_TILE with row 'r' of the image matrix -- before had dct matrix switching
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE );                                                                                              // for the length of tiled rows
		vbx_set_2D( BLOCK_SIZE, NUM_TILE_X * BLOCK_SIZE*sizeof(dt),     NUM_TILE_X * BLOCK_SIZE*sizeof(dt),                            0 ); // for all 'columns' of tiled data 
		vbx_set_3D( NUM_TILE_Y, NUM_TILE_X * DCT_SIZE*sizeof(dt),       NUM_TILE_X * DCT_SIZE*sizeof(dt),                              0 ); // for all groups Y
		vbx_3D( VVH, VMUL,                             vprods,                        vblockTMP,  vcoeff + r*NUM_TILE_X*BLOCK_SIZE); // for all rows of tiled coeffients 

#if ACCUMULATE
		// accumulate the multiply operations
#if 0 & USE_ACCUM_FLAGS
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE - (BLOCK_SIZE-1) );
		vbx( VVH, VADD, vaccum, vprods+0, vprods+1 );
		vbx_set_2D( BLOCK_SIZE-2, 0, 0, sizeof(dt) );
		vbx_2D( VVH, VADD, vaccum, vaccum, vprods+2 );
		vbx( VVH, VCMV_Z, vblockVPU+r, vaccum,   vflags );

#elif BLOCK4
		//case DCT 4
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE - (BLOCK_SIZE-1) );
		vbx( VVH, VADD, vaccum, vprods, vprods+1 );
		vbx( VVH, VADD, vaccum, vaccum, vprods+2 );
		vbx( VVH, VADD, vaccum, vaccum, vprods+3 );
		//vbx( VVH, VCMV_Z, vblockVPU+r, vaccum, vflags );
		vbx_set_vl( NUM_TILE_X * BLOCK_SIZE - (BLOCK_SIZE-1) );                    // for the length of a tiled row
		vbx_set_2D( BLOCK_SIZE, 1*sizeof(dt), NUM_TILE_X*BLOCK_SIZE*sizeof(dt), 0);// for all tiled rows 
#if NUM_TILE_Y == 1
		vbx_2D(VVH, VCMV_Z, vblockVPU+r*NUM_TILE_X*BLOCK_SIZE, vaccum, vflags  );  // 
#else
		int y;
		for (y=0; y< NUM_TILE_Y; y++){
			vbx_2D(VVH, VCMV_Z, vblockVPU+r*NUM_TILE_X*BLOCK_SIZE + y*NUM_TILE_X*DCT_SIZE , vaccum+y*NUM_TILE_X*DCT_SIZE, vflags  );  // 
		}
#endif
#else
		//correct?
		vbx_set_vl( BLOCK_SIZE );                                                                                              // for the length of a row
		vbx_set_2D( BLOCK_SIZE,   sizeof(dt), NUM_TILE_X*BLOCK_SIZE*sizeof(dt), NUM_TILE_X*BLOCK_SIZE*sizeof(dt) );            // for all rows in that block
		vbx_set_3D( NUM_TILE_X,   BLOCK_SIZE*sizeof(dt),            BLOCK_SIZE*sizeof(dt),            BLOCK_SIZE*sizeof(dt) ); // for all tiled blocks horizontally(x)
#if NUM_TILE_Y == 1
		vbx_acc_3D( VVH, VOR,   vblockVPU + r*NUM_TILE_X*BLOCK_SIZE ,    vprods ,  vprods );
#else
		int y;
		for (y=0; y< NUM_TILE_Y; y++){ 
			vbx_acc_3D( VVH, VOR,   vblockVPU + r*NUM_TILE_X*BLOCK_SIZE + y*NUM_TILE_X*DCT_SIZE,      vprods+ y*NUM_TILE_X*DCT_SIZE,  vprods+ y*NUM_TILE_X*DCT_SIZE );
		}
#endif
#endif
#endif

#if DMA
		// every other iteration, prefetch the next row of the next image
		// NB: with 2D DMA, we could issue this as a single DMA request at the top of the file
		// instead, we must intersperse these 1D DMA strips to ensure they don't block the instruction queue
#if NUM_TILE_Y > 1
		//if( !(r&1) && r<(BLOCK_SIZE-1)  && get_next )
		if( get_next )
			getBigTileImageY( 
			                  vimageDMA,
			                  image+next_x*NUM_TILE_X*BLOCK_SIZE+next_y*IMAGE_WIDTH*NUM_TILE_Y*BLOCK_SIZE,
			                  r );
			                  //(BLOCK_SIZE/2 +1+((r-1)>>1)) ); // BLOCK/2 -1 rows
#else
		//if( !(r&1) && r<(BLOCK_SIZE-1)  && get_next )
		if( get_next )
			getBigTileImage( vimageDMA,
			                 image+next_x*NUM_TILE_X*BLOCK_SIZE+next_y*IMAGE_WIDTH*NUM_TILE_Y*BLOCK_SIZE,
			                 r );
			                 //(BLOCK_SIZE/2 +1+((r-1)>>1)) ); // BLOCK/2 -1 rows
#endif
#endif
	}

	vbx_set_vl( NUM_TILE_X * BLOCK_SIZE * NUM_TILE_Y * BLOCK_SIZE );
	vbx( SVH, VSHR, vblockVPU, SHIFT_AMOUNT, vblockVPU );
#if DMA2
	// Write result back to memory as one big block
	vbx_dma_to_host( block_v, vblockVPU, BIG_TILE_SIZE*sizeof(dt) );
#endif 

	v->db = !v->db;
#ifdef DEBUG 
	{
		vbx_sync();
		int i,j;
		printf("%d\n", !db);
		for(i=0;i<BLOCK_SIZE*NUM_TILE_Y;i++){
			for(j=0;j<BLOCK_SIZE*NUM_TILE_X;j++){
				printf(" %4d", block_v[i*BLOCK_SIZE*NUM_TILE_X+j]);
			}
			printf("\n");
		}
	}
#endif
}





static void GenerateRandomImage( dt *image, int width, int height, int seed )
{
	/*generate random input matrix   */
	int i, j;
	srand(seed);
	for (i = 0; i < height; i++) {
		dt salt = (dt) (rand() % MAX_RAND_NUMBER - rand() % MAX_RAND_NUMBER);
		for (j = 0; j < width; j++) {
			if( i==0 ) {
				// first row is entirely random. this is slow due to rand() and mmodulo.
				image[ i*width + j] = (dt) (rand() % MAX_RAND_NUMBER - rand() % MAX_RAND_NUMBER);
			} else {
				// to speed up image generation,
				// successive rows are xor of previous row with a new random value
				image[ i*width + j] = salt ^ image[ (i-1)*width + j ];
			}

		}
	}
}

static void GenerateSetImage( dt *image, int width, int height )
{
	/*generate set input matrix   */
	int i, j;
	for (i = 0; i < height; i++) {
		for (j = 0; j < width; j++) {
			image[ i*width + j] = i*width+j;
		}
	}
}
