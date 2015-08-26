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
#include "vbx.h"
#include "vbw_exit_codes.h"


/** Adds two vectors of elements allocated *in the scratchpad*.
 *  The function properly handles overlapping source and destination addresses.
 *  @pre v_in1 and v_in2 contain the data to be added
 *  @pre all overlapping conditions are supported
 *  @pre there must be vl*sizeof(vbx_sp_t) available scratch space if v_out overlaps one
 *       input on the left and the other input on the right. Otherwise, no scratch is needed.
 *  @post v_out contains the element-wise sum of v_in1 and v_in2.
 *
 *  @param[out] v_out *in scratch*.
 *  @param[in] v_in1 *in scratch*.
 *  @param[in] v_in2 *in scratch*.
 *  @param[in] vl is number of elements to add.
 *  @returns negative on error condition. See vbw_exit_codes.h
 *
 *  @todo add an external version
 */
template<typename vbx_sp_t>
int vbw_vec_add(vbx_sp_t *v_out, vbx_sp_t *v_in1, vbx_sp_t *v_in2, unsigned int vl)
{
	vbx_sp_t *v_temp;
	int WB = VBX_GET_THIS_MXP()->scratchpad_alignment_bytes;

	if( !vl ){
		return VBW_SUCCESS;
	}

	int overlapL1 = 0, overlapL2 = 0, overlapR1 = 0, overlapR2 = 0;

	if( abs(v_out-v_in1) < vl ) {
		if( v_out <= v_in1 ) {
			overlapL1 = 1;
		} else {
			overlapR1 = 1;
		}
	}

	if( abs(v_out-v_in2) < vl ) {
		if( v_out <= v_in2 ) {
			overlapL2 = 1;
		} else {
			overlapR2 = 1;
		}
	}

	if( !(overlapR1 || overlapR2) || vl <= (unsigned)WB ) {              // 0-2 left side overlaps, no right side overlaps == no hazard
		vbx_set_vl(vl);
		vbxx(VADD, v_out, v_in1, v_in2);
	} else if( !(overlapL1 || overlapL2) ) {              // 0-2 right side overlaps, no left side overlaps == no hazard if traversed backward
		int NROWS = vl / WB;
		vbx_set_vl( WB );
		vbx_set_2D( NROWS, -WB*sizeof(vbx_sp_t), -WB*sizeof(vbx_sp_t), -WB*sizeof(vbx_sp_t) );
		vbxx_2D(VADD, v_out+vl-WB, v_in1+vl-WB, v_in2+vl-WB );
		vbx_set_vl( vl - NROWS*WB );
		vbxx( VADD, v_out, v_in1, v_in2);
	} else {                                       // one of each == hazard
		vbx_sp_push();
		v_temp = (vbx_sp_t *)vbx_sp_malloc(vl*sizeof(vbx_sp_t));
		if(v_temp==NULL){
			vbx_sp_pop();
			return VBW_ERROR_SP_ALLOC_FAILED;
		}
		vbx_set_vl( vl );
		if( overlapR1 ) {                          // we need to make a copy of v_in1 to avoid the hazard
			vbxx( VMOV, v_temp, v_in1);
			vbxx( VADD, v_out, v_temp, v_in2);
		} else {                            // we need to make a copy of v_in2 to avoid the hazard
			vbxx( VMOV, v_temp, v_in2);
			vbxx( VADD, v_out, v_in1, v_temp);
		}
		vbx_sp_pop();
	}

	return VBW_SUCCESS;
}
extern "C" int vbw_vec_add_word(vbx_word_t *v_out, vbx_word_t *v_in1, vbx_word_t *v_in2, unsigned int vl){
	return vbw_vec_add<vbx_word_t>(v_out,v_in1,v_in2,vl);
}
extern "C" int vbw_vec_add_uword(vbx_uword_t *v_out, vbx_uword_t *v_in1, vbx_uword_t *v_in2, unsigned int vl){
	return vbw_vec_add<vbx_uword_t>(v_out,v_in1,v_in2,vl);
}
extern "C" int vbw_vec_add_half(vbx_half_t *v_out, vbx_half_t *v_in1, vbx_half_t *v_in2, unsigned int vl){
	return vbw_vec_add<vbx_half_t>(v_out,v_in1,v_in2,vl);
}
extern "C" int vbw_vec_add_uhalf(vbx_uhalf_t *v_out, vbx_uhalf_t *v_in1, vbx_uhalf_t *v_in2, unsigned int vl){
	return vbw_vec_add<vbx_uhalf_t>(v_out,v_in1,v_in2,vl);
}
extern "C" int vbw_vec_add_byte(vbx_byte_t *v_out, vbx_byte_t *v_in1, vbx_byte_t *v_in2, unsigned int vl){
	return vbw_vec_add<vbx_byte_t>(v_out,v_in1,v_in2,vl);
}
extern "C" int vbw_vec_add_ubyte(vbx_ubyte_t *v_out, vbx_ubyte_t *v_in1, vbx_ubyte_t *v_in2, unsigned int vl){
	return vbw_vec_add<vbx_ubyte_t>(v_out,v_in1,v_in2,vl);
}
