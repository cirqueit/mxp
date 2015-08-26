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
VBXCOPYRIGHT( test_dma_bandwidth )

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#include "vbx.h"
#include "vbx_common.h"
#include "vbx_test.h"

///////////////////////////////////////////////////////////////////////////
void print_dma_bandwidth(vbx_timestamp_t time_start,
                         vbx_timestamp_t time_stop,
                         int bytes,
                         int iterations,
                         double max_megabytes_per_second)
{
	if (time_stop < time_start) {
		printf("Error: DMA stop time (%llu) is less than start time (%llu)!\n",
		       (unsigned long long) time_stop,
		       (unsigned long long) time_start);
		printf("Skipping bandwidth calculation.\n");
		return;
	}

	vbx_timestamp_t cycles = time_stop - time_start;
	vbx_timestamp_t mxp_cycles = vbx_mxp_cycles(cycles);
	double seconds = ((double) cycles) / ((double) vbx_timestamp_freq());

	vbx_timestamp_t avg_mxp_cycles = mxp_cycles/iterations;
	double avg_seconds = seconds/((double) iterations);
	double bytes_per_second = ((double) bytes)/avg_seconds;
	double megabytes_per_second = bytes_per_second/(1024*1024);

	printf("Transfer length in bytes: %d\n", bytes);
	printf("Transfer time in seconds: %s\n", vbx_eng(avg_seconds, 4));
	printf("Transfer time in cycles: %llu\n",
	       (unsigned long long) avg_mxp_cycles);
	// printf("Bytes per second: %s\n", vbx_eng(bytes_per_second, 4));
	printf("Megabytes per second: %s\n", vbx_eng(megabytes_per_second, 4));
	printf("Efficiency: %.0f%%\n",
	       round(megabytes_per_second*100/max_megabytes_per_second));
	printf("Average of %d transfers.\n", iterations);
}

///////////////////////////////////////////////////////////////////////////
int dma_bandwidth_test()
{
	const int num_iter = 64;

	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int scratchpad_size = this_mxp->scratchpad_size;

	uint8_t *buf = vbx_shared_malloc(scratchpad_size);
	vbx_ubyte_t *v_buf = vbx_sp_malloc(scratchpad_size);

	vbx_timestamp_t time_start, time_stop;

	int i;
	int len;
	int to_host;
	int errors = 0;

	vbx_mxp_print_params();

	// dma_alignment_bytes gives DMA master data bus width in bytes.
	double bytes_per_sec = \
		(((double) this_mxp->core_freq) * this_mxp->dma_alignment_bytes);
	double max_megabytes_per_sec = bytes_per_sec/(1024*1024);
	printf("\nMax available bandwidth = %s Megabytes/s\n",
	       vbx_eng(max_megabytes_per_sec, 4));

	printf("\n");

	for (to_host = 0; to_host < 2; to_host++) {
		for (len = 32; len <= scratchpad_size ; len *= 2) {
			printf("DMA %s, %d bytes\n", to_host ? "write" : "read", len);
			vbx_timestamp_start();
			if (to_host) {
				time_start = vbx_timestamp();
				for (i = 0; i < num_iter; i++) {
					vbx_dma_to_host(buf, v_buf, len);
				}
				vbx_sync();
				time_stop = vbx_timestamp();
			} else {
				time_start = vbx_timestamp();
				for (i = 0; i < num_iter; i++) {
					vbx_dma_to_vector(v_buf, buf, len);
				}
				vbx_sync();
				time_stop = vbx_timestamp();
			}
			print_dma_bandwidth(time_start, time_stop, len, num_iter,
			                    max_megabytes_per_sec);
			printf("\n");
		}
		printf("\n");
	}

	vbx_shared_free(buf);
	vbx_sp_free();

	return errors;
}

int main()
{
	int errors = 0;

	vbx_test_init();

	errors += dma_bandwidth_test();

	VBX_TEST_END(errors);

	return 0;
}
