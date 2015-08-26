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
void F8(vbx_half_t* yr,vbx_half_t* yi,vbx_half_t* xr,vbx_half_t* xi)
{
	vbx_set_vl(TILE);
	vbx(VVH, VSUB, (yr)+0*TILE, (xr)+0*TILE, (xr)+4*TILE); // y0 = a - e
	vbx(VVH, VSUB, (yi)+0*TILE, (xi)+0*TILE, (xi)+4*TILE); // iy0 = a - e
	vbx(VVH, VADD, (yr)+1*TILE, (xr)+0*TILE, (xr)+4*TILE); // y1 = a + e
	vbx(VVH, VADD, (yi)+1*TILE, (xi)+0*TILE, (xi)+4*TILE); // iy1 = a + e
	vbx(VVH, VADD, (yr)+2*TILE, (xr)+1*TILE, (xr)+7*TILE); // y2 = b + h
	vbx(VVH, VADD, (yi)+2*TILE, (xi)+1*TILE, (xi)+7*TILE); // iy2 = b + h
	vbx(VVH, VADD, (yr)+3*TILE, (xr)+2*TILE, (xr)+6*TILE); // y3 = c + g
	vbx(VVH, VADD, (yi)+3*TILE, (xi)+2*TILE, (xi)+6*TILE); // iy3 = c + g
	vbx(VVH, VADD, (yr)+4*TILE, (xr)+3*TILE, (xr)+5*TILE); // y4 = d + f
	vbx(VVH, VADD, (yi)+4*TILE, (xi)+3*TILE, (xi)+5*TILE); // iy4 = d + f
	vbx(VVH, VSUB, (yr)+5*TILE, (xi)+2*TILE, (xi)+6*TILE); // y5 = i(c - g)
	vbx(VVH, VSUB, (yi)+5*TILE, (xr)+2*TILE, (xr)+6*TILE); // iy5 = i(c - g)
	vbx(VVH, VSUB, (yr)+6*TILE, (xi)+3*TILE, (xi)+5*TILE); // y6 = i(d - f)
	vbx(VVH, VSUB, (yi)+6*TILE, (xr)+3*TILE, (xr)+5*TILE); // iy6 = i(d - f)
	vbx(VVH, VSUB, (yr)+7*TILE, (xi)+7*TILE, (xi)+1*TILE); // y7 = i(h - b)
	vbx(VVH, VSUB, (yi)+7*TILE, (xr)+7*TILE, (xr)+1*TILE); // iy7 = i(h - b)
	vbx(VVH, VADD, (xr)+4*TILE, (yr)+1*TILE, (yr)+3*TILE); // x4 = y1 + y3  -- a+e + c+g
	vbx(VVH, VADD, (xi)+4*TILE, (yi)+1*TILE, (yi)+3*TILE); // ix4 = y1 + y3  -- a+e + c+g
	vbx(VVH, VADD, (xr)+5*TILE, (yr)+2*TILE, (yr)+4*TILE); // x5 = y2 + y4  -- b+h + d+f
	vbx(VVH, VADD, (xi)+5*TILE, (yi)+2*TILE, (yi)+4*TILE); // ix5 = y2 + y4  -- b+h + d+f
	vbx(VVH, VSUB, (xr)+6*TILE, (yr)+2*TILE, (yr)+4*TILE); // x6 = y2 - y4  -- b+h - d+f
	vbx(VVH, VSUB, (xi)+6*TILE, (yi)+2*TILE, (yi)+4*TILE); // ix6 = y2 - y4  -- b+h - d+f
	vbx(VVH, VSUB, (xr)+7*TILE, (yr)+7*TILE, (yr)+6*TILE); // x7 = y7 - y6  -- i(h-b - d-f)
	vbx(VVH, VSUB, (xi)+7*TILE, (yi)+7*TILE, (yi)+6*TILE); // ix7 = y7 - y6  -- i(h-b - d-f)
	vbx(SVH, VMULFXP, (xr)+6*TILE,     23170, (xr)+6*TILE); // x6 *= /2
	vbx(VVH, VADDC, (xr)+6*TILE, (xr)+6*TILE, (xr)+6*TILE); // round
	vbx(SVH, VMULFXP, (xi)+6*TILE,     23170, (xi)+6*TILE); // ix6 *= /2
	vbx(VVH, VADDC, (xi)+6*TILE, (xi)+6*TILE, (xi)+6*TILE); // round
	vbx(SVH, VMULFXP, (xr)+7*TILE,     23170, (xr)+7*TILE); // x7 *= /2
	vbx(VVH, VADDC, (xr)+7*TILE, (xr)+7*TILE, (xr)+7*TILE); // round
	vbx(SVH, VMULFXP, (xi)+7*TILE,     23170, (xi)+7*TILE); // ix7 *= /2
	vbx(VVH, VADDC, (xi)+7*TILE, (xi)+7*TILE, (xi)+7*TILE); // round
	vbx(VVH, VSUB, (xr)+1*TILE, (xr)+7*TILE, (yr)+5*TILE); // x1 = x7 - y5 -- i /2 - c-g
	vbx(VVH, VSUB, (xi)+1*TILE, (xi)+7*TILE, (yi)+5*TILE); // ix1 = x7 - y5 -- i /2 - c-g
	vbx(VVH, VADD, (xr)+2*TILE, (yr)+7*TILE, (yr)+6*TILE); // x2 = y7 + y6 -- i(h-b + d-f)
	vbx(VVH, VADD, (xi)+2*TILE, (yi)+7*TILE, (yi)+6*TILE); // ix2 = y7 + y6 -- i(h-b + d-f)
	vbx(VVH, VADD, (xr)+3*TILE, (xr)+7*TILE, (yr)+5*TILE); // x3 = x7 + y5 -- i /2 + c-g
	vbx(VVH, VADD, (xi)+3*TILE, (xi)+7*TILE, (yi)+5*TILE); // ix3 = x7 + y5 -- i /2 + c-g
	vbx(VVH, VSUB, (yr)+2*TILE, (yr)+1*TILE, (yr)+3*TILE); // y2 = y1 - y3 -- a+e - c+g
	vbx(VVH, VSUB, (yi)+2*TILE, (yi)+1*TILE, (yi)+3*TILE); // iy2 = y1 - y3 -- a+e - c+g
	vbx(VVH, VADD, (yr)+1*TILE, (yr)+0*TILE, (xr)+6*TILE); // y1 = y0 + x6 -- a-e + /2
	vbx(VVH, VADD, (yi)+1*TILE, (yi)+0*TILE, (xi)+6*TILE); // iy1 = y0 + x6 -- a-e + /2
	vbx(VVH, VSUB, (yr)+3*TILE, (yr)+0*TILE, (xr)+6*TILE); // y3 = y0 - x6 -- a-e - /2
	vbx(VVH, VSUB, (yi)+3*TILE, (yi)+0*TILE, (xi)+6*TILE); // iy3 = y0 - x6 -- a-e - /2
	vbx(VVH, VADD, (yr)+0*TILE, (xr)+4*TILE, (xr)+5*TILE); // y0 = x4 + x5 -- a+b+..+h
	vbx(VVH, VADD, (yi)+0*TILE, (xi)+4*TILE, (xi)+5*TILE); // iy0 = x4 + x5 -- a+b+..+h
	vbx(VVH, VSUB, (yr)+4*TILE, (xr)+4*TILE, (xr)+5*TILE); // y4 = x4 - x5 -- a-b+..-h
	vbx(VVH, VSUB, (yi)+4*TILE, (xi)+4*TILE, (xi)+5*TILE); // iy4 = x4 - x5 -- a-b+..-h
	vbx(VVH, VMOV, (yr)+5*TILE, (yr)+3*TILE,          0 ); // y5 = y3
	vbx(VVH, VMOV, (yi)+5*TILE, (yi)+3*TILE,          0 ); // iy5 = y3
	vbx(VVH, VMOV, (yr)+6*TILE, (yr)+2*TILE,          0 ); // y6 = y2
	vbx(VVH, VMOV, (yi)+6*TILE, (yi)+2*TILE,          0 ); // iy6 = y2
	vbx(VVH, VMOV, (yr)+7*TILE, (yr)+1*TILE,          0 ); // y7 = y1
	vbx(VVH, VMOV, (yi)+7*TILE, (yi)+1*TILE,          0 ); // iy7 = y1
	vbx(SVH, VSUB, (xr)+5*TILE,           0, (xr)+3*TILE); // x5 = -x3
	vbx(SVH, VSUB, (xi)+5*TILE,           0, (xi)+3*TILE); // ix5 = -x3
	vbx(SVH, VSUB, (xr)+6*TILE,           0, (xr)+2*TILE); // x6 = -x2
	vbx(SVH, VSUB, (xi)+6*TILE,           0, (xi)+2*TILE); // ix6 = -x2
	vbx(SVH, VSUB, (xr)+7*TILE,           0, (xr)+1*TILE); // x7 = -x1
	vbx(SVH, VSUB, (xi)+7*TILE,           0, (xi)+1*TILE); // ix7 = -x1
	vbx(VVH, VSUB, (yr)+1*TILE, (yr)+1*TILE, (xr)+1*TILE); // y1 = y1 + x1
	vbx(VVH, VADD, (yi)+1*TILE, (yi)+1*TILE, (xi)+1*TILE); // iy1 = y1 + x1
	vbx(VVH, VSUB, (yr)+2*TILE, (yr)+2*TILE, (xr)+2*TILE); // y2 = y2 + x2
	vbx(VVH, VADD, (yi)+2*TILE, (yi)+2*TILE, (xi)+2*TILE); // iy2 = y2 + x2
	vbx(VVH, VSUB, (yr)+3*TILE, (yr)+3*TILE, (xr)+3*TILE); // y3 = y3 + x3
	vbx(VVH, VADD, (yi)+3*TILE, (yi)+3*TILE, (xi)+3*TILE); // iy3 = y3 + x3
	vbx(VVH, VSUB, (yr)+5*TILE, (yr)+5*TILE, (xr)+5*TILE); // y5 = y5 + x5
	vbx(VVH, VADD, (yi)+5*TILE, (yi)+5*TILE, (xi)+5*TILE); // iy5 = y5 + x5
	vbx(VVH, VSUB, (yr)+6*TILE, (yr)+6*TILE, (xr)+6*TILE); // y6 = y6 + x6
	vbx(VVH, VADD, (yi)+6*TILE, (yi)+6*TILE, (xi)+6*TILE); // iy6 = y6 + x6
	vbx(VVH, VSUB, (yr)+7*TILE, (yr)+7*TILE, (xr)+7*TILE); // y7 = y7 + x7
	vbx(VVH, VADD, (yi)+7*TILE, (yi)+7*TILE, (xi)+7*TILE); // iy7 = y7 + x7
}
