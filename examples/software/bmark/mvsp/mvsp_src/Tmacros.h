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

#ifndef T1
#define T1(n,a,b,t,m)do{\
	vbx(VVH,VMOV, (tt)+t*TILE*m, (yr)+n*TILE*m,           0 );\
	vbx(SVH,VADD, (yr)+n*TILE*m,           0, (yi)+n*TILE*m );\
	vbx(SVH,VSUB, (yi)+n*TILE*m,           0, (tt)+t*TILE*m );\
	} while(0)
#endif

#ifndef T4p
#define T4p(n,a,b,s,t,m)do{\
	vbx(SVH, VMULFXP, (tt)+s*TILE*m,           a, (yr)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+s*TILE*m, (tt)+s*TILE*m, (tt)+s*TILE*m);\
	vbx(SVH, VMULFXP, (tt)+t*TILE*m,          -b, (yi)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+t*TILE*m, (tt)+t*TILE*m, (tt)+t*TILE*m);\
	vbx(VVH,    VADD, (yr)+n*TILE*m, (tt)+t*TILE*m, (tt)+s*TILE*m);\
	vbx(VVH,    VSUB, (yi)+n*TILE*m, (tt)+t*TILE*m, (tt)+s*TILE*m);\
	} while(0)
#endif

#ifndef T4n
#define T4n(n,a,b,s,t,m)do{\
	vbx(SVH, VMULFXP, (tt)+s*TILE*m,           a, (yr)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+s*TILE*m, (tt)+s*TILE*m, (tt)+s*TILE*m);\
	vbx(SVH, VMULFXP, (tt)+t*TILE*m,           b, (yi)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+t*TILE*m, (tt)+t*TILE*m, (tt)+t*TILE*m);\
	vbx(VVH,    VSUB, (yr)+n*TILE*m, (tt)+s*TILE*m, (tt)+t*TILE*m);\
	vbx(VVH,    VADD, (yi)+n*TILE*m, (tt)+s*TILE*m, (tt)+t*TILE*m);\
	} while(0)
#endif

#ifndef TN
#define TN(n,a,b,s,t,u,v,m)do{\
	vbx(SVH, VMULFXP, (tt)+s*TILE*m,           a, (yr)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+s*TILE*m, (tt)+s*TILE*m, (tt)+s*TILE*m);\
	vbx(SVH, VMULFXP, (tt)+t*TILE*m,           b, (yr)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+t*TILE*m, (tt)+t*TILE*m, (tt)+t*TILE*m);\
	vbx(SVH, VMULFXP, (tt)+u*TILE*m,           a, (yi)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+u*TILE*m, (tt)+u*TILE*m, (tt)+u*TILE*m);\
	vbx(SVH, VMULFXP, (tt)+v*TILE*m,           b, (yi)+n*TILE*m);\
	vbx(VVH,   VADDC, (tt)+v*TILE*m, (tt)+v*TILE*m, (tt)+v*TILE*m);\
	vbx(VVH,    VSUB, (yr)+n*TILE*m, (tt)+s*TILE*m, (tt)+v*TILE*m);\
	vbx(VVH,    VADD, (yi)+n*TILE*m, (tt)+u*TILE*m, (tt)+t*TILE*m);\
	} while(0)
#endif

#ifndef T1_2D
#define T1_2D(n,a,b,t,m)do{\
	vbx_2D(VVH,VMOV, (tt)+t*TILE*m, (yr)+n*TILE*m,           0 );\
	vbx_2D(SVH,VADD, (yr)+n*TILE*m,           0, (yi)+n*TILE*m );\
	vbx_2D(SVH,VSUB, (yi)+n*TILE*m,           0, (tt)+t*TILE*m );\
	} while(0)
#endif

#ifndef T4p_2D
#define T4p_2D(n,a,b,s,t,m)do{\
	vbx_2D(SVH, VMULFXP, (tt)+s*TILE*m,           a, (yr)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+s*TILE*m, (tt)+s*TILE*m, (tt)+s*TILE*m);\
	vbx_2D(SVH, VMULFXP, (tt)+t*TILE*m,          -b, (yi)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+t*TILE*m, (tt)+t*TILE*m, (tt)+t*TILE*m);\
	vbx_2D(VVH,    VADD, (yr)+n*TILE*m, (tt)+t*TILE*m, (tt)+s*TILE*m);\
	vbx_2D(VVH,    VSUB, (yi)+n*TILE*m, (tt)+t*TILE*m, (tt)+s*TILE*m);\
	} while(0)
#endif

#ifndef T4n_2D
#define T4n_2D(n,a,b,s,t,m)do{\
	vbx_2D(SVH, VMULFXP, (tt)+s*TILE*m,           a, (yr)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+s*TILE*m, (tt)+s*TILE*m, (tt)+s*TILE*m);\
	vbx_2D(SVH, VMULFXP, (tt)+t*TILE*m,           b, (yi)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+t*TILE*m, (tt)+t*TILE*m, (tt)+t*TILE*m);\
	vbx_2D(VVH,    VSUB, (yr)+n*TILE*m, (tt)+s*TILE*m, (tt)+t*TILE*m);\
	vbx_2D(VVH,    VADD, (yi)+n*TILE*m, (tt)+s*TILE*m, (tt)+t*TILE*m);\
	} while(0)
#endif

#ifndef TN_2D
#define TN_2D(n,a,b,s,t,u,v,m)do{\
	vbx_2D(SVH, VMULFXP, (tt)+s*TILE*m,           a, (yr)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+s*TILE*m, (tt)+s*TILE*m, (tt)+s*TILE*m);\
	vbx_2D(SVH, VMULFXP, (tt)+t*TILE*m,           b, (yr)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+t*TILE*m, (tt)+t*TILE*m, (tt)+t*TILE*m);\
	vbx_2D(SVH, VMULFXP, (tt)+u*TILE*m,           a, (yi)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+u*TILE*m, (tt)+u*TILE*m, (tt)+u*TILE*m);\
	vbx_2D(SVH, VMULFXP, (tt)+v*TILE*m,           b, (yi)+n*TILE*m);\
	vbx_2D(VVH,   VADDC, (tt)+v*TILE*m, (tt)+v*TILE*m, (tt)+v*TILE*m);\
	vbx_2D(VVH,    VSUB, (yr)+n*TILE*m, (tt)+s*TILE*m, (tt)+v*TILE*m);\
	vbx_2D(VVH,    VADD, (yi)+n*TILE*m, (tt)+u*TILE*m, (tt)+t*TILE*m);\
	} while(0)
#endif
