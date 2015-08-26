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

void FR4(vbx_half_t* yr,vbx_half_t* yi,vbx_half_t* xr,vbx_half_t* xi)
{
	vbx_set_vl(TILE);
	vbx(VVH, VADD, (yr),        (xr),        (xr)+2*TILE); // y0 = a + c
	vbx(VVH, VSUB, (yr)+TILE,   (xr),        (xr)+2*TILE); // y1 = a - c
	vbx(VVH, VADD, (xr),        (xr)+TILE,   (xr)+3*TILE); // x0 = b + d
	vbx(VVH, VSUB, (yi)+3*TILE, (xr)+TILE,   (xr)+3*TILE); // iy3 = b - d for imaginary
	vbx(VVH, VSUB, (yr)+2*TILE, (yr),        (xr)       ); // y2 = y0 - x0 -- a+c - b+d
	vbx(VVH, VMOV, (yr)+3*TILE, (yr)+TILE,      0       ); // y3 = y1      -- a-c
	vbx(VVH, VADD, (yr),        (yr),        (xr)       ); // y0 = y0 + x0 -- a+c + b+d
	vbx(SVH, VSUB, (yi)+TILE,      0,        (yi)+3*TILE); // iy1 =  -x2   --  -ib-d
}
