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

#include "scalar_vec_divide.h"

static inline void divide_uword( uint32_t *div, uint32_t *rem, uint32_t a, uint32_t b )
{
	// initialize
	uint32_t bb = b;

	// data-dependent loop 1
	// shifts out all leading zeros
	int32_t i, max_count=1;

	int32_t flag=1;
	for( i=0; i<31; i++ ) {
		uint32_t v2b = 2*bb;
		uint32_t vtmp = v2b/2;
		if( bb != vtmp) flag=0;
		if(  a  < v2b ) flag=0;
		if( flag ) bb = v2b;

		if( !flag ) break;
		max_count++;
	}

	// data-dependent loop 2
	// shift in all significant digits
	uint32_t result = 0;
	flag=1;
	uint32_t vcc = a;
	for( i=0; i<max_count; i++ ) {
		if( bb < b ) flag=0;
		uint32_t v2b = 0;
		uint32_t vtmp = vcc - bb;
		if( vcc >= bb ) v2b  = 1;
		v2b = v2b + result + result;
		if( flag ) result = v2b;
		if( vcc >= bb ) vcc = vtmp;
		bb = bb >> 1;
	}
	uint32_t remainder = vcc;

	if( a==0 ) { result = remainder = 0; }
	if( b==0 ) { result = remainder = UINT_MAX; }

	*div = result;
	if(rem) *rem = remainder;
}

static inline void divide_uhalf( uint16_t *div, uint16_t *rem, uint16_t a, uint16_t b )
{
	// initialize
	uint16_t bb = b;

	// data-dependent loop 1
	// shifts out all leading zeros
	int16_t i, max_count=1;

	int16_t flag=1;
	for( i=0; i<31; i++ ) {
		uint16_t v2b = 2*bb;
		uint16_t vtmp = v2b/2;
		if( bb != vtmp) flag=0;
		if(  a  < v2b ) flag=0;
		if( flag ) bb = v2b;

		if( !flag ) break;
		max_count++;
	}

	// data-dependent loop 2
	// shift in all significant digits
	uint16_t result = 0;
	flag=1;
	uint16_t vcc = a;
	for( i=0; i<max_count; i++ ) {
		if( bb < b ) flag=0;
		uint16_t v2b = 0;
		uint16_t vtmp = vcc - bb;
		if( vcc >= bb ) v2b  = 1;
		v2b = v2b + result + result;
		if( flag ) result = v2b;
		if( vcc >= bb ) vcc = vtmp;
		bb = bb >> 1;
	}
	uint16_t remainder = vcc;

	if( a==0 ) { result = remainder = 0; }
	if( b==0 ) { result = remainder = UINT_MAX; }

	*div = result;
	if(rem) *rem = remainder;
}

static inline void divide_ubyte( uint8_t *div, uint8_t *rem, uint8_t a, uint8_t b )
{
	// initialize
	uint8_t bb = b;

	// data-dependent loop 1
	// shifts out all leading zeros
	int8_t i, max_count=1;

	int8_t flag=1;
	for( i=0; i<31; i++ ) {
		uint8_t v2b = 2*bb;
		uint8_t vtmp = v2b/2;
		if( bb != vtmp) flag=0;
		if(  a  < v2b ) flag=0;
		if( flag ) bb = v2b;

		if( !flag ) break;
		max_count++;
	}

	// data-dependent loop 2
	// shift in all significant digits
	uint8_t result = 0;
	flag=1;
	uint8_t vcc = a;
	for( i=0; i<max_count; i++ ) {
		if( bb < b ) flag=0;
		uint8_t v2b = 0;
		uint8_t vtmp = vcc - bb;
		if( vcc >= bb ) v2b  = 1;
		v2b = v2b + result + result;
		if( flag ) result = v2b;
		if( vcc >= bb ) vcc = vtmp;
		bb = bb >> 1;
	}
	uint8_t remainder = vcc;

	if( a==0 ) { result = remainder = 0; }
	if( b==0 ) { result = remainder = UINT_MAX; }

	*div = result;
	if(rem) *rem = remainder;
}

static inline void divide_word( int32_t *div, int32_t *rem, int32_t a, int32_t b )
{
	// initialize
	int32_t bb = b;

	// data-dependent loop 1
	// shifts out all leading zeros
	int32_t i, max_count=1;

	int32_t flag=1;
	for( i=0; i<31; i++ ) {
		int32_t v2b = 2*bb;
		int32_t vtmp = v2b/2;
		if( bb != vtmp) flag=0;
		if(  a  < v2b ) flag=0;
		if( flag ) bb = v2b;

		if( !flag ) break;
		max_count++;
	}

	// data-dependent loop 2
	// shift in all significant digits
	int32_t result = 0;
	flag=1;
	int32_t vcc = a;
	for( i=0; i<max_count; i++ ) {
		if( bb < b ) flag=0;
		int32_t v2b = 0;
		int32_t vtmp = vcc - bb;
		if( vcc >= bb ) v2b  = 1;
		v2b = v2b + result + result;
		if( flag ) result = v2b;
		if( vcc >= bb ) vcc = vtmp;
		bb = bb >> 1;
	}
	int32_t remainder = vcc;

	if( a==0 ) { result = remainder = 0; }
	if( b==0 ) { result = remainder = UINT_MAX; }

	*div = result;
	if(rem) *rem = remainder;
}

static inline void divide_half( int16_t *div, int16_t *rem, int16_t a, int16_t b )
{
	// initialize
	int16_t bb = b;

	// data-dependent loop 1
	// shifts out all leading zeros
	int16_t i, max_count=1;

	int16_t flag=1;
	for( i=0; i<31; i++ ) {
		int16_t v2b = 2*bb;
		int16_t vtmp = v2b/2;
		if( bb != vtmp) flag=0;
		if(  a  < v2b ) flag=0;
		if( flag ) bb = v2b;

		if( !flag ) break;
		max_count++;
	}

	// data-dependent loop 2
	// shift in all significant digits
	int16_t result = 0;
	flag=1;
	int16_t vcc = a;
	for( i=0; i<max_count; i++ ) {
		if( bb < b ) flag=0;
		int16_t v2b = 0;
		int16_t vtmp = vcc - bb;
		if( vcc >= bb ) v2b  = 1;
		v2b = v2b + result + result;
		if( flag ) result = v2b;
		if( vcc >= bb ) vcc = vtmp;
		bb = bb >> 1;
	}
	int16_t remainder = vcc;

	if( a==0 ) { result = remainder = 0; }
	if( b==0 ) { result = remainder = UINT_MAX; }

	*div = result;
	if(rem) *rem = remainder;
}

static inline void divide_byte( int8_t *div, int8_t *rem, int8_t a, int8_t b )
{
	// initialize
	int8_t bb = b;

	// data-dependent loop 1
	// shifts out all leading zeros
	int8_t i, max_count=1;

	int8_t flag=1;
	for( i=0; i<31; i++ ) {
		int8_t v2b = 2*bb;
		int8_t vtmp = v2b/2;
		if( bb != vtmp) flag=0;
		if(  a  < v2b ) flag=0;
		if( flag ) bb = v2b;

		if( !flag ) break;
		max_count++;
	}

	// data-dependent loop 2
	// shift in all significant digits
	int8_t result = 0;
	flag=1;
	int8_t vcc = a;
	for( i=0; i<max_count; i++ ) {
		if( bb < b ) flag=0;
		int8_t v2b = 0;
		int8_t vtmp = vcc - bb;
		if( vcc >= bb ) v2b  = 1;
		v2b = v2b + result + result;
		if( flag ) result = v2b;
		if( vcc >= bb ) vcc = vtmp;
		bb = bb >> 1;
	}
	int8_t remainder = vcc;

	if( a==0 ) { result = remainder = 0; }
	if( b==0 ) { result = remainder = UINT_MAX; }

	*div = result;
	if(rem) *rem = remainder;
}

void scalar_vec_divide_byte(int8_t *output, int8_t *remainder, int8_t *input1, int8_t *input2, const int N)
{
    int i;
    for(i=0; i<N; i++){
        divide_byte(&output[i], &remainder[i], input1[i], input2[i]);

    }
}

void scalar_vec_divide_half(int16_t *output, int16_t *remainder, int16_t *input1, int16_t *input2, const int N)
{
    int i;
    for(i=0; i<N; i++){
        divide_half(&output[i], &remainder[i], input1[i], input2[i]);

    }
}

void scalar_vec_divide_word(int32_t *output, int32_t *remainder, int32_t *input1, int32_t *input2, const int N)
{
    int i;
    for(i=0; i<N; i++){
        divide_word(&output[i], &remainder[i], input1[i], input2[i]);

    }
}

void scalar_vec_divide_ubyte(uint8_t *output, uint8_t *remainder, uint8_t *input1, uint8_t *input2, const int N)
{
    int i;
    for(i=0; i<N; i++){
        divide_ubyte(&output[i], &remainder[i], input1[i], input2[i]);

    }
}

void scalar_vec_divide_uhalf(uint16_t *output, uint16_t *remainder,  uint16_t *input1, uint16_t *input2, const int N)
{
    int i;
    for(i=0; i<N; i++){
        divide_uhalf(&output[i], &remainder[i], input1[i], input2[i]);

    }
}

void scalar_vec_divide_uword(uint32_t *output, uint32_t *remainder, uint32_t *input1, uint32_t *input2, const int N)
{
    int i;
    for(i=0; i<N; i++){
        divide_uword(&output[i], &remainder[i], input1[i], input2[i]);

    }
}
