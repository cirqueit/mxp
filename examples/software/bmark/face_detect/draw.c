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
VBXCOPYRIGHT( draw )

#include "draw.h"

//draw a rectangle of given size, in a given color, on the output image
void draw_rectangle(int startx, int starty, int width, int height, pixel* color, pixel *output_buffer, const int image_width, const int image_height, const int image_pitch)
{
	int endy = starty + height;
	int endx = startx + width;
	int x,y;

	if(startx <= 0){
		startx = 1;
	}
	if(starty <= 0){
		starty = 1;
	}
	if(endy >= image_height-1){
		endy = image_height-2;
	}
	if(endx >= image_width-1){
		endx = image_width-2;
	}

	for(y = starty; y < endy; y++){
	output_buffer[y*image_pitch+startx+1] = *color;
	output_buffer[y*image_pitch+startx] = *color;
	output_buffer[y*image_pitch+endx+1] = *color;
	output_buffer[y*image_pitch+endx] = *color;
	}

	for(x = startx; x < endx; x++){
		output_buffer[starty*image_pitch+x] = *color;
		output_buffer[(starty+1)*image_pitch+x] = *color;
		output_buffer[endy*image_pitch+x] = *color;
		output_buffer[(endy+1)*image_pitch+x] = *color;
	}
}

//draw a given set of haar features as rectangles on the output image
void draw_features( feat* feature, pixel* color, pixel* output, const int image_width, const int image_height, const int image_pitch)
{
	feat* current;

	current = feature;
	while(current){
		draw_rectangle(current->x, current->y, current->w, current->w, color, output, image_width, image_height, image_pitch);
		current = current->next;
	}
}
