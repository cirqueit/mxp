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

#include "vbx_test.h"
#include "Vector.hpp"
#include "vbw_vec_div.h"
const int SHORT_TEST_LEN = 16;


typedef vbx_byte_t test_t;
#define DIVISOR 2

template <typename T>
static void print_array(T *d, int size)
{
	for(int i=0;i<size;i++){
		printf("%d\t",d[i]);
	}
	printf("\n");
}

template<typename T>
static int verify_array( T*  scalar,T* vector,int size)
{
	int errors=0;
	for(int i=0;i<size;i++){
		if(vector[i]!=scalar[i]){
			errors++;
			printf("error @ %d scalar=%d vector=%d\n",i,scalar[i],vector[i]);
		}
	}
	return errors;
}
int exhaustive_test(){
	int errors=0;
	test_t* quotient=(test_t*)vbx_sp_malloc  (256*sizeof(test_t));
	test_t* dividend=(test_t*)vbx_sp_malloc  (256*sizeof(test_t));
	test_t* divisor =(test_t*)vbx_sp_malloc  (256*sizeof(test_t));
	test_t* scalar_quotient = (test_t*)malloc(256*sizeof(test_t));
	vbx_set_vl(256);
	const int limit = (sizeof(test_t)==1) ? 127 : (sizeof(test_t)==2 ? 32767 : (1<<24)-1/*16M*/ );
	for( int k=1; k<=1+limit/256; k++ ) {
		vbxx( VMUL, dividend, k, (vbx_enum_t*)0 );
		for( int i=1; i<=limit; i++ ) {
			vbxx(VMOV,divisor,i);
			vbw_vec_divide(quotient,dividend,divisor,256);
			for( int j=0; j<256; j++ ) {
				scalar_quotient[j]=dividend[j]/divisor[j];
			}
			vbx_sync();
			errors += verify_array( scalar_quotient, quotient, 256 );
		}
	}

	return errors;
}
int main(){
	vbx_test_init();
	vbx_mxp_print_params();
	int errors=0;
	vbx_sp_push();
	test_t* quotient=(test_t*)vbx_sp_malloc(SHORT_TEST_LEN*sizeof(test_t));
	test_t* dividend=(test_t*)vbx_sp_malloc(SHORT_TEST_LEN*sizeof(test_t));
	test_t* divisor =(test_t*)vbx_sp_malloc(SHORT_TEST_LEN*sizeof(test_t));
	test_t* scalar_quotient = (test_t*)malloc(SHORT_TEST_LEN*sizeof(test_t));
	vbx_set_vl(SHORT_TEST_LEN);
	vbxx(VMUL,dividend,1,(vbx_enum_t*)0);
	vbxx(VADD,dividend,120,dividend );
	vbxx(VMOV,divisor,DIVISOR);
	printf ("dividend\n");
	print_array( dividend, SHORT_TEST_LEN);
	printf("divisor\n");
	print_array( divisor, SHORT_TEST_LEN);
	vbw_vec_divide(quotient,dividend,divisor,SHORT_TEST_LEN);
	vbx_sync();
	printf("vector quotient\n");
	print_array( quotient, SHORT_TEST_LEN);
	for(int i=0;i<SHORT_TEST_LEN;i++){
		scalar_quotient[i]=dividend[i]/divisor[i];
	}
	printf("scalar quotient\n");
	print_array( scalar_quotient, SHORT_TEST_LEN);

	errors+=verify_array( scalar_quotient,quotient,SHORT_TEST_LEN);
	vbx_sp_pop();
	errors+=exhaustive_test();
	//vbxsim_print_stats_extended();
	VBX_TEST_END(errors);

}
