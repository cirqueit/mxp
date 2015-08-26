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

// Matrix Vector Signal Processing

#include "vbx_copyright.h"
VBXCOPYRIGHT(spl_test)

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "vbx.h"
#include "vbx_port.h"
#include "vbx_common.h"
#include "vbx_vec_rev.h"

#include "mvsp_macro.h"

//#define DEBUG 1
//#define N 16
//// MAX TILE = Scratch(64k) / 4 (real/imag input+output) * 2 (short) * N point FFT
//#define TILE N//8192/N
//#define N2 N*TILE

#define SWAP(yr,xr,tmp) do{	tmp = yr; yr = xr; xr = tmp; } while(0)

void printm(short* m){
	int i,j;
	for (i = 0; i < N; i++) {
		for (j = 0; j < TILE; j++) {
			printf("%d\t",m[i*TILE+j]);
		}
		printf("\n");
	}
	printf("\n");
}

void mvsp()
{
	int time_start, time_stop;
	unsigned int cycles;
	double vbx_time;
	vbx_timestamp_start();

	//Alloc and create input w/ value matching position
	short* xr = (short*)vbx_shared_malloc(N2*sizeof(short));
	short* xi = (short*)vbx_shared_malloc(N2*sizeof(short));
	short* yr = (short*)vbx_shared_malloc(N2*sizeof(short));
	short* yi = (short*)vbx_shared_malloc(N2*sizeof(short));

	int i,j;
	for (i = 0; i < N; i++) {
		for (j = 0; j < TILE; j++) {
			if(i==(j%N))xr[i*TILE+j]=100;
			else xr[i*TILE+j]=0;
			xi[i*TILE+j]=0;
		}
}

#if DEBUG
	printm(xr);printm(xi);
#endif

	//Alloc and DMA in input
	vbx_half_t* v_xr = (vbx_half_t*)vbx_sp_malloc(N2*sizeof(short));
	vbx_half_t* v_xi = (vbx_half_t*)vbx_sp_malloc(N2*sizeof(short));
	vbx_half_t* v_yr = (vbx_half_t*)vbx_sp_malloc(N2*sizeof(short));
	vbx_half_t* v_yi = (vbx_half_t*)vbx_sp_malloc(N2*sizeof(short));
	vbx_half_t* tmp;
	if( !v_xr || !v_xi || !v_yr || !v_yi ) return;

	vbx_dma_to_vector(v_xr, xr, N2*sizeof(short));
	vbx_dma_to_vector(v_xi, xi, N2*sizeof(short));
	vbx_sync();
	time_start = vbx_timestamp();

	//Perform ops in scratchpad
	short swap = mvsp_macro(v_yr,v_yi,v_xr,v_xi);
	vbx_sync();
	time_stop = vbx_timestamp();

	//DMA out result and free
	if (swap){
		SWAP(v_yr,v_xr,tmp);
		SWAP(v_yi,v_xi,tmp);
	}
	vbx_dma_to_host(yr, v_yr, N2*sizeof(short));
	vbx_dma_to_host(yi, v_yi, N2*sizeof(short));
	vbx_sync();
	vbx_sp_free();

#if DEBUG
	printm(yr);printm(yi);
#endif

	//Calculate megasamples / second
	cycles = time_stop - time_start;
	vbx_time = (double) cycles;
	vbx_time /= (double) vbx_timestamp_freq();
	vbx_time *= 1000.0;			//ms
	vbx_timestamp_t	mxp_cycles = vbx_mxp_cycles(cycles);

	printf("Finished, vector took %0.3f ms \n", vbx_time);
	printf("Cycles: %d\n", (int) mxp_cycles);

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	double vbx_msps = (double) (N*TILE) * 1000 / vbx_time;	// samples per second
	vbx_msps /= 1000000;
	printf("V%d@%dMHz\n", this_mxp->vector_lanes, this_mxp->core_freq / 1000000);
	printf("%f MSPS\n", vbx_msps);

	putchar(4);
	return;
}
