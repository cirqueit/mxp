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

#include "vbx_copyright.h"
VBXCOPYRIGHT( api )

#include "vbx.h"
#include "vbx_port.h"



// --------------------------------------------------------
// System-wide global variables

#if VBX_USE_GLOBAL_MXP_PTR
vbx_mxp_t *vbx_mxp_ptr;
#endif

// --------------------------------------------------------
// Local variables
//#define vbx_sp        (this_mxp->sp)
#define sp_stack      (this_mxp->spstack)
#define sp_stack_top  (this_mxp->spstack_top)
#define sp_stack_max  (this_mxp->spstack_max)

// --------------------------------------------------------
// System-wide initialization

/** Initialize MXP processor
 *
 * param[out] this_mxp
 */
void _vbx_init( vbx_mxp_t *this_mxp )
{
	// initialize the sp stack
	// max = depth of scratchpad
	this_mxp->spstack_max = (VBX_STATIC_ALLOCATE_SP_STACK ?
	                         VBX_STATIC_SP_STACK_SIZE:64);
	this_mxp->spstack_top = 0;

	if( !this_mxp->spstack ) {
		int spstack_size = this_mxp->spstack_max * sizeof(vbx_void_t *);
		this_mxp->spstack = (vbx_void_t **)malloc( spstack_size );
		if ( !this_mxp->spstack ) {
			VBX_PRINTF("ERROR: failed to malloc %d bytes for spstack.\n", spstack_size);
			VBX_FATAL(__LINE__, __FILE__, -1);
		}
#if VBX_DEBUG_MALLOC
		printf("_vbx_init: malloc %d bytes\n", spstack_size);
#endif
	}

#if VBX_USE_GLOBAL_MXP_PTR
	// Must be set before any MXP instructions can be issued!
	vbx_mxp_ptr = this_mxp;
#endif

	// FIXME WARNING: the function call below only works for uniprocessors
	// The function must only be called by the CPU that owns the accelerator
	// described by 'mxp' instance.
#if !linux && 0
	vbx_set_reg( VBX_REG_MXPCPU, (int)this_mxp ); // FIXME
#endif
	this_mxp->init = 1;
}


// --------------------------------------------------------
// Allocate and deallocate scratchpad memory.

static void print_sp_malloc_null()
{	printf( "WARNING: vbx_sp_malloc() requested 0 bytes.\n" );
}

static void print_sp_malloc_full( size_t num_bytes, size_t padded_bytes )
{
	printf( "ERROR: vbx_sp_malloc() requested %d bytes, ", (int)num_bytes );
	printf( "aligned needs %d bytes, ",       (int)padded_bytes );
	printf( "but only %d bytes available.\n", (int)vbx_sp_getfree() );
}

vbx_void_t *vbx_sp_malloc_debug( int LINE,const char *FNAME, size_t num_bytes )
{
	// print pretty error messages
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	if( !this_mxp || !this_mxp->init ) {
		VBX_PRINTF( "ERROR: failed to call _vbx_init().\n" );
		VBX_FATAL(LINE,FNAME,-1);
	}

	// pad to scratchpad width to reduce occurrence of false hazards
	size_t padded = VBX_PAD_UP( num_bytes, this_mxp->scratchpad_alignment_bytes );
	size_t freesp = (size_t)(this_mxp->scratchpad_end - this_mxp->sp); //VBX_SCRATCHPAD_END - (size_t)vbx_sp; // vbx_sp_getfree();

	vbx_void_t  *result = NULL;
	if( VBX_DEBUG_LEVEL && (num_bytes==0) ) {
		print_sp_malloc_null();
	} else if( VBX_DEBUG_LEVEL && freesp < padded ) {
		print_sp_malloc_full( num_bytes, padded );
	} else if( num_bytes > 0  &&  freesp >= padded ) {
		result        = this_mxp->sp;
		this_mxp->sp += padded;
#if VBX_DEBUG_SP_MALLOC
		printf("sp_malloc %d bytes padded to %d, sp=0x%08x\n", num_bytes, padded, this_mxp->sp);
#endif
	}

	if( !result ) {
		VBX_FATAL(LINE,FNAME,-1);
	}
	return result;
}

vbx_void_t *vbx_sp_malloc_nodebug( size_t num_bytes )
{
	if( VBX_DEBUG_LEVEL && 0 ) {
		// print pretty error messages
		return vbx_sp_malloc_debug( __LINE__, __FILE__, num_bytes );
	}

	// do it, but do not print pretty error messages
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();

	// check for valid argument values
	if( !this_mxp  ||  num_bytes==0 )
		return NULL;

	// add padding and allocate
	// pad to scratchpad width to reduce occurrence of false hazards
	size_t padded = VBX_PAD_UP( num_bytes, this_mxp->scratchpad_alignment_bytes );
	vbx_void_t *old_sp = this_mxp->sp;
	this_mxp->sp += padded;

	// scratchpad full
	if( this_mxp->sp > this_mxp->scratchpad_end ) {
		this_mxp->sp = old_sp;
		return NULL;
	}

	// success
	return old_sp;
}

void vbx_sp_push_realloc(){
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	//double the stack space
	this_mxp->spstack_max*=2;
	size_t spstack_size=this_mxp->spstack_max*sizeof(void*);

	printf("realloc sp_stack %d\n",this_mxp->spstack_max);
	this_mxp->spstack=(void**)realloc((void*)this_mxp->spstack,spstack_size);

	if ( !this_mxp->spstack ) {
		VBX_PRINTF("ERROR: Failed to malloc %d bytes for spstack.\n", (int)spstack_size);
		VBX_FATAL(__LINE__, __FILE__, -1);
	}
}
void vbx_sp_free_debug( int LINE, const char *FNAME )
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	if( !this_mxp )  {
		VBX_PRINTF( "ERROR: failed to call _vbx_init().\n" );
		VBX_FATAL(LINE,FNAME,-1);
	} else {
		this_mxp->sp = this_mxp->scratchpad_addr;
		this_mxp->spstack_top = 0;
	}
}

void vbx_sp_free_nodebug()
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	if( this_mxp )  {
		this_mxp->sp = this_mxp->scratchpad_addr;
		this_mxp->spstack_top = 0;
	}
}

//make this function not inlined to improve code
//density of inlined functions
void VBX_FATAL(int line, const char* fname, int err){
	printf( "FATAL ERROR: line %d of %s.\n", line, fname );
	if( VBX_DEBUG_LEVEL > 1 ) {
		printf("Exiting.\n");
		putchar(4);
		exit(err);
	}
}

// --------------------------------------------------------
// Scratchpad manipulation routines
int vbx_sp_getused()
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int used = 0;
	if( this_mxp )
		used = (int)(this_mxp->sp - this_mxp->scratchpad_addr);
	return used;
}

int vbx_sp_getfree()
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	int free = 0;
	if( this_mxp )
		free = (int)(this_mxp->scratchpad_end - this_mxp->sp);
	return free;
}

vbx_void_t *vbx_sp_get()
{
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	return this_mxp ? this_mxp->sp : NULL;
}

void vbx_sp_set_debug( int LINE, const char *FNAME, vbx_void_t *new_sp )
{
	// print pretty error messages
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	if( !this_mxp )  {
		VBX_PRINTF( "ERROR: failed to call _vbx_init().\n" );
		VBX_FATAL(LINE,FNAME,-1);
	} else if( (this_mxp->scratchpad_addr <= new_sp && new_sp <= this_mxp->scratchpad_end)
	           && VBX_IS_ALIGNED(new_sp, 4) ) {
		this_mxp->sp = new_sp;
	} else {
		VBX_PRINTF( "ERROR: attempt to set scratchpad to illegal or unaligned address 0x%08lx.\n", (long int)new_sp );
		VBX_FATAL(LINE,FNAME,-1);
	}
}

void vbx_sp_set_nodebug( vbx_void_t *new_sp )
{
	if( VBX_DEBUG_LEVEL ) {
		// print pretty error messages
		vbx_sp_set_debug( __LINE__, __FILE__, new_sp );
	}

	// do it, but do not print pretty error messages
	vbx_mxp_t *this_mxp = VBX_GET_THIS_MXP();
	if( this_mxp
	           && (this_mxp->scratchpad_addr <= new_sp && new_sp <= this_mxp->scratchpad_end)
	           && VBX_IS_ALIGNED(new_sp, 4) ) {
		this_mxp->sp = new_sp;
	}
}



size_t __old_vl__=0;
