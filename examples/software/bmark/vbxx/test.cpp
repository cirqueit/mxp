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


#include "vbx_copyright.h"
VBXCOPYRIGHT( test_vbxx )

#include "vbx.h"
#include "vbx_test.h"

int compare_results_uhalf(vbx_uhalf_t *v_acc, vbx_uhalf_t *v_1, vbx_uhalf_t *v_2){
  vbx_acc(VVHU, VABSDIFF, v_acc, v_1, v_2);
  vbx_sync();
  return v_acc[0];
}

int compare_results_ubyte(vbx_ubyte_t *v_acc, vbx_ubyte_t *v_1, vbx_ubyte_t *v_2){
  vbx_acc(VVBU, VABSDIFF, v_acc, v_1, v_2);
  vbx_sync();
  return v_acc[0];
}

int compare_results_uword(vbx_uword_t *v_acc, vbx_uword_t *v_1, vbx_uword_t *v_2){
  vbx_acc(VVWU, VABSDIFF, v_acc, v_1, v_2);
  vbx_sync();
  return v_acc[0];
}

int compare_results_half(vbx_half_t *v_acc, vbx_half_t *v_1, vbx_half_t *v_2){
  vbx_acc(VVH, VABSDIFF, v_acc, v_1, v_2);
  vbx_sync();
  return v_acc[0];
}

int compare_results_byte(vbx_byte_t *v_acc, vbx_byte_t *v_1, vbx_byte_t *v_2){
  vbx_acc(VVB, VABSDIFF, v_acc, v_1, v_2);
  vbx_sync();
  return v_acc[0];
}

int compare_results_word(vbx_word_t *v_acc, vbx_word_t *v_1, vbx_word_t *v_2){
  vbx_acc(VVW, VABSDIFF, v_acc, v_1, v_2);
  vbx_sync();
  return v_acc[0];
}

int compare_accumulated_uhalf(vbx_uhalf_t *v_1, vbx_uhalf_t *v_2){
  vbx_sync();
  return v_1[0] - v_2[0];
}

int compare_accumulated_ubyte(vbx_ubyte_t *v_1, vbx_ubyte_t *v_2){
  vbx_sync();
  return v_1[0] - v_2[0];
}

int compare_accumulated_uword(vbx_uword_t *v_1, vbx_uword_t *v_2){
  vbx_sync();
  return v_1[0] - v_2[0];
}

int compare_accumulated_half(vbx_half_t *v_1, vbx_half_t *v_2){
  vbx_sync();
  return v_1[0] - v_2[0];
}

int compare_accumulated_byte(vbx_byte_t *v_1, vbx_byte_t *v_2){
  vbx_sync();
  return v_1[0] - v_2[0];
}

int compare_accumulated_word(vbx_word_t *v_1, vbx_word_t *v_2){
  vbx_sync();
  return v_1[0] - v_2[0];
}

// function version
int test_vec_function()
{
	int N = 8;
	int errors = 0;

	vbx_uhalf_t *v_uhalf_out1 = (vbx_uhalf_t *)vbx_sp_malloc( N*sizeof(vbx_uhalf_t) );
	vbx_uhalf_t *v_uhalf_out2 = (vbx_uhalf_t *)vbx_sp_malloc( N*sizeof(vbx_uhalf_t) );
	vbx_uhalf_t *v_uhalf_in1 = (vbx_uhalf_t *)vbx_sp_malloc( N*sizeof(vbx_uhalf_t) );
	vbx_uhalf_t *v_uhalf_in2 = (vbx_uhalf_t *)vbx_sp_malloc( N*sizeof(vbx_uhalf_t) );
	vbx_uhalf_t *v_uhalf_acc = (vbx_uhalf_t *)vbx_sp_malloc( sizeof(vbx_uhalf_t) );

	vbx_uword_t *v_uword_out1 = (vbx_uword_t *)vbx_sp_malloc( N*sizeof(vbx_uword_t) );
	vbx_uword_t *v_uword_out2 = (vbx_uword_t *)vbx_sp_malloc( N*sizeof(vbx_uword_t) );
	vbx_uword_t *v_uword_in1 = (vbx_uword_t *)vbx_sp_malloc( N*sizeof(vbx_uword_t) );
	vbx_uword_t *v_uword_in2 = (vbx_uword_t *)vbx_sp_malloc( N*sizeof(vbx_uword_t) );
	vbx_uword_t *v_uword_acc = (vbx_uword_t *)vbx_sp_malloc( sizeof(vbx_uword_t) );

	vbx_ubyte_t *v_ubyte_out1 = (vbx_ubyte_t *)vbx_sp_malloc( N*sizeof(vbx_ubyte_t) );
	vbx_ubyte_t *v_ubyte_out2 = (vbx_ubyte_t *)vbx_sp_malloc( N*sizeof(vbx_ubyte_t) );
	vbx_ubyte_t *v_ubyte_in1 = (vbx_ubyte_t *)vbx_sp_malloc( N*sizeof(vbx_ubyte_t) );
	vbx_ubyte_t *v_ubyte_in2 = (vbx_ubyte_t *)vbx_sp_malloc( N*sizeof(vbx_ubyte_t) );
	vbx_ubyte_t *v_ubyte_acc = (vbx_ubyte_t *)vbx_sp_malloc( sizeof(vbx_ubyte_t) );

	vbx_half_t *v_half_out1 = (vbx_half_t *)vbx_sp_malloc( N*sizeof(vbx_half_t) );
	vbx_half_t *v_half_out2 = (vbx_half_t *)vbx_sp_malloc( N*sizeof(vbx_half_t) );
	vbx_half_t *v_half_in1 = (vbx_half_t *)vbx_sp_malloc( N*sizeof(vbx_half_t) );
	vbx_half_t *v_half_in2 = (vbx_half_t *)vbx_sp_malloc( N*sizeof(vbx_half_t) );
	vbx_half_t *v_half_acc = (vbx_half_t *)vbx_sp_malloc( sizeof(vbx_half_t) );

	vbx_word_t *v_word_out1 = (vbx_word_t *)vbx_sp_malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *v_word_out2 = (vbx_word_t *)vbx_sp_malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *v_word_in1 = (vbx_word_t *)vbx_sp_malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *v_word_in2 = (vbx_word_t *)vbx_sp_malloc( N*sizeof(vbx_word_t) );
	vbx_word_t *v_word_acc = (vbx_word_t *)vbx_sp_malloc( sizeof(vbx_word_t) );

	vbx_byte_t *v_byte_out1 = (vbx_byte_t *)vbx_sp_malloc( N*sizeof(vbx_byte_t) );
	vbx_byte_t *v_byte_out2 = (vbx_byte_t *)vbx_sp_malloc( N*sizeof(vbx_byte_t) );
	vbx_byte_t *v_byte_in1 = (vbx_byte_t *)vbx_sp_malloc( N*sizeof(vbx_byte_t) );
	vbx_byte_t *v_byte_in2 = (vbx_byte_t *)vbx_sp_malloc( N*sizeof(vbx_byte_t) );
	vbx_byte_t *v_byte_acc = (vbx_byte_t *)vbx_sp_malloc( sizeof(vbx_byte_t) );

	vbx_set_vl( N );

  //initialize ops
	vbx( SEH, VAND, (vbx_half_t *)v_ubyte_in1,       0xf, 0 );
	vbx( SEH, VAND, (vbx_half_t *)v_uhalf_in1,       0xf, 0 );
	vbx( SEH, VAND, (vbx_half_t *)v_uword_in1,       0xf, 0 );
	vbx( SEH, VAND, (vbx_half_t *)v_byte_in1,       0xf, 0 );
	vbx( SEH, VAND, (vbx_half_t *)v_half_in1,       0xf, 0 );
	vbx( SEH, VAND, (vbx_half_t *)v_word_in1,       0xf, 0 );

	vbx( SEH, VMUL, (vbx_half_t *)v_ubyte_in2, 0x00101010, 0 );
	vbx( SEH, VMUL, (vbx_half_t *)v_uhalf_in2, 0x00101010, 0 );
	vbx( SEH, VMUL, (vbx_half_t *)v_uword_in2, 0x00101010, 0 );
	vbx( SEH, VMUL, (vbx_half_t *)v_byte_in2, 0x00101010, 0 );
	vbx( SEH, VMUL, (vbx_half_t *)v_half_in2, 0x00101010, 0 );
	vbx( SEH, VMUL, (vbx_half_t *)v_word_in2, 0x00101010, 0 );

	vbx_sync();

  //-------------------------------------------------
	vbx_enum_t *v_enum = 0;

#if 1 //enable tests
	vbxx( VABSDIFF, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVB, VABSDIFF, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVB, VOR, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVB, VROTR, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVB, VCMV_GEZ, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_byte_out1, v_byte_in1 );
	vbxasm( VVB, VSUBB, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_byte_out1, v_byte_in1 );
	vbxasm( VVB, VAND, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_byte_out1, v_byte_in1 );
	vbxasm( VVB, VROTL, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBU, VADDC, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBU, VMULFXP, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBU, VSHR, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBU, VCMV_GTZ, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_ubyte_out1, v_ubyte_in1 );
	vbxasm( VVBU, VSUB, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_ubyte_out1, v_ubyte_in1 );
	vbxasm( VVBU, VMULHI, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_ubyte_out1, v_ubyte_in1 );
	vbxasm( VVBU, VSHL, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBH, VADD, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBH, VMUL, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBH, VXOR, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBH, VCMV_Z, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBHU, VSUBB, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBHU, VAND, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBHU, VROTL, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBHU, VCMV_LTZ, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBW, VSUB, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBW, VMULHI, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBW, VSHL, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBW, VCMV_LEZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm( VVBW, VCMV_NZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMOV, v_word_out1, v_byte_in1 );
	vbxasm( VVBW, VMOV, v_word_out2, v_byte_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBWU, VABSDIFF, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBWU, VOR, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBWU, VROTR, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm( VVBWU, VCMV_GEZ, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHB, VADDC, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHB, VMULFXP, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHB, VSHR, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHB, VCMV_GTZ, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHBU, VADD, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHBU, VMUL, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHBU, VXOR, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHBU, VCMV_Z, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm( VVH, VSUBB, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm( VVH, VAND, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm( VVH, VROTL, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm( VVH, VCMV_LTZ, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_half_out1, v_half_in1 );
	vbxasm( VVH, VADDC, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_half_out1, v_half_in1 );
	vbxasm( VVH, VMULFXP, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_half_out1, v_half_in1 );
	vbxasm( VVH, VSHR, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHU, VSUB, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHU, VMULHI, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHU, VSHL, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHU, VCMV_LEZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHU, VCMV_NZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_uhalf_out1, v_uhalf_in1 );
	vbxasm( VVHU, VADD, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_uhalf_out1, v_uhalf_in1 );
	vbxasm( VVHU, VMUL, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_uhalf_out1, v_uhalf_in1 );
	vbxasm( VVHU, VXOR, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMOV, v_uhalf_out1, v_uhalf_in1 );
	vbxasm( VVHU, VMOV, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHW, VABSDIFF, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHW, VOR, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHW, VROTR, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm( VVHW, VCMV_GEZ, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHWU, VADDC, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHWU, VMULFXP, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHWU, VSHR, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm( VVHWU, VCMV_GTZ, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWB, VADD, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWB, VMUL, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWB, VXOR, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWB, VCMV_Z, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWBU, VSUBB, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWBU, VAND, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWBU, VROTL, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWBU, VCMV_LTZ, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWH, VSUB, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWH, VMULHI, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWH, VSHL, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWH, VCMV_LEZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm( VVWH, VCMV_NZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMOV, v_half_out1, v_word_in1 );
	vbxasm( VVWH, VMOV, v_half_out2, v_word_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWHU, VABSDIFF, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWHU, VOR, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWHU, VROTR, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWHU, VCMV_GEZ, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm( VVW, VADDC, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm( VVW, VMULFXP, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm( VVW, VSHR, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm( VVW, VCMV_GTZ, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_word_out1, v_word_in1 );
	vbxasm( VVW, VSUB, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_word_out1, v_word_in1 );
	vbxasm( VVW, VMULHI, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_word_out1, v_word_in1 );
	vbxasm( VVW, VSHL, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWU, VADD, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWU, VMUL, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWU, VXOR, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm( VVWU, VCMV_Z, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_uword_out1, v_uword_in1 );
	vbxasm( VVWU, VABSDIFF, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_uword_out1, v_uword_in1 );
	vbxasm( VVWU, VOR, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_uword_out1, v_uword_in1 );
	vbxasm( VVWU, VROTR, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_byte_out1, 8, v_byte_in2 );
	vbxasm( SVB, VSUBB, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_byte_out1, 8, v_byte_in2 );
	vbxasm( SVB, VAND, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_byte_out1, 8, v_byte_in2 );
	vbxasm( SVB, VROTL, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_byte_out1, 8, v_byte_in2 );
	vbxasm( SVB, VCMV_LTZ, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}
	vbxx( VADDC, v_byte_out1, 8 );
	vbxasm( SVB, VADDC, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_byte_out1, 8 );

	vbxasm( SVB, VMULFXP, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}
	errors=0;
	vbxx( VSHR, v_byte_out1, 8 );
	vbxasm( SVB, VSHR, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm( SVBU, VSUB, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm( SVBU, VMULHI, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm( SVBU, VSHL, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm( SVBU, VCMV_LEZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm( SVBU, VCMV_NZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_ubyte_out1, 8 );
	vbxasm( SVBU, VADD, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_ubyte_out1, 8 );
	vbxasm( SVBU, VMUL, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_ubyte_out1, 8 );
	vbxasm( SVBU, VXOR, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMOV, v_ubyte_out1, 8 );
	vbxasm( SVBU, VMOV, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_half_out1, 8, v_byte_in2 );
	vbxasm( SVBH, VABSDIFF, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_half_out1, 8, v_byte_in2 );
	vbxasm( SVBH, VOR, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_half_out1, 8, v_byte_in2 );
	vbxasm( SVBH, VROTR, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_half_out1, 8, v_byte_in2 );
	vbxasm( SVBH, VCMV_GEZ, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm( SVBHU, VSUBB, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm( SVBHU, VAND, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm( SVBHU, VROTL, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm( SVBHU, VCMV_LTZ, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_word_out1, 8, v_byte_in2 );
	vbxasm( SVBW, VADDC, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_word_out1, 8, v_byte_in2 );
	vbxasm( SVBW, VMULFXP, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_word_out1, 8, v_byte_in2 );
	vbxasm( SVBW, VSHR, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_word_out1, 8, v_byte_in2 );
	vbxasm( SVBW, VCMV_GTZ, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm( SVBWU, VSUB, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm( SVBWU, VMULHI, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm( SVBWU, VSHL, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm( SVBWU, VCMV_LEZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm( SVBWU, VCMV_NZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_byte_out1, 8, v_half_in2 );
	vbxasm( SVHB, VADD, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_byte_out1, 8, v_half_in2 );
	vbxasm( SVHB, VMUL, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_byte_out1, 8, v_half_in2 );
	vbxasm( SVHB, VXOR, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_byte_out1, 8, v_half_in2 );
	vbxasm( SVHB, VCMV_Z, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm( SVHBU, VABSDIFF, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm( SVHBU, VOR, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm( SVHBU, VROTR, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm( SVHBU, VCMV_GEZ, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_half_out1, 8, v_half_in2 );
	vbxasm( SVH, VSUBB, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_half_out1, 8, v_half_in2 );
	vbxasm( SVH, VAND, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_half_out1, 8, v_half_in2 );
	vbxasm( SVH, VROTL, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_half_out1, 8, v_half_in2 );
	vbxasm( SVH, VCMV_LTZ, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_half_out1, 8 );
	vbxasm( SVH, VADDC, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_half_out1, 8 );
	vbxasm( SVH, VMULFXP, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_half_out1, 8 );
	vbxasm( SVH, VSHR, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm( SVHU, VSUB, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm( SVHU, VMULHI, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm( SVHU, VSHL, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm( SVHU, VCMV_LEZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm( SVHU, VCMV_NZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_uhalf_out1, 8 );
	vbxasm( SVHU, VADD, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_uhalf_out1, 8 );
	vbxasm( SVHU, VMUL, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_uhalf_out1, 8 );
	vbxasm( SVHU, VXOR, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMOV, v_uhalf_out1, 8 );
	vbxasm( SVHU, VMOV, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_word_out1, 8, v_half_in2 );
	vbxasm( SVHW, VABSDIFF, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_word_out1, 8, v_half_in2 );
	vbxasm( SVHW, VOR, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_word_out1, 8, v_half_in2 );
	vbxasm( SVHW, VROTR, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_word_out1, 8, v_half_in2 );
	vbxasm( SVHW, VCMV_GEZ, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm( SVHWU, VSUBB, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm( SVHWU, VAND, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm( SVHWU, VROTL, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm( SVHWU, VCMV_LTZ, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_byte_out1, 8, v_word_in2 );
	vbxasm( SVWB, VADDC, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_byte_out1, 8, v_word_in2 );
	vbxasm( SVWB, VMULFXP, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_byte_out1, 8, v_word_in2 );
	vbxasm( SVWB, VSHR, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_byte_out1, 8, v_word_in2 );
	vbxasm( SVWB, VCMV_GTZ, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm( SVWBU, VSUB, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm( SVWBU, VMULHI, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm( SVWBU, VSHL, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm( SVWBU, VCMV_LEZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm( SVWBU, VCMV_NZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_half_out1, 8, v_word_in2 );
	vbxasm( SVWH, VADD, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_half_out1, 8, v_word_in2 );
	vbxasm( SVWH, VMUL, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_half_out1, 8, v_word_in2 );
	vbxasm( SVWH, VXOR, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_half_out1, 8, v_word_in2 );
	vbxasm( SVWH, VCMV_Z, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm( SVWHU, VABSDIFF, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm( SVWHU, VOR, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm( SVWHU, VROTR, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm( SVWHU, VCMV_GEZ, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_word_out1, 8, v_word_in2 );
	vbxasm( SVW, VSUBB, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_word_out1, 8, v_word_in2 );
	vbxasm( SVW, VAND, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_word_out1, 8, v_word_in2 );
	vbxasm( SVW, VROTL, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_word_out1, 8, v_word_in2 );
	vbxasm( SVW, VCMV_LTZ, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_word_out1, 8 );
	vbxasm( SVW, VADDC, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_word_out1, 8 );
	vbxasm( SVW, VMULFXP, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_word_out1, 8 );
	vbxasm( SVW, VSHR, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_uword_out1, 8, v_uword_in2 );
	vbxasm( SVWU, VSUB, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_uword_out1, 8, v_uword_in2 );
	vbxasm( SVWU, VMULHI, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_uword_out1, 8, v_uword_in2 );
	vbxasm( SVWU, VSHL, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm( SVWU, VCMV_LEZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm( SVWU, VCMV_NZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_uword_out1, 8 );
	vbxasm( SVWU, VADD, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_uword_out1, 8 );
	vbxasm( SVWU, VMUL, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_uword_out1, 8 );
	vbxasm( SVWU, VXOR, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMOV, v_uword_out1, 8 );
	vbxasm( SVWU, VMOV, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_byte_out1, v_byte_in1, v_enum );
	vbxasm( VEB, VABSDIFF, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_byte_out1, v_byte_in1, v_enum );
	vbxasm( VEB, VOR, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_byte_out1, v_byte_in1, v_enum );
	vbxasm( VEB, VROTR, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_byte_out1, v_byte_in1, v_enum );
	vbxasm( VEB, VCMV_GEZ, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_byte_out1, v_enum );
	vbxasm( VEB, VSUBB, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_byte_out1, v_enum );
	vbxasm( VEB, VAND, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_byte_out1, v_enum );
	vbxasm( VEB, VROTL, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm( VEBU, VADDC, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm( VEBU, VMULFXP, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm( VEBU, VSHR, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm( VEBU, VCMV_GTZ, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_ubyte_out1, v_enum );
	vbxasm( VEBU, VSUB, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_ubyte_out1, v_enum );
	vbxasm( VEBU, VMULHI, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_ubyte_out1, v_enum );
	vbxasm( VEBU, VSHL, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_half_out1, v_half_in1, v_enum );
	vbxasm( VEH, VADD, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_half_out1, v_half_in1, v_enum );
	vbxasm( VEH, VMUL, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_half_out1, v_half_in1, v_enum );
	vbxasm( VEH, VXOR, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_half_out1, v_half_in1, v_enum );
	vbxasm( VEH, VCMV_Z, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_half_out1, v_enum );
	vbxasm( VEH, VABSDIFF, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_half_out1, v_enum );
	vbxasm( VEH, VOR, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_half_out1, v_enum );
	vbxasm( VEH, VROTR, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm( VEHU, VSUBB, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm( VEHU, VAND, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm( VEHU, VROTL, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm( VEHU, VCMV_LTZ, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_uhalf_out1, v_enum );
	vbxasm( VEHU, VADDC, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_uhalf_out1, v_enum );
	vbxasm( VEHU, VMULFXP, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_uhalf_out1, v_enum );
	vbxasm( VEHU, VSHR, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_word_out1, v_word_in1, v_enum );
	vbxasm( VEW, VSUB, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_word_out1, v_word_in1, v_enum );
	vbxasm( VEW, VMULHI, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_word_out1, v_word_in1, v_enum );
	vbxasm( VEW, VSHL, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_word_out1, v_word_in1, v_enum );
	vbxasm( VEW, VCMV_LEZ, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_word_out1, v_word_in1, v_enum );
	vbxasm( VEW, VCMV_NZ, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_word_out1, v_enum );
	vbxasm( VEW, VADD, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_word_out1, v_enum );
	vbxasm( VEW, VMUL, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_word_out1, v_enum );
	vbxasm( VEW, VXOR, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_uword_out1, v_uword_in1, v_enum );
	vbxasm( VEWU, VABSDIFF, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_uword_out1, v_uword_in1, v_enum );
	vbxasm( VEWU, VOR, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_uword_out1, v_uword_in1, v_enum );
	vbxasm( VEWU, VROTR, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_uword_out1, v_uword_in1, v_enum );
	vbxasm( VEWU, VCMV_GEZ, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_uword_out1, v_enum );
	vbxasm( VEWU, VSUBB, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_uword_out1, v_enum );
	vbxasm( VEWU, VAND, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_uword_out1, v_enum );
	vbxasm( VEWU, VROTL, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_byte_out1, 8, v_enum );
	vbxasm( SEB, VADDC, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_byte_out1, 8, v_enum );
	vbxasm( SEB, VMULFXP, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_byte_out1, 8, v_enum );
	vbxasm( SEB, VSHR, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_byte_out1, 8, v_enum );
	vbxasm( SEB, VCMV_GTZ, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUB, v_ubyte_out1, 8, v_enum );
	vbxasm( SEBU, VSUB, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULHI, v_ubyte_out1, 8, v_enum );
	vbxasm( SEBU, VMULHI, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHL, v_ubyte_out1, 8, v_enum );
	vbxasm( SEBU, VSHL, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LEZ, v_ubyte_out1, 8, v_enum );
	vbxasm( SEBU, VCMV_LEZ, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_NZ, v_ubyte_out1, 8, v_enum );
	vbxasm( SEBU, VCMV_NZ, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADD, v_half_out1, 8, v_enum );
	vbxasm( SEH, VADD, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMUL, v_half_out1, 8, v_enum );
	vbxasm( SEH, VMUL, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VXOR, v_half_out1, 8, v_enum );
	vbxasm( SEH, VXOR, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_Z, v_half_out1, 8, v_enum );
	vbxasm( SEH, VCMV_Z, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VABSDIFF, v_uhalf_out1, 8, v_enum );
	vbxasm( SEHU, VABSDIFF, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VOR, v_uhalf_out1, 8, v_enum );
	vbxasm( SEHU, VOR, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTR, v_uhalf_out1, 8, v_enum );
	vbxasm( SEHU, VROTR, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GEZ, v_uhalf_out1, 8, v_enum );
	vbxasm( SEHU, VCMV_GEZ, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSUBB, v_word_out1, 8, v_enum );
	vbxasm( SEW, VSUBB, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VAND, v_word_out1, 8, v_enum );
	vbxasm( SEW, VAND, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VROTL, v_word_out1, 8, v_enum );
	vbxasm( SEW, VROTL, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_LTZ, v_word_out1, 8, v_enum );
	vbxasm( SEW, VCMV_LTZ, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VADDC, v_uword_out1, 8, v_enum );
	vbxasm( SEWU, VADDC, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VMULFXP, v_uword_out1, 8, v_enum );
	vbxasm( SEWU, VMULFXP, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VSHR, v_uword_out1, 8, v_enum );
	vbxasm( SEWU, VSHR, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx( VCMV_GTZ, v_uword_out1, 8, v_enum );
	vbxasm( SEWU, VCMV_GTZ, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVB, VSUB, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVB, VMULHI, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVB, VSHL, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVB, VCMV_LEZ, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVB, VCMV_NZ, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_byte_out1, v_byte_in1 );
	vbxasm_acc( VVB, VADD, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_byte_out1, v_byte_in1 );
	vbxasm_acc( VVB, VMUL, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_byte_out1, v_byte_in1 );
	vbxasm_acc( VVB, VXOR, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMOV, v_byte_out1, v_byte_in1 );
	vbxasm_acc( VVB, VMOV, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBU, VABSDIFF, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBU, VOR, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBU, VROTR, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBU, VCMV_GEZ, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc( VVBU, VSUBB, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc( VVBU, VAND, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc( VVBU, VROTL, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBH, VADDC, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBH, VMULFXP, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBH, VSHR, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBH, VCMV_GTZ, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBHU, VADD, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBHU, VMUL, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBHU, VXOR, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBHU, VCMV_Z, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBW, VSUBB, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBW, VAND, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBW, VROTL, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc( VVBW, VCMV_LTZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBWU, VSUB, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBWU, VMULHI, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBWU, VSHL, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBWU, VCMV_LEZ, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc( VVBWU, VCMV_NZ, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMOV, v_uword_out1, v_ubyte_in1 );
	vbxasm_acc( VVBWU, VMOV, v_uword_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHB, VABSDIFF, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHB, VOR, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHB, VROTR, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHB, VCMV_GEZ, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHBU, VADDC, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHBU, VMULFXP, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHBU, VSHR, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHBU, VCMV_GTZ, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVH, VADD, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVH, VMUL, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVH, VXOR, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVH, VCMV_Z, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_half_out1, v_half_in1 );
	vbxasm_acc( VVH, VABSDIFF, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_half_out1, v_half_in1 );
	vbxasm_acc( VVH, VOR, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_half_out1, v_half_in1 );
	vbxasm_acc( VVH, VROTR, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHU, VSUBB, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHU, VAND, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHU, VROTL, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHU, VCMV_LTZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc( VVHU, VADDC, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc( VVHU, VMULFXP, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc( VVHU, VSHR, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHW, VSUB, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHW, VMULHI, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHW, VSHL, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHW, VCMV_LEZ, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc( VVHW, VCMV_NZ, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMOV, v_word_out1, v_half_in1 );
	vbxasm_acc( VVHW, VMOV, v_word_out2, v_half_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHWU, VABSDIFF, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHWU, VOR, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHWU, VROTR, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc( VVHWU, VCMV_GEZ, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWB, VADDC, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWB, VMULFXP, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWB, VSHR, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWB, VCMV_GTZ, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWBU, VADD, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWBU, VMUL, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWBU, VXOR, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWBU, VCMV_Z, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWH, VSUBB, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWH, VAND, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWH, VROTL, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVWH, VCMV_LTZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWHU, VSUB, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWHU, VMULHI, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWHU, VSHL, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWHU, VCMV_LEZ, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWHU, VCMV_NZ, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMOV, v_uhalf_out1, v_uword_in1 );
	vbxasm_acc( VVWHU, VMOV, v_uhalf_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVW, VABSDIFF, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVW, VOR, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVW, VROTR, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc( VVW, VCMV_GEZ, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_word_out1, v_word_in1 );
	vbxasm_acc( VVW, VSUBB, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_word_out1, v_word_in1 );
	vbxasm_acc( VVW, VAND, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_word_out1, v_word_in1 );
	vbxasm_acc( VVW, VROTL, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWU, VADDC, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWU, VMULFXP, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWU, VSHR, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc( VVWU, VCMV_GTZ, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_uword_out1, v_uword_in1 );
	vbxasm_acc( VVWU, VSUB, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_uword_out1, v_uword_in1 );
	vbxasm_acc( VVWU, VMULHI, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_uword_out1, v_uword_in1 );
	vbxasm_acc( VVWU, VSHL, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc( SVB, VADD, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc( SVB, VMUL, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc( SVB, VXOR, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc( SVB, VCMV_Z, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_byte_out1, 8 );
	vbxasm_acc( SVB, VABSDIFF, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_byte_out1, 8 );
	vbxasm_acc( SVB, VOR, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_byte_out1, 8 );
	vbxasm_acc( SVB, VROTR, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBU, VSUBB, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBU, VAND, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBU, VROTL, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBU, VCMV_LTZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_ubyte_out1, 8 );
	vbxasm_acc( SVBU, VADDC, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_ubyte_out1, 8 );
	vbxasm_acc( SVBU, VMULFXP, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_ubyte_out1, 8 );
	vbxasm_acc( SVBU, VSHR, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBH, VSUB, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBH, VMULHI, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBH, VSHL, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBH, VCMV_LEZ, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBH, VCMV_NZ, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBHU, VADD, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBHU, VMUL, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBHU, VXOR, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBHU, VCMV_Z, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBW, VABSDIFF, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBW, VOR, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBW, VROTR, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc( SVBW, VCMV_GEZ, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBWU, VSUBB, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBWU, VAND, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBWU, VROTL, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc( SVBWU, VCMV_LTZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc( SVHB, VADDC, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc( SVHB, VMULFXP, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc( SVHB, VSHR, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc( SVHB, VCMV_GTZ, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHBU, VSUB, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHBU, VMULHI, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHBU, VSHL, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHBU, VCMV_LEZ, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHBU, VCMV_NZ, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_half_out1, 8, v_half_in2 );
	vbxasm_acc( SVH, VADD, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_half_out1, 8, v_half_in2 );
	vbxasm_acc( SVH, VMUL, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_half_out1, 8, v_half_in2 );
	vbxasm_acc( SVH, VXOR, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_half_out1, 8, v_half_in2 );
	vbxasm_acc( SVH, VCMV_Z, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_half_out1, 8 );
	vbxasm_acc( SVH, VABSDIFF, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_half_out1, 8 );
	vbxasm_acc( SVH, VOR, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_half_out1, 8 );
	vbxasm_acc( SVH, VROTR, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHU, VSUBB, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHU, VAND, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHU, VROTL, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHU, VCMV_LTZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_uhalf_out1, 8 );
	vbxasm_acc( SVHU, VADDC, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_uhalf_out1, 8 );
	vbxasm_acc( SVHU, VMULFXP, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_uhalf_out1, 8 );
	vbxasm_acc( SVHU, VSHR, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_word_out1, 8, v_half_in2 );
	vbxasm_acc( SVHW, VSUB, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_word_out1, 8, v_half_in2 );
	vbxasm_acc( SVHW, VMULHI, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_word_out1, 8, v_half_in2 );
	vbxasm_acc( SVHW, VSHL, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_word_out1, 8, v_half_in2 );
	vbxasm_acc( SVHW, VCMV_LEZ, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_word_out1, 8, v_half_in2 );
	vbxasm_acc( SVHW, VCMV_NZ, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHWU, VADD, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHWU, VMUL, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHWU, VXOR, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc( SVHWU, VCMV_Z, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc( SVWB, VABSDIFF, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc( SVWB, VOR, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc( SVWB, VROTR, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc( SVWB, VCMV_GEZ, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWBU, VSUBB, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWBU, VAND, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWBU, VROTL, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWBU, VCMV_LTZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_half_out1, 8, v_word_in2 );
	vbxasm_acc( SVWH, VADDC, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_half_out1, 8, v_word_in2 );
	vbxasm_acc( SVWH, VMULFXP, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_half_out1, 8, v_word_in2 );
	vbxasm_acc( SVWH, VSHR, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_half_out1, 8, v_word_in2 );
	vbxasm_acc( SVWH, VCMV_GTZ, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWHU, VSUB, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWHU, VMULHI, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWHU, VSHL, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWHU, VCMV_LEZ, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWHU, VCMV_NZ, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_word_out1, 8, v_word_in2 );
	vbxasm_acc( SVW, VADD, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_word_out1, 8, v_word_in2 );
	vbxasm_acc( SVW, VMUL, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_word_out1, 8, v_word_in2 );
	vbxasm_acc( SVW, VXOR, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_word_out1, 8, v_word_in2 );
	vbxasm_acc( SVW, VCMV_Z, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_word_out1, 8 );
	vbxasm_acc( SVW, VABSDIFF, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_word_out1, 8 );
	vbxasm_acc( SVW, VOR, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_word_out1, 8 );
	vbxasm_acc( SVW, VROTR, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWU, VSUBB, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWU, VAND, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWU, VROTL, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc( SVWU, VCMV_LTZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_uword_out1, 8 );
	vbxasm_acc( SVWU, VADDC, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_uword_out1, 8 );
	vbxasm_acc( SVWU, VMULFXP, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_uword_out1, 8 );
	vbxasm_acc( SVWU, VSHR, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc( VEB, VSUB, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc( VEB, VMULHI, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc( VEB, VSHL, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc( VEB, VCMV_LEZ, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc( VEB, VCMV_NZ, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_byte_out1, v_enum );
	vbxasm_acc( VEB, VADD, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_byte_out1, v_enum );
	vbxasm_acc( VEB, VMUL, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_byte_out1, v_enum );
	vbxasm_acc( VEB, VXOR, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc( VEBU, VABSDIFF, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc( VEBU, VOR, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc( VEBU, VROTR, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc( VEBU, VCMV_GEZ, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_ubyte_out1, v_enum );
	vbxasm_acc( VEBU, VSUBB, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_ubyte_out1, v_enum );
	vbxasm_acc( VEBU, VAND, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_ubyte_out1, v_enum );
	vbxasm_acc( VEBU, VROTL, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc( VEH, VADDC, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc( VEH, VMULFXP, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc( VEH, VSHR, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc( VEH, VCMV_GTZ, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_half_out1, v_enum );
	vbxasm_acc( VEH, VSUB, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_half_out1, v_enum );
	vbxasm_acc( VEH, VMULHI, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_half_out1, v_enum );
	vbxasm_acc( VEH, VSHL, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc( VEHU, VADD, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc( VEHU, VMUL, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc( VEHU, VXOR, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc( VEHU, VCMV_Z, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_uhalf_out1, v_enum );
	vbxasm_acc( VEHU, VABSDIFF, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_uhalf_out1, v_enum );
	vbxasm_acc( VEHU, VOR, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_uhalf_out1, v_enum );
	vbxasm_acc( VEHU, VROTR, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc( VEW, VSUBB, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc( VEW, VAND, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc( VEW, VROTL, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc( VEW, VCMV_LTZ, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_word_out1, v_enum );
	vbxasm_acc( VEW, VADDC, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_word_out1, v_enum );
	vbxasm_acc( VEW, VMULFXP, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_word_out1, v_enum );
	vbxasm_acc( VEW, VSHR, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc( VEWU, VSUB, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc( VEWU, VMULHI, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc( VEWU, VSHL, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc( VEWU, VCMV_LEZ, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc( VEWU, VCMV_NZ, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_uword_out1, v_enum );
	vbxasm_acc( VEWU, VADD, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_uword_out1, v_enum );
	vbxasm_acc( VEWU, VMUL, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_uword_out1, v_enum );
	vbxasm_acc( VEWU, VXOR, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_byte_out1, 8, v_enum );
	vbxasm_acc( SEB, VABSDIFF, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_byte_out1, 8, v_enum );
	vbxasm_acc( SEB, VOR, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_byte_out1, 8, v_enum );
	vbxasm_acc( SEB, VROTR, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_byte_out1, 8, v_enum );
	vbxasm_acc( SEB, VCMV_GEZ, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUBB, v_ubyte_out1, 8, v_enum );
	vbxasm_acc( SEBU, VSUBB, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VAND, v_ubyte_out1, 8, v_enum );
	vbxasm_acc( SEBU, VAND, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTL, v_ubyte_out1, 8, v_enum );
	vbxasm_acc( SEBU, VROTL, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LTZ, v_ubyte_out1, 8, v_enum );
	vbxasm_acc( SEBU, VCMV_LTZ, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADDC, v_half_out1, 8, v_enum );
	vbxasm_acc( SEH, VADDC, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULFXP, v_half_out1, 8, v_enum );
	vbxasm_acc( SEH, VMULFXP, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHR, v_half_out1, 8, v_enum );
	vbxasm_acc( SEH, VSHR, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GTZ, v_half_out1, 8, v_enum );
	vbxasm_acc( SEH, VCMV_GTZ, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSUB, v_uhalf_out1, 8, v_enum );
	vbxasm_acc( SEHU, VSUB, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMULHI, v_uhalf_out1, 8, v_enum );
	vbxasm_acc( SEHU, VMULHI, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VSHL, v_uhalf_out1, 8, v_enum );
	vbxasm_acc( SEHU, VSHL, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_LEZ, v_uhalf_out1, 8, v_enum );
	vbxasm_acc( SEHU, VCMV_LEZ, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_NZ, v_uhalf_out1, 8, v_enum );
	vbxasm_acc( SEHU, VCMV_NZ, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VADD, v_word_out1, 8, v_enum );
	vbxasm_acc( SEW, VADD, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VMUL, v_word_out1, 8, v_enum );
	vbxasm_acc( SEW, VMUL, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VXOR, v_word_out1, 8, v_enum );
	vbxasm_acc( SEW, VXOR, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_Z, v_word_out1, 8, v_enum );
	vbxasm_acc( SEW, VCMV_Z, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VABSDIFF, v_uword_out1, 8, v_enum );
	vbxasm_acc( SEWU, VABSDIFF, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VOR, v_uword_out1, 8, v_enum );
	vbxasm_acc( SEWU, VOR, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VROTR, v_uword_out1, 8, v_enum );
	vbxasm_acc( SEWU, VROTR, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc( VCMV_GEZ, v_uword_out1, 8, v_enum );
	vbxasm_acc( SEWU, VCMV_GEZ, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVB, VSUBB, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVB, VAND, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVB, VROTL, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVB, VCMV_LTZ, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_byte_out1, v_byte_in1 );
	vbxasm_2D( VVB, VADDC, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_byte_out1, v_byte_in1 );
	vbxasm_2D( VVB, VMULFXP, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_byte_out1, v_byte_in1 );
	vbxasm_2D( VVB, VSHR, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBU, VSUB, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBU, VMULHI, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBU, VSHL, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBU, VCMV_LEZ, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBU, VCMV_NZ, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_2D( VVBU, VADD, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_2D( VVBU, VMUL, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_2D( VVBU, VXOR, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMOV, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_2D( VVBU, VMOV, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBH, VABSDIFF, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBH, VOR, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBH, VROTR, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBH, VCMV_GEZ, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBHU, VADDC, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBHU, VMULFXP, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBHU, VSHR, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBHU, VCMV_GTZ, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBW, VADD, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBW, VMUL, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBW, VXOR, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_2D( VVBW, VCMV_Z, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBWU, VSUBB, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBWU, VAND, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBWU, VROTL, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_2D( VVBWU, VCMV_LTZ, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHB, VSUB, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHB, VMULHI, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHB, VSHL, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHB, VCMV_LEZ, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHB, VCMV_NZ, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMOV, v_byte_out1, v_half_in1 );
	vbxasm_2D( VVHB, VMOV, v_byte_out2, v_half_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHBU, VABSDIFF, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHBU, VOR, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHBU, VROTR, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHBU, VCMV_GEZ, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVH, VADDC, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVH, VMULFXP, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVH, VSHR, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVH, VCMV_GTZ, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_half_out1, v_half_in1 );
	vbxasm_2D( VVH, VSUB, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_half_out1, v_half_in1 );
	vbxasm_2D( VVH, VMULHI, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_half_out1, v_half_in1 );
	vbxasm_2D( VVH, VSHL, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHU, VADD, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHU, VMUL, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHU, VXOR, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHU, VCMV_Z, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_2D( VVHU, VABSDIFF, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_2D( VVHU, VOR, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_2D( VVHU, VROTR, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHW, VSUBB, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHW, VAND, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHW, VROTL, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_2D( VVHW, VCMV_LTZ, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHWU, VSUB, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHWU, VMULHI, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHWU, VSHL, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHWU, VCMV_LEZ, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_2D( VVHWU, VCMV_NZ, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMOV, v_uword_out1, v_uhalf_in1 );
	vbxasm_2D( VVHWU, VMOV, v_uword_out2, v_uhalf_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWB, VABSDIFF, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWB, VOR, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWB, VROTR, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWB, VCMV_GEZ, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWBU, VADDC, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWBU, VMULFXP, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWBU, VSHR, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWBU, VCMV_GTZ, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWH, VADD, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWH, VMUL, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWH, VXOR, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVWH, VCMV_Z, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWHU, VSUBB, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWHU, VAND, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWHU, VROTL, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWHU, VCMV_LTZ, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVW, VSUB, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVW, VMULHI, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVW, VSHL, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVW, VCMV_LEZ, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_2D( VVW, VCMV_NZ, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_word_out1, v_word_in1 );
	vbxasm_2D( VVW, VADD, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_word_out1, v_word_in1 );
	vbxasm_2D( VVW, VMUL, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_word_out1, v_word_in1 );
	vbxasm_2D( VVW, VXOR, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMOV, v_word_out1, v_word_in1 );
	vbxasm_2D( VVW, VMOV, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWU, VABSDIFF, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWU, VOR, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWU, VROTR, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_2D( VVWU, VCMV_GEZ, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_uword_out1, v_uword_in1 );
	vbxasm_2D( VVWU, VSUBB, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_uword_out1, v_uword_in1 );
	vbxasm_2D( VVWU, VAND, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_uword_out1, v_uword_in1 );
	vbxasm_2D( VVWU, VROTL, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_byte_out1, 8, v_byte_in2 );
	vbxasm_2D( SVB, VADDC, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_byte_out1, 8, v_byte_in2 );
	vbxasm_2D( SVB, VMULFXP, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_byte_out1, 8, v_byte_in2 );
	vbxasm_2D( SVB, VSHR, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_byte_out1, 8, v_byte_in2 );
	vbxasm_2D( SVB, VCMV_GTZ, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_byte_out1, 8 );
	vbxasm_2D( SVB, VSUB, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_byte_out1, 8 );
	vbxasm_2D( SVB, VMULHI, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_byte_out1, 8 );
	vbxasm_2D( SVB, VSHL, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBU, VADD, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBU, VMUL, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBU, VXOR, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBU, VCMV_Z, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_ubyte_out1, 8 );
	vbxasm_2D( SVBU, VABSDIFF, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_ubyte_out1, 8 );
	vbxasm_2D( SVBU, VOR, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_ubyte_out1, 8 );
	vbxasm_2D( SVBU, VROTR, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_half_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBH, VSUBB, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_half_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBH, VAND, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_half_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBH, VROTL, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_half_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBH, VCMV_LTZ, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBHU, VADDC, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBHU, VMULFXP, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBHU, VSHR, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBHU, VCMV_GTZ, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_word_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBW, VSUB, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_word_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBW, VMULHI, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_word_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBW, VSHL, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_word_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBW, VCMV_LEZ, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_word_out1, 8, v_byte_in2 );
	vbxasm_2D( SVBW, VCMV_NZ, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBWU, VADD, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBWU, VMUL, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBWU, VXOR, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_2D( SVBWU, VCMV_Z, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_byte_out1, 8, v_half_in2 );
	vbxasm_2D( SVHB, VABSDIFF, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_byte_out1, 8, v_half_in2 );
	vbxasm_2D( SVHB, VOR, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_byte_out1, 8, v_half_in2 );
	vbxasm_2D( SVHB, VROTR, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_byte_out1, 8, v_half_in2 );
	vbxasm_2D( SVHB, VCMV_GEZ, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHBU, VSUBB, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHBU, VAND, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHBU, VROTL, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHBU, VCMV_LTZ, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_half_out1, 8, v_half_in2 );
	vbxasm_2D( SVH, VADDC, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_half_out1, 8, v_half_in2 );
	vbxasm_2D( SVH, VMULFXP, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_half_out1, 8, v_half_in2 );
	vbxasm_2D( SVH, VSHR, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_half_out1, 8, v_half_in2 );
	vbxasm_2D( SVH, VCMV_GTZ, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_half_out1, 8 );
	vbxasm_2D( SVH, VSUB, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_half_out1, 8 );
	vbxasm_2D( SVH, VMULHI, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_half_out1, 8 );
	vbxasm_2D( SVH, VSHL, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHU, VADD, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHU, VMUL, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHU, VXOR, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHU, VCMV_Z, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_uhalf_out1, 8 );
	vbxasm_2D( SVHU, VABSDIFF, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_uhalf_out1, 8 );
	vbxasm_2D( SVHU, VOR, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_uhalf_out1, 8 );
	vbxasm_2D( SVHU, VROTR, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_word_out1, 8, v_half_in2 );
	vbxasm_2D( SVHW, VSUBB, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_word_out1, 8, v_half_in2 );
	vbxasm_2D( SVHW, VAND, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_word_out1, 8, v_half_in2 );
	vbxasm_2D( SVHW, VROTL, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_word_out1, 8, v_half_in2 );
	vbxasm_2D( SVHW, VCMV_LTZ, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHWU, VADDC, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHWU, VMULFXP, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHWU, VSHR, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_2D( SVHWU, VCMV_GTZ, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_byte_out1, 8, v_word_in2 );
	vbxasm_2D( SVWB, VSUB, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_byte_out1, 8, v_word_in2 );
	vbxasm_2D( SVWB, VMULHI, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_byte_out1, 8, v_word_in2 );
	vbxasm_2D( SVWB, VSHL, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_byte_out1, 8, v_word_in2 );
	vbxasm_2D( SVWB, VCMV_LEZ, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_byte_out1, 8, v_word_in2 );
	vbxasm_2D( SVWB, VCMV_NZ, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWBU, VADD, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWBU, VMUL, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWBU, VXOR, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWBU, VCMV_Z, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_half_out1, 8, v_word_in2 );
	vbxasm_2D( SVWH, VABSDIFF, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_half_out1, 8, v_word_in2 );
	vbxasm_2D( SVWH, VOR, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_half_out1, 8, v_word_in2 );
	vbxasm_2D( SVWH, VROTR, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_half_out1, 8, v_word_in2 );
	vbxasm_2D( SVWH, VCMV_GEZ, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWHU, VSUBB, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWHU, VAND, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWHU, VROTL, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWHU, VCMV_LTZ, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_word_out1, 8, v_word_in2 );
	vbxasm_2D( SVW, VADDC, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_word_out1, 8, v_word_in2 );
	vbxasm_2D( SVW, VMULFXP, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_word_out1, 8, v_word_in2 );
	vbxasm_2D( SVW, VSHR, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_word_out1, 8, v_word_in2 );
	vbxasm_2D( SVW, VCMV_GTZ, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_word_out1, 8 );
	vbxasm_2D( SVW, VSUB, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_word_out1, 8 );
	vbxasm_2D( SVW, VMULHI, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_word_out1, 8 );
	vbxasm_2D( SVW, VSHL, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_uword_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWU, VADD, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_uword_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWU, VMUL, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_uword_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWU, VXOR, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_uword_out1, 8, v_uword_in2 );
	vbxasm_2D( SVWU, VCMV_Z, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_uword_out1, 8 );
	vbxasm_2D( SVWU, VABSDIFF, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_uword_out1, 8 );
	vbxasm_2D( SVWU, VOR, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_uword_out1, 8 );
	vbxasm_2D( SVWU, VROTR, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_2D( VEB, VSUBB, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_2D( VEB, VAND, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_2D( VEB, VROTL, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_2D( VEB, VCMV_LTZ, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_byte_out1, v_enum );
	vbxasm_2D( VEB, VADDC, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_byte_out1, v_enum );
	vbxasm_2D( VEB, VMULFXP, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_byte_out1, v_enum );
	vbxasm_2D( VEB, VSHR, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_2D( VEBU, VSUB, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_2D( VEBU, VMULHI, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_2D( VEBU, VSHL, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_2D( VEBU, VCMV_LEZ, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_2D( VEBU, VCMV_NZ, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_ubyte_out1, v_enum );
	vbxasm_2D( VEBU, VADD, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_ubyte_out1, v_enum );
	vbxasm_2D( VEBU, VMUL, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_ubyte_out1, v_enum );
	vbxasm_2D( VEBU, VXOR, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_half_out1, v_half_in1, v_enum );
	vbxasm_2D( VEH, VABSDIFF, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_half_out1, v_half_in1, v_enum );
	vbxasm_2D( VEH, VOR, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_half_out1, v_half_in1, v_enum );
	vbxasm_2D( VEH, VROTR, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_half_out1, v_half_in1, v_enum );
	vbxasm_2D( VEH, VCMV_GEZ, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_half_out1, v_enum );
	vbxasm_2D( VEH, VSUBB, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_half_out1, v_enum );
	vbxasm_2D( VEH, VAND, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_half_out1, v_enum );
	vbxasm_2D( VEH, VROTL, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_2D( VEHU, VADDC, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_2D( VEHU, VMULFXP, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_2D( VEHU, VSHR, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_2D( VEHU, VCMV_GTZ, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_uhalf_out1, v_enum );
	vbxasm_2D( VEHU, VSUB, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_uhalf_out1, v_enum );
	vbxasm_2D( VEHU, VMULHI, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_uhalf_out1, v_enum );
	vbxasm_2D( VEHU, VSHL, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_word_out1, v_word_in1, v_enum );
	vbxasm_2D( VEW, VADD, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_word_out1, v_word_in1, v_enum );
	vbxasm_2D( VEW, VMUL, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_word_out1, v_word_in1, v_enum );
	vbxasm_2D( VEW, VXOR, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_word_out1, v_word_in1, v_enum );
	vbxasm_2D( VEW, VCMV_Z, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_word_out1, v_enum );
	vbxasm_2D( VEW, VABSDIFF, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_word_out1, v_enum );
	vbxasm_2D( VEW, VOR, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_word_out1, v_enum );
	vbxasm_2D( VEW, VROTR, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_2D( VEWU, VSUBB, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_2D( VEWU, VAND, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_2D( VEWU, VROTL, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_2D( VEWU, VCMV_LTZ, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_uword_out1, v_enum );
	vbxasm_2D( VEWU, VADDC, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_uword_out1, v_enum );
	vbxasm_2D( VEWU, VMULFXP, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_uword_out1, v_enum );
	vbxasm_2D( VEWU, VSHR, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_byte_out1, 8, v_enum );
	vbxasm_2D( SEB, VSUB, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_byte_out1, 8, v_enum );
	vbxasm_2D( SEB, VMULHI, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_byte_out1, 8, v_enum );
	vbxasm_2D( SEB, VSHL, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_byte_out1, 8, v_enum );
	vbxasm_2D( SEB, VCMV_LEZ, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_byte_out1, 8, v_enum );
	vbxasm_2D( SEB, VCMV_NZ, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADD, v_ubyte_out1, 8, v_enum );
	vbxasm_2D( SEBU, VADD, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMUL, v_ubyte_out1, 8, v_enum );
	vbxasm_2D( SEBU, VMUL, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VXOR, v_ubyte_out1, 8, v_enum );
	vbxasm_2D( SEBU, VXOR, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_Z, v_ubyte_out1, 8, v_enum );
	vbxasm_2D( SEBU, VCMV_Z, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VABSDIFF, v_half_out1, 8, v_enum );
	vbxasm_2D( SEH, VABSDIFF, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VOR, v_half_out1, 8, v_enum );
	vbxasm_2D( SEH, VOR, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTR, v_half_out1, 8, v_enum );
	vbxasm_2D( SEH, VROTR, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GEZ, v_half_out1, 8, v_enum );
	vbxasm_2D( SEH, VCMV_GEZ, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUBB, v_uhalf_out1, 8, v_enum );
	vbxasm_2D( SEHU, VSUBB, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VAND, v_uhalf_out1, 8, v_enum );
	vbxasm_2D( SEHU, VAND, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VROTL, v_uhalf_out1, 8, v_enum );
	vbxasm_2D( SEHU, VROTL, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LTZ, v_uhalf_out1, 8, v_enum );
	vbxasm_2D( SEHU, VCMV_LTZ, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VADDC, v_word_out1, 8, v_enum );
	vbxasm_2D( SEW, VADDC, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULFXP, v_word_out1, 8, v_enum );
	vbxasm_2D( SEW, VMULFXP, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHR, v_word_out1, 8, v_enum );
	vbxasm_2D( SEW, VSHR, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_GTZ, v_word_out1, 8, v_enum );
	vbxasm_2D( SEW, VCMV_GTZ, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSUB, v_uword_out1, 8, v_enum );
	vbxasm_2D( SEWU, VSUB, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VMULHI, v_uword_out1, 8, v_enum );
	vbxasm_2D( SEWU, VMULHI, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VSHL, v_uword_out1, 8, v_enum );
	vbxasm_2D( SEWU, VSHL, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_LEZ, v_uword_out1, 8, v_enum );
	vbxasm_2D( SEWU, VCMV_LEZ, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_2D( VCMV_NZ, v_uword_out1, 8, v_enum );
	vbxasm_2D( SEWU, VCMV_NZ, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVB, VADD, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVB, VMUL, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVB, VXOR, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVB, VCMV_Z, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_byte_out1, v_byte_in1 );
	vbxasm_acc_2D( VVB, VABSDIFF, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_byte_out1, v_byte_in1 );
	vbxasm_acc_2D( VVB, VOR, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_byte_out1, v_byte_in1 );
	vbxasm_acc_2D( VVB, VROTR, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBU, VSUBB, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBU, VAND, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBU, VROTL, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBU, VCMV_LTZ, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc_2D( VVBU, VADDC, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc_2D( VVBU, VMULFXP, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc_2D( VVBU, VSHR, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBH, VSUB, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBH, VMULHI, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBH, VSHL, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBH, VCMV_LEZ, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBH, VCMV_NZ, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMOV, v_half_out1, v_byte_in1 );
	vbxasm_acc_2D( VVBH, VMOV, v_half_out2, v_byte_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBHU, VABSDIFF, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBHU, VOR, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBHU, VROTR, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBHU, VCMV_GEZ, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBW, VADDC, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBW, VMULFXP, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBW, VSHR, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_2D( VVBW, VCMV_GTZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBWU, VADD, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBWU, VMUL, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBWU, VXOR, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_2D( VVBWU, VCMV_Z, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHB, VSUBB, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHB, VAND, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHB, VROTL, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHB, VCMV_LTZ, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHBU, VSUB, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHBU, VMULHI, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHBU, VSHL, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHBU, VCMV_LEZ, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHBU, VCMV_NZ, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMOV, v_ubyte_out1, v_uhalf_in1 );
	vbxasm_acc_2D( VVHBU, VMOV, v_ubyte_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVH, VABSDIFF, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVH, VOR, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVH, VROTR, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVH, VCMV_GEZ, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_half_out1, v_half_in1 );
	vbxasm_acc_2D( VVH, VSUBB, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_half_out1, v_half_in1 );
	vbxasm_acc_2D( VVH, VAND, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_half_out1, v_half_in1 );
	vbxasm_acc_2D( VVH, VROTL, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHU, VADDC, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHU, VMULFXP, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHU, VSHR, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHU, VCMV_GTZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_2D( VVHU, VSUB, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_2D( VVHU, VMULHI, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_2D( VVHU, VSHL, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHW, VADD, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHW, VMUL, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHW, VXOR, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_2D( VVHW, VCMV_Z, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHWU, VSUBB, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHWU, VAND, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHWU, VROTL, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_2D( VVHWU, VCMV_LTZ, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWB, VSUB, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWB, VMULHI, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWB, VSHL, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWB, VCMV_LEZ, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWB, VCMV_NZ, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMOV, v_byte_out1, v_word_in1 );
	vbxasm_acc_2D( VVWB, VMOV, v_byte_out2, v_word_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWBU, VABSDIFF, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWBU, VOR, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWBU, VROTR, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWBU, VCMV_GEZ, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWH, VADDC, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWH, VMULFXP, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWH, VSHR, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVWH, VCMV_GTZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWHU, VADD, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWHU, VMUL, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWHU, VXOR, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWHU, VCMV_Z, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVW, VSUBB, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVW, VAND, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVW, VROTL, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_2D( VVW, VCMV_LTZ, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_word_out1, v_word_in1 );
	vbxasm_acc_2D( VVW, VADDC, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_word_out1, v_word_in1 );
	vbxasm_acc_2D( VVW, VMULFXP, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_word_out1, v_word_in1 );
	vbxasm_acc_2D( VVW, VSHR, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWU, VSUB, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWU, VMULHI, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWU, VSHL, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWU, VCMV_LEZ, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_2D( VVWU, VCMV_NZ, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_uword_out1, v_uword_in1 );
	vbxasm_acc_2D( VVWU, VADD, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_uword_out1, v_uword_in1 );
	vbxasm_acc_2D( VVWU, VMUL, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_uword_out1, v_uword_in1 );
	vbxasm_acc_2D( VVWU, VXOR, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMOV, v_uword_out1, v_uword_in1 );
	vbxasm_acc_2D( VVWU, VMOV, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVB, VABSDIFF, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVB, VOR, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVB, VROTR, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVB, VCMV_GEZ, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_byte_out1, 8 );
	vbxasm_acc_2D( SVB, VSUBB, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_byte_out1, 8 );
	vbxasm_acc_2D( SVB, VAND, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_byte_out1, 8 );
	vbxasm_acc_2D( SVB, VROTL, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBU, VADDC, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBU, VMULFXP, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBU, VSHR, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBU, VCMV_GTZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_ubyte_out1, 8 );
	vbxasm_acc_2D( SVBU, VSUB, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_ubyte_out1, 8 );
	vbxasm_acc_2D( SVBU, VMULHI, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_ubyte_out1, 8 );
	vbxasm_acc_2D( SVBU, VSHL, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBH, VADD, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBH, VMUL, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBH, VXOR, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBH, VCMV_Z, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBHU, VABSDIFF, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBHU, VOR, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBHU, VROTR, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBHU, VCMV_GEZ, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBW, VSUBB, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBW, VAND, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBW, VROTL, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_2D( SVBW, VCMV_LTZ, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBWU, VADDC, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBWU, VMULFXP, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBWU, VSHR, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_2D( SVBWU, VCMV_GTZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHB, VSUB, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHB, VMULHI, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHB, VSHL, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHB, VCMV_LEZ, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHB, VCMV_NZ, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHBU, VADD, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHBU, VMUL, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHBU, VXOR, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHBU, VCMV_Z, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVH, VABSDIFF, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVH, VOR, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVH, VROTR, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVH, VCMV_GEZ, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_half_out1, 8 );
	vbxasm_acc_2D( SVH, VSUBB, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_half_out1, 8 );
	vbxasm_acc_2D( SVH, VAND, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_half_out1, 8 );
	vbxasm_acc_2D( SVH, VROTL, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHU, VADDC, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHU, VMULFXP, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHU, VSHR, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHU, VCMV_GTZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_uhalf_out1, 8 );
	vbxasm_acc_2D( SVHU, VSUB, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_uhalf_out1, 8 );
	vbxasm_acc_2D( SVHU, VMULHI, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_uhalf_out1, 8 );
	vbxasm_acc_2D( SVHU, VSHL, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHW, VADD, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHW, VMUL, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHW, VXOR, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_2D( SVHW, VCMV_Z, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHWU, VABSDIFF, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHWU, VOR, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHWU, VROTR, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_2D( SVHWU, VCMV_GEZ, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWB, VSUBB, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWB, VAND, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWB, VROTL, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWB, VCMV_LTZ, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWBU, VADDC, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWBU, VMULFXP, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWBU, VSHR, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWBU, VCMV_GTZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWH, VSUB, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWH, VMULHI, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWH, VSHL, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWH, VCMV_LEZ, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVWH, VCMV_NZ, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWHU, VADD, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWHU, VMUL, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWHU, VXOR, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWHU, VCMV_Z, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVW, VABSDIFF, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVW, VOR, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVW, VROTR, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_2D( SVW, VCMV_GEZ, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_word_out1, 8 );
	vbxasm_acc_2D( SVW, VSUBB, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_word_out1, 8 );
	vbxasm_acc_2D( SVW, VAND, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_word_out1, 8 );
	vbxasm_acc_2D( SVW, VROTL, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWU, VADDC, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWU, VMULFXP, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWU, VSHR, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_2D( SVWU, VCMV_GTZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_uword_out1, 8 );
	vbxasm_acc_2D( SVWU, VSUB, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_uword_out1, 8 );
	vbxasm_acc_2D( SVWU, VMULHI, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_uword_out1, 8 );
	vbxasm_acc_2D( SVWU, VSHL, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_2D( VEB, VADD, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_2D( VEB, VMUL, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_2D( VEB, VXOR, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_2D( VEB, VCMV_Z, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_byte_out1, v_enum );
	vbxasm_acc_2D( VEB, VABSDIFF, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_byte_out1, v_enum );
	vbxasm_acc_2D( VEB, VOR, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_byte_out1, v_enum );
	vbxasm_acc_2D( VEB, VROTR, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_2D( VEBU, VSUBB, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_2D( VEBU, VAND, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_2D( VEBU, VROTL, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_2D( VEBU, VCMV_LTZ, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_ubyte_out1, v_enum );
	vbxasm_acc_2D( VEBU, VADDC, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_ubyte_out1, v_enum );
	vbxasm_acc_2D( VEBU, VMULFXP, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_ubyte_out1, v_enum );
	vbxasm_acc_2D( VEBU, VSHR, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_2D( VEH, VSUB, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_2D( VEH, VMULHI, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_2D( VEH, VSHL, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_2D( VEH, VCMV_LEZ, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_2D( VEH, VCMV_NZ, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_half_out1, v_enum );
	vbxasm_acc_2D( VEH, VADD, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_half_out1, v_enum );
	vbxasm_acc_2D( VEH, VMUL, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_half_out1, v_enum );
	vbxasm_acc_2D( VEH, VXOR, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_2D( VEHU, VABSDIFF, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_2D( VEHU, VOR, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_2D( VEHU, VROTR, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_2D( VEHU, VCMV_GEZ, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_uhalf_out1, v_enum );
	vbxasm_acc_2D( VEHU, VSUBB, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_uhalf_out1, v_enum );
	vbxasm_acc_2D( VEHU, VAND, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_uhalf_out1, v_enum );
	vbxasm_acc_2D( VEHU, VROTL, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_2D( VEW, VADDC, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_2D( VEW, VMULFXP, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_2D( VEW, VSHR, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_2D( VEW, VCMV_GTZ, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_word_out1, v_enum );
	vbxasm_acc_2D( VEW, VSUB, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_word_out1, v_enum );
	vbxasm_acc_2D( VEW, VMULHI, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_word_out1, v_enum );
	vbxasm_acc_2D( VEW, VSHL, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_2D( VEWU, VADD, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_2D( VEWU, VMUL, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_2D( VEWU, VXOR, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_2D( VEWU, VCMV_Z, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_uword_out1, v_enum );
	vbxasm_acc_2D( VEWU, VABSDIFF, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_uword_out1, v_enum );
	vbxasm_acc_2D( VEWU, VOR, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_uword_out1, v_enum );
	vbxasm_acc_2D( VEWU, VROTR, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_byte_out1, 8, v_enum );
	vbxasm_acc_2D( SEB, VSUBB, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_byte_out1, 8, v_enum );
	vbxasm_acc_2D( SEB, VAND, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_byte_out1, 8, v_enum );
	vbxasm_acc_2D( SEB, VROTL, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_byte_out1, 8, v_enum );
	vbxasm_acc_2D( SEB, VCMV_LTZ, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADDC, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_2D( SEBU, VADDC, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULFXP, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_2D( SEBU, VMULFXP, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHR, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_2D( SEBU, VSHR, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GTZ, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_2D( SEBU, VCMV_GTZ, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUB, v_half_out1, 8, v_enum );
	vbxasm_acc_2D( SEH, VSUB, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMULHI, v_half_out1, 8, v_enum );
	vbxasm_acc_2D( SEH, VMULHI, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSHL, v_half_out1, 8, v_enum );
	vbxasm_acc_2D( SEH, VSHL, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LEZ, v_half_out1, 8, v_enum );
	vbxasm_acc_2D( SEH, VCMV_LEZ, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_NZ, v_half_out1, 8, v_enum );
	vbxasm_acc_2D( SEH, VCMV_NZ, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VADD, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_2D( SEHU, VADD, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VMUL, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_2D( SEHU, VMUL, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VXOR, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_2D( SEHU, VXOR, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_Z, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_2D( SEHU, VCMV_Z, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VABSDIFF, v_word_out1, 8, v_enum );
	vbxasm_acc_2D( SEW, VABSDIFF, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VOR, v_word_out1, 8, v_enum );
	vbxasm_acc_2D( SEW, VOR, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTR, v_word_out1, 8, v_enum );
	vbxasm_acc_2D( SEW, VROTR, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_GEZ, v_word_out1, 8, v_enum );
	vbxasm_acc_2D( SEW, VCMV_GEZ, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VSUBB, v_uword_out1, 8, v_enum );
	vbxasm_acc_2D( SEWU, VSUBB, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VAND, v_uword_out1, 8, v_enum );
	vbxasm_acc_2D( SEWU, VAND, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VROTL, v_uword_out1, 8, v_enum );
	vbxasm_acc_2D( SEWU, VROTL, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_2D( VCMV_LTZ, v_uword_out1, 8, v_enum );
	vbxasm_acc_2D( SEWU, VCMV_LTZ, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVB, VADDC, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVB, VMULFXP, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVB, VSHR, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVB, VCMV_GTZ, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_byte_out1, v_byte_in1 );
	vbxasm_3D( VVB, VSUB, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_byte_out1, v_byte_in1 );
	vbxasm_3D( VVB, VMULHI, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_byte_out1, v_byte_in1 );
	vbxasm_3D( VVB, VSHL, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBU, VADD, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBU, VMUL, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBU, VXOR, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBU, VCMV_Z, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_3D( VVBU, VABSDIFF, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_3D( VVBU, VOR, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_3D( VVBU, VROTR, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBH, VSUBB, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBH, VAND, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBH, VROTL, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBH, VCMV_LTZ, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBHU, VSUB, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBHU, VMULHI, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBHU, VSHL, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBHU, VCMV_LEZ, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBHU, VCMV_NZ, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMOV, v_uhalf_out1, v_ubyte_in1 );
	vbxasm_3D( VVBHU, VMOV, v_uhalf_out2, v_ubyte_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBW, VABSDIFF, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBW, VOR, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBW, VROTR, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_3D( VVBW, VCMV_GEZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBWU, VADDC, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBWU, VMULFXP, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBWU, VSHR, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_3D( VVBWU, VCMV_GTZ, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHB, VADD, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHB, VMUL, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHB, VXOR, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHB, VCMV_Z, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHBU, VSUBB, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHBU, VAND, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHBU, VROTL, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHBU, VCMV_LTZ, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVH, VSUB, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVH, VMULHI, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVH, VSHL, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVH, VCMV_LEZ, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVH, VCMV_NZ, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_half_out1, v_half_in1 );
	vbxasm_3D( VVH, VADD, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_half_out1, v_half_in1 );
	vbxasm_3D( VVH, VMUL, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_half_out1, v_half_in1 );
	vbxasm_3D( VVH, VXOR, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMOV, v_half_out1, v_half_in1 );
	vbxasm_3D( VVH, VMOV, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHU, VABSDIFF, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHU, VOR, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHU, VROTR, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHU, VCMV_GEZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_3D( VVHU, VSUBB, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_3D( VVHU, VAND, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_3D( VVHU, VROTL, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHW, VADDC, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHW, VMULFXP, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHW, VSHR, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_3D( VVHW, VCMV_GTZ, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHWU, VADD, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHWU, VMUL, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHWU, VXOR, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_3D( VVHWU, VCMV_Z, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWB, VSUBB, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWB, VAND, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWB, VROTL, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWB, VCMV_LTZ, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWBU, VSUB, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWBU, VMULHI, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWBU, VSHL, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWBU, VCMV_LEZ, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWBU, VCMV_NZ, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMOV, v_ubyte_out1, v_uword_in1 );
	vbxasm_3D( VVWBU, VMOV, v_ubyte_out2, v_uword_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWH, VABSDIFF, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWH, VOR, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWH, VROTR, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVWH, VCMV_GEZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWHU, VADDC, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWHU, VMULFXP, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWHU, VSHR, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWHU, VCMV_GTZ, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVW, VADD, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVW, VMUL, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVW, VXOR, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_3D( VVW, VCMV_Z, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_word_out1, v_word_in1 );
	vbxasm_3D( VVW, VABSDIFF, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_word_out1, v_word_in1 );
	vbxasm_3D( VVW, VOR, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_word_out1, v_word_in1 );
	vbxasm_3D( VVW, VROTR, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWU, VSUBB, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWU, VAND, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWU, VROTL, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_3D( VVWU, VCMV_LTZ, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_uword_out1, v_uword_in1 );
	vbxasm_3D( VVWU, VADDC, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_uword_out1, v_uword_in1 );
	vbxasm_3D( VVWU, VMULFXP, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_uword_out1, v_uword_in1 );
	vbxasm_3D( VVWU, VSHR, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_byte_out1, 8, v_byte_in2 );
	vbxasm_3D( SVB, VSUB, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_byte_out1, 8, v_byte_in2 );
	vbxasm_3D( SVB, VMULHI, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_byte_out1, 8, v_byte_in2 );
	vbxasm_3D( SVB, VSHL, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_byte_out1, 8, v_byte_in2 );
	vbxasm_3D( SVB, VCMV_LEZ, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_byte_out1, 8, v_byte_in2 );
	vbxasm_3D( SVB, VCMV_NZ, v_byte_out2, 8, v_byte_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_byte_out1, 8 );
	vbxasm_3D( SVB, VADD, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_byte_out1, 8 );
	vbxasm_3D( SVB, VMUL, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_byte_out1, 8 );
	vbxasm_3D( SVB, VXOR, v_byte_out2, 8, v_byte_out2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMOV, v_byte_out1, 8 );
	vbxasm_3D( SVB, VMOV, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBU, VABSDIFF, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBU, VOR, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBU, VROTR, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBU, VCMV_GEZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_ubyte_out1, 8 );
	vbxasm_3D( SVBU, VSUBB, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_ubyte_out1, 8 );
	vbxasm_3D( SVBU, VAND, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_ubyte_out1, 8 );
	vbxasm_3D( SVBU, VROTL, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_half_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBH, VADDC, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_half_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBH, VMULFXP, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_half_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBH, VSHR, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_half_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBH, VCMV_GTZ, v_half_out2, 8, v_byte_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBHU, VSUB, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBHU, VMULHI, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBHU, VSHL, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBHU, VCMV_LEZ, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBHU, VCMV_NZ, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_word_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBW, VADD, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_word_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBW, VMUL, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_word_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBW, VXOR, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_word_out1, 8, v_byte_in2 );
	vbxasm_3D( SVBW, VCMV_Z, v_word_out2, 8, v_byte_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBWU, VABSDIFF, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBWU, VOR, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBWU, VROTR, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_3D( SVBWU, VCMV_GEZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_byte_out1, 8, v_half_in2 );
	vbxasm_3D( SVHB, VSUBB, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_byte_out1, 8, v_half_in2 );
	vbxasm_3D( SVHB, VAND, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_byte_out1, 8, v_half_in2 );
	vbxasm_3D( SVHB, VROTL, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_byte_out1, 8, v_half_in2 );
	vbxasm_3D( SVHB, VCMV_LTZ, v_byte_out2, 8, v_half_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHBU, VADDC, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHBU, VMULFXP, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHBU, VSHR, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHBU, VCMV_GTZ, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_half_out1, 8, v_half_in2 );
	vbxasm_3D( SVH, VSUB, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_half_out1, 8, v_half_in2 );
	vbxasm_3D( SVH, VMULHI, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_half_out1, 8, v_half_in2 );
	vbxasm_3D( SVH, VSHL, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_half_out1, 8, v_half_in2 );
	vbxasm_3D( SVH, VCMV_LEZ, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_half_out1, 8, v_half_in2 );
	vbxasm_3D( SVH, VCMV_NZ, v_half_out2, 8, v_half_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_half_out1, 8 );
	vbxasm_3D( SVH, VADD, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_half_out1, 8 );
	vbxasm_3D( SVH, VMUL, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_half_out1, 8 );
	vbxasm_3D( SVH, VXOR, v_half_out2, 8, v_half_out2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMOV, v_half_out1, 8 );
	vbxasm_3D( SVH, VMOV, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHU, VABSDIFF, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHU, VOR, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHU, VROTR, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHU, VCMV_GEZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_uhalf_out1, 8 );
	vbxasm_3D( SVHU, VSUBB, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_uhalf_out1, 8 );
	vbxasm_3D( SVHU, VAND, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_uhalf_out1, 8 );
	vbxasm_3D( SVHU, VROTL, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_word_out1, 8, v_half_in2 );
	vbxasm_3D( SVHW, VADDC, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_word_out1, 8, v_half_in2 );
	vbxasm_3D( SVHW, VMULFXP, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_word_out1, 8, v_half_in2 );
	vbxasm_3D( SVHW, VSHR, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_word_out1, 8, v_half_in2 );
	vbxasm_3D( SVHW, VCMV_GTZ, v_word_out2, 8, v_half_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHWU, VSUB, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHWU, VMULHI, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHWU, VSHL, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHWU, VCMV_LEZ, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_3D( SVHWU, VCMV_NZ, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_byte_out1, 8, v_word_in2 );
	vbxasm_3D( SVWB, VADD, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_byte_out1, 8, v_word_in2 );
	vbxasm_3D( SVWB, VMUL, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_byte_out1, 8, v_word_in2 );
	vbxasm_3D( SVWB, VXOR, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_byte_out1, 8, v_word_in2 );
	vbxasm_3D( SVWB, VCMV_Z, v_byte_out2, 8, v_word_in2 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWBU, VABSDIFF, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWBU, VOR, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWBU, VROTR, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWBU, VCMV_GEZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_half_out1, 8, v_word_in2 );
	vbxasm_3D( SVWH, VSUBB, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_half_out1, 8, v_word_in2 );
	vbxasm_3D( SVWH, VAND, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_half_out1, 8, v_word_in2 );
	vbxasm_3D( SVWH, VROTL, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_half_out1, 8, v_word_in2 );
	vbxasm_3D( SVWH, VCMV_LTZ, v_half_out2, 8, v_word_in2 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWHU, VADDC, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWHU, VMULFXP, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWHU, VSHR, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWHU, VCMV_GTZ, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_word_out1, 8, v_word_in2 );
	vbxasm_3D( SVW, VSUB, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_word_out1, 8, v_word_in2 );
	vbxasm_3D( SVW, VMULHI, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_word_out1, 8, v_word_in2 );
	vbxasm_3D( SVW, VSHL, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_word_out1, 8, v_word_in2 );
	vbxasm_3D( SVW, VCMV_LEZ, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_word_out1, 8, v_word_in2 );
	vbxasm_3D( SVW, VCMV_NZ, v_word_out2, 8, v_word_in2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_word_out1, 8 );
	vbxasm_3D( SVW, VADD, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_word_out1, 8 );
	vbxasm_3D( SVW, VMUL, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_word_out1, 8 );
	vbxasm_3D( SVW, VXOR, v_word_out2, 8, v_word_out2 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMOV, v_word_out1, 8 );
	vbxasm_3D( SVW, VMOV, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_uword_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWU, VABSDIFF, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_uword_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWU, VOR, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_uword_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWU, VROTR, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm_3D( SVWU, VCMV_GEZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_uword_out1, 8 );
	vbxasm_3D( SVWU, VSUBB, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_uword_out1, 8 );
	vbxasm_3D( SVWU, VAND, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_uword_out1, 8 );
	vbxasm_3D( SVWU, VROTL, v_uword_out2, 8, v_uword_out2 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_3D( VEB, VADDC, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_3D( VEB, VMULFXP, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_3D( VEB, VSHR, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_3D( VEB, VCMV_GTZ, v_byte_out2, v_byte_in1, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_byte_out1, v_enum );
	vbxasm_3D( VEB, VSUB, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_byte_out1, v_enum );
	vbxasm_3D( VEB, VMULHI, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_byte_out1, v_enum );
	vbxasm_3D( VEB, VSHL, v_byte_out2, v_byte_out2, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_3D( VEBU, VADD, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_3D( VEBU, VMUL, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_3D( VEBU, VXOR, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_3D( VEBU, VCMV_Z, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_ubyte_out1, v_enum );
	vbxasm_3D( VEBU, VABSDIFF, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_ubyte_out1, v_enum );
	vbxasm_3D( VEBU, VOR, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_ubyte_out1, v_enum );
	vbxasm_3D( VEBU, VROTR, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_half_out1, v_half_in1, v_enum );
	vbxasm_3D( VEH, VSUBB, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_half_out1, v_half_in1, v_enum );
	vbxasm_3D( VEH, VAND, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_half_out1, v_half_in1, v_enum );
	vbxasm_3D( VEH, VROTL, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_half_out1, v_half_in1, v_enum );
	vbxasm_3D( VEH, VCMV_LTZ, v_half_out2, v_half_in1, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_half_out1, v_enum );
	vbxasm_3D( VEH, VADDC, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_half_out1, v_enum );
	vbxasm_3D( VEH, VMULFXP, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_half_out1, v_enum );
	vbxasm_3D( VEH, VSHR, v_half_out2, v_half_out2, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_3D( VEHU, VSUB, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_3D( VEHU, VMULHI, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_3D( VEHU, VSHL, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_3D( VEHU, VCMV_LEZ, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_3D( VEHU, VCMV_NZ, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_uhalf_out1, v_enum );
	vbxasm_3D( VEHU, VADD, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_uhalf_out1, v_enum );
	vbxasm_3D( VEHU, VMUL, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_uhalf_out1, v_enum );
	vbxasm_3D( VEHU, VXOR, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_word_out1, v_word_in1, v_enum );
	vbxasm_3D( VEW, VABSDIFF, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_word_out1, v_word_in1, v_enum );
	vbxasm_3D( VEW, VOR, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_word_out1, v_word_in1, v_enum );
	vbxasm_3D( VEW, VROTR, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_word_out1, v_word_in1, v_enum );
	vbxasm_3D( VEW, VCMV_GEZ, v_word_out2, v_word_in1, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_word_out1, v_enum );
	vbxasm_3D( VEW, VSUBB, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_word_out1, v_enum );
	vbxasm_3D( VEW, VAND, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_word_out1, v_enum );
	vbxasm_3D( VEW, VROTL, v_word_out2, v_word_out2, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_3D( VEWU, VADDC, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_3D( VEWU, VMULFXP, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_3D( VEWU, VSHR, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_3D( VEWU, VCMV_GTZ, v_uword_out2, v_uword_in1, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_uword_out1, v_enum );
	vbxasm_3D( VEWU, VSUB, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_uword_out1, v_enum );
	vbxasm_3D( VEWU, VMULHI, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_uword_out1, v_enum );
	vbxasm_3D( VEWU, VSHL, v_uword_out2, v_uword_out2, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_byte_out1, 8, v_enum );
	vbxasm_3D( SEB, VADD, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_byte_out1, 8, v_enum );
	vbxasm_3D( SEB, VMUL, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_byte_out1, 8, v_enum );
	vbxasm_3D( SEB, VXOR, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_byte_out1, 8, v_enum );
	vbxasm_3D( SEB, VCMV_Z, v_byte_out2, 8, 0 );
	errors += compare_results_byte(v_byte_acc , v_byte_out1 , v_byte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VABSDIFF, v_ubyte_out1, 8, v_enum );
	vbxasm_3D( SEBU, VABSDIFF, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VOR, v_ubyte_out1, 8, v_enum );
	vbxasm_3D( SEBU, VOR, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTR, v_ubyte_out1, 8, v_enum );
	vbxasm_3D( SEBU, VROTR, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GEZ, v_ubyte_out1, 8, v_enum );
	vbxasm_3D( SEBU, VCMV_GEZ, v_ubyte_out2, 8, 0 );
	errors += compare_results_ubyte(v_ubyte_acc , v_ubyte_out1 , v_ubyte_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUBB, v_half_out1, 8, v_enum );
	vbxasm_3D( SEH, VSUBB, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VAND, v_half_out1, 8, v_enum );
	vbxasm_3D( SEH, VAND, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VROTL, v_half_out1, 8, v_enum );
	vbxasm_3D( SEH, VROTL, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LTZ, v_half_out1, 8, v_enum );
	vbxasm_3D( SEH, VCMV_LTZ, v_half_out2, 8, 0 );
	errors += compare_results_half(v_half_acc , v_half_out1 , v_half_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADDC, v_uhalf_out1, 8, v_enum );
	vbxasm_3D( SEHU, VADDC, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULFXP, v_uhalf_out1, 8, v_enum );
	vbxasm_3D( SEHU, VMULFXP, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHR, v_uhalf_out1, 8, v_enum );
	vbxasm_3D( SEHU, VSHR, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_GTZ, v_uhalf_out1, 8, v_enum );
	vbxasm_3D( SEHU, VCMV_GTZ, v_uhalf_out2, 8, 0 );
	errors += compare_results_uhalf(v_uhalf_acc , v_uhalf_out1 , v_uhalf_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSUB, v_word_out1, 8, v_enum );
	vbxasm_3D( SEW, VSUB, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMULHI, v_word_out1, 8, v_enum );
	vbxasm_3D( SEW, VMULHI, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VSHL, v_word_out1, 8, v_enum );
	vbxasm_3D( SEW, VSHL, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_LEZ, v_word_out1, 8, v_enum );
	vbxasm_3D( SEW, VCMV_LEZ, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_NZ, v_word_out1, 8, v_enum );
	vbxasm_3D( SEW, VCMV_NZ, v_word_out2, 8, 0 );
	errors += compare_results_word(v_word_acc , v_word_out1 , v_word_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VADD, v_uword_out1, 8, v_enum );
	vbxasm_3D( SEWU, VADD, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VMUL, v_uword_out1, 8, v_enum );
	vbxasm_3D( SEWU, VMUL, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VXOR, v_uword_out1, 8, v_enum );
	vbxasm_3D( SEWU, VXOR, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_3D( VCMV_Z, v_uword_out1, 8, v_enum );
	vbxasm_3D( SEWU, VCMV_Z, v_uword_out2, 8, 0 );
	errors += compare_results_uword(v_uword_acc , v_uword_out1 , v_uword_out2  );

	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVB, VABSDIFF, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVB, VOR, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVB, VROTR, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_byte_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVB, VCMV_GEZ, v_byte_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_byte_out1, v_byte_in1 );
	vbxasm_acc_3D( VVB, VSUBB, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_byte_out1, v_byte_in1 );
	vbxasm_acc_3D( VVB, VAND, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_byte_out1, v_byte_in1 );
	vbxasm_acc_3D( VVB, VROTL, v_byte_out2, v_byte_out2, v_byte_in1 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBU, VADDC, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBU, VMULFXP, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBU, VSHR, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_ubyte_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBU, VCMV_GTZ, v_ubyte_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc_3D( VVBU, VSUB, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc_3D( VVBU, VMULHI, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_ubyte_out1, v_ubyte_in1 );
	vbxasm_acc_3D( VVBU, VSHL, v_ubyte_out2, v_ubyte_out2, v_ubyte_in1 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBH, VADD, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBH, VMUL, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBH, VXOR, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_half_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBH, VCMV_Z, v_half_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBHU, VSUBB, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBHU, VAND, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBHU, VROTL, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_uhalf_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBHU, VCMV_LTZ, v_uhalf_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBW, VSUB, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBW, VMULHI, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBW, VSHL, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBW, VCMV_LEZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_word_out1, v_byte_in1, v_byte_in2 );
	vbxasm_acc_3D( VVBW, VCMV_NZ, v_word_out2, v_byte_in1, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMOV, v_word_out1, v_byte_in1 );
	vbxasm_acc_3D( VVBW, VMOV, v_word_out2, v_byte_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBWU, VABSDIFF, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBWU, VOR, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBWU, VROTR, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_uword_out1, v_ubyte_in1, v_ubyte_in2 );
	vbxasm_acc_3D( VVBWU, VCMV_GEZ, v_uword_out2, v_ubyte_in1, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHB, VADDC, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHB, VMULFXP, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHB, VSHR, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_byte_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHB, VCMV_GTZ, v_byte_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHBU, VADD, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHBU, VMUL, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHBU, VXOR, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_ubyte_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHBU, VCMV_Z, v_ubyte_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVH, VSUBB, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVH, VAND, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVH, VROTL, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_half_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVH, VCMV_LTZ, v_half_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_half_out1, v_half_in1 );
	vbxasm_acc_3D( VVH, VADDC, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_half_out1, v_half_in1 );
	vbxasm_acc_3D( VVH, VMULFXP, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_half_out1, v_half_in1 );
	vbxasm_acc_3D( VVH, VSHR, v_half_out2, v_half_out2, v_half_in1 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHU, VSUB, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHU, VMULHI, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHU, VSHL, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHU, VCMV_LEZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_uhalf_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHU, VCMV_NZ, v_uhalf_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_3D( VVHU, VADD, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_3D( VVHU, VMUL, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_3D( VVHU, VXOR, v_uhalf_out2, v_uhalf_out2, v_uhalf_in1 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMOV, v_uhalf_out1, v_uhalf_in1 );
	vbxasm_acc_3D( VVHU, VMOV, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHW, VABSDIFF, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHW, VOR, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHW, VROTR, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_word_out1, v_half_in1, v_half_in2 );
	vbxasm_acc_3D( VVHW, VCMV_GEZ, v_word_out2, v_half_in1, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHWU, VADDC, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHWU, VMULFXP, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHWU, VSHR, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_uword_out1, v_uhalf_in1, v_uhalf_in2 );
	vbxasm_acc_3D( VVHWU, VCMV_GTZ, v_uword_out2, v_uhalf_in1, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWB, VADD, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWB, VMUL, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWB, VXOR, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_byte_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWB, VCMV_Z, v_byte_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWBU, VSUBB, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWBU, VAND, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWBU, VROTL, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_ubyte_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWBU, VCMV_LTZ, v_ubyte_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWH, VSUB, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWH, VMULHI, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWH, VSHL, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWH, VCMV_LEZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_half_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVWH, VCMV_NZ, v_half_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMOV, v_half_out1, v_word_in1 );
	vbxasm_acc_3D( VVWH, VMOV, v_half_out2, v_word_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWHU, VABSDIFF, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWHU, VOR, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWHU, VROTR, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_uhalf_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWHU, VCMV_GEZ, v_uhalf_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVW, VADDC, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVW, VMULFXP, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVW, VSHR, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_word_out1, v_word_in1, v_word_in2 );
	vbxasm_acc_3D( VVW, VCMV_GTZ, v_word_out2, v_word_in1, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_word_out1, v_word_in1 );
	vbxasm_acc_3D( VVW, VSUB, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_word_out1, v_word_in1 );
	vbxasm_acc_3D( VVW, VMULHI, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_word_out1, v_word_in1 );
	vbxasm_acc_3D( VVW, VSHL, v_word_out2, v_word_out2, v_word_in1 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWU, VADD, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWU, VMUL, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWU, VXOR, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_uword_out1, v_uword_in1, v_uword_in2 );
	vbxasm_acc_3D( VVWU, VCMV_Z, v_uword_out2, v_uword_in1, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_uword_out1, v_uword_in1 );
	vbxasm_acc_3D( VVWU, VABSDIFF, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_uword_out1, v_uword_in1 );
	vbxasm_acc_3D( VVWU, VOR, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_uword_out1, v_uword_in1 );
	vbxasm_acc_3D( VVWU, VROTR, v_uword_out2, v_uword_out2, v_uword_in1 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVB, VSUBB, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVB, VAND, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVB, VROTL, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_byte_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVB, VCMV_LTZ, v_byte_out2, 8, v_byte_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_byte_out1, 8 );
	vbxasm_acc_3D( SVB, VADDC, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_byte_out1, 8 );
	vbxasm_acc_3D( SVB, VMULFXP, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_byte_out1, 8 );
	vbxasm_acc_3D( SVB, VSHR, v_byte_out2, 8, v_byte_out2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBU, VSUB, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBU, VMULHI, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBU, VSHL, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBU, VCMV_LEZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_ubyte_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBU, VCMV_NZ, v_ubyte_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_ubyte_out1, 8 );
	vbxasm_acc_3D( SVBU, VADD, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_ubyte_out1, 8 );
	vbxasm_acc_3D( SVBU, VMUL, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_ubyte_out1, 8 );
	vbxasm_acc_3D( SVBU, VXOR, v_ubyte_out2, 8, v_ubyte_out2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMOV, v_ubyte_out1, 8 );
	vbxasm_acc_3D( SVBU, VMOV, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBH, VABSDIFF, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBH, VOR, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBH, VROTR, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_half_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBH, VCMV_GEZ, v_half_out2, 8, v_byte_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBHU, VSUBB, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBHU, VAND, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBHU, VROTL, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_uhalf_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBHU, VCMV_LTZ, v_uhalf_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBW, VADDC, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBW, VMULFXP, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBW, VSHR, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_word_out1, 8, v_byte_in2 );
	vbxasm_acc_3D( SVBW, VCMV_GTZ, v_word_out2, 8, v_byte_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBWU, VSUB, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBWU, VMULHI, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBWU, VSHL, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBWU, VCMV_LEZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_uword_out1, 8, v_ubyte_in2 );
	vbxasm_acc_3D( SVBWU, VCMV_NZ, v_uword_out2, 8, v_ubyte_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHB, VADD, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHB, VMUL, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHB, VXOR, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_byte_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHB, VCMV_Z, v_byte_out2, 8, v_half_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHBU, VABSDIFF, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHBU, VOR, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHBU, VROTR, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_ubyte_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHBU, VCMV_GEZ, v_ubyte_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVH, VSUBB, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVH, VAND, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVH, VROTL, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_half_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVH, VCMV_LTZ, v_half_out2, 8, v_half_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_half_out1, 8 );
	vbxasm_acc_3D( SVH, VADDC, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_half_out1, 8 );
	vbxasm_acc_3D( SVH, VMULFXP, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_half_out1, 8 );
	vbxasm_acc_3D( SVH, VSHR, v_half_out2, 8, v_half_out2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHU, VSUB, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHU, VMULHI, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHU, VSHL, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHU, VCMV_LEZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_uhalf_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHU, VCMV_NZ, v_uhalf_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_uhalf_out1, 8 );
	vbxasm_acc_3D( SVHU, VADD, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_uhalf_out1, 8 );
	vbxasm_acc_3D( SVHU, VMUL, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_uhalf_out1, 8 );
	vbxasm_acc_3D( SVHU, VXOR, v_uhalf_out2, 8, v_uhalf_out2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMOV, v_uhalf_out1, 8 );
	vbxasm_acc_3D( SVHU, VMOV, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHW, VABSDIFF, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHW, VOR, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHW, VROTR, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_word_out1, 8, v_half_in2 );
	vbxasm_acc_3D( SVHW, VCMV_GEZ, v_word_out2, 8, v_half_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHWU, VSUBB, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHWU, VAND, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHWU, VROTL, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_uword_out1, 8, v_uhalf_in2 );
	vbxasm_acc_3D( SVHWU, VCMV_LTZ, v_uword_out2, 8, v_uhalf_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWB, VADDC, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWB, VMULFXP, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWB, VSHR, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_byte_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWB, VCMV_GTZ, v_byte_out2, 8, v_word_in2 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWBU, VSUB, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWBU, VMULHI, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWBU, VSHL, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWBU, VCMV_LEZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_ubyte_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWBU, VCMV_NZ, v_ubyte_out2, 8, v_uword_in2 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWH, VADD, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWH, VMUL, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWH, VXOR, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_half_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVWH, VCMV_Z, v_half_out2, 8, v_word_in2 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWHU, VABSDIFF, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWHU, VOR, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWHU, VROTR, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_uhalf_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWHU, VCMV_GEZ, v_uhalf_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVW, VSUBB, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVW, VAND, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVW, VROTL, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_word_out1, 8, v_word_in2 );
	vbxasm_acc_3D( SVW, VCMV_LTZ, v_word_out2, 8, v_word_in2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_word_out1, 8 );
	vbxasm_acc_3D( SVW, VADDC, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_word_out1, 8 );
	vbxasm_acc_3D( SVW, VMULFXP, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_word_out1, 8 );
	vbxasm_acc_3D( SVW, VSHR, v_word_out2, 8, v_word_out2 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWU, VSUB, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWU, VMULHI, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWU, VSHL, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWU, VCMV_LEZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_uword_out1, 8, v_uword_in2 );
	vbxasm_acc_3D( SVWU, VCMV_NZ, v_uword_out2, 8, v_uword_in2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_uword_out1, 8 );
	vbxasm_acc_3D( SVWU, VADD, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_uword_out1, 8 );
	vbxasm_acc_3D( SVWU, VMUL, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_uword_out1, 8 );
	vbxasm_acc_3D( SVWU, VXOR, v_uword_out2, 8, v_uword_out2 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMOV, v_uword_out1, 8 );
	vbxasm_acc_3D( SVWU, VMOV, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_3D( VEB, VABSDIFF, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_3D( VEB, VOR, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_3D( VEB, VROTR, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_byte_out1, v_byte_in1, v_enum );
	vbxasm_acc_3D( VEB, VCMV_GEZ, v_byte_out2, v_byte_in1, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_byte_out1, v_enum );
	vbxasm_acc_3D( VEB, VSUBB, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_byte_out1, v_enum );
	vbxasm_acc_3D( VEB, VAND, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_byte_out1, v_enum );
	vbxasm_acc_3D( VEB, VROTL, v_byte_out2, v_byte_out2, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_3D( VEBU, VADDC, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_3D( VEBU, VMULFXP, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_3D( VEBU, VSHR, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_ubyte_out1, v_ubyte_in1, v_enum );
	vbxasm_acc_3D( VEBU, VCMV_GTZ, v_ubyte_out2, v_ubyte_in1, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_ubyte_out1, v_enum );
	vbxasm_acc_3D( VEBU, VSUB, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_ubyte_out1, v_enum );
	vbxasm_acc_3D( VEBU, VMULHI, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_ubyte_out1, v_enum );
	vbxasm_acc_3D( VEBU, VSHL, v_ubyte_out2, v_ubyte_out2, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_3D( VEH, VADD, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_3D( VEH, VMUL, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_3D( VEH, VXOR, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_half_out1, v_half_in1, v_enum );
	vbxasm_acc_3D( VEH, VCMV_Z, v_half_out2, v_half_in1, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_half_out1, v_enum );
	vbxasm_acc_3D( VEH, VABSDIFF, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_half_out1, v_enum );
	vbxasm_acc_3D( VEH, VOR, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_half_out1, v_enum );
	vbxasm_acc_3D( VEH, VROTR, v_half_out2, v_half_out2, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_3D( VEHU, VSUBB, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_3D( VEHU, VAND, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_3D( VEHU, VROTL, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_uhalf_out1, v_uhalf_in1, v_enum );
	vbxasm_acc_3D( VEHU, VCMV_LTZ, v_uhalf_out2, v_uhalf_in1, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_uhalf_out1, v_enum );
	vbxasm_acc_3D( VEHU, VADDC, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_uhalf_out1, v_enum );
	vbxasm_acc_3D( VEHU, VMULFXP, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_uhalf_out1, v_enum );
	vbxasm_acc_3D( VEHU, VSHR, v_uhalf_out2, v_uhalf_out2, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_3D( VEW, VSUB, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_3D( VEW, VMULHI, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_3D( VEW, VSHL, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_3D( VEW, VCMV_LEZ, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_word_out1, v_word_in1, v_enum );
	vbxasm_acc_3D( VEW, VCMV_NZ, v_word_out2, v_word_in1, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_word_out1, v_enum );
	vbxasm_acc_3D( VEW, VADD, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_word_out1, v_enum );
	vbxasm_acc_3D( VEW, VMUL, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_word_out1, v_enum );
	vbxasm_acc_3D( VEW, VXOR, v_word_out2, v_word_out2, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_3D( VEWU, VABSDIFF, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_3D( VEWU, VOR, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_3D( VEWU, VROTR, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_uword_out1, v_uword_in1, v_enum );
	vbxasm_acc_3D( VEWU, VCMV_GEZ, v_uword_out2, v_uword_in1, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_uword_out1, v_enum );
	vbxasm_acc_3D( VEWU, VSUBB, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_uword_out1, v_enum );
	vbxasm_acc_3D( VEWU, VAND, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_uword_out1, v_enum );
	vbxasm_acc_3D( VEWU, VROTL, v_uword_out2, v_uword_out2, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_byte_out1, 8, v_enum );
	vbxasm_acc_3D( SEB, VADDC, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_byte_out1, 8, v_enum );
	vbxasm_acc_3D( SEB, VMULFXP, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_byte_out1, 8, v_enum );
	vbxasm_acc_3D( SEB, VSHR, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_byte_out1, 8, v_enum );
	vbxasm_acc_3D( SEB, VCMV_GTZ, v_byte_out2, 8, 0 );
	errors += compare_accumulated_byte(v_byte_out1 , v_byte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUB, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_3D( SEBU, VSUB, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULHI, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_3D( SEBU, VMULHI, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHL, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_3D( SEBU, VSHL, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LEZ, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_3D( SEBU, VCMV_LEZ, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_NZ, v_ubyte_out1, 8, v_enum );
	vbxasm_acc_3D( SEBU, VCMV_NZ, v_ubyte_out2, 8, 0 );
	errors += compare_accumulated_ubyte(v_ubyte_out1 , v_ubyte_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADD, v_half_out1, 8, v_enum );
	vbxasm_acc_3D( SEH, VADD, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMUL, v_half_out1, 8, v_enum );
	vbxasm_acc_3D( SEH, VMUL, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VXOR, v_half_out1, 8, v_enum );
	vbxasm_acc_3D( SEH, VXOR, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_Z, v_half_out1, 8, v_enum );
	vbxasm_acc_3D( SEH, VCMV_Z, v_half_out2, 8, 0 );
	errors += compare_accumulated_half(v_half_out1 , v_half_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VABSDIFF, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_3D( SEHU, VABSDIFF, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VOR, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_3D( SEHU, VOR, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTR, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_3D( SEHU, VROTR, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GEZ, v_uhalf_out1, 8, v_enum );
	vbxasm_acc_3D( SEHU, VCMV_GEZ, v_uhalf_out2, 8, 0 );
	errors += compare_accumulated_uhalf(v_uhalf_out1 , v_uhalf_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSUBB, v_word_out1, 8, v_enum );
	vbxasm_acc_3D( SEW, VSUBB, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VAND, v_word_out1, 8, v_enum );
	vbxasm_acc_3D( SEW, VAND, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VROTL, v_word_out1, 8, v_enum );
	vbxasm_acc_3D( SEW, VROTL, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_LTZ, v_word_out1, 8, v_enum );
	vbxasm_acc_3D( SEW, VCMV_LTZ, v_word_out2, 8, 0 );
	errors += compare_accumulated_word(v_word_out1 , v_word_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VADDC, v_uword_out1, 8, v_enum );
	vbxasm_acc_3D( SEWU, VADDC, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VMULFXP, v_uword_out1, 8, v_enum );
	vbxasm_acc_3D( SEWU, VMULFXP, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VSHR, v_uword_out1, 8, v_enum );
	vbxasm_acc_3D( SEWU, VSHR, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	vbxx_acc_3D( VCMV_GTZ, v_uword_out1, 8, v_enum );
	vbxasm_acc_3D( SEWU, VCMV_GTZ, v_uword_out2, 8, 0 );
	errors += compare_accumulated_uword(v_uword_out1 , v_uword_out2  );
	if(errors){
		printf("Failed @ line %d\n", __LINE__);
	}

	printf("Completed Tests\n");
#endif //enable tests
  //-------------------------------------------------

	return errors;
}

int main()
{
	int errors = 0;

	vbx_test_init();

	errors += test_vec_function();

	VBX_TEST_END(errors);
	return 0;
}
