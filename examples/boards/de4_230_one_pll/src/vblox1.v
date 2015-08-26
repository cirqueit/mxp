//`define USE_DDR2_DIMM2

module fpga
  (

   //////// CLOCK //////////
   GCLKIN,
   GCLKOUT_FPGA,
   OSC_50_Bank2,
   OSC_50_Bank3,
   OSC_50_Bank4,
   OSC_50_Bank5,
   OSC_50_Bank6,
   OSC_50_Bank7,
   PLL_CLKIN_p,

   //////// LED x 8 //////////
   LED,

   //////////// SLIDE SWITCH x 4 //////////
   SLIDE_SW,

   //////// BUTTON x 4 //////////
   BUTTON,
   CPU_RESET_n,

`ifndef USE_DDR2_DIMM2
   //////// DDR2 SODIMM //////////
   M1_DDR2_addr,
   M1_DDR2_ba,
   M1_DDR2_cas_n,
   M1_DDR2_cke,
   M1_DDR2_clk,
   M1_DDR2_clk_n,
   M1_DDR2_cs_n,
   M1_DDR2_dm,
   M1_DDR2_dq,
   M1_DDR2_dqs,
   M1_DDR2_dqsn,
   M1_DDR2_odt,
   M1_DDR2_ras_n,
   M1_DDR2_SA,
   M1_DDR2_SCL,
   M1_DDR2_SDA,
   M1_DDR2_we_n,

`else
   //////// DDR2 SODIMM //////////

   M2_DDR2_addr,
   M2_DDR2_ba,
   M2_DDR2_cas_n,
   M2_DDR2_cke,
   M2_DDR2_clk,
   M2_DDR2_clk_n,
   M2_DDR2_cs_n,
   M2_DDR2_dm,
   M2_DDR2_dq,
   M2_DDR2_dqs,
   M2_DDR2_dqsn,
   M2_DDR2_odt,
   M2_DDR2_ras_n,
   M2_DDR2_SA,
   M2_DDR2_SCL,
   M2_DDR2_SDA,
   M2_DDR2_we_n ,
`endif  //USE_DDR2_DIMM2

   RUP_PAD,
   RDN_PAD
   );

   //=======================================================
   //  PARAMETER declarations
   //=======================================================


   //=======================================================
   //  PORT declarations
   //=======================================================

   //////////// CLOCK //////////
   input                        GCLKIN;
   output                       GCLKOUT_FPGA;
   input                        OSC_50_Bank2;
   input                        OSC_50_Bank3;
   input                        OSC_50_Bank4;
   input                        OSC_50_Bank5;
   input                        OSC_50_Bank6;
   input                        OSC_50_Bank7;
   input                        PLL_CLKIN_p;

   //////////// LED x 8 //////////
   output [7:0]                 LED;

   //////////// SLIDE SWITCH x 4 //////////
   input [3:0]                  SLIDE_SW;

   //////////// BUTTON x 4 //////////
   input [3:0]                  BUTTON;
   input                        CPU_RESET_n;

   input                        RUP_PAD;
   input                        RDN_PAD;

`ifndef USE_DDR2_DIMM2
   //////////// DDR2 SODIMM //////////
   output [15:0]                M1_DDR2_addr;
   output [2:0]                 M1_DDR2_ba;
   output                       M1_DDR2_cas_n;
   output [1:0]                 M1_DDR2_cke;
   inout [1:0]                  M1_DDR2_clk;
   inout [1:0]                  M1_DDR2_clk_n;
   output [1:0]                 M1_DDR2_cs_n;
   output [7:0]                 M1_DDR2_dm;
   inout [63:0]                 M1_DDR2_dq;
   inout [7:0]                  M1_DDR2_dqs;
   inout [7:0]                  M1_DDR2_dqsn;
   output [1:0]                 M1_DDR2_odt;
   output                       M1_DDR2_ras_n;
   output [1:0]                 M1_DDR2_SA;
   output                       M1_DDR2_SCL;
   inout                        M1_DDR2_SDA;
   output                       M1_DDR2_we_n;

`else
   //////////// DDR2 SODIMM //////////
   output [15:0]                M2_DDR2_addr;
   output [2:0]                 M2_DDR2_ba;
   output                       M2_DDR2_cas_n;
   output [1:0]                 M2_DDR2_cke;
   inout [1:0]                  M2_DDR2_clk;
   inout [1:0]                  M2_DDR2_clk_n;
   output [1:0]                 M2_DDR2_cs_n;
   output [7:0]                 M2_DDR2_dm;
   inout [63:0]                 M2_DDR2_dq;
   inout [7:0]                  M2_DDR2_dqs;
   inout [7:0]                  M2_DDR2_dqsn;
   output [1:0]                 M2_DDR2_odt;
   output                       M2_DDR2_ras_n;
   output [1:0]                 M2_DDR2_SA;
   output                       M2_DDR2_SCL;
   inout                        M2_DDR2_SDA;
   output                       M2_DDR2_we_n;

`endif //`ifndef USE_DDR2_DIMM2


   //=======================================================
   //  REG/WIRE declarations
   //=======================================================

   wire [7:0] led_wire;

   wire ddr_pll_locked;
   wire ddr_pll_mem_clk;

   wire ddr_init_done;
   wire ddr_cal_success;
   wire ddr_cal_fail;

   wire [3:0] debounced_switches;


   //=======================================================
   //  Structural coding
   //=======================================================

   wire reset_n;
   assign reset_n = CPU_RESET_n;

   // Qsys module instance
   vblox1 vblox1_inst
     (
      // 1 global signals:
      .clk_50(OSC_50_Bank3),
      .reset_n(reset_n),

      // the_button
      .in_port_to_the_button(BUTTON),

      // the_led
      .out_port_from_the_led(led_wire),

      .slide_switch_export(debounced_switches),

      .oct_rup(RUP_PAD),
      .oct_rdn(RDN_PAD),

`ifndef USE_DDR2_DIMM2
      .memory_mem_a(M1_DDR2_addr),
      .memory_mem_ba(M1_DDR2_ba),
      .memory_mem_cas_n(M1_DDR2_cas_n),
      .memory_mem_cke(M1_DDR2_cke),
      .memory_mem_ck_n(M1_DDR2_clk_n),
      .memory_mem_ck(M1_DDR2_clk),
      .memory_mem_cs_n(M1_DDR2_cs_n),
      .memory_mem_dm(M1_DDR2_dm),
      .memory_mem_dq(M1_DDR2_dq),
      .memory_mem_dqs(M1_DDR2_dqs),
      .memory_mem_dqs_n(M1_DDR2_dqsn),
      .memory_mem_odt(M1_DDR2_odt),
      .memory_mem_ras_n(M1_DDR2_ras_n),
      .memory_mem_we_n(M1_DDR2_we_n),

`else
      .memory_mem_a(M2_DDR2_addr),
      .memory_mem_ba(M2_DDR2_ba),
      .memory_mem_cas_n(M2_DDR2_cas_n),
      .memory_mem_cke(M2_DDR2_cke),
      .memory_mem_ck_n(M2_DDR2_clk_n),
      .memory_mem_ck(M2_DDR2_clk),
      .memory_mem_cs_n(M2_DDR2_cs_n),
      .memory_mem_dm(M2_DDR2_dm),
      .memory_mem_dq(M2_DDR2_dq),
      .memory_mem_dqs(M2_DDR2_dqs),
      .memory_mem_dqs_n(M2_DDR2_dqsn),
      .memory_mem_odt(M2_DDR2_odt),
      .memory_mem_ras_n(M2_DDR2_ras_n),
      .memory_mem_we_n(M2_DDR2_we_n),

`endif

      // pll_mem_clk from DDR2 controller is 2x afi_clk, so use as sysclk_2x
      .emif_pll_conduit_pll_mem_clk(ddr_pll_mem_clk), // out
      .sysclk_2x_clk(ddr_pll_mem_clk), // in

      // Connect pll locked output back to dll.
      .emif_pll_conduit_pll_locked(ddr_pll_locked), // out
      .emif_dll_conduit_dll_pll_locked(ddr_pll_locked), // in

      .mem_if_ddr2_emif_0_status_local_init_done(ddr_init_done), // out
      .mem_if_ddr2_emif_0_status_local_cal_success(ddr_cal_success), // out
      .mem_if_ddr2_emif_0_status_local_cal_fail(ddr_cal_fail) // out
      );

  // Not using the SPD (Serial Presence Detect) I2C EEPROM
  // Drive these constant if not using.
`ifndef USE_DDR2_DIMM2
  assign M1_DDR2_SCL = 1'b0;
  assign M1_DDR2_SA  = 1'b0;
`else
  assign M2_DDR2_SCL = 1'b0;
  assign M2_DDR2_SA  = 1'b0;
`endif

  //////////////////////////////////////////////////////////////////////

  assign LED = ~{led_wire[7:5],
                 ddr_cal_fail,      // 4
                 ddr_cal_success,   // 3
                 ddr_init_done,     // 2
                 led_wire[1],   // 1
                 led_wire[0]};  // 0

  //////////////////////////////////////////////////////////////////////
  generate
    genvar i;

    for (i = 0; i < 4; i = i+1)
      begin : gen_debounce
        debounce debounce_inst
             (.clk(OSC_50_Bank3),
              .button(SLIDE_SW[i]),
              .result(debounced_switches[i])
              );
      end
  endgenerate

endmodule
