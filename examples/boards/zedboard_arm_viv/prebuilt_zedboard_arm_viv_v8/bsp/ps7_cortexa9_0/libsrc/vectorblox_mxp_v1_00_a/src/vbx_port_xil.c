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


#if __MICROBLAZE__ || __ARM_ARCH_7A__

#include "vbx_copyright.h"
VBXCOPYRIGHT( port_mb )

#include "vbx.h"
#include "vbx_port.h"

// --------------------------------------------------------
volatile void* vbx_uncached_malloc(size_t size)
{
	void *p;

#if VBX_DEBUG_MALLOC
	printf("uncached_malloc %d bytes\n", size);
#endif
	p = malloc(size);
	if (!p) {
#if VBX_DEBUG_MALLOC
		VBX_PRINTF("ERROR: uncached_malloc failed.\n");
		VBX_FATAL(__LINE__, __FILE__, -1);
#endif
		return NULL;
	}
	Xil_DCacheFlushRange((u32) p, size);
	return (volatile void *) VBX_UNCACHED_ADDR(p);
}

void vbx_uncached_free(volatile void *p)
{
	free((void *) VBX_CACHED_ADDR(p));
}

void *vbx_remap_cached(volatile void *p, u32 len)
{
	return (void *) VBX_CACHED_ADDR(p);
}

volatile void *vbx_remap_uncached(void *p)
{
	Xil_DCacheFlushRange((u32) p, 1);
	return (volatile void *) VBX_UNCACHED_ADDR(p);
}

volatile void *vbx_remap_uncached_flush(void *p, u32 len)
{
	vbx_dcache_flush(p, len);
	return (volatile void *) VBX_UNCACHED_ADDR(p);
}

// --------------------------------------------------------

u32 vbx_timestamp_tmrctr_freq = 0;

#if (__ARM_ARCH_7A__ && VBX_USE_A9_PMU_TIMER)

void vbx_timestamp_init(u32 freq)
{
	vbx_timestamp_tmrctr_freq = freq;
}

int vbx_timestamp_start()
{
	// Reset counter to 0.
	XTime_SetTime((XTime) 0);
	return 0;
}

vbx_timestamp_t vbx_timestamp()
{
	XTime v;

	XTime_GetTime(&v);
	return (vbx_timestamp_t) v;
}

#else // !(__ARM_ARCH_7A__ && VBX_USE_A9_PMU_TIMER)

XTmrCtr *vbx_timestamp_tmrctr = NULL;

void vbx_timestamp_init(XTmrCtr *inst_ptr, u32 freq)
{
	vbx_timestamp_tmrctr = inst_ptr;
	vbx_timestamp_tmrctr_freq = freq;

	// XTmrCtr_SetOptions(vbx_timestamp_tmrctr, 0,
	//                    XTC_CASCADE_MODE_OPTION);
	XTmrCtr_SetResetValue(vbx_timestamp_tmrctr, 0, 0);
}

int vbx_timestamp_start()
{
	if (!vbx_timestamp_tmrctr) {
		return -1;
	}
	XTmrCtr_Start(vbx_timestamp_tmrctr, 0);
	return 0;
}

vbx_timestamp_t vbx_timestamp()
{
	u32 v;

	if (!vbx_timestamp_tmrctr) {
		return 0xffffffff;
	}

	v = XTmrCtr_GetValue(vbx_timestamp_tmrctr, 0);
	return (vbx_timestamp_t) v;
}
#endif // !(__ARM_ARCH_7A__ && VBX_USE_A9_PMU_TIMER)

u32 vbx_timestamp_freq()
{
	return vbx_timestamp_tmrctr_freq;
}

#endif // __MICROBLAZE__ || __ARM_ARCH_7A__
// --------------------------------------------------------
