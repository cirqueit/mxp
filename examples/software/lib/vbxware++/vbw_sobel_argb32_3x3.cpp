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

#include "Vector.hpp"
#include "prefetch.hpp"
#include "vbw_argb_luma.hpp"
#include "vbw_mtx_sobel.hpp"
namespace vbw{
	template<typename luma_t>
	static void sobel_row(VBX::Vector<vbx_uhalf_t>& sobel,const VBX::Vector<luma_t>& luma)
	{
		int img_width=luma.size;
		//apply [1 2 1] convolution
		//do some clever stuff to do 2 operations instead of 3
		sobel=(luma[0 upto img_width-1]+ luma[1 upto img_width]);
		sobel[1 upto img_width-1]=sobel[0 upto img_width-2] + sobel[1 upto img_width-1];
	}

#define mod3(a) ((a)>=3?(a)-3:(a))
	int sobel_argb32_3x3_partial(vbx_uword_t *sobel_out, vbx_uword_t *argb_in, const short image_width,
	                             const short image_height, const short image_pitch, const short renorm)
	{
		VBX::Prefetcher<vbx_uword_t> input(1,image_width,argb_in,argb_in+image_height*image_pitch,image_pitch);
		VBX::Vector<vbx_uword_t> output(image_width);
		VBX::Vector<vbx_uhalf_t>* luma[3];
		luma[0]=new VBX::Vector<vbx_uhalf_t>(image_width);
		luma[1]=new VBX::Vector<vbx_uhalf_t>(image_width);
		luma[2]=new VBX::Vector<vbx_uhalf_t>(image_width);
		VBX::Vector<vbx_uhalf_t> gradient_x(image_width);
		VBX::Vector<vbx_uhalf_t> gradient_y(image_width);
		VBX::Vector<vbx_uhalf_t>* sobel_rows[3];

		sobel_rows[0]=new VBX::Vector<vbx_uhalf_t>(image_width);
		sobel_rows[1]=new VBX::Vector<vbx_uhalf_t>(image_width);
		sobel_rows[2]=new VBX::Vector<vbx_uhalf_t>(image_width);
		input.fetch();
		int rowmod3=0;
		for(int row=0;row<image_height;row++){
			input.fetch();

			VBX::Vector<vbx_uhalf_t>& sobel_top= *sobel_rows[rowmod3];
			VBX::Vector<vbx_uhalf_t>& sobel_bot= *sobel_rows[mod3(rowmod3+2)];
			VBX::Vector<vbx_uhalf_t>& luma_top= *luma[rowmod3];
			VBX::Vector<vbx_uhalf_t>& luma_mid= *luma[mod3(rowmod3+1)];
			VBX::Vector<vbx_uhalf_t>& luma_bot= *luma[mod3(rowmod3+2)];
			rowmod3=mod3(rowmod3+1);
			argb_to_luma8(luma_bot,input[0]);
			sobel_row( sobel_bot ,luma_bot);
			if(row<2){
				continue;
			}

			gradient_y=absdiff(sobel_top,sobel_bot);
			gradient_x=luma_top +luma_bot + luma_mid*2;
			gradient_x[1 upto image_width-1]=absdiff(gradient_x[0 upto image_width-2],gradient_x[2 upto image_width]);

			output=((gradient_x + gradient_y) >> renorm);

			output.cond_move(output>0xFF,0xFF);

			output*=0x010101;

			//write to output buffer, skipping first and last elements
			output[1 upto (image_width -1)].dma_write(sobel_out+(row-1)*image_pitch +1);

		}
		output=0;
		output.dma_write(sobel_out);
		output.dma_write(sobel_out+ (image_height-1)*image_pitch);
		delete luma[0];
		delete luma[1];
		delete luma[2];
		delete sobel_rows[0];
		delete sobel_rows[1];
		delete sobel_rows[2];

		return 0;
	}
	int sobel_argb32_3x3(vbx_uword_t *sobel_out, vbx_uword_t *argb_in, const short image_width,
	                             const short image_height, const short image_pitch, const short renorm)
	{
		size_t free_sp=vbx_sp_getfree();
		size_t vectors_needed=8;
		size_t partial_width=free_sp/(vectors_needed*sizeof(vbx_uword_t));
		if(partial_width>image_width){
			sobel_argb32_3x3_partial(sobel_out, argb_in, image_width, image_height, image_pitch,renorm);
		}else{
			//can do entire row at a time, so do partial_width at a time
			size_t partial_step=partial_width-2;
			for(unsigned i=0;;i+=partial_step){
				//account for last tile being smaller
				if(i+partial_width > image_width){
					partial_width=image_width-i;
				}

				sobel_argb32_3x3_partial(sobel_out+i, argb_in+i, partial_width, image_height, image_pitch,renorm);

				if(i+partial_width == image_width){
					//that was the last tile, so break,
					//I don't believe that this can be in the for statement
					break;
				}
			}
		}
		VBX::Vector<vbx_uword_t> side(1);
		side=0;
		side.to2D(1,image_height,0).dma_write(sobel_out,image_pitch);//write to first pixel
		side.to2D(1,image_height,0).dma_write(sobel_out+image_width-1,image_pitch);//write to last pixel

		vbx_sync();

	}
	int sobel_luma8_3x3(vbx_uword_t *output,
	                    unsigned char *input,
	                    const short image_width,
	                    const short image_height,
	                    const short image_pitch,
	                    const short renorm)
	{
		VBX::Prefetcher<vbx_ubyte_t> luma_in(3,image_width,input,input+image_height*image_pitch,image_pitch);
		VBX::Vector<vbx_uhalf_t> *sobel[3];
		sobel[0]=new VBX::Vector<vbx_uhalf_t>(image_width-2);
		sobel[1]=new VBX::Vector<vbx_uhalf_t>(image_width-2);
		sobel[2]=new VBX::Vector<vbx_uhalf_t>(image_width-2);
		VBX::Vector<vbx_uhalf_t> gradient_x(image_width-2);
		VBX::Vector<vbx_uhalf_t> gradient_y(image_width-2);
		VBX::Vector<vbx_uword_t> row_out(image_width);
		VBX::Vector<vbx_uhalf_t> tmp(image_width);
		if(!tmp.data){
			printf("Out of scratchpad memory\n");
			return -1;
		}
		luma_in.fetch();
		luma_in.fetch();

		sobel_row(*sobel[0],luma_in[0]);
		luma_in.fetch();
		sobel_row(*sobel[1],luma_in[1]);
		//set first row black
		row_out=0;
		row_out.dma_write(output);
		for(int row=0,s_t=0,s_b=2;row<image_height-(3-1);row++,s_t++,s_b++){
			luma_in.fetch();
			//use reference to refer to vectors without copying
			VBX::Vector<vbx_ubyte_t>& luma_top=luma_in[0];
			VBX::Vector<vbx_ubyte_t>& luma_mid=luma_in[1];
			VBX::Vector<vbx_ubyte_t>& luma_bot=luma_in[2];
			if(s_t>=3)s_t=0;//mod 3
			if(s_b>=3)s_b=0;//mod 3
			VBX::Vector<vbx_uhalf_t>& sobel_top=*sobel[s_t];
			VBX::Vector<vbx_uhalf_t>& sobel_bot=*sobel[s_b];

			sobel_row(sobel_bot,luma_bot);

			gradient_y=absdiff(sobel_top,sobel_bot);
			tmp=luma_top+luma_bot+(luma_mid<<1);
			gradient_x=absdiff(tmp,tmp[2 upto image_width]);
			//sum the gradients, normalize and saturate at 255
			row_out[1 upto image_width-1]=(gradient_x+gradient_y)>>renorm;
			row_out.cond_move(row_out>255,255);
			//copy lowest byte into the 2nd and 3rd;
			row_out*=0x10101;
			row_out.dma_write(output+(row+1)*image_pitch);
		}
		//set last row black
		row_out=0;
		row_out.dma_write(output+(image_height-1)*image_width);
		return 0;
	}

}
