/*****************************************************************************
 *  File: audio_interface.v
 *
 *  singal router module for TLV320AIC23/WM8731 Digital audio CODEC interface
 *
 *  Author by H.S.Hagiwara    Nov.29,2008
 *  Jan 2009 Interface magazine Web version
 ****************************************************************************/


module audio_interface
(
	clk,
	reset_n,
	dac_data_L,
	dac_data_R,
	audio_CLK, 
	audio_LRCIN, 
	audio_DIN,
	audio_LRCOUT,
	audio_DOUT,
	audio_BCLK,
	adc_data_L,
	adc_data_R,
	dac_data_ack,
	adc_data_valid,
	sampling_rate
);


input clk; // assuming 48,60,120MHz
input reset_n;

input [15:0] dac_data_R; // audio data R
input [15:0] dac_data_L; // audio data L

// CODEC audio interface
output audio_CLK;
output audio_DIN;
input audio_DOUT;
output audio_LRCIN, audio_LRCOUT, audio_BCLK;
output [15:0] adc_data_L;
output [15:0] adc_data_R;
output dac_data_ack; // dac_data acknowledge
output adc_data_valid; // adc_data valid
input [13:0] sampling_rate;

////////////////////////////////////////////////////////////////////////////////

  wire [13:0]  divide = sampling_rate;
  
wire dac_adc_valid; // dac data enable and adc start trigger

wire ck_div4;
wire ck_div8;
wire ck_div5;
wire ck_div10;
wire ck_div20;

audio_clk_gen inst_audio_clk_gen
(
	.clk(clk),
	.reset_n(reset_n),
	.ck_div4(ck_div4), // 1/4 of clk : This is 12MHz if clk is 48MHz
//	.ck_div8(ck_div8), // 1/8 of clk : This is 12MHz if clk is 96MHz
//	.ck_div5(ck_div5), // 1/5 of clk : This is 12MHz if clk is 60MHz
//	.ck_div10(ck_div10), // 1/10 of clk : This is 12MHz if clk is 120MHz 
//	.ck_div20(ck_div20), // 1/20 of clk
	.divide(divide),  // 
	.en_divided(dac_adc_valid) // 1/devide of clk having just one cycle high: This signal is for 44.1KHz sampling
);


wire ck_12MHz = ck_div4;  // Use this if clk is 48MHz
//wire ck_12MHz = ck_div5;  // Use this if clk is 60MHz
//wire ck_12MHz = ck_div10;  // Use this if clk is 120MHz

wire shift_clk = ck_12MHz;  // This becomes BCLK and should be slower than 20MHz. 


audio_data_ctrl inst_audio_data_ctrl
(
	clk,
	reset_n,
	shift_clk, // This becomes BCLK and should be slower than 20MHz
	dac_adc_valid, 
	dac_data_L,
	dac_data_R,
	audio_LRCIN, 
	audio_DIN, 
	audio_LRCOUT, 
	audio_DOUT, 
	audio_BCLK,
	adc_data_L,
	adc_data_R,
	adc_data_valid
);

assign audio_CLK = ck_12MHz;  // This Freq. should be slower than 18.5MHz

assign dac_data_ack = dac_adc_valid;

endmodule