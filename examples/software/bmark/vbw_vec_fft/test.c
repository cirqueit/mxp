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
VBXCOPYRIGHT( test_fft5 )

#include <math.h>
#include <stdlib.h>
#include <stdio.h>

#include "vbx.h"
#include "fft.h"
#include "vbx_port.h"
#include "vbx_common.h"

// I/O control
#define DEBUG 0
#define SPECTRUM 0
// Sweep parameters
#define SWEEP_START 13
#define SWEEP_STOP  4
// Parameters for generated test waveform
#define FREQUENCY 1
#define AMPLITUDE 10000

short *Sinewave = NULL;

int main()
{
	int sweep = SWEEP_START;
	int max_sz = 1 << sweep;
	int i;

	vbx_test_init();

	vbx_timestamp_start();

	vbx_timestamp_t time_start, time_stop;
	vbx_timestamp_t scalar_time, vbx_time;
	vbx_timestamp_t scalar_time_i, vbx_time_i;
	vbx_timestamp_t scalar_time_r, vbx_time_r;
	vbx_timestamp_t scalar_time_ri, vbx_time_ri;

	short *vector_fr, *vector_fi, *vector_fr2, *vector_fi2, *vreal_fr, *vreal_fr2;
	short *in_r, *in_i, *scalar_fr, *scalar_fi,*scalar_fr2, *scalar_fi2, *sreal_fr, *sreal_fr2;
	short *tw_r, *tw_i, *itw_r, *itw_i, *tw_r2, *tw_i2, *itw_r2,*itw_i2;
	short *twiddle, *vector, *scalar;
	short *large_mem;

	scalar=(short *)malloc( 6*max_sz*sizeof(short));
	scalar_fr=&scalar[(0*max_sz)];
	scalar_fi=&scalar[(1*max_sz)];
	sreal_fr =&scalar[(2*max_sz)];
	sreal_fr2=&scalar[(3*max_sz)];
	in_r     =&scalar[(4*max_sz)];
	in_i     =&scalar[(5*max_sz)];

	vector = (short *)vbx_shared_malloc( 6*max_sz*sizeof(short) );
	vector_fr  = &vector[(0*max_sz)];
	vector_fr2 = &vector[(1*max_sz)];
	vector_fi  = &vector[(2*max_sz)];
	vector_fi2 = &vector[(3*max_sz)];
	vreal_fr   = &vector[(4*max_sz)];
	vreal_fr2  = &vector[(5*max_sz)];

	twiddle = (short *)vbx_shared_malloc( 3*max_sz*sizeof(short) );
	tw_r  = &twiddle[ 0*(max_sz/4)];
	tw_i  = &twiddle[ 2*(max_sz/4)];
	itw_r = &twiddle[ 4*(max_sz/4)];
	itw_i = &twiddle[ 6*(max_sz/4)];
	tw_r2 = &twiddle[ 8*(max_sz/4)];
	tw_i2 = &twiddle[ 9*(max_sz/4)];
	itw_r2= &twiddle[10*(max_sz/4)];
	itw_i2= &twiddle[11*(max_sz/4)];

	Sinewave = (short *)vbx_shared_malloc( 3*max_sz/4*sizeof(short) );
	
	if(     scalar == NULL || vector  == NULL || \
		twiddle == NULL || Sinewave == NULL) {
 			VBX_EXIT(-1);
	}

	if(max_sz > (VBX_SCRATCHPAD_SIZE >> 3 ) ){
			int x = max_sz;
						int level = 0;
			while(x > (VBX_SCRATCHPAD_SIZE >> 3 ) ){ x >>=1; level++;}
			large_mem = (short *)vbx_shared_malloc( (9*max_sz/2)*(level)*sizeof(short) );
			if( large_mem == NULL ){
				VBX_EXIT(-1);
			}
	}
	
	printf("Twiddle gen...\n");
	/* gen twiddle wave */
	for( i=0; i<=max_sz/4; i++ )
		Sinewave[i] = (short)(32767. * sin(i*(2*3.1415926535)/max_sz) + 0.5 );
	for( i=max_sz/4+1; i<max_sz/2; i++ )
		Sinewave[i] = Sinewave[max_sz/2-i];
	for( i=max_sz/2; i<3*max_sz/4; i++ )
		Sinewave[i] = -Sinewave[i-max_sz/2];

	/* gen full bflys */
	for (i=0; i<max_sz/2; i++){
		tw_r[i] =  Sinewave[i+max_sz/4];
		tw_i[i] = -Sinewave[i];
		itw_r[i] = tw_r[i];
		itw_i[i] = -tw_i[i];
	}
	/* gen 1/2 bflys */
	for (i=0; i<max_sz/4; i++){
		tw_r2[i]=tw_r[i<<1];
		tw_i2[i]=tw_i[i<<1];
		itw_r2[i]=itw_r[i<<1];
		itw_i2[i]=itw_i[i<<1];
	}

	printf("Wave gen...\n");
	/* gen wave */
	for( i=0; i<(max_sz); i++ ) {
		in_r[i] = (float)AMPLITUDE*cos(i*FREQUENCY*(2*3.1415926535)/ (max_sz) );
		in_i[i]  = 0;
	}

	for (sweep = SWEEP_START; sweep >= SWEEP_STOP; sweep--){
		int lg_fft = sweep;
		int fft_sz = 1 << lg_fft;
		int i, s_scale,v_scale,d_scale, vr_scale, sr_scale;
		int diff,errors=0;
		int ops = 5 * fft_sz * lg_fft; // 5 N logN
		float seconds, mops, msps, cps, speed;
		
		if( sweep != SWEEP_START){
			/* reduce full bflys */
			for (i=0; i<fft_sz/2; i++){
				tw_r[i] =  tw_r[i<<1];
				tw_i[i] =  tw_i[i<<1];
				itw_r[i] = itw_r[i<<1];
				itw_i[i] = itw_i[i<<1];
			}
			/* reduce 1/2 bflys */
			for (i=0; i<fft_sz/4; i++){
				tw_r2[i]  = tw_r2[i<<1];
				tw_i2[i]  = tw_i2[i<<1];
				itw_r2[i] = itw_r2[i<<1];
				itw_i2[i] = itw_i2[i<<1];
			}
			/* reduce wave */
			for( i=0; i<(fft_sz); i++ ) {
				in_r[i] = in_r[i<<1];
				in_i[i]  = in_i[i<<1];
			}
		}
		/* assign inputs */
		for( i=0; i<(fft_sz); i++ ) {
			vector_fr[i] = in_r[i];
			vector_fi[i] = in_i[i];

			scalar_fr[i] = in_r[i];
			scalar_fi[i] = in_i[i];
			
			if( i & 0x01 ) {
				vreal_fr[(fft_sz+i)>>1]  = in_r[i];
				sreal_fr[(fft_sz+i)>>1]  = in_r[i];
			} else {
				vreal_fr[i>>1]  = in_r[i];
				sreal_fr[i>>1]  = in_r[i];
			}
		}

		/* start cooley scalar */
		time_start = vbx_timestamp();
		s_scale = scalar_fix_fft_cooley(scalar_fr, scalar_fi, lg_fft,0);
		time_stop  = vbx_timestamp();
		scalar_time = time_stop - time_start;
		seconds = (float)scalar_time/vbx_timestamp_freq();

		/* start new vector */
		time_start = vbx_timestamp();
		d_scale = vector_fix_fft_large_init(vector_fr, vector_fi, vector_fr2, vector_fi2, tw_r,tw_i,lg_fft, 0,0,large_mem);
		time_stop  = vbx_timestamp();
		vbx_time = time_stop - time_start;
		seconds = (float)vbx_time/vbx_timestamp_freq();

#if DEBUG & ROUND
		/* start stockham divide and conquer -- if rounding on, should match scalar DIF stockham perfectly */
		for( i = 0; i < (fft_sz) ; i++ ) {
			if (i != vector_fr2[i] ){
				errors++;
			}
		}
#endif
		/* start real cooley scalar */
		time_start = vbx_timestamp();
		sr_scale = scalar_fix_fft_stockham_real_fly(sreal_fr, sreal_fr2, tw_r2,tw_i2,lg_fft,0);
		time_stop  = vbx_timestamp();
		scalar_time_r = time_stop - time_start;
		seconds = (float)scalar_time_r/vbx_timestamp_freq();

		/* start real large vector */
		time_start = vbx_timestamp();
		vr_scale = vector_fix_fft_large_init(vreal_fr, NULL, vreal_fr2, NULL, tw_r2, tw_i2, lg_fft, 0,1,large_mem);
		time_stop  = vbx_timestamp();
		vbx_time_r = time_stop - time_start;
		seconds = (float)vbx_time_r/vbx_timestamp_freq();

#if SPECTRUM 
		
		printf("\nReal\tInput   Scalar  VecD&C  ScaReal VecReal\n");
		fflush(stdout);
		for (i=0; i<fft_sz; i++){
			printf("%d\t",i );
			printf("%d\t",in_r[i] );
			printf("%d\t",scalar_fr[i] );
			printf("%d\t",vector_fr2[i] );
			printf("%d\t",( sreal_fr2[i] >> 1 ) );
			printf("%d\t",( vreal_fr2[i] >> 1 ) );
			printf("\n");
		}
#endif
		/* start cooley scalar inverse */
		time_start = vbx_timestamp();
		s_scale = scalar_fix_fft_cooley(scalar_fr, scalar_fi, lg_fft,1);
		time_stop  = vbx_timestamp();
		scalar_time_i = time_stop - time_start;
		seconds = (float)scalar_time_i/vbx_timestamp_freq();

		/* start large vector inverse */
		time_start = vbx_timestamp();
		d_scale = vector_fix_fft_large_init(vector_fr2, vector_fi2, vector_fr, vector_fi,itw_r,itw_i, lg_fft, 1,0,large_mem);
		time_stop  = vbx_timestamp();
		vbx_time_i = time_stop - time_start;
		seconds = (float)vbx_time_i/vbx_timestamp_freq();

#if DEBUG & ROUND
		/* start stockham divide and conquer -- if rounding on, should match scalar DIF stockham perfectly */
		for( i = 0; i < (fft_sz) ; i++ ) {
			if (scalar_fr[i] != vector_fr2[i] ){
				errors++;
			}
		}
#endif

		/* start real cooley scalar inverse */
		time_start = vbx_timestamp();
		sr_scale = scalar_fix_fft_stockham_real_fly(sreal_fr2, sreal_fr,itw_r2,itw_i2, lg_fft,1);
		time_stop  = vbx_timestamp();
		scalar_time_ri = time_stop - time_start;
		seconds = (float)scalar_time_ri/vbx_timestamp_freq();

		/* start real large vector inverse */
		time_start = vbx_timestamp();
		vr_scale = vector_fix_fft_large_init(vreal_fr2, NULL, vreal_fr, NULL,itw_r2, itw_i2, lg_fft, 1,1,large_mem);
		time_stop  = vbx_timestamp();
		vbx_time_ri = time_stop - time_start;
		seconds = (float)vbx_time_ri/vbx_timestamp_freq();
		
#if SPECTRUM 
		printf("\nInvReal\tInput   Scalar  VecD&C  ScaReal VecReal\n");
		fflush(stdout);
		for (i=0; i<fft_sz; i++){
			printf("%d\t",i );
			printf("%d\t",in_r[i] );
			printf("%d\t",( (short)(scalar_fr[i] << s_scale) ) );
			printf("%d\t",( (short)(vector_fr[i] << d_scale) ) );

			if (i & 0x01) {
				printf("%d\t ",(short)( sreal_fr[(fft_sz+i)>>1] << sr_scale) );
				printf("%d\t ",(short)( vreal_fr[(fft_sz+i)>>1] << vr_scale) );

			} else {
				printf("%d\t ",(short) ( sreal_fr[i>>1] << sr_scale) );
				printf("%d\t ",(short) ( vreal_fr[i>>1] << vr_scale) );
			}

			printf("\n");
		}
#endif
		/* print out speed up*/
		printf( "\nN\t");
		printf( "OPS\t" );
		printf( "SECS\t\t" );
		printf( "MOPS\t" );
		printf( "CPS\t" );
		printf( "SPEEDUP\t\t" );
		printf( "MSPS\n" );

		printf("Scalar\n");
		seconds = (float)scalar_time/vbx_timestamp_freq();
		mops = (float)ops / seconds / 1000000;
		msps = (float)fft_sz / seconds / 1000000;
		cps = (float)REALCYCLES(scalar_time)/ (fft_sz);
		speed = ( (float)scalar_time ) / ( (float)(scalar_time) );

		printf( "%d\t",(fft_sz) );
		printf( "%d\t", ops );
		printf( "%8.6f\t", seconds );
		printf( "%5.2f\t", mops );
		printf( "%5.2f\t", cps );
		printf( "%f\t", speed );
		printf( "%5.2f\n", msps );

		seconds = (float)scalar_time_i/vbx_timestamp_freq();
		mops = (float)ops / seconds / 1000000;
		msps = (float)fft_sz / seconds / 1000000;
		cps = (float)REALCYCLES(scalar_time_i)/ (fft_sz);
		speed = ( (float)scalar_time_i ) / ( (float)(scalar_time_i) );

		printf( "%d\t",(fft_sz) );
		printf( "%d\t", ops );
		printf( "%8.6f\t", seconds );
		printf( "%5.2f\t", mops );
		printf( "%5.2f\t", cps );
		printf( "%f\t", speed );
		printf( "%5.2f\n", msps );

		printf("Vector\n");
		seconds = (float)vbx_time/vbx_timestamp_freq();
		mops = (float)ops / seconds / 1000000;
		msps = (float)fft_sz / seconds / 1000000;
		cps = (float)REALCYCLES(vbx_time)/ (fft_sz);
		speed = ( (float)scalar_time ) / ( (float)(vbx_time) );

		printf( "%d\t",(fft_sz) );
		printf( "%d\t", ops );
		printf( "%8.6f\t", seconds );
		printf( "%5.2f\t", mops );
		printf( "%5.2f\t", cps );
		printf( "%f\t", speed );
		printf( "%5.2f\n", msps );

		seconds = (float)vbx_time_i/vbx_timestamp_freq();
		mops = (float)ops / seconds / 1000000;
		msps = (float)fft_sz / seconds / 1000000;
		cps = (float)REALCYCLES(vbx_time_i)/ (fft_sz);
		speed = ( (float)scalar_time_i ) / ( (float)(vbx_time_i) );

		printf( "%d\t",(fft_sz) );
		printf( "%d\t", ops );
		printf( "%8.6f\t", seconds );
		printf( "%5.2f\t", mops );
		printf( "%5.2f\t", cps );
		printf( "%f\t", speed );
		printf( "%5.2f\n", msps );	
		
		printf("VecReal\n");
		seconds = (float)vbx_time_r/vbx_timestamp_freq();
		mops = (float)ops / seconds / 1000000;
		msps = (float)fft_sz / seconds / 1000000;
		cps = (float)REALCYCLES(vbx_time_r )/ (fft_sz);
		speed = ( (float)scalar_time ) / ( (float)(vbx_time_r) );

		printf( "%d\t",(fft_sz) );
		printf( "%d\t", ops );
		printf( "%8.6f\t", seconds );
		printf( "%5.2f\t", mops );
		printf( "%5.2f\t", cps );
		printf( "%f\t", speed );
		printf( "%5.2f\n", msps );

		seconds = (float)vbx_time_ri/vbx_timestamp_freq();
		mops = (float)ops / seconds / 1000000;
		msps = (float)fft_sz / seconds / 1000000;
		cps = (float)REALCYCLES(vbx_time_ri)/ (fft_sz);
		speed = ( (float)scalar_time_i ) / ( (float)(vbx_time_ri) );

		printf( "%d\t",(fft_sz) );
		printf( "%d\t", ops );
		printf( "%8.6f\t", seconds );
		printf( "%5.2f\t", mops );
		printf( "%5.2f\t", cps );
		printf( "%f\t", speed );
		printf( "%5.2f\n", msps );	
	}
#if DEBUG & ROUND
	printf("%d\n",errors);
#endif
	printf("Lanes\tScratch Size\n");
	printf("%d\t%d\n", VBX_VECTOR_LANES,VBX_SCRATCHPAD_SIZE);

	putchar(4);  // control-D to signify EOF for nios2-terminal
	free( scalar);
	vbx_shared_free( vector  );
	vbx_shared_free( twiddle );
	vbx_shared_free( Sinewave );
	if( large_mem != NULL ) free( large_mem);
	return 1;
}
