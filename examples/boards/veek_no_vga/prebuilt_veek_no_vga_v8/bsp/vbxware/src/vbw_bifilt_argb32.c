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
VBXCOPYRIGHT(vbw_bifilt_argb32)

#include "vbx.h"
#include "vbx_port.h"
#include "vbw_mtx_sobel.h"
#include "vbw_exit_codes.h"
#include "vbw_buffer.h"
#include "vbw_vec_div.h"

/// Convert a row of aRGB pixels into luma values
/// v_luma should not equal v_row_in
/// Trashes v_temp
static void vbw_rgb2luma(vbx_uhalf_t *v_luma, vbx_uword_t *v_row_in, vbx_uhalf_t *v_temp, const int image_width)
{
	vbx_set_vl(image_width);

	// Move weighted B into v_luma
	vbx(SVWHU, VAND, v_temp, 0xFF,   v_row_in);
	vbx(SVHU,  VMUL, v_luma, 25,     v_temp);

	// Move weighted G into v_temp and add it to v_luma
	vbx(SVWHU, VAND, v_temp, 0xFF,   (vbx_uword_t*)(((vbx_ubyte_t *)v_row_in)+1));
	vbx(SVHU,  VMUL, v_temp, 129,    v_temp);
	vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

	// Move weighted R into v_temp and add it to v_luma
	vbx(SVWHU, VAND, v_temp, 0xFF,   (vbx_uword_t*)(((vbx_ubyte_t *)v_row_in)+2));
	vbx(SVHU,  VMUL, v_temp, 66,     v_temp);
	vbx(VVHU,  VADD, v_luma, v_luma, v_temp);

	vbx(SVHU,  VADD, v_luma, 128,    v_luma); // for rounding
//	vbx(SVHU,  VSHR, v_luma, 8,      v_luma);
}



/** EXPERIMENTAL: bilateral filter for noise reduction
 *
 * @brief 3x3 Bilateral filter, source is 32-bit aRGB image, output is 32b aRGB image in grayscale
 *
 * @param[out] output      32-bit aRGB grayscale output
 * @param[in] input        32-bit aRGB input
 * @param[in] image_width  Image width in pixels
 * @param[in] image_height Image height in pixels
 * @param[in] image_pitch  Distance in pixels between the start of subsequent rows. usually equal to image_width
 * @param[in] renorm       Number of bits to shift the final intensity by to the right
 * @returns Negative on error condition. See vbw_exit_codes.h
 */

#define W 5   // window size, 3 or 5, eg 3 for a 3x3 window

#if 0
static double sigma=1.000000;
// to take advantage of symmetry later, we can precompute factors of each row
// and then just sum the correct preweighted rows
#define NUM_GAUSS 3
static int gauss_factors[NUM_GAUSS] = { 93, 154, 255 };
#endif

#if W==3

static int gauss[3][3] = {
	#if 1
		{  93, 154,  93 },
		{ 154, 255, 154 },
		{  93, 154,  93 }
	#elif 0
		{ 255, 255, 255 },
		{ 255, 255, 255 },
		{ 255, 255, 255 }
	#else
		{  64, 128,  64 },
		{ 128, 255, 128 },
		{  64, 128,  64 }
	#endif
};
//static int gauss_factors[3] = { 64, 128, 255 };

#else

//static double sigma=1.000000;
static int gauss[5][5] = {
	{   4,  20,  34,  20,   4 },
	{  20,  93, 154,  93,  20 },
	{  34, 154, 255, 154,  34 },
	{  20,  93, 154,  93,  20 },
	{   4,  20,  34,  20,   4 }
};
//static int gauss_factors[6] = { 4, 20, 34, 93, 154, 255 };

#endif





int vbw_bifilt_argb32_3x3(unsigned *output, unsigned *input, short image_width, const short image_height, const short image_pitch, const short renorm)
{

//return vbw_sobel_argb32_3x3( output, input, image_width, image_height, image_pitch, renorm);

	int y;
	int xx, yy, sharp;

	vbx_uword_t *v_row_in;
	vbx_ubyte_t *v_luma_top, *v_luma_mid, *v_luma_bot;
	vbx_ubyte_t *v_luma_hii,              *v_luma_low;
	vbx_ubyte_t *v_src[W][W];

	vbx_uword_t *v_row_out;

	vbx_ubyte_t *v00, *v01, *v02, *v10, *v11, *v12, *v20, *v21, *v22;
#if W==5
	vbx_ubyte_t *v03, *v04,       *v13, *v14,       *v23, *v24;
	vbx_ubyte_t *v30, *v31, *v32, *v40, *v41, *v42;
	vbx_ubyte_t *v33, *v34,       *v43, *v44;
#endif
	vbx_ubyte_t *v[W][W];

	vbx_uhalf_t *vI, *vW, *vT;  // vT== temporary


	vbx_sp_push();

	// Allocate space in scratchpad for vectors
	struct rotating_prefetcher_t v_row_db=rotating_prefetcher(1,image_width*sizeof(vbx_uword_t),
	                                                          input,input+image_height*image_pitch,
	                                                          image_pitch*sizeof(vbx_uword_t));

	v_row_out  = (vbx_uword_t*)vbx_sp_malloc(image_width*sizeof(vbx_uword_t));
	vT         = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
#if 1
	// save some space by overlapping with v_row_out
	vW         = (vbx_uhalf_t*)v_row_out;
	vI         = (vbx_uhalf_t*)v_row_out + image_width;
#else
	vW         = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
	vI         = (vbx_uhalf_t*)vbx_sp_malloc(image_width*sizeof(vbx_uhalf_t));
#endif

#if W==3
	v_luma_top      = (vbx_ubyte_t*)vbx_sp_malloc( 3 * image_width*sizeof(vbx_ubyte_t));
	v_luma_mid      = v_luma_top + 1 * image_width*sizeof(vbx_ubyte_t) ;
	v_luma_bot      = v_luma_top + 2 * image_width*sizeof(vbx_ubyte_t) ;
#else
	v_luma_top      = (vbx_ubyte_t*)vbx_sp_malloc( 5 * image_width*sizeof(vbx_ubyte_t));
	v_luma_hii      = v_luma_top + 1 * image_width*sizeof(vbx_ubyte_t) ;
	v_luma_mid      = v_luma_top + 2 * image_width*sizeof(vbx_ubyte_t) ;
	v_luma_low      = v_luma_top + 3 * image_width*sizeof(vbx_ubyte_t) ;
	v_luma_bot      = v_luma_top + 4 * image_width*sizeof(vbx_ubyte_t) ;
#endif


	if(v_luma_bot==NULL){
		vbx_sp_pop();
		return VBW_ERROR_SP_ALLOC_FAILED;
	}

	// Transfer the first 3 input rows and interleave first 2 rgb2luma and first 2 sobel row calculations
#if W==3
	rp_fetch(&v_row_db);
	v_row_in = rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma(vW, v_row_in, vT, image_width);                                // 1st luma row
	vbx( SVHBU, VSHR, v_luma_top, 8, vW );                                     // convert to byte

	v_row_in = rp_fetch(&v_row_db);
	v_row_in = rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma( vW, v_row_in, vT, image_width);                               // 2nd luma row
	vbx( SVHBU, VSHR, v_luma_mid, 8,  vW );                                    // convert to byte

#else
	rp_fetch(&v_row_db);
	v_row_in = rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma(vW, v_row_in, vT, image_width);                                // 1st luma row
	vbx( SVHBU, VSHR, v_luma_top, 8, vW );                                     // convert to byte

	rp_fetch(&v_row_db);
	v_row_in = rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma( vW, v_row_in, vT, image_width);                               // 2nd luma row
	vbx( SVHBU, VSHR, v_luma_hii, 8,  vW );                                    // convert to byte

	rp_fetch(&v_row_db);
	v_row_in = rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma( vW, v_row_in, vT, image_width);                               // 2nd luma row
	vbx( SVHBU, VSHR, v_luma_mid, 8,  vW );                                    // convert to byte

	rp_fetch(&v_row_db);
	v_row_in = rp_get_buffer(&v_row_db,0);
	vbw_rgb2luma( vW, v_row_in, vT, image_width);                               // 2nd luma row
	vbx( SVHBU, VSHR, v_luma_low, 8,  vW );                                    // convert to byte
#endif


	// blank out the top and bottom rows
	unsigned *out;
	vbx_set_vl(image_width);
	unsigned COLOUR = ( 200 | (128<<8) | (244<<16) );
	vbx(SVWU, VMOV, v_row_out, COLOUR, 0);
	for( y=0; y<W/2; y++ ) {
		// Set top output rows to 0
		out = output + image_width*y;
		vbx_dma_to_host( out, v_row_out, image_width*sizeof(vbx_uword_t) );
		// Set bottom rows to 0
		out = output + image_width*(image_height-1-y);
		vbx_dma_to_host( out, v_row_out, image_width*sizeof(vbx_uword_t) );
	}



	// Calculate edges
	for (y = 0; y < image_height-(W-1); y++) {

		vbx_set_vl(image_width);
		// Transfer the next input row while processing
		rp_fetch(&v_row_db);
		v_row_in = rp_get_buffer(&v_row_db,0);
		// Convert aRGB input to luma
		vbw_rgb2luma( vW, v_row_in, vT, image_width);
		vbx( SVHBU, VSHR, v_luma_bot, 8,  vW );                                     // convert to byte

vbx_sp_push();
		image_width=image_width/2;
		vbx_set_vl(image_width);

		v[0][0] = v00   = (vbx_ubyte_t*)vbx_sp_malloc( 25 * image_width*sizeof(vbx_ubyte_t));
		v[0][1] = v01   = v00 +  1 * image_width*sizeof(vbx_ubyte_t) ;
		v[0][2] = v02   = v00 +  2 * image_width*sizeof(vbx_ubyte_t) ;
		v[1][0] = v10   = v00 +  3 * image_width*sizeof(vbx_ubyte_t) ;
		v[1][1] = v11   = v00 +  4 * image_width*sizeof(vbx_ubyte_t) ;
		v[1][2] = v12   = v00 +  5 * image_width*sizeof(vbx_ubyte_t) ;
		v[2][0] = v20   = v00 +  6 * image_width*sizeof(vbx_ubyte_t) ;
		v[2][1] = v21   = v00 +  7 * image_width*sizeof(vbx_ubyte_t) ;
		v[2][2] = v22   = v00 +  8 * image_width*sizeof(vbx_ubyte_t) ;

	#if W==5
		v[0][3] = v03   = v00 +  9 * image_width*sizeof(vbx_ubyte_t) ;
		v[0][4] = v04   = v00 + 10 * image_width*sizeof(vbx_ubyte_t) ;
		v[1][3] = v13   = v00 + 11 * image_width*sizeof(vbx_ubyte_t) ;
		v[1][4] = v14   = v00 + 12 * image_width*sizeof(vbx_ubyte_t) ;
		v[2][3] = v23   = v00 + 13 * image_width*sizeof(vbx_ubyte_t) ;
		v[2][4] = v24   = v00 + 14 * image_width*sizeof(vbx_ubyte_t) ;

		v[3][0] = v30   = v00 + 15 * image_width*sizeof(vbx_ubyte_t) ;
		v[3][1] = v31   = v00 + 16 * image_width*sizeof(vbx_ubyte_t) ;
		v[3][2] = v32   = v00 + 17 * image_width*sizeof(vbx_ubyte_t) ;
		v[3][3] = v33   = v00 + 18 * image_width*sizeof(vbx_ubyte_t) ;
		v[3][4] = v34   = v00 + 19 * image_width*sizeof(vbx_ubyte_t) ;

		v[4][0] = v40   = v00 + 20 * image_width*sizeof(vbx_ubyte_t) ;
		v[4][1] = v41   = v00 + 22 * image_width*sizeof(vbx_ubyte_t) ;
		v[4][2] = v42   = v00 + 22 * image_width*sizeof(vbx_ubyte_t) ;
		v[4][3] = v43   = v00 + 23 * image_width*sizeof(vbx_ubyte_t) ;
		v[4][4] = v44   = v00 + 24 * image_width*sizeof(vbx_ubyte_t) ;
	#endif

		if(v00==NULL){
printf("mem alloc failed\n"); fflush(stdout);
			vbx_sp_pop();
			vbx_sp_pop();
			return VBW_ERROR_SP_ALLOC_FAILED;
		}


//FIXME -- how to manage row buffers with 5 rows?  3 rows are shown below:
#if W==3
		for( xx=0; xx<W; xx++ ) v_src[0][xx] = v_luma_top+xx;
		for( xx=0; xx<W; xx++ ) v_src[1][xx] = v_luma_mid+xx;
		for( xx=0; xx<W; xx++ ) v_src[2][xx] = v_luma_bot+xx;
#else
		for( xx=0; xx<W; xx++ ) v_src[0][xx] = v_luma_top+xx;
		for( xx=0; xx<W; xx++ ) v_src[1][xx] = v_luma_hii+xx;
		for( xx=0; xx<W; xx++ ) v_src[2][xx] = v_luma_mid+xx;
		for( xx=0; xx<W; xx++ ) v_src[3][xx] = v_luma_low+xx;
		for( xx=0; xx<W; xx++ ) v_src[4][xx] = v_luma_bot+xx;
#endif

		vbx_set_vl( image_width - W + 1 );

		// compute error (absdiff) in pixel colour with neighbours
		for( yy=0; yy<W; yy++ ) {
			for( xx=0; xx<W; xx++ ) {
				vbx( VVBU, VABSDIFF, v[yy][xx], v_luma_mid+(W/2), v_src[yy][xx] );
			}
		}


		// v[][] holds the errors (differences) between pixels
		// efficiently compute a function that looks approximately something like exp(-x):
		//     large value for small errors, small value for big errors
		for( yy=0; yy<W; yy++ ) {
			for( xx=0; xx<W; xx++ ) {
				vbx( SVBU, VABSDIFF, v[yy][xx], 255, v[yy][xx] );  // 255 - img_err
				// 11 or more iterations is mathematically equivalent to a pure gaussian blur // FIXME is this true?
#define NUM_SHARPEN_ITERATIONS  3   // 0 to 10 iterations, practical max is 7 or 8
				for( sharp=0; sharp < NUM_SHARPEN_ITERATIONS; sharp++ ) {
					vbx( VVBU, VMULHI, v[yy][xx], v[yy][xx], v[yy][xx] ); // v*v;
				}
			}
		}

		// with right decimal place, could do the next two instructions using MULFXP and do as BYTES
		// convolve errors with gaussian blur kernel
		for( yy=0; yy<W; yy++ ) {
			for( xx=0; xx<W; xx++ ) {
				vbx( SVBU, VMULHI, v[yy][xx], gauss[yy][xx], v[yy][xx] );
			}
		}

		// sum up the weights for normalization later
		vbx( VVBHU, VADD, vW, v[0][0], v[0][1] );
		vbx( VVBHU, VADD, vT, v[0][2], v[1][0] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VADD, vT, v[1][1], v[1][2] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VADD, vT, v[2][0], v[2][1] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VMOV, vT, v[2][2], 0 );
		vbx( VVHU,  VADD, vW, vW, vT );
	#if (W==5)
		vbx( VVBHU, VADD, vT, v[3][0], v[3][1] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VADD, vT, v[3][2], v[4][0] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VADD, vT, v[4][1], v[4][2] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VMOV, vT, v[0][3], v[0][4] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VMOV, vT, v[1][3], v[1][4] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VMOV, vT, v[2][3], v[2][4] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VMOV, vT, v[3][3], v[3][4] );
		vbx( VVHU,  VADD, vW, vW, vT );
		vbx( VVBHU, VMOV, vT, v[4][3], v[4][4] );
		vbx( VVHU,  VADD, vW, vW, vT );
	#endif


		// convolve image with new weights
		for( yy=0; yy<W; yy++ ) {
			for( xx=0; xx<W; xx++ ) {
				vbx( VVBU, VMULHI, v[yy][xx], v_src[yy][xx], v[yy][xx] );
				//vbx( SVBU, VMULHI, v[yy][xx], gauss[yy][xx], v_src[yy][xx] );
				//vbx( SVBU, VMUL  , v[yy][xx],         1      , v_src[yy][xx] );
			}
		}



		// sum up the weighted pixels
		vbx( VVBHU, VADD, vI, v[0][0], v[0][1] );
		vbx( VVBHU, VADD, vT, v[0][2], v[1][0] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VADD, vT, v[1][1], v[1][2] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VADD, vT, v[2][0], v[2][1] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VMOV, vT, v[2][2], 0 );
		vbx( VVHU,  VADD, vI, vI, vT );

	#if (W==5)
		vbx( VVBHU, VADD, vT, v[3][0], v[3][1] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VADD, vT, v[3][2], v[4][0] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VADD, vT, v[4][1], v[4][2] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VMOV, vT, v[0][3], v[0][4] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VMOV, vT, v[1][3], v[1][4] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VMOV, vT, v[2][3], v[2][4] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VMOV, vT, v[3][3], v[3][4] );
		vbx( VVHU,  VADD, vI, vI, vT );
		vbx( VVBHU, VMOV, vT, v[4][3], v[4][4] );
		vbx( VVHU,  VADD, vI, vI, vT );
	#endif


// keep RHS of image as original grayscale
image_width=image_width*2;
vbx_set_vl( image_width/2 );
//vbx( VVWHU, VMOV, vT+image_width/2, (v_row_in       ) + image_width/2+1, 0 );
vbx( VVBHU, VMOV, vT+image_width/2, (v_src[ 0 ][ 0 ]) + image_width/2+1, 0 );
vbx_sp_pop(); // don't need v[][] data any more

// compute LHS of image
#if 0
		vbx( VVBHU, VMOV, vT, v_src[2][2], 0 );
		//vbx( SVHU, VSHR, vI,  3, vI );
		//vbx( SVHU, VSHR, vW,  3, vW );
		//vbx( VVHU, VMUL, vT, vI, vW );
		//vbx( SVHU, VSHR, vT,  8, vT );
#else
		uint32_t h = image_width/2;
		vbx( SVHU, VADD, vW, 0x80, vW ); // round
		vbx( SVHU, VSHR, vW,    8, vW );
		vbw_vec_divide_uhalf( vT  , vI  , vW  , h                 );
		//vbw_vec_divide_uhalf( vT+h, vI+h, vW+h, image_width-W+1-h );
#endif
		// ensure LHS doesn't overflow
		vbx( SVHU, VAND, vT, 0xff, vT );

		// Copy the result to the low byte of the output row
		// Trick to copy the low byte (b) to the middle two bytes as well
		// Note that first and last columns are 0
		vbx_set_vl(image_width-W+1);
		vbx(SVHWU, VMULLO, v_row_out+W/2, 0x00010101, vT);

		// blank out left and right edges
		// then DMA the result to the output
		vbx_set_vl(W/2);
		vbx(SVWU, VMOV, v_row_out, COLOUR, 0 );
		vbx(SVWU, VMOV, v_row_out + image_width - (W/2), COLOUR, 0 );
		vbx_dma_to_host( output+(y+1)*image_pitch, v_row_out, image_width*sizeof(vbx_uword_t) );

		// Rotate luma buffers
		vbx_ubyte_t *tmp_ptr;
		tmp_ptr      = v_luma_top;
#if W==3
		v_luma_top   = v_luma_mid;
		v_luma_mid   = v_luma_bot;
		v_luma_bot   = tmp_ptr;
#else
		v_luma_top   = v_luma_hii;
		v_luma_hii   = v_luma_mid;
		v_luma_mid   = v_luma_low;
		v_luma_low   = v_luma_bot;
		v_luma_bot   = tmp_ptr;
#endif

	}

	vbx_sync();
	vbx_sp_pop();

	return VBW_SUCCESS;
}
