/*****************************************************************************
 *  File: audio_avalon_controller_top.v
 *
 *  TLV320AIC23/WM8731 Digital audio CODEC interface top module
 *
 *  Author by H.S.Hagiwara    Nov.29,2008
 *  Jan 2009 Interface magazine Web version
 ****************************************************************************/
module audio_avalon_controller_top
(
	clk, // should be 60MHz
	reset_n,

// Avalon-MM slave signals
  avs_s1_addr,
  avs_s1_cs_n,
  avs_s1_write_n,
  avs_s1_writedata,
  avs_s1_read_n,
  avs_s1_readdata,
//  avs_s1_waitrequest,
  avs_s1_readyfordata,
  avs_s1_dataavailable,
  avs_s1_begintransfer,
  avs_s1_irq,

   //  Digital audio CODEC interface signals for TLV320AIC23/WM8731
	audio_CLK,    // = XCK, 
	audio_LRCIN,  // = DACLRCK 
	audio_DIN,    // = DACDAT
	audio_LRCOUT, // = ADCLRCK
	audio_DOUT,   // = ADCDAT
	audio_BCLK   // = BCLK
);

// avalon_mm global signals
input clk; // assuming 48MHz, 60MHz, 120MHz
input reset_n;

// avalon_mm slave signals
input  [2:0] avs_s1_addr;
input  avs_s1_cs_n;
input  avs_s1_write_n;
input [31:0]  avs_s1_writedata;
input  avs_s1_read_n;
output [31:0]  avs_s1_readdata;
//output  avs_s1_waitrequest;
input avs_s1_begintransfer;

output  avs_s1_readyfordata;
output  avs_s1_dataavailable;
output  avs_s1_irq;


// CODEC audio interface
output audio_CLK;
output audio_DIN;
input audio_DOUT;
output audio_LRCIN, audio_LRCOUT, audio_BCLK;



reg [15:0] dac_data_L;
reg [15:0] dac_data_R;
wire [15:0] adc_data_L;
wire [15:0] adc_data_R;

//////////////////////////////////////////////////////////////////////
// handle avs_s1_addr[1:0]==1 write: DAC data
//
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      dac_data_L <= 16'b0;
      dac_data_R <= 16'b0;
    end
    else if ( ~avs_s1_cs_n & ~avs_s1_write_n ) begin
      if ( avs_s1_addr == 3'd1 ) begin
        dac_data_L <= avs_s1_writedata[31:16];
        dac_data_R <= avs_s1_writedata[15:0];
      end
    end
  end
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// handle avs_s1_addr[1:0]==3 write : control reg
//
reg ITRDY; // Interrupt Enable bit for dac data empty 
reg IRRDY; // Interrupt Enable bit for adc data ready
reg RSTN;
  always @(posedge clk or negedge reset_n ) begin
    if (~reset_n) begin
      ITRDY <= 1'b0;
      IRRDY <= 1'b0;
      RSTN   <= 1'b0;
    end
    else if ( ~avs_s1_cs_n & ~avs_s1_write_n ) begin
      if ( avs_s1_addr == 3'd3 ) begin
        ITRDY <= avs_s1_writedata[6];
        IRRDY <= avs_s1_writedata[7];
        RSTN   <= avs_s1_writedata[15];
      end
    end
  end

//
//////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
// handle avs_s1_addr[1:0]==5 write : sampling rate reg
//
reg [13:0] sampling_reg; // Sampling Rate register
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      sampling_reg <= 14'b0;
    end
    else if ( ~avs_s1_cs_n & ~avs_s1_write_n ) begin
      if ( avs_s1_addr == 3'd5 ) begin
        sampling_reg <= avs_s1_writedata[13:0];
      end
    end
  end
//
//////////////////////////////////////////////////////////////////////



wire dac_data_ack;
wire adc_data_valid;

reg TRDY; // DAC register can accept new data Flag
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      TRDY <= 1'b1;
    end
    else if ( ~avs_s1_cs_n & ~avs_s1_write_n  & avs_s1_begintransfer & (avs_s1_addr == 3'd1) ) begin
        TRDY <= 1'b0;
    end
    else if (dac_data_ack) begin
        TRDY <= 1'b1;
    end
  end
reg RRDY; // New ADC data is arrived Flag
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      RRDY <= 1'b0;
    end
    else if ( ~avs_s1_cs_n & ~avs_s1_read_n & avs_s1_begintransfer & (avs_s1_addr == 3'd0 ) ) begin
        RRDY <= 1'b0;
    end
    else if (adc_data_valid) begin
        RRDY <= 1'b1;
    end
  end

  assign avs_s1_irq = (TRDY & ITRDY) | (RRDY & IRRDY);
//////////////////////////////////////////////////////////////////////
// handle avalon MM read access
//
function [31:0] data_selector;
input [2:0] ad;
input [31:0] dat0, dat2, dat3, dat5;
  casex (ad)
    0:       data_selector = dat0;
    2:       data_selector = dat2;
    3:       data_selector = dat3;
    5:       data_selector = dat5;
    default: data_selector = 32'bx;
  endcase
endfunction

  assign avs_s1_readdata = data_selector(avs_s1_addr, { adc_data_L, adc_data_R }  /* read data for address 0 */
                                                    , { 24'b0, RRDY, TRDY, 6'b0}  /* read data for address 2 */
                                                    , { 16'b0, RSTN, 7'b0, IRRDY, ITRDY, 6'b0}  /* read data for address 3 */
                                                    , { 18'b0, sampling_reg}  /* read data for address 5 */
                                                    );
//  assign avs_s1_readdata = 
//                    (~avs_s1_cs_n & ~avs_s1_read_n & (avs_s1_addr==3'd0)) ? { adc_data_L, adc_data_R } :
//                    (~avs_s1_cs_n & ~avs_s1_read_n & (avs_s1_addr==3'd2)) ? { 24'b0, RRDY, TRDY, 6'b0} :
//                    (~avs_s1_cs_n & ~avs_s1_read_n & (avs_s1_addr==3'd3)) ? { 16'b0, RSTN, 7'b0, IRRDY, ITRDY, 6'b0} : 
//                    (~avs_s1_cs_n & ~avs_s1_read_n & (avs_s1_addr==3'd5)) ? { 19'b0, sampling_reg} : 32'b0;
//
//////////////////////////////////////////////////////////////////////
/*
reg d1_RRDY; // Delay of RRDY 
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      d1_RRDY <= 1'b0;
    end
    else begin
        d1_RRDY <= RRDY;
    end
  end
reg d1_TRDY; // Delay of TRDY 
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      d1_TRDY <= 1'b0;
    end
    else begin
        d1_TRDY <= TRDY;
    end
  end
  assign avs_s1_readyfordata = d1_TRDY;
  assign avs_s1_dataavailable = d1_RRDY;
*/

  assign avs_s1_readyfordata = TRDY;
  assign avs_s1_dataavailable = RRDY;

//  assign avs_s1_waitrequest = ~RRDY & ~avs_s1_cs_n & ~avs_s1_read_n ;

// Digital Audio Interface module
//  - Serialize dac_data_L/R and send to AIC23
//  - Deserialize ADC data and set in adc_data_L/R 
// Sampling rate is defined inside this module
audio_interface inst_audio_interface
(
	.clk(clk),
	.reset_n( ~(~reset_n | ~RSTN) ),
	.dac_data_L(dac_data_L),
	.dac_data_R(dac_data_R),
	.audio_CLK(audio_CLK),
	.audio_LRCIN(audio_LRCIN), 
	.audio_DIN(audio_DIN), 
	.audio_LRCOUT(audio_LRCOUT), 
	.audio_DOUT(audio_DOUT), 
	.audio_BCLK(audio_BCLK),
	.adc_data_L(adc_data_L),
	.adc_data_R(adc_data_R),
	.dac_data_ack(dac_data_ack), 
	.adc_data_valid(adc_data_valid),
	.sampling_rate(sampling_reg)
);


endmodule