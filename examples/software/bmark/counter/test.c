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
VBXCOPYRIGHT( test_vec_add )

/*
 * Vector Add - Scalar version and Vector version
 */

#include <stdio.h>
#include "vbx.h"
#include "vbx_test.h"
#include "scalar_vec_add.h"
#include "vbw_vec_add_all.h"
#include "vbx_counters.h"
int main(void)
{
	vbx_test_init();
	vbx_mxp_print_params();
	int errors=0;
	unsigned instr_cycles,instr_count, dma_cycles,dma_count;
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int lanes= this_mxp->vector_lanes;
	int dma_width=this_mxp->dma_alignment_bytes /4;
	debug(lanes);
	debug(dma_width);
	vbx_set_vl(-1);
	VBX_COUNTER_RESET();
	vbx(SVW,VMOV,0,0,0);
	vbx_sync();
	if(VBX_SIMULATOR)
		printf("simulator\n");
	else
		printf("not simulator\n");
	instr_cycles=VBX_GET_WRITEBACK_CYCLES();
	dma_cycles=VBX_GET_DMA_CYCLES();
	dma_count=VBX_GET_DMAS();
	instr_count=VBX_GET_INSTRUCTIONS();


	debug(instr_cycles);
	debug(dma_cycles);
	debug(dma_count);
	debug(instr_count );

	VBX_TEST_END(errors);
	return 0;
}
