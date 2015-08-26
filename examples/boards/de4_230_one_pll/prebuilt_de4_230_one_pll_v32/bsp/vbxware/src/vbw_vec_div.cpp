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

#include <assert.h>

#include "vbw_exit_codes.h"
#include "vbx.h"
#include "vbw_template.hpp"

using namespace VBX;

/** VBX software divide routine.
 *  @pre  Requires about 5 times the aligned vector size in additional free space in the scratchpad.
 *  @pre  v_in1 contains the numerators.
 *  @pre  v_in2 contains the denominators.
 *  @pre  v_out does not overlap a source vector, or overlaps it completely.
 *  @post v_out contains element-wise v_in1[i] divided by v_in2[i].
 *
 *  @returns negative on error condition. See vbw_exit_codes.h
 *  @param[out] v_out Scratchpad pointer to result of the divide
 *  @param[in] v_in1 Scratchpad pointer to the numerator
 *  @param[in] v_in2 Scratchpad pointer to the denominator
 *  @param[in] vl Length of the aforementioned vectors.
 *  @returns negative on error condition. See vbw_exit_codes.h
 */


template<typename vbx_sp_t>
int vbw_vec_divide(vbx_sp_t *v_out, vbx_sp_t *v_in1, vbx_sp_t *v_in2, unsigned int vl)
{
	uint32_t i;
	vbx_set_vl(vl);

	typedef typename unsigned_conv<vbx_sp_t>::type unsigned_sp_t;
	typedef typename signed_conv<vbx_sp_t>::type signed_sp_t;
	Vector<unsigned_sp_t> n((unsigned_sp_t*)v_out,vl); // working copy == v_out
	Vector<unsigned_sp_t> a((unsigned_sp_t*)v_in1,vl); // original input operands
	Vector<unsigned_sp_t> b((unsigned_sp_t*)v_in2,vl);

	// temporaries
	Vector<unsigned_sp_t> pos_a(a);		// working copy of a operand, modified
	Vector<unsigned_sp_t> pos_b(b);		// working copy of b operand, modified
	Vector<unsigned_sp_t> shamt(vl);
	Vector<unsigned_sp_t> x(vl);

	Vector<vbx_ubyte_t> negative_result(vl);


	// datasize values
	const uint32_t ds = sizeof(vbx_sp_t);   // 1, 2 or 4
	const uint32_t SHAMT = ds*8;
	const uint32_t MSB   = 1<<(SHAMT-1);

	// byte:   iter,bump = {1,8}, {2,2}*, {3,1}
	// half:   iter,bump = {4,2}
	// word:   iter,bump = {5,1}
	const uint32_t NUM_ITER      = ( ds==1 ? 2/*byte*/ : (ds==2 ? 4/*half*/ : 5/*word*/) );
	const uint32_t NUM_BUMP_ITER = ( ds==1 ? 2/*byte*/ : (ds==2 ? 2/*half*/ : 1/*word*/) );

	if( is_signed<vbx_sp_t>() ) { //test whether the the type is signed
		negative_result = 0;
		Vector_mask( pos_a.template cast<signed_sp_t>()<0 ) {
			pos_a = -pos_a;
			negative_result ^= 1;
		}
		Vector_mask( pos_b.template cast<signed_sp_t>()<0 ) {
			pos_b = -pos_b;
			negative_result ^= 1;
		}
	}

	// normalize d so it is in the range (0.5,1]
	// normalize n so it is in the range [0.5,1)
	// use 'd' here, but it is aliased to 'x'
	Vector<unsigned_sp_t> &d = x;
	d = pos_b;

	shamt = SHAMT;
#if 0
	// normalize d one bit at a time
	Vector_mask( d<=0x80U, vl ) {
		for( i=0; i<8; i++ ) {
			if(i>0) Vector_mask_narrow( d<=0x80U );
			Vector_mask_narrow( d>0, vl );
			d = d * 2;
			shamt -= 1;
		}
	}
#else
	// normalize d in log(n)+1 steps
	if(ds==4) {
		Vector_mask( d<=0x0000ffffU ) { d = d <<16; shamt -= 16; }
		Vector_mask( d<=0x00ffffffU ) { d = d << 8; shamt -=  8; }
		Vector_mask( d<=0x0fffffffU ) { d = d << 4; shamt -=  4; }
		Vector_mask( d<=0x3fffffffU ) { d = d << 2; shamt -=  2; }
		Vector_mask( d<=0x7fffffffU ) { d = d << 1; shamt -=  1; }
		Vector_mask( d<=0x80000000U ) { d = d << 1; shamt -=  1; }
	} else if (ds==2) {
		Vector_mask( d<=0x00ffU ) { d = d << 8; shamt -=  8; }
		Vector_mask( d<=0x0fffU ) { d = d << 4; shamt -=  4; }
		Vector_mask( d<=0x3fffU ) { d = d << 2; shamt -=  2; }
		Vector_mask( d<=0x7fffU ) { d = d << 1; shamt -=  1; }
		Vector_mask( d<=0x8000U ) { d = d << 1; shamt -=  1; }
	} else if (ds==1) {
		Vector_mask( d<=0x0fU ) { d = d << 4; shamt -=  4; }
		Vector_mask( d<=0x3fU ) { d = d << 2; shamt -=  2; }
		Vector_mask( d<=0x7fU ) { d = d << 1; shamt -=  1; }
		Vector_mask( d<=0x80U ) { d = d << 1; shamt -=  1; }  // FIXME: this last check is needed, but can it be done more efficiently?
	}
#endif

	x = 0 - d;
	n = pos_a;

#if 0
	// my testing shows that normalizing n is not required
	Vector_mask( n>0 ) {
		for( i=0; i<8; i++ ) {
			Vector_mask_narrow( n<0x80 );
			n = n * 2;
			shamt += 1;
		}
	}
#endif

	// the Goldschmidt loop where the actual division is done
	for( i=0; i<NUM_ITER; i++ ) {
		// multiply, check for overflow, and renormalize
		n = n + mulhi(n,x);
		Vector_mask( n.fs() ) {
			n = (n>>1) | MSB; // 0x80;
			shamt--;
		}
		x = mulhi(x,x);
	}
	n = n>>shamt;
	n.cond_move( shamt>=SHAMT, 0 );

	// Goldschmidt is known to accumulate errors in the loop above
	// these are manifested by discarding mullo bits of n*x, x*x
	// to correct for these,  check and add a final few +1's to the answer
	// use 'rem' here, but it is aliased to 'x' to save space
	Vector<unsigned_sp_t> &rem = x;
	rem = (pos_a - n*pos_b);	// n == likely quotient (perhaps rounded down a bit)
	Vector_mask( rem >= pos_b ) {
		n.cond_move( pos_b>0, n+1 );	// first bump is peeled out of loop
		for( i=1; i < NUM_BUMP_ITER; i++ ) {
			rem = rem - pos_b;
			Vector_mask_narrow( rem >= pos_b );
			n.cond_move( pos_b>0, n+1 ); // is implicitly masked
		}
	}

	if( is_signed<vbx_sp_t>() ) { //test whether the the type is signed
		n.cond_move( negative_result.template cast<vbx_sp_t>(), -n.template cast<vbx_sp_t>() );
	}

	return 0;
}

extern "C" int vbw_vec_divide_word(vbx_word_t *v_out, vbx_word_t *v_in1, vbx_word_t *v_in2, unsigned int vl)
{return vbw_vec_divide(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_divide_uword(vbx_uword_t *v_out, vbx_uword_t *v_in1, vbx_uword_t *v_in2, unsigned int vl)
{return vbw_vec_divide(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_divide_half(vbx_half_t *v_out, vbx_half_t *v_in1, vbx_half_t *v_in2, unsigned int vl)
{return vbw_vec_divide(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_divide_uhalf(vbx_uhalf_t *v_out, vbx_uhalf_t *v_in1, vbx_uhalf_t *v_in2, unsigned int vl)
{return vbw_vec_divide(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_divide_byte(vbx_byte_t *v_out, vbx_byte_t *v_in1, vbx_byte_t *v_in2, unsigned int vl)
{return vbw_vec_divide(v_out, v_in1, v_in2, vl);}
extern "C" int vbw_vec_divide_ubyte(vbx_ubyte_t *v_out, vbx_ubyte_t *v_in1, vbx_ubyte_t *v_in2, unsigned int vl)
{return vbw_vec_divide(v_out, v_in1, v_in2, vl);}
