//--------------------------------------------------------------------------
//
// axi2axi_remap based on Xilinx's axi2axi_connector.
//
// Addresses on slave port get remapped on master port.
// For now, bit 31 just gets cleared, but more generally, a range of the most
// significant address bits could be remapped to a different range.
//
//--------------------------------------------------------------------------

`timescale 1ns/1ps

module axi2axi_remap #
  (
   parameter integer C_S_AXI_ID_WIDTH              = 1,
   parameter integer C_S_AXI_ADDR_WIDTH            = 32,
   parameter integer C_S_AXI_DATA_WIDTH            = 32,
   parameter integer C_S_AXI_AWUSER_WIDTH          = 1,
   parameter integer C_S_AXI_ARUSER_WIDTH          = 1,
   parameter integer C_S_AXI_WUSER_WIDTH           = 1,
   parameter integer C_S_AXI_RUSER_WIDTH           = 1,
   parameter integer C_S_AXI_BUSER_WIDTH           = 1
   )
  (
   // System Signals
   input wire ACLK,
   input wire ARESETN,

   // Slave Interface Write Address Ports
   input  wire [C_S_AXI_ID_WIDTH-1:0]      S_AXI_AWID,
   input  wire [C_S_AXI_ADDR_WIDTH-1:0]    S_AXI_AWADDR,
   input  wire [8-1:0]                     S_AXI_AWLEN,
   input  wire [3-1:0]                     S_AXI_AWSIZE,
   input  wire [2-1:0]                     S_AXI_AWBURST,
   input  wire [2-1:0]                     S_AXI_AWLOCK,
   input  wire [4-1:0]                     S_AXI_AWCACHE,
   input  wire [3-1:0]                     S_AXI_AWPROT,
   input  wire [4-1:0]                     S_AXI_AWREGION,
   input  wire [4-1:0]                     S_AXI_AWQOS,
   input  wire [C_S_AXI_AWUSER_WIDTH-1:0]  S_AXI_AWUSER,
   input  wire                             S_AXI_AWVALID,
   output wire                             S_AXI_AWREADY,

   // Slave Interface Write Data Ports
   input wire [C_S_AXI_ID_WIDTH-1:0]       S_AXI_WID,
   input  wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_WDATA,
   input  wire [C_S_AXI_DATA_WIDTH/8-1:0]  S_AXI_WSTRB,
   input  wire                             S_AXI_WLAST,
   input  wire [C_S_AXI_WUSER_WIDTH-1:0]   S_AXI_WUSER,
   input  wire                             S_AXI_WVALID,
   output wire                             S_AXI_WREADY,

   // Slave Interface Write Response Ports
   output wire [C_S_AXI_ID_WIDTH-1:0]      S_AXI_BID,
   output wire [2-1:0]                     S_AXI_BRESP,
   output wire [C_S_AXI_BUSER_WIDTH-1:0]   S_AXI_BUSER,
   output wire                             S_AXI_BVALID,
   input  wire                             S_AXI_BREADY,

   // Slave Interface Read Address Ports
   input  wire [C_S_AXI_ID_WIDTH-1:0]      S_AXI_ARID,
   input  wire [C_S_AXI_ADDR_WIDTH-1:0]    S_AXI_ARADDR,
   input  wire [8-1:0]                     S_AXI_ARLEN,
   input  wire [3-1:0]                     S_AXI_ARSIZE,
   input  wire [2-1:0]                     S_AXI_ARBURST,
   input  wire [2-1:0]                     S_AXI_ARLOCK,
   input  wire [4-1:0]                     S_AXI_ARCACHE,
   input  wire [3-1:0]                     S_AXI_ARPROT,
   input  wire [4-1:0]                     S_AXI_ARREGION,
   input  wire [4-1:0]                     S_AXI_ARQOS,
   input  wire [C_S_AXI_ARUSER_WIDTH-1:0]  S_AXI_ARUSER,
   input  wire                             S_AXI_ARVALID,
   output wire                             S_AXI_ARREADY,

   // Slave Interface Read Data Ports
   output wire [C_S_AXI_ID_WIDTH-1:0]      S_AXI_RID,
   output wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA,
   output wire [2-1:0]                     S_AXI_RRESP,
   output wire                             S_AXI_RLAST,
   output wire [C_S_AXI_RUSER_WIDTH-1:0]   S_AXI_RUSER,
   output wire                             S_AXI_RVALID,
   input  wire                             S_AXI_RREADY,
   
   // Master Interface Write Address Port
   output wire [C_S_AXI_ID_WIDTH-1:0]      M_AXI_AWID,
   output wire [C_S_AXI_ADDR_WIDTH-1:0]    M_AXI_AWADDR,
   output wire [8-1:0]                     M_AXI_AWLEN,
   output wire [3-1:0]                     M_AXI_AWSIZE,
   output wire [2-1:0]                     M_AXI_AWBURST,
   output wire [2-1:0]                     M_AXI_AWLOCK,
   output wire [4-1:0]                     M_AXI_AWCACHE,
   output wire [3-1:0]                     M_AXI_AWPROT,
   output wire [4-1:0]                     M_AXI_AWREGION,
   output wire [4-1:0]                     M_AXI_AWQOS,
   output wire [C_S_AXI_AWUSER_WIDTH-1:0]  M_AXI_AWUSER,
   output wire                             M_AXI_AWVALID,
   input  wire                             M_AXI_AWREADY,
   
   // Master Interface Write Data Ports
   output wire [C_S_AXI_ID_WIDTH-1:0]      M_AXI_WID,
   output wire [C_S_AXI_DATA_WIDTH-1:0]    M_AXI_WDATA,
   output wire [C_S_AXI_DATA_WIDTH/8-1:0]  M_AXI_WSTRB,
   output wire                             M_AXI_WLAST,
   output wire [C_S_AXI_WUSER_WIDTH-1:0]   M_AXI_WUSER,
   output wire                             M_AXI_WVALID,
   input  wire                             M_AXI_WREADY,
   
   // Master Interface Write Response Ports
   input  wire [C_S_AXI_ID_WIDTH-1:0]      M_AXI_BID,
   input  wire [2-1:0]                     M_AXI_BRESP,
   input  wire [C_S_AXI_BUSER_WIDTH-1:0]   M_AXI_BUSER,
   input  wire                             M_AXI_BVALID,
   output wire                             M_AXI_BREADY,
   
   // Master Interface Read Address Port
   output wire [C_S_AXI_ID_WIDTH-1:0]      M_AXI_ARID,
   output wire [C_S_AXI_ADDR_WIDTH-1:0]    M_AXI_ARADDR,
   output wire [8-1:0]                     M_AXI_ARLEN,
   output wire [3-1:0]                     M_AXI_ARSIZE,
   output wire [2-1:0]                     M_AXI_ARBURST,
   output wire [2-1:0]                     M_AXI_ARLOCK,
   output wire [4-1:0]                     M_AXI_ARCACHE,
   output wire [3-1:0]                     M_AXI_ARPROT,
   output wire [4-1:0]                     M_AXI_ARREGION,
   output wire [4-1:0]                     M_AXI_ARQOS,
   output wire [C_S_AXI_ARUSER_WIDTH-1:0]  M_AXI_ARUSER,
   output wire                             M_AXI_ARVALID,
   input  wire                             M_AXI_ARREADY,
   
   // Master Interface Read Data Ports
   input  wire [C_S_AXI_ID_WIDTH-1:0]      M_AXI_RID,
   input  wire [C_S_AXI_DATA_WIDTH-1:0]    M_AXI_RDATA,
   input  wire [2-1:0]                     M_AXI_RRESP,
   input  wire                             M_AXI_RLAST,
   input  wire [C_S_AXI_RUSER_WIDTH-1:0]   M_AXI_RUSER,
   input  wire                             M_AXI_RVALID,
   output wire                             M_AXI_RREADY
  );

  // Write address port
  assign M_AXI_AWID     = S_AXI_AWID;
  assign M_AXI_AWADDR   = {1'b0, S_AXI_AWADDR[C_S_AXI_ADDR_WIDTH-2:0]};
  assign M_AXI_AWLEN    = S_AXI_AWLEN;
  assign M_AXI_AWSIZE   = S_AXI_AWSIZE;
  assign M_AXI_AWBURST  = S_AXI_AWBURST;
  assign M_AXI_AWLOCK   = S_AXI_AWLOCK;
  assign M_AXI_AWCACHE  = S_AXI_AWCACHE;
  assign M_AXI_AWPROT   = S_AXI_AWPROT;
  assign M_AXI_AWREGION = S_AXI_AWREGION;
  assign M_AXI_AWQOS    = S_AXI_AWQOS;
  assign M_AXI_AWUSER   = S_AXI_AWUSER;
  assign M_AXI_AWVALID  = S_AXI_AWVALID;
  assign S_AXI_AWREADY  = M_AXI_AWREADY;

  // Write Data Port
  assign M_AXI_WID      = S_AXI_WID;
  assign M_AXI_WDATA    = S_AXI_WDATA;
  assign M_AXI_WSTRB    = S_AXI_WSTRB;
  assign M_AXI_WLAST    = S_AXI_WLAST;
  assign M_AXI_WUSER    = S_AXI_WUSER;
  assign M_AXI_WVALID   = S_AXI_WVALID;
  assign S_AXI_WREADY   = M_AXI_WREADY;

  // Write Response Port
  assign S_AXI_BID      = M_AXI_BID;
  assign S_AXI_BRESP    = M_AXI_BRESP;
  assign S_AXI_BUSER    = M_AXI_BUSER;
  assign S_AXI_BVALID   = M_AXI_BVALID;
  assign M_AXI_BREADY   = S_AXI_BREADY;
  
  // Read Address Port
  assign M_AXI_ARID     = S_AXI_ARID;
  assign M_AXI_ARADDR   = {1'b0, S_AXI_ARADDR[C_S_AXI_ADDR_WIDTH-2:0]};
  assign M_AXI_ARLEN    = S_AXI_ARLEN;
  assign M_AXI_ARSIZE   = S_AXI_ARSIZE;
  assign M_AXI_ARBURST  = S_AXI_ARBURST;
  assign M_AXI_ARLOCK   = S_AXI_ARLOCK;
  assign M_AXI_ARCACHE  = S_AXI_ARCACHE;
  assign M_AXI_ARPROT   = S_AXI_ARPROT;
  assign M_AXI_ARREGION = S_AXI_ARREGION;
  assign M_AXI_ARQOS    = S_AXI_ARQOS;
  assign M_AXI_ARUSER   = S_AXI_ARUSER;
  assign M_AXI_ARVALID  = S_AXI_ARVALID;
  assign S_AXI_ARREADY  = M_AXI_ARREADY;

  // Read Data Port
  assign S_AXI_RID      = M_AXI_RID;
  assign S_AXI_RDATA    = M_AXI_RDATA;
  assign S_AXI_RRESP    = M_AXI_RRESP;
  assign S_AXI_RLAST    = M_AXI_RLAST;
  assign S_AXI_RUSER    = M_AXI_RUSER;
  assign S_AXI_RVALID   = M_AXI_RVALID;
  assign M_AXI_RREADY   = S_AXI_RREADY;

endmodule
