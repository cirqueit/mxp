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

// VectorBlox 2012
void FR8(vbx_half_t* yr,vbx_half_t* yi,vbx_half_t* xr,vbx_half_t* xi)
{
	vbx_set_vl(TILE);
	vbx(VVH, VSUB, (yr)+0*TILE, (xr)+0*TILE, (xr)+4*TILE); // y0 = a - e
	vbx(VVH, VADD, (yr)+1*TILE, (xr)+0*TILE, (xr)+4*TILE); // y1 = a + e
	vbx(VVH, VADD, (yr)+2*TILE, (xr)+1*TILE, (xr)+7*TILE); // y2 = b + h
	vbx(VVH, VADD, (yr)+3*TILE, (xr)+2*TILE, (xr)+6*TILE); // y3 = c + g
	vbx(VVH, VADD, (yr)+4*TILE, (xr)+3*TILE, (xr)+5*TILE); // y4 = d + f
	vbx(VVH, VSUB, (yr)+5*TILE, (xr)+2*TILE, (xr)+6*TILE); // iy5 = i(c - g)
	vbx(VVH, VSUB, (yr)+6*TILE, (xr)+3*TILE, (xr)+5*TILE); // iy6 = i(d - f)
	vbx(VVH, VSUB, (yr)+7*TILE, (xr)+7*TILE, (xr)+1*TILE); // iy7 = i(h - b)

	vbx(VVH, VADD, (xr)+4*TILE, (yr)+1*TILE, (yr)+3*TILE); // x4 = y1 + y3  -- a+e + c+g
	vbx(VVH, VADD, (xr)+5*TILE, (yr)+2*TILE, (yr)+4*TILE); // x5 = y2 + y4  -- b+h + d+f
	vbx(VVH, VSUB, (xr)+6*TILE, (yr)+2*TILE, (yr)+4*TILE); // x6 = y2 - y4  -- b+h - d+f
	vbx(VVH, VSUB, (xr)+7*TILE, (yr)+7*TILE, (yr)+6*TILE); // x7 = y7 - y6  -- i(h-b - d-f)
	vbx(SVH, VMULFXP, (xr)+6*TILE,     23170, (xr)+6*TILE); // x6 *= /2
	vbx(VVH, VADDC, (xr)+6*TILE, (xr)+6*TILE, (xr)+6*TILE); // round
	vbx(SVH, VMULFXP, (xr)+7*TILE,     23170, (xr)+7*TILE); // x7 *= /2
	vbx(VVH, VADDC, (xr)+7*TILE, (xr)+7*TILE, (xr)+7*TILE); // round

	vbx(VVH, VSUB, (yi)+1*TILE, (xr)+7*TILE, (yr)+5*TILE); // iy1 = x7 - y5 -- i /2 - c-g
	vbx(VVH, VADD, (yi)+2*TILE, (yr)+7*TILE, (yr)+6*TILE); // iy2 = y7 + y6 -- i(h-b + d-f)
	vbx(VVH, VADD, (yi)+3*TILE, (xr)+7*TILE, (yr)+5*TILE); // iy3 = x7 + y5 -- i /2 + c-g
	vbx(VVH, VSUB, (yr)+2*TILE, (yr)+1*TILE, (yr)+3*TILE); // y2 = y1 - y3 -- a+e - c+g
	vbx(VVH, VADD, (yr)+1*TILE, (yr)+0*TILE, (xr)+6*TILE); // y1 = y0 + x6 -- a-e + /2
	vbx(VVH, VSUB, (yr)+3*TILE, (yr)+0*TILE, (xr)+6*TILE); // y3 = y0 - x6 -- a-e - /2
	vbx(VVH, VADD, (yr)+0*TILE, (xr)+4*TILE, (xr)+5*TILE); // y0 = x4 + x5 -- a+b+..+h
	vbx(VVH, VSUB, (yr)+4*TILE, (xr)+4*TILE, (xr)+5*TILE); // y4 = x4 - x5 -- a-b+..-h

	vbx(VVH, VMOV, (yr)+5*TILE, (yr)+3*TILE,          0 ); // y5 = y3
	vbx(VVH, VMOV, (yr)+6*TILE, (yr)+2*TILE,          0 ); // y6 = y2
	vbx(VVH, VMOV, (yr)+7*TILE, (yr)+1*TILE,          0 ); // y7 = y1
	vbx(SVH, VSUB, (yi)+5*TILE,           0, (yi)+3*TILE); // iy5 = -iy3
	vbx(SVH, VSUB, (yi)+6*TILE,           0, (yi)+2*TILE); // iy6 = -iy2
	vbx(SVH, VSUB, (yi)+7*TILE,           0, (yi)+1*TILE); // iy7 = -iy1
}
