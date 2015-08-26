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
#include "vbx_port.h"
#include "vbx_test.h"
#include "Vector.hpp"
#include <malloc.h>

using namespace VBX;
template <typename T,typename V>
int verify(Vector<T>& vector,V* scalar,int len){
	//make these volatile to avoid read combining
	volatile T* va=(volatile T*)vector.data;
	volatile V* vb=(volatile V*)scalar;
	vbx_sync();
	for(int i=0;i<len;i++){
		unsigned int aa=va[i],bb=vb[i];
		if(aa!=bb){
			fprintf(stderr,"vector[%d]=0x%x,scalar[%d]=0x%x\n",i,aa,i,bb);
			return 0;
		}
	}
	return 1;
}

template<typename T>
void randomize(Vector<T>& v){
	for(size_t i=0;i<v.size;i++){
		v.data[i]=rand();
	}
}
//V=B tests

//V=B* tests
template<typename D, typename S1,typename S2>
int test_Bstar(Vector<D>& dest,Vector<S1>& srcA,Vector<S1>& srcB,Vector<S2>& srcC,int len){
	int errors=0;
	D* s_dest=(D*)vbx_shared_malloc(len*sizeof(D));
	S1 scalarA __attribute__((unused));
	S1 scalarB __attribute__((unused));
	S2 scalarC __attribute__((unused));
	randomize(dest);
	randomize(srcA);
	randomize(srcB);
	randomize(srcC);

	scalarA=rand(),scalarB=rand(),scalarC=rand();

	dest= (srcA ^ srcB).template cast<D>() * (scalarC);
	vbx_sync();
	for(int i=0;i<len;i++){

		s_dest[i]= (srcA.data[i] ^ srcB.data[i] ) *  scalarC;
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"VVS Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (srcA - scalarB) * (scalarC);
	for(int i=0;i<len;i++){
		s_dest[i]= (S1)(srcA.data[i] - scalarB) *  scalarC;
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"VSS Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (srcA & ENUM) ^ (scalarC);
	for(int i=0;i<len;i++){
		s_dest[i]= (srcA.data[i] & (typeof(scalarB))i) ^  scalarC;
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"VES Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (scalarA + srcB).template cast<S2>() - (srcC);
	for(int i=0;i<len;i++){
		s_dest[i]= (S2)(scalarA + srcB.data[i]) -  srcC.data[i];
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"SVV Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (scalarA + scalarB) * (srcC);
	for(int i=0;i<len;i++){
		s_dest[i]= (scalarA + scalarB) *  srcC.data[i];
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"SSV Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (scalarA + ENUM) << (scalarC&7);
	for(int i=0;i<len;i++){
		s_dest[i]= (D)(scalarA + (S1)i) <<  (scalarC&7);
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"SES Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (ENUM + srcB) + (scalarC);
	for(int i=0;i<len;i++){
		s_dest[i]= (S1)((S1)i + srcB.data[i]) +  scalarC;
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"EVS Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	dest= (ENUM + scalarB) + (srcC);
	for(int i=0;i<len;i++){
		s_dest[i]= (S2)((typeof(scalarA))i + scalarB) +  srcC.data[i];
	}
	if(!verify(dest,s_dest,len)){
		fprintf(stderr,"ESV Failed %s\n",__PRETTY_FUNCTION__);
		errors++;
	}
	vbx_shared_free(s_dest);
	return errors;
}

int test_all_Bstar(int len){
	int errors=0;
	Vector<vbx_uword_t> vdest_vbx_uword_t(len),vsrca_vbx_uword_t(len),vsrcb_vbx_uword_t(len),vsrcc_vbx_uword_t(len);
	Vector<vbx_uhalf_t> vdest_vbx_uhalf_t(len),vsrca_vbx_uhalf_t(len),vsrcb_vbx_uhalf_t(len),vsrcc_vbx_uhalf_t(len);
	Vector<vbx_ubyte_t> vdest_vbx_ubyte_t(len),vsrca_vbx_ubyte_t(len),vsrcb_vbx_ubyte_t(len),vsrcc_vbx_ubyte_t(len);
	Vector<vbx_word_t> vdest_vbx_word_t(len),vsrca_vbx_word_t(len),vsrcb_vbx_word_t(len),vsrcc_vbx_word_t(len);
	Vector<vbx_half_t> vdest_vbx_half_t(len),vsrca_vbx_half_t(len),vsrcb_vbx_half_t(len),vsrcc_vbx_half_t(len);
	Vector<vbx_byte_t> vdest_vbx_byte_t(len),vsrca_vbx_byte_t(len),vsrcb_vbx_byte_t(len),vsrcc_vbx_byte_t(len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_word_t,vsrcb_vbx_word_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_uhalf_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_uhalf_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_uhalf_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_word_t,vsrcb_vbx_word_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_word_t,vsrcb_vbx_word_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_word_t,vsrcb_vbx_word_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_word_t,vsrcb_vbx_word_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_uword_t,len);
	errors+=test_Bstar(vdest_vbx_uhalf_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_uword_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_uhalf_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_uword_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_half_t,vsrcb_vbx_half_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_ubyte_t,vsrcb_vbx_ubyte_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_word_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_byte_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_half_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_ubyte_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_word_t,len);
	errors+=test_Bstar(vdest_vbx_byte_t,vsrca_vbx_byte_t,vsrcb_vbx_byte_t,vsrcc_vbx_ubyte_t,len);
	errors+=test_Bstar(vdest_vbx_uword_t,vsrca_vbx_uhalf_t,vsrcb_vbx_uhalf_t,vsrcc_vbx_uhalf_t,len);
	errors+=test_Bstar(vdest_vbx_half_t,vsrca_vbx_uword_t,vsrcb_vbx_uword_t,vsrcc_vbx_ubyte_t,len);
	return errors;
}

int cmv_test(int len){
	Vector<vbx_word_t> a(len);
	Vector<vbx_half_t> b(len);
	Vector<vbx_word_t> c(len);
	int errors=0;
	c=0;
	b=1;
	a=ENUM;
	vbx_word_t* s_c=(vbx_word_t*)vbx_shared_malloc(len*sizeof(vbx_word_t));
	for(int i=0;i<len;i++){
		s_c[i]=!(a.data[i]==0 || a.data[i]>=3) && b.data[i]==1?b.data[i]*5:c.data[i];
	}
	c.cond_move(!(a==0 || a>=3) && (b==1).cast<vbx_word_t>(),(b*5).cast<vbx_word_t>());
	if(!verify(c,s_c,len)){
		fprintf(stderr,"CMV Failed %s line %d\n",__PRETTY_FUNCTION__,__LINE__);
		errors++;
	}
	vbx_shared_free(s_c);
	return errors;
}

int masked_test(int len)
{
	Vector<vbx_word_t> a(len);
	Vector<vbx_half_t> b(len);
	Vector<vbx_byte_t> c=(len);
	int errors=0;
	b=len/2;
	a=ENUM;
	c=0;
	Vector_mask(a==0 || a<b.cast<vbx_word_t>()){
		c=1;
	}
	vbx_byte_t* s_c=(vbx_byte_t*)vbx_shared_malloc(len*sizeof(vbx_word_t));
	for(int i=0;i<len;i++){
		s_c[i]=0;
	}
	for(int i=0;i<len;i++){
		if(a.data[i] == 0 || a.data[i] <b.data[i]){
			s_c[i]=1;
		}
	}
	c.printVec();
	if(!verify(c,s_c,len)){
		fprintf(stderr,"masked test Failed %s line %d\n",__PRETTY_FUNCTION__,__LINE__);
		errors++;
	}
	return errors;
}
int main()
{
	int errors=0;
	vbx_test_init();

	vbx_mxp_print_params();

	if(1){
		Vector<vbx_word_t> a(7);
		Vector<vbx_word_t> b(10);
		Vector<vbx_word_t> c(2);
		a=ENUM;
		c=ENUM&1;

		b[0]=accumulate(a+1);
		vbx_word_t scalar=28;
		errors+=!verify(b,&scalar,1);

		b[0 upto 5]=accumulate(a.to2D(2,5,1));

		vbx_word_t pscalar[]={1,3,5,7,9};
		errors+=!verify(b,pscalar,5);
	}
	if(1){
		Vector<vbx_word_t> a(10);
		Vector<vbx_word_t> b(10);
		Vector<vbx_word_t> c(10);
		Vector<vbx_word_t> d(10);
		a=ENUM;
		b=ENUM;
		c=ENUM;
		d.to2D(2,5,2)=a.to2D(2,5,2)+b.to2D(2,5,2)+c.to2D(2,5,2);
		vbx_word_t pscalar[]={0,3,6,9,12,15,18,21,24,27};
		errors+=!verify(d,pscalar,10);
	}
	if(1){
		Vector<vbx_word_t> a(5);
		Vector<vbx_word_t> b(10);
		Vector<vbx_word_t> c(10);
		Vector<vbx_word_t> d(5);
		a=ENUM;
		b=ENUM;
		c=ENUM;

		d=a+accumulate(b.to2D(2,5,2)+c.to2D(2,5,2));
		vbx_word_t pscalar[]={2,11,20,29,38};
		errors+=!verify(d,pscalar,5);
		d= accumulate(b.to2D(2,5,2)+1)+accumulate(c.to2D(2,5,2)+1);
		vbx_word_t pscalar1[]={6,14,22,30,38};
		errors+=!verify(d,pscalar1,5);
	}
	if(1){
		errors+=test_all_Bstar(100);
		errors+=cmv_test(100);
		errors+=masked_test(10);
	}
	VBX_TEST_END(errors);
	return errors;
}
