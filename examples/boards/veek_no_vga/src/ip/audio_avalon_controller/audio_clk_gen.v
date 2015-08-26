/*****************************************************************************
 *  File: audio_clk_gen.v
 *
 *  clock generator for TLV320AIC23/WM8731 Digital audio CODEC interface
 *
 *  Author by H.S.Hagiwara    Nov.29,2008
 *  Jan 2009 Interface magazine Web version
 ****************************************************************************/

module audio_clk_gen
(
	clk,
	reset_n,
	ck_div4, // 1/4 of clk, 12MHz(if clk=48MHz)
	ck_div5, // 1/5 of clk, 12MHz(if clk=60MHz)
	ck_div8, // 1/8 of clk, 12MHz(if clk=96MHz)
	ck_div10, // 1/10 of clk, 12(if clk=120MHz)
	ck_div20, // 1/20 of clk, 6(if clk=120MHz)
	divide, // divide rate of en_divided
	en_divided  // 1/(devide+1)  cycle of clk
);

//
input clk; // assuming as 48,60,120MHz
input reset_n; // async. reset

//
output ck_div4;
output ck_div8;
output ck_div5;
output ck_div10;
output ck_div20;
input [13:0] divide;
output en_divided;

//reg ck_div2;
reg en_divided;

////////////////////////////////////
reg [13:0] cnt; // countable upto 14999, divisor 120MHz -> 8KHz
// Capture Avalon-MM data
always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
    cnt <= 0;
  else 
    if (cnt == divide)
      cnt <= 0;
    else 
      cnt <= cnt + 1;
end

always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
    en_divided <= 0;
  else
    if (cnt == 0)
      en_divided <= 1;
    else
      en_divided <= 0;
end

reg [2:0] cnt8; 
always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
    cnt8 <= 0; 
  else
    cnt8 <= cnt8+1; 
end

assign ck_div4 = cnt8[1];
assign ck_div8 = cnt8[2];



reg [2:0] cntx; 
always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
    cntx <= 0; 
  else
    if (cntx == 3'd4)
      cntx <= 0; 
    else
      cntx <= cntx+1; 
end

assign ck_div5 = cntx[1];

reg ck_div10;
always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
    ck_div10 <= 0;
  else
    if (cntx == 3'd4)
      ck_div10 <= ~ck_div10;
end
 
reg ck_div20;
always @(posedge clk or negedge reset_n) begin
  if (!reset_n)
    ck_div20 <= 0;
  else
    if (cntx == 3'd4 && ck_div10==1)
      ck_div20 <= ~ck_div20;
end

////////////////////////////////////

endmodule