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
#include "scalar_mtx_median.h"

/** Scalar byte median finding using a bubble sort.  
 * Does a bubble sort until filter_size/2 elements have been sorted 
 * and selects the next lowest element, which will be the median
 *
 * @param[in] input.
 * @retval min 
 *
 */
int8_t scalar_bubble_byte(int8_t *array, const int32_t filter_size)
{
	int8_t min, temp;
	int32_t j, i;
	for(j = 0; j < filter_size/2; j++){
		min = array[j];
		for(i = j+1; i < filter_size; i++){
			if(array[i] < min){
				temp = min;
				min = array[i];
				array[i] = temp;
			}
		}
		array[j] = min;
	}
	min = array[filter_size/2];
	for (i = (filter_size/2)+1; i < filter_size; i++){
		if (array[i] < min){
			min = array[i];
		}
	}
	return min;
}
/** Scalar half median finding using a bubble sort.  
 * Does a bubble sort until filter_size/2 elements have been sorted 
 * and selects the next lowest element, which will be the median
 *
 * @param[in] input.
 * @retval min 
 *
 */
int16_t scalar_bubble_half(int16_t *array, const int32_t filter_size)
{
	int16_t min, temp;
	int32_t j, i;
	for(j = 0; j < filter_size/2; j++){
		min = array[j];
		for(i = j+1; i < filter_size; i++){
			if(array[i] < min){
				temp = min;
				min = array[i];
				array[i] = temp;
			}
		}
		array[j] = min;
	}
	min = array[filter_size/2];
	for (i = (filter_size/2)+1; i < filter_size; i++){
		if (array[i] < min){
			min = array[i];
		}
	}
	return min;
}
/** Scalar byte word finding using a bubble sort.  
 * Does a bubble sort until filter_size/2 elements have been sorted 
 * and selects the next lowest element, which will be the median
 *
 * @param[in] input.
 * @retval min 
 *
 */
int32_t scalar_bubble_word(int32_t *array, const int32_t filter_size)
{
	int32_t min, temp;
	int32_t j, i;
	for(j = 0; j < filter_size/2; j++){
		min = array[j];
		for(i = j+1; i < filter_size; i++){
			if(array[i] < min){
				temp = min;
				min = array[i];
				array[i] = temp;
			}
		}
		array[j] = min;
	}
	min = array[filter_size/2];
	for (i = (filter_size/2)+1; i < filter_size; i++){
		if (array[i] < min){
			min = array[i];
		}
	}
	return min;
}

/** Scalar byte median finding using a bubble sort.  
 * Does a bubble sort until filter_size/2 elements have been sorted 
 * and selects the next lowest element, which will be the median
 *
 * @param[in] input.
 * @retval min 
 *
 */
uint8_t scalar_bubble_ubyte(uint8_t *array, const int32_t filter_size)
{
	uint8_t min, temp;
	int32_t j, i;
	for(j = 0; j < filter_size/2; j++){
		min = array[j];
		for(i = j+1; i < filter_size; i++){
			if(array[i] < min){
				temp = min;
				min = array[i];
				array[i] = temp;
			}
		}
		array[j] = min;
	}
	min = array[filter_size/2];
	for (i = (filter_size/2)+1; i < filter_size; i++){
		if (array[i] < min){
			min = array[i];
		}
	}
	return min;
}
/** Scalar half median finding using a bubble sort.  
 * Does a bubble sort until filter_size/2 elements have been sorted 
 * and selects the next lowest element, which will be the median
 *
 * @param[in] input.
 * @retval min 
 *
 */
uint16_t scalar_bubble_uhalf(uint16_t *array, const int32_t filter_size)
{
	uint16_t min, temp;
	int32_t j, i;
	for(j = 0; j < filter_size/2; j++){
		min = array[j];
		for(i = j+1; i < filter_size; i++){
			if(array[i] < min){
				temp = min;
				min = array[i];
				array[i] = temp;
			}
		}
		array[j] = min;
	}
	min = array[filter_size/2];
	for (i = (filter_size/2)+1; i < filter_size; i++){
		if (array[i] < min){
			min = array[i];
		}
	}
	return min;
}
/** Scalar byte word finding using a bubble sort.  
 * Does a bubble sort until filter_size/2 elements have been sorted 
 * and selects the next lowest element, which will be the median
 *
 * @param[in] input.
 * @retval min 
 *
 */
uint32_t scalar_bubble_uword(uint32_t *array, const int32_t filter_size)
{
	uint32_t min, temp;
	int32_t j, i;
	for(j = 0; j < filter_size/2; j++){
		min = array[j];
		for(i = j+1; i < filter_size; i++){
			if(array[i] < min){
				temp = min;
				min = array[i];
				array[i] = temp;
			}
		}
		array[j] = min;
	}
	min = array[filter_size/2];
	for (i = (filter_size/2)+1; i < filter_size; i++){
		if (array[i] < min){
			min = array[i];
		}
	}
	return min;
}

/** Scalar Median filter byte.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_byte(int8_t *output, int8_t *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
	int32_t y,x,j,i;
	int8_t array[filter_height*filter_width];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)];
				}
			}
			output[y*image_pitch+x] = scalar_bubble_byte(array, filter_height*filter_width);
		}
	}
}
/** Scalar Median filter half.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_half(int16_t *output, int16_t *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
	int32_t y,x,j,i;
	int16_t array[filter_height*filter_width];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)];
				}
			}
			output[y*image_pitch+x] = scalar_bubble_half(array, filter_height*filter_width);
		}
	}
}
/** Scalar Median filter word.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_word(int32_t *output, int32_t *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
	int32_t y,x,j,i;
	int32_t array[filter_height*filter_width];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)];
				}
			}
			output[y*image_pitch+x] = scalar_bubble_word(array, filter_height*filter_width);
		}
	}
}
/** Scalar Median filter byte.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_ubyte(uint8_t *output, uint8_t *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
	int32_t y,x,j,i;
	uint8_t array[filter_height*filter_width];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)];
				}
			}
			output[y*image_pitch+x] = scalar_bubble_ubyte(array, filter_height*filter_width);
		}
	}
}
/** Scalar Median filter half.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_uhalf(uint16_t *output, uint16_t *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
	int32_t y,x,j,i;
	uint16_t array[filter_height*filter_width];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)];
				}
			}
			output[y*image_pitch+x] = scalar_bubble_uhalf(array, filter_height*filter_width);
		}
	}
}
/** Scalar Median filter word.  
 * Scans the image, and for each filter block runs the bubble sort median finder
 *
 * @param[in] input.
 * @param[out] output.
 */
void scalar_mtx_median_uword(uint32_t *output, uint32_t *input, const int32_t filter_height, const int32_t filter_width, const int32_t image_height, const int32_t image_width, const int32_t image_pitch)
{
	int32_t y,x,j,i;
	uint32_t array[filter_height*filter_width];

	for(y=0; y<image_height-filter_height; y++){
		for(x=0; x<image_width-filter_width; x++){
			for(j=0; j<filter_height; j++){
				for(i=0; i<filter_width; i++){
					array[j*filter_width+i] = input[(y+j)*image_pitch+(x+i)];
				}
			}
			output[y*image_pitch+x] = scalar_bubble_uword(array, filter_height*filter_width);
		}
	}
}
