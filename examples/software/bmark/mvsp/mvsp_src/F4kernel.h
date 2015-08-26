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
void F4(vbx_half_t* yr,vbx_half_t* yi,vbx_half_t* xr,vbx_half_t* xi)
{
	vbx_set_vl(TILE);
	vbx(VVH, VADD, (yr),        (xr),        (xr)+2*TILE); // y0 = a + c
	vbx(VVH, VADD, (yi),        (xi),        (xi)+2*TILE);
	vbx(VVH, VSUB, (yr)+TILE,   (xr),        (xr)+2*TILE); // y1 = a - c
	vbx(VVH, VSUB, (yi)+TILE,   (xi),        (xi)+2*TILE);
	vbx(VVH, VADD, (xr),        (xr)+TILE,   (xr)+3*TILE); // x0 = b + d
	vbx(VVH, VADD, (xi),        (xi)+TILE,   (xi)+3*TILE);
	vbx(VVH, VSUB, (xr)+2*TILE, (xi)+TILE,   (xi)+3*TILE); // x2 = b - d
	vbx(VVH, VSUB, (xi)+2*TILE, (xr)+TILE,   (xr)+3*TILE);
	vbx(VVH, VSUB, (yr)+2*TILE, (yr),        (xr)       ); // y2 = y0 - x0 -- a+c - b+d
	vbx(VVH, VSUB, (yi)+2*TILE, (yi),        (xi)       );
	vbx(VVH, VSUB, (yr)+3*TILE, (yr)+TILE,   (xr)+2*TILE); // y3 = y1 + x2 -- a-c + ib-d
	vbx(VVH, VADD, (yi)+3*TILE, (yi)+TILE,   (xi)+2*TILE);
	vbx(VVH, VADD, (yr),        (yr),        (xr)       ); // y0 = y0 + x0 -- a+c + b+d
	vbx(VVH, VADD, (yi),        (yi),        (xi)       );
	vbx(VVH, VADD, (yr)+TILE,   (yr)+TILE,   (xr)+2*TILE); // y1 = y1 - x2 -- a-c - ib-d
	vbx(VVH, VSUB, (yi)+TILE,   (yi)+TILE,   (xi)+2*TILE);
}
