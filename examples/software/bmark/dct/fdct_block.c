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
VBXCOPYRIGHT(test_fdct_block)

// -------------------------------------------------------------------

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <sys/time.h>

#include "vbx.h"
#include "vbx_port.h"
#include "vbx_test.h"

/*  VBX DCT */

#define BLOCK_SIZE       4
#define DCT_SIZE         (BLOCK_SIZE*BLOCK_SIZE)
#define NUMBER_OF_BLOCKS (1920*1088)/(DCT_SIZE)
//the following is to make data type change easier.
//typedef short dt;
typedef vbx_half_t dt;

#define nDEBUG					/*change to DEBUG to print input and output matrices */
#define MAX_RAND_NUMBER 150		//input range is -MAX_RAND_NUMBER ~ MAX_RAND_NUMBER
#define PI 3.14159265358979323846
#define SHIFT_DOUBLE 128.0
#define SHIFT_AMOUNT 7
#define F_OFFSET ((dt)(0.499999*SHIFT_DOUBLE))

#ifdef USE_MP
//MP STUFF//

#include "io.h"
#include "system.h"
#ifdef FIFO_0_TO_1_BASE
#define USE_MP
#endif

volatile int dcf_dummy = 0;
int my_dcache_flush()
{
	int return_val = 0;
	int *somewhere = (int *) &my_dcache_flush;
	int i;

	for (i = 0; i < (ALT_CPU_DCACHE_SIZE / sizeof(int)); i += (ALT_CPU_DCACHE_LINE_SIZE / sizeof(int))) {
		return_val += somewhere[i];
	}

	dcf_dummy += return_val;
	return return_val;
}

#include "nios2.h"
#define NUM_PROCS 4

#define FIFO_SND(DATA) IOWR(FIFO_0_TO_1_BASE, 0, (int)DATA)
#define FIFO_RCV()  IORD(FIFO_1_TO_0_BASE, 0)
#define MASTER_FIFO_SND(PNUM,DATA) IOWR(FIFO_0_TO_1_BASE+(0x40*(PNUM-1)), 0, (int)DATA)
#define MASTER_FIFO_RCV(PNUM)  IORD(FIFO_1_TO_0_BASE+(0x40*(PNUM-1)), 0)
//END MP STUFF//
#endif //USE_MP



void GenerateRandomMatrix(int size, int seed, dt *Matrix);


static void init_fdct(void);
void fdct_scalar(dt *block_s, int start, int end);
void fdct_vbx(dt *block_v, dt *cin, int start, int end);


static dt      c[BLOCK_SIZE][BLOCK_SIZE];
static double c2[BLOCK_SIZE][BLOCK_SIZE];


int main_block()
{
	int i, j, base, block_num;

	dt *block_s;
	dt *block_v;
#ifdef USE_MP
	dt *block_m;
#endif
	dt *cin;

	vbx_timestamp_t time_start, time_stop;
	double vbx_time, scalar_time;
	int errors;

	int total_errors = 0;

	printf("Block DCT\n");
	printf("\n%dx%d Block Size\n", BLOCK_SIZE, BLOCK_SIZE);

	//this can be hard coded without any computation
	init_fdct();

#ifdef USE_MP
	int cpuid, cpu_num;
	NIOS2_READ_CPUID(cpuid);

	if (cpuid >= NUM_PROCS)
		return 0;

	if (!cpuid) {
		for (cpu_num = 1; cpu_num < NUM_PROCS; cpu_num++) {
			MASTER_FIFO_RCV(cpu_num);
			MASTER_FIFO_SND(cpu_num, cpuid);
		}
	} else {
		FIFO_SND(cpuid);
		FIFO_RCV();
		block_m = (dt *) FIFO_RCV();
		fdct_scalar(block_m, ((NUMBER_OF_BLOCKS / NUM_PROCS) * cpuid), ((NUMBER_OF_BLOCKS / NUM_PROCS) * (cpuid + 1)));
		my_dcache_flush();
		FIFO_SND(cpuid);

		block_v = (dt *) FIFO_RCV();
		cin = (dt *) FIFO_RCV();
		fdct_vbx(block_v, cin, ((NUMBER_OF_BLOCKS / NUM_PROCS) * cpuid),
				 ((NUMBER_OF_BLOCKS / NUM_PROCS) * (cpuid + 1)));
		FIFO_SND(cpuid);

		return 0;
	}
#endif //USE_MP

	block_s = malloc(NUMBER_OF_BLOCKS * DCT_SIZE * sizeof(dt));
	block_v = vbx_shared_malloc(NUMBER_OF_BLOCKS * DCT_SIZE * sizeof(dt));
	cin = (dt *) vbx_shared_malloc(DCT_SIZE * sizeof(dt));
#ifdef USE_MP
	block_m = malloc(NUMBER_OF_BLOCKS * DCT_SIZE * sizeof(dt));
#endif

	for (block_num = 0; block_num < NUMBER_OF_BLOCKS; block_num++) {
		GenerateRandomMatrix(BLOCK_SIZE, block_num + 1, block_s + block_num * DCT_SIZE);
		GenerateRandomMatrix(BLOCK_SIZE, block_num + 1, block_v + block_num * DCT_SIZE);
#ifdef USE_MP
		GenerateRandomMatrix(BLOCK_SIZE, block_num + 1, block_m + block_num * DCT_SIZE);
#endif
	}

	//Make an uncached 1D version of the c matrix
	for (i = 0; i < BLOCK_SIZE; i++) {
		for (j = 0; j < BLOCK_SIZE; j++) {
			cin[i * BLOCK_SIZE + j] = c[i][j];
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

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	fdct_scalar(block_s, 0, NUMBER_OF_BLOCKS);
	time_stop = vbx_timestamp();

	scalar_time = vbx_print_scalar_time_per(time_start,
	                                        time_stop,
	                                        (double) (NUMBER_OF_BLOCKS),
	                                        "block");

	vbx_timestamp_start();
	time_start = vbx_timestamp();
	fdct_vbx(block_v, cin, 0, NUMBER_OF_BLOCKS);
	time_stop = vbx_timestamp();

	vbx_time = vbx_print_vector_time_per(time_start,
	                                     time_stop,
	                                     (double) (NUMBER_OF_BLOCKS),
	                                     "block",
	                                     scalar_time);

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	double vbx_mbps = (double) (NUMBER_OF_BLOCKS) / vbx_time;	// blocks per second
	printf("V%d@%dMHz: %f blocks/s, %f megapixel/s\n",
	       this_mxp->vector_lanes, this_mxp->core_freq / 1000000,
	       vbx_mbps, (vbx_mbps * DCT_SIZE) / 1000000);

	printf("\nchecking results...\n");

	errors = 0;
	int correct = 0;
	for (block_num = 0; block_num < NUMBER_OF_BLOCKS; block_num++) {
		for (i = 0; i < BLOCK_SIZE; i++) {
			base = i * BLOCK_SIZE;
			for (j = 0; j < BLOCK_SIZE; j++) {
				if (block_s[block_num * DCT_SIZE + base + j] != block_v[block_num * DCT_SIZE + base + j]) {
					if (errors < 5) {
						printf("\nError at %d [%d,%d], result is %d, should be %d\n",
							   block_num, i, j, (int) block_v[block_num * DCT_SIZE + base + j],
							   (int) block_s[block_num * DCT_SIZE + base + j]);
					}
					errors++;
				} else
					correct++;
			}
		}
	}

	printf("%d errors\n\n", errors);
	printf("%d correct\n\n", correct);
	total_errors += errors;

#ifdef USE_MP

	vbx_timestamp_start();
	time_start = vbx_timestamp();

	for (cpu_num = 1; cpu_num < NUM_PROCS; cpu_num++) {
		MASTER_FIFO_SND(cpu_num, block_m);
	}
	fdct_scalar(block_m, 0, NUMBER_OF_BLOCKS / NUM_PROCS);
	for (cpu_num = 1; cpu_num < NUM_PROCS; cpu_num++) {
		MASTER_FIFO_RCV(cpu_num);
	}

	time_stop = vbx_timestamp();

	print("Finished MP.");
	double scalar_mp_time = \
		vbx_print_scalar_time_per(time_start,
		                          time_stop,
		                          (double) (NUMBER_OF_BLOCKS),
		                          "block");

	printf("checking results...\n");

	errors = 0;
	for (block_num = 0; block_num < NUMBER_OF_BLOCKS; block_num++) {
		for (i = 0; i < BLOCK_SIZE; i++) {
			base = i * BLOCK_SIZE;
			for (j = 0; j < BLOCK_SIZE; j++) {
				if (block_s[block_num * DCT_SIZE + base + j] != block_m[block_num * DCT_SIZE + base + j]) {
					if (errors < 5) {
						printf("\nError at %d [%d,%d], result is %d, should be %d\n",
							   block_num, i, j, (int) block_m[block_num * DCT_SIZE + base + j],
							   (int) block_s[block_num * DCT_SIZE + base + j]);
					}
					errors++;
				}
			}
		}
	}

	printf("%d errors\n\n", errors);
	total_errors += errors;

	//Reset vbx matrix
	for (block_num = 0; block_num < NUMBER_OF_BLOCKS; block_num++) {
		GenerateRandomMatrix(BLOCK_SIZE, block_num + 1, block_v + block_num * DCT_SIZE);
	}

	vbx_timestamp_start();
	time_start = vbx_timestamp();

	for (cpu_num = 1; cpu_num < NUM_PROCS; cpu_num++) {
		MASTER_FIFO_SND(cpu_num, block_v);
		MASTER_FIFO_SND(cpu_num, cin);
	}
	fdct_vbx(block_v, cin, 0, NUMBER_OF_BLOCKS / NUM_PROCS);
	for (cpu_num = 1; cpu_num < NUM_PROCS; cpu_num++) {
		MASTER_FIFO_RCV(cpu_num);
	}

	time_stop = vbx_timestamp();

	printf("Finished VECTOR MP\n");

	double vector_mp_time = \
		vbx_print_vector_time_per(time_start,
		                          time_stop,
		                          (double) (NUMBER_OF_BLOCKS),
		                          "block",
		                          scalar_mp_time);

	printf("checking results...\n");

	errors = 0;
	for (block_num = 0; block_num < NUMBER_OF_BLOCKS; block_num++) {
		for (i = 0; i < BLOCK_SIZE; i++) {
			base = i * BLOCK_SIZE;
			for (j = 0; j < BLOCK_SIZE; j++) {
				if (block_s[block_num * DCT_SIZE + base + j] != block_v[block_num * DCT_SIZE + base + j]) {
					if (errors < 5) {
						printf("\nError at %d [%d,%d], result is %d, should be %d\n",
							   block_num, i, j, (int) block_v[block_num * DCT_SIZE + base + j],
							   (int) block_s[block_num * DCT_SIZE + base + j]);
					}
					errors++;
				}
			}
		}
	}

	printf("%d errors\n\n", errors);
	total_errors += errors;

#endif //USE MP

	free( (void*)block_s );
	vbx_shared_free( (void*)block_v );
	vbx_shared_free( (void*)cin );
#ifdef USE_MP
	free(block_m);
#endif

	return total_errors;
}


#if 0
// UNUSED CODE
int IsClose(dt a, dt b);
int IsClose(dt a, dt b)
{
	if (abs(a - b) <= 1)
		return 1;
	else
		return 0;
}
#endif


static void init_fdct()
{
	int i, j;
	double s;

	//compute coeffs matrix in double and truncated to dt
	for (i = 0; i < BLOCK_SIZE; i++) {
		s = (i == 0) ? sqrt(0.125) : 0.5;
		for (j = 0; j < BLOCK_SIZE; j++) {
			c2[i][j] = s * cos((double) ((PI / 8.0) * i * j + 0.5));
			c[i][j] = (dt) (c2[i][j] * SHIFT_DOUBLE + 0.499999);
#ifdef DEBUG
			printf("%0.2f[%0.4f,%d] ", c[i][j] / c2[i][j], c2[i][j], c[i][j]);
#endif
		}
#ifdef DEBUG
		printf("\n");
#endif

	}
}


void fdct_scalar(dt *block, int start, int end)
{
	int i, j, k, block_num;
	dt s;
	dt tmp[DCT_SIZE];
#ifdef DEBUG
	printf("scalar first pass\n");
#endif

	for (block_num = start; block_num < end; block_num++) {
		for (i = 0; i < BLOCK_SIZE; i++) {
			for (j = 0; j < BLOCK_SIZE; j++) {
				s = 0;
				for (k = 0; k < BLOCK_SIZE; k++) {
					s += c[j][k] * block[block_num * DCT_SIZE + BLOCK_SIZE * i + k];
				}
				tmp[BLOCK_SIZE * i + j] = (s) >> SHIFT_AMOUNT;
#ifdef DEBUG
				printf("%d ", (int) tmp[BLOCK_SIZE * i + j]);
#endif
			}
#ifdef DEBUG
			printf("\n");
#endif
		}

		for (j = 0; j < BLOCK_SIZE; j++) {
			for (i = 0; i < BLOCK_SIZE; i++) {
				s = 0;
				for (k = 0; k < BLOCK_SIZE; k++) {
					s += c[i][k] * tmp[BLOCK_SIZE * k + j];
				}
				block[block_num * DCT_SIZE + BLOCK_SIZE * i + j] = (s) >> SHIFT_AMOUNT;
				// block[block_num*DCT_SIZE+BLOCK_SIZE*i+j] = (s + F_OFFSET) >> SHIFT_AMOUNT;
			}
		}
	}
}


uint32_t alignDown( uint32_t i )
{
	// round down i to the nearest power-of-2 value
	i |= i >> 1;
	i |= i >> 2;
	i |= i >> 4;
	i |= i >> 8;
	i |= i >> 16;
	i -= i >> 1;
	return i;
}


void fdct_vbx(dt *block, dt *cin, int start, int end)
{
	int block_j, block_i;

	int par_blocks;

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	const int VBX_SCRATCHPAD_SIZE = this_mxp->scratchpad_size;

	par_blocks = (VBX_SCRATCHPAD_SIZE - (DCT_SIZE * sizeof(dt))) / (3 * DCT_SIZE * sizeof(dt));

	// round down to nearest power-of-2
	par_blocks = alignDown( par_blocks );

	int padding = (VBX_SCRATCHPAD_SIZE - ((par_blocks * 3 + 1) * DCT_SIZE * sizeof(dt))) >> 2;
#if BLOCK_SIZE == 4
  padding/=2;
#endif

	dt *v_dct_matrix = (dt *) vbx_sp_malloc(DCT_SIZE * sizeof(dt));
	vbx_sp_malloc(padding);
	dt *v_tmp_proc = (dt *) vbx_sp_malloc(par_blocks * DCT_SIZE * sizeof(dt));
	vbx_sp_malloc(padding);
	dt *v_block_proc = (dt *) vbx_sp_malloc(par_blocks * DCT_SIZE * sizeof(dt));
	vbx_sp_malloc(padding);
	dt *v_block_ret = (dt *) vbx_sp_malloc(par_blocks * DCT_SIZE * sizeof(dt));
	if (vbx_sp_malloc(padding) == NULL) {
		printf("Error in padding!\n");
		if (v_block_ret == NULL) {
			printf("Vector malloc failed, exiting\n");
			return;
		}
	}

	if(par_blocks > end-start){
		par_blocks = end-start;
	}

	dt *v_block_temp;

	vbx_dma_to_vector( v_dct_matrix, (void*)cin, DCT_SIZE * sizeof(dt) );

	//Transfer the first block
	vbx_dma_to_vector(v_block_proc, (void*)(block + DCT_SIZE * start), par_blocks * DCT_SIZE * sizeof(dt));

	//Process batches of size par_blocks
	for (block_j = start; block_j < end; block_j += par_blocks) {

		//Initialize vbx lengths and strides for first matrix multiply
		vbx_set_vl(BLOCK_SIZE);                                                      // for length of a row / 'column'
		vbx_set_2D(BLOCK_SIZE, BLOCK_SIZE * sizeof(dt), 0, BLOCK_SIZE * sizeof(dt)); // for all rows of coeffiecents
		vbx_set_3D(BLOCK_SIZE, 1 * sizeof(dt), BLOCK_SIZE * sizeof(dt), 0);          // for all 'columns' of data : in each row of data save result (row major)

		//If not the first batch, transfer the result of the previous
		//batch back to main memory
		if (block_j != start) {
			vbx_dma_to_host( (void*)(block + DCT_SIZE * (block_j - par_blocks)), v_block_ret, par_blocks * DCT_SIZE * sizeof(dt));
		}

		//Update par_blocks if we're at the end
		if(end - block_j <= par_blocks){
			par_blocks = end - block_j;
		}

		//Transfer next batch to scratchpad.  Note that since DMA
		//transfers are in order, this will happen only after the previous
		//batch results have finished transferring to main memory
		int next_transfer_length = par_blocks;
		if(end - block_j < par_blocks + next_transfer_length){
			next_transfer_length = (end - block_j) - par_blocks;
		}
		if (next_transfer_length > 0) {
			vbx_dma_to_vector( v_block_ret, (void*)(block + DCT_SIZE * (block_j + par_blocks)),
			                   next_transfer_length * DCT_SIZE * sizeof(dt));
		}
		//Process current batch.

		//First matrix multiply of each block
		for (block_i = 0; block_i < par_blocks; block_i++) {
			vbx_acc_3D( VVH, VMULLO, v_tmp_proc   + block_i * DCT_SIZE,
			                         v_block_proc + block_i * DCT_SIZE,
			                         v_dct_matrix ); //accumulate and save each row * 'column'
		}

		//Shift all results using a single long vbx
		vbx_set_vl(DCT_SIZE * par_blocks);
		vbx(SVH, VSHR, v_tmp_proc, SHIFT_AMOUNT, v_tmp_proc);

		//Initialize vbx lengths and strides for first matrix multiply
		vbx_set_vl(BLOCK_SIZE);
		vbx_set_2D(BLOCK_SIZE, 1 * sizeof(dt), BLOCK_SIZE * sizeof(dt), 0);
		vbx_set_3D(BLOCK_SIZE, BLOCK_SIZE * sizeof(dt), 0, BLOCK_SIZE * sizeof(dt));

		//Second matrix multiply of each block
		for (block_i = 0; block_i < par_blocks; block_i++) {
			vbx_acc_3D(VVH, VMULLO, v_block_proc + block_i * DCT_SIZE, v_tmp_proc + block_i * DCT_SIZE, v_dct_matrix);
		}

		//Again shift all results using a single long vbx
		vbx_set_vl(DCT_SIZE * par_blocks);
		vbx(SVH, VSHR, v_block_proc, SHIFT_AMOUNT, v_block_proc);

		//Swap pointers for processing/transferring batches
		v_block_temp = v_block_proc;
		v_block_proc = v_block_ret;
		v_block_ret = v_block_temp;
	}

	//Transfer the result of the last batch back to main memory

	vbx_dma_to_host( (void*)(block + DCT_SIZE * (end - par_blocks)), v_block_ret, par_blocks * DCT_SIZE * sizeof(dt));

	//Free allocated memory
	vbx_sp_free();
	vbx_sync();
}


void GenerateRandomMatrix(int size, int seed, dt *Matrix)
{
	/*generate random input matrix   */
	int i, j;
	srand(seed);
	for (i = 0; i < size; i++) {
		dt salt = (dt) (rand() % MAX_RAND_NUMBER - rand() % MAX_RAND_NUMBER);
		for (j = 0; j < size; j++) {
			if( i==0 ) {
				Matrix[i * BLOCK_SIZE + j] = (dt) (rand() % MAX_RAND_NUMBER - rand() % MAX_RAND_NUMBER);
			} else {
				Matrix[i * BLOCK_SIZE + j] = salt ^ Matrix[  (i-1) * BLOCK_SIZE + j ];
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
