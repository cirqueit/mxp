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

#include "vbw_fix16.h"
static const fxp_t min_fxp = 0x80000000;

/**
 * It now uses newtons method of successive aproximation, this is
 * O(op_size) rather than the possible O(log(op_size)) that is possible,
 * but it is significantly simpler, and more importantly it works.
 * Goldschmidt ( O(logN) ) loses precision when scaling down the
 * denominator to fit in (.5,1]
 */

void vbw_fix16_div( vbx_word_t* v_result, vbx_word_t* v_a, vbx_word_t* v_b, int length )
{
	vbx_uword_t* v_product = vbx_sp_malloc(length*sizeof(vbx_word_t));
	vbx_uword_t* v_tmp = vbx_sp_malloc(length*sizeof(vbx_word_t));
	vbx_uword_t* v_sub = vbx_sp_malloc(length*sizeof(vbx_word_t));
	vbx_word_t* v_neg = vbx_sp_malloc(length*sizeof(vbx_word_t));
	vbx_uword_t* v_quotient=(vbx_uword_t*)v_result;

	vbx_uword_t* v_numerator=(vbx_uword_t*)vbx_sp_malloc(length*sizeof(vbx_word_t));
	vbx_uword_t* v_denominator=(vbx_uword_t*)vbx_sp_malloc(length*sizeof(vbx_word_t));
	//n=abs(a);d=abs(b)
	vbx(SVW,VABSDIFF,(vbx_word_t*)v_numerator,0,v_a);
	vbx(SVW,VABSDIFF,(vbx_word_t*)v_denominator,0,v_b);

	//record if the relsult should be negative
	//v_neg= msb(v_a ^ v_b);
	vbx(VVW,VXOR,v_neg,v_a,v_b);
	vbx(SVW,VAND,v_neg,1<<31,v_neg);



	//successive approximation until v_d * v_q == v_n

	uint32_t bit=1<<31;

	/* v_q = bit; */
	/* while(bit){ */
	/* 	if(v_q*v_d > v_n){ <--watch for overflow here*/
	/* 		v_q ^=bit; */
	/* 	} */
	/* 	bit>>=1; */
	/* 	v_q|=bit; */
	/* } */

	vbx(SVWU,VMOV,v_quotient,bit,0);

	while(bit){
		vbx(VVWU,VMULFXP,v_product,v_denominator,v_quotient);
		vbx(SVWU,VXOR,v_tmp,bit,v_quotient);
		vbx(VVWU,VCMV_FS,v_quotient,v_tmp,v_product); //clear the bit if overflow
		vbx(VVWU,VSUB,v_sub,v_product,v_numerator);
		vbx(VVWU,VCMV_GTZ,v_quotient,v_tmp,v_sub); //clear the bit if gt
		bit>>=1;
		vbx(SVWU,VOR,v_quotient,bit,v_quotient);
	}

	//correct the sign if necessary
	vbx(SVWU,VMUL,v_tmp,-1,v_result);
	vbx(VVWU,VCMV_NZ,(vbx_uword_t*)v_result,v_tmp,(vbx_uword_t*)v_neg);
}

void vbw_fix16_sqrt( vbx_word_t* v_out, vbx_word_t* v_x, int length)
{
  vbx_sp_push();
  //vbx_word_t* v_tmp = (vbx_word_t *)vbx_sp_malloc(sizeof(vbx_word_t)*length*11);
  vbx_word_t* v_tmp = (vbx_word_t *)vbx_sp_malloc(sizeof(vbx_word_t)*length*10);
  vbx_word_t* v_result   = v_tmp + 0*length;
  vbx_uword_t* v_bit      = (vbx_uword_t*)v_tmp + 1*length;
  vbx_word_t* v_num      = v_tmp + 2*length;
  vbx_uword_t* v_else_num = (vbx_uword_t*)v_tmp + 3*length;

  vbx_uword_t* v_t_bit    = (vbx_uword_t*)v_tmp + 4*length;
  vbx_uword_t* v_t_num    = (vbx_uword_t*)v_tmp + 5*length;

  vbx_uword_t* v_t_add    = (vbx_uword_t*)v_tmp + 6*length;
  vbx_word_t* v_t_sub    = v_tmp + 7*length;
  vbx_uword_t* v_t_result = (vbx_uword_t*)v_tmp + 8*length;
  vbx_uword_t* v_if_num   = (vbx_uword_t*)v_tmp + 9*length;
  //vbx_word_t* v_neg   = v_tmp + 10*length;

  v_result = v_out;

	//uint8_t  neg = (inValue < 0);
  //vbx(SVW, VMOV, v_neg, 0, 0 );
  //vbx(SVW, VCMV_LTZ, v_neg, 1, v_x);

	//uint32_t num = (neg ? -inValue : inValue);
  vbx(SVW, VABSDIFF, v_num, 0, v_x);
	//uint32_t result = 0;
  vbx(SVW, VMOV, v_result, 0, 0 );
	//uint32_t bit;
  vbx(SVWU, VMOV, v_bit, (1<<30), 0 );

  //*
	// Many numbers will be less than 15, so
	// this gives a good balance between time spent
	// in if vs. time spent in the while loop
	// when searching for the starting value.
  /*
	if (num & 0xFFF00000)
		bit = (uint32_t)1 << 30;
	else
		bit = (uint32_t)1 << 18;
        */


//	while (bit > num) bit >>= 2;

  int i, max_iter;
  max_iter = 16; //1<<30 and >>2 every iter, so max iter = 30/2 + 1
  for(i=0; i<max_iter; i++){
    vbx(VVW, VSUB, v_t_sub, (vbx_word_t*)v_bit, v_num);
    vbx(SVWU, VSHR, v_t_bit, 2, v_bit);
    vbx(VVW, VCMV_GTZ, (vbx_word_t*)v_bit, (vbx_word_t*)v_t_bit, v_t_sub);
  }

	// The main part is executed twice, in order to avoid
	// using 64 bit values in computations.
  /*
		while (bit)
		{
			if (num >= result + bit)
			{
				num -= result + bit;
				result = (result >> 1) + bit;
			}
			else
			{
				result = (result >> 1);
			}
			bit >>= 2;
		}
  */
  max_iter = 16;
  for(i=0; i<max_iter; i++){

      //v_result + bit
    vbx(VVW, VADD, (vbx_word_t*)v_t_add, (vbx_word_t*)v_bit, v_result);
      //v_num - (v_result + bit)
    vbx(VVW, VSUB, v_t_sub, v_num, (vbx_word_t*)v_t_add);

    //if (v_num - (v_result + bit) >= 0) v_num = v_num - (v_result + bit)
    vbx(VVW, VCMV_GEZ, (vbx_word_t*)v_t_num, v_t_sub, v_t_sub);
    //else v_num stays
    vbx(VVW, VCMV_LTZ, (vbx_word_t*)v_t_num, v_num, v_t_sub);

    vbx(SVW, VSHR, (vbx_word_t*)v_t_result, 1, v_result);
    vbx(VVW, VADD, (vbx_word_t*)v_t_add, (vbx_word_t*)v_bit, (vbx_word_t*)v_t_result);
    //if (v_num - (v_result + bit) >= 0) v_result = v_result >> 1 + bit
    //else  v_result >> 1
    vbx(VVW, VCMV_GEZ, (vbx_word_t*)v_t_result, (vbx_word_t*)v_t_add, v_t_sub);

    vbx(SVW, VSHR, (vbx_word_t*)v_t_bit, 2, (vbx_word_t*)v_bit);

    vbx(VVW, VCMV_GTZ, v_num, (vbx_word_t*)v_t_num, (vbx_word_t*)v_bit);
    vbx(VVW, VCMV_GTZ, v_result, (vbx_word_t*)v_t_result, (vbx_word_t*)v_bit);
    vbx(VVW, VCMV_GTZ, (vbx_word_t*)v_bit, (vbx_word_t*)v_t_bit, (vbx_word_t*)v_bit);
  }

  //vbx(SVW, VSHL, v_result, 8, v_result);

//#if 0
 /*
  if (num > 65535)
  {
    // The remainder 'num' is too large to be shifted left
    // by 16, so we have to add 1 to result manually and
    // adjust 'num' accordingly.
    // num = a - (result + 0.5)^2
    //	 = num + result^2 - (result + 0.5)^2
    //	 = num - result - 0.5
    num -= result;
    num = (num << 16) - 0x8000;
    result = (result << 16) + 0x8000;
  }
  else
  {
    num <<= 16;
    result <<= 16;
  }

  bit = 1 << 14;
  */
  vbx(SVW, VSUB, v_t_sub, 65535, v_num);
  vbx(VVWU, VSUB, v_if_num, (vbx_uword_t*)v_num, (vbx_uword_t*)v_result);
  vbx(SVWU, VSHL, v_if_num, 16, v_if_num);
  vbx(SVWU, VADD, v_if_num, (-1*(0x8000)), v_if_num);

  vbx(SVWU, VSHL, v_t_result, 16, (vbx_uword_t*)v_result);
  vbx(SVWU, VADD, v_t_add, (0x8000), v_t_result);
  vbx(SVWU, VSHL, v_else_num, 16, (vbx_uword_t*)v_num);

  vbx(VVWU, VCMV_LTZ, (vbx_uword_t*)v_num, v_if_num, (vbx_uword_t*)v_t_sub);
  vbx(VVWU, VCMV_GEZ, (vbx_uword_t*)v_num, v_else_num, (vbx_uword_t*)v_t_sub);
  vbx(VVWU, VCMV_LTZ, (vbx_uword_t*)v_result, v_t_add, (vbx_uword_t*)v_t_sub);
  vbx(VVWU, VCMV_GEZ, (vbx_uword_t*)v_result, v_t_result, (vbx_uword_t*)v_t_sub);

  vbx(SVWU, VMOV, v_bit, (1<<14), 0);

  max_iter = 8; //1<<14 and >>2 every iter, so 14/2 + 1
  for(i=0; i<max_iter; i++){

    vbx(VVWU, VADD, v_t_add, v_bit, (vbx_uword_t*)v_result);
    vbx(VVWU, VSUB, (vbx_uword_t*)v_t_sub, (vbx_uword_t*)v_num, v_t_add);

    vbx(VVW, VCMV_GEZ, (vbx_word_t*)v_t_num, v_t_sub, v_t_sub);
    vbx(VVW, VCMV_LTZ, (vbx_word_t*)v_t_num, v_num, v_t_sub);

    vbx(SVWU, VSHR, v_t_result, 1, (vbx_uword_t*)v_result);
    vbx(VVWU, VADD, v_t_add, v_bit, v_t_result);
    vbx(VVW, VCMV_GEZ, (vbx_word_t*)v_t_result, (vbx_word_t*)v_t_add, v_t_sub);

    vbx(SVWU, VSHR, v_t_bit, 2, v_bit);

    vbx(VVWU, VCMV_NZ, (vbx_uword_t*)v_num, v_t_num, v_bit);
    vbx(VVWU, VCMV_NZ, (vbx_uword_t*)v_result, v_t_result, v_bit);
    vbx(VVWU, VCMV_NZ, v_bit, v_t_bit, v_bit);
  }

#ifndef FIXMATH_NO_ROUNDING
  /*
	// Finally, if next bit would have been 1, round the result upwards.
	if (num > result)
	{
		result++;
	}
  */
  vbx(VVW, VSUB, v_t_sub, v_num, v_result);
  vbx(SVW, VADD, (vbx_word_t*)v_t_result, 1, v_result);
  vbx(VVW, VCMV_GTZ, v_result, (vbx_word_t*)v_t_result, v_t_sub);
#endif

  /*
	return (neg ? -result : result);
  */
  vbx(SVW, VSUB, (vbx_word_t*)v_t_result, 0, v_result);
  vbx(VVW, VCMV_LTZ, v_result, (vbx_word_t*)v_t_result, v_x);

  vbx_sp_pop();
}
