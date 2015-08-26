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

/**@file*/

#include "vbw_exit_codes.h"
#include "vbx.h"
#include "vbw_template.hpp"
/** VBX software power routine.
 *  @pre  Requires 4 to 5 times the aligned vector size in additional free space in the scratchpad.
 *  @pre  v_in1 contains the bases.
 *  @pre  v_in2 contains the exponents.
 *  @pre  v_out does not overlap a source vector, or overlaps it completely.
 *  @post v_out contains element-wise v_in1[i] raised to the power v_in2[i].
 *
 *  @param[out] v_out Scratchpad pointer to result of the exponentiation
 *  @param[in] v_in1 Scratchpad pointer to the base of the exponentiation
 *  @param[in] v_in2 Scratchpad pointer to the power of the exponentiation
 *  @param[in] vl Length of the aforementioned vectors.
 *  @returns negative on error condition. See vbw_exit_codes.h
 */

template<typename vbx_sp_t>
int vbw_vec_power(vbx_sp_t *v_out, vbx_sp_t *v_in1, vbx_sp_t *v_in2, unsigned int vl)
{
	int i;
	vbx_sp_push();
	vbx_set_vl(vl);

	vbx_sp_t *vaa   = (vbx_sp_t *)vbx_sp_malloc( vl*sizeof(vbx_sp_t) );
	vbx_sp_t *v_bb  = (vbx_sp_t *)vbx_sp_malloc( vl*sizeof(vbx_sp_t) );
	vbx_sp_t *v_flg = (vbx_sp_t *)vbx_sp_malloc( vl*sizeof(vbx_sp_t) );
	vbx_sp_t *v_tmp = (vbx_sp_t *)vbx_sp_malloc( vl*sizeof(vbx_sp_t) );
	if(v_tmp == NULL){
		return VBW_ERROR_SP_ALLOC_FAILED;
	}


	vbxx( VMOV,   vaa, v_in1);
	vbxx( VMOV,  v_bb, v_in2);
	vbxx( VMOV, v_out,     1);

	const int len_bits = sizeof(vbx_sp_t)*8;
	for( i=0; i <len_bits; i++ ) {
		vbxx( VAND,    v_flg,     1, v_bb  );
		vbxx( VMUL,    v_tmp, v_out, vaa   ); // tmp = out * aa
		vbxx( VCMV_NZ, v_out, v_tmp, v_flg );
		vbxx( VMUL,    vaa,     vaa, vaa   ); // aa = aa * aa
		vbxx( VSHR,    v_bb,      1, v_bb  ); //  b = b >> 1
		if( ((i&3) == 3) && (i < len_bits-1) ) {    // check every 4 cycles
			vbxx_acc(VCMV_NZ, v_tmp, 1, v_bb );
			vbx_sync();
			if( !(*v_tmp) ) break;
		}
	}

	if((vbx_sp_t)-1<0){//is signed
		// if( 0 > v_in2 ) power = 0
		vbxx( VSUB,     v_tmp,  (typename word_sized<vbx_sp_t>::type)0, v_in2 );
		vbxx( VCMV_GTZ, v_out,  (typename word_sized<vbx_sp_t>::type)0, v_tmp );
	}

	vbx_sp_pop();
	return VBW_SUCCESS;
}

extern "C" int vbw_vec_power_word(vbx_word_t *v_out, vbx_word_t *v_in1, vbx_word_t *v_in2, unsigned int vl)
{return vbw_vec_power(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_power_uword(vbx_uword_t *v_out, vbx_uword_t *v_in1, vbx_uword_t *v_in2, unsigned int vl)
{return vbw_vec_power(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_power_half(vbx_half_t *v_out, vbx_half_t *v_in1, vbx_half_t *v_in2, unsigned int vl)
{return vbw_vec_power(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_power_uhalf(vbx_uhalf_t *v_out, vbx_uhalf_t *v_in1, vbx_uhalf_t *v_in2, unsigned int vl)
{return vbw_vec_power(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_power_byte(vbx_byte_t *v_out, vbx_byte_t *v_in1, vbx_byte_t *v_in2, unsigned int vl)
{return vbw_vec_power(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_power_ubyte(vbx_ubyte_t *v_out, vbx_ubyte_t *v_in1, vbx_ubyte_t *v_in2, unsigned int vl)
{return vbw_vec_power(v_out, v_in1, v_in2, vl);}
