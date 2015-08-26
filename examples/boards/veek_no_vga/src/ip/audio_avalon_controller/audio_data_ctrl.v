/*****************************************************************************
 *  File: audio_data_ctrl.v
 *
 *  Ser-Des module for TLV320AIC23/WM8731 Digital audio CODEC interface
 *
 *  Author by H.S.Hagiwara    Nov.29,2008
 *  Jan 2009 Interface magazine Web version
 ****************************************************************************/

module audio_data_ctrl
(
	clk,
	reset_n,
	shift_clk,
	dac_adc_valid,
	dac_data_L,
	dac_data_R,
//	audio_clk, 
	audio_LRCIN, audio_DIN, audio_LRCOUT, audio_DOUT, audio_BCLK,
	adc_data_L,
	adc_data_R,
	adc_data_valid


);

input clk; // assuming 48,60,120MHz
input reset_n;

input shift_clk; // this is BCLK
input dac_adc_valid; // dac data enable and adc start trigger
input [15:0] dac_data_R; // audio data R
input [15:0] dac_data_L; // audio data L

// CODEC audio interface
//output audio_clk;
output audio_DIN;
input audio_DOUT;
output audio_LRCIN, audio_LRCOUT, audio_BCLK;
output [15:0] adc_data_L;
output [15:0] adc_data_R;
output adc_data_valid; // adc_data valid

////////////////////////////////////////////////////////////////////////////////


reg shift_clk_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    shift_clk_reg <= 1'b0;
  else
    shift_clk_reg <= shift_clk;
end

reg shift_clk_posedge;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    shift_clk_posedge <= 1'b0;
  else
    shift_clk_posedge <= ~shift_clk_reg & shift_clk;
end
reg shift_clk_negedge;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    shift_clk_negedge <= 1'b0;
  else
    shift_clk_negedge <= shift_clk_reg & ~shift_clk;
end

reg dac_adc_valid_reg;
reg [4:0] cnt;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    cnt <= 0;
  else 
    if (shift_clk_negedge)
      if (dac_adc_valid_reg)
        cnt <= 1;
      else
        if (cnt != 0)
          cnt <= cnt +1;
end

always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    dac_adc_valid_reg <= 0;
  else if (dac_adc_valid) 
    dac_adc_valid_reg <= 1;
  else  if (shift_clk_negedge) 
      dac_adc_valid_reg <= 0;
end


//reg audio_BCLK;
//always @(posedge clk or negedge reset_n) begin
//  if (~reset_n)
//    audio_BCLK <= 0;
//  else
//    audio_BCLK <= ~shift_clk;
//end
assign audio_BCLK = ~shift_clk;



reg audio_LRCIN;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    audio_LRCIN <= 0;
  else 
    if (shift_clk_negedge) begin
      if (dac_adc_valid_reg)
        audio_LRCIN <= 1;
      else 
        if (cnt == 5'd16)
          audio_LRCIN <= 0;
    end
end
assign audio_LRCOUT = audio_LRCIN;  // use same LRC

reg [31:0] dac_data_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    dac_data_reg <= 0;
  else if (dac_adc_valid) begin
    dac_data_reg <= {dac_data_L, dac_data_R};
  end
  else
    if (shift_clk_negedge) begin
      if (cnt != 0)
        dac_data_reg <= {dac_data_reg[30:0], 1'b0} ;
    end
end

assign audio_DIN = dac_data_reg[31];


// ADC data capture
reg adc_capture_valid;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    adc_capture_valid <= 0;
  else if (shift_clk_negedge)
    adc_capture_valid <= (cnt == 31) ? 1 : 0;
end

reg [31:0] adc_data_reg;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n)
    adc_data_reg <= 0 ;
  else if (shift_clk_posedge) 
    if ((cnt != 0) ||  adc_capture_valid)
      adc_data_reg <= {adc_data_reg[30:0], audio_DOUT} ;
end

reg [15:0] adc_data_L;
reg [15:0] adc_data_R;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n) begin
      adc_data_L <= 0 ;
      adc_data_R <= 0 ;
  end
  else if (shift_clk_negedge)
    if (adc_capture_valid) begin
      adc_data_L <= adc_data_reg[31:16] ;
      adc_data_R <= adc_data_reg[15: 0] ;
    end
end

reg adc_data_valid;
always @(posedge clk or negedge reset_n) begin
  if (~reset_n) 
    adc_data_valid <= 0;
  else
    adc_data_valid <= shift_clk_negedge & adc_capture_valid;
end




endmodule