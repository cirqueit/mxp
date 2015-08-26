//----------------------------------------------------------------------------
// Clears bit 31 of araddr and awaddr.
// ---------------------------------------------------------------------------

module axi_addr_remap #
  (
   parameter integer C_AXI_ADDR_WIDTH            = 32,
   parameter integer C_AXI_DATA_WIDTH            = 32
   )
  (
   // System Signals
   input wire aclk,
   input wire aresetn,

   // Slave Interface Write Address Ports
   input  wire [C_AXI_ADDR_WIDTH-1:0]   s_axi_awaddr,
   input  wire [3-1:0]                  s_axi_awprot,
   input  wire                          s_axi_awvalid,
   output wire                          s_axi_awready,

   // Slave Interface Write Data Ports
   input  wire [C_AXI_DATA_WIDTH-1:0]   s_axi_wdata,
   input  wire [C_AXI_DATA_WIDTH/8-1:0] s_axi_wstrb,
   input  wire                          s_axi_wvalid,
   output wire                          s_axi_wready,

   // Slave Interface Write Response Ports
   output wire [2-1:0]                 s_axi_bresp,
   output wire                         s_axi_bvalid,
   input  wire                         s_axi_bready,

   // Slave Interface Read Address Ports
   input  wire [C_AXI_ADDR_WIDTH-1:0]   s_axi_araddr,
   input  wire [3-1:0]                  s_axi_arprot,
   input  wire                          s_axi_arvalid,
   output wire                          s_axi_arready,

   // Slave Interface Read Data Ports
   output wire [C_AXI_DATA_WIDTH-1:0]  s_axi_rdata,
   output wire [2-1:0]                 s_axi_rresp,
   input wire                          s_axi_rready,
   output wire                         s_axi_rvalid,

   // Master Interface Write Address Port
   output wire [C_AXI_ADDR_WIDTH-1:0]   m_axi_awaddr,
   output wire [3-1:0]                  m_axi_awprot,
   output wire                          m_axi_awvalid,
   input  wire                          m_axi_awready,

   // Master Interface Write Data Ports
   output wire [C_AXI_DATA_WIDTH-1:0]   m_axi_wdata,
   output wire [C_AXI_DATA_WIDTH/8-1:0] m_axi_wstrb,
   output wire                          m_axi_wvalid,
   input  wire                          m_axi_wready,

   // Master Interface Write Response Ports
   input  wire [2-1:0]                 m_axi_bresp,
   input  wire                         m_axi_bvalid,
   output wire                         m_axi_bready,

   // Master Interface Read Address Port
   output wire [C_AXI_ADDR_WIDTH-1:0]   m_axi_araddr,
   output wire [3-1:0]                  m_axi_arprot,
   output wire                          m_axi_arvalid,
   input  wire                          m_axi_arready,

   // Master Interface Read Data Ports
   input  wire [C_AXI_DATA_WIDTH-1:0]  m_axi_rdata,
   input  wire [2-1:0]                 m_axi_rresp,
   input  wire                         m_axi_rvalid,
   output wire                         m_axi_rready
  );

  assign m_axi_awaddr   = {1'b0, s_axi_awaddr[C_AXI_ADDR_WIDTH-2:0]};
  assign m_axi_awprot   = s_axi_awprot;
  assign m_axi_awvalid  = s_axi_awvalid;
  assign s_axi_awready  = m_axi_awready;

  assign m_axi_wdata    = s_axi_wdata;
  assign m_axi_wstrb    = s_axi_wstrb;
  assign m_axi_wvalid   = s_axi_wvalid;
  assign s_axi_wready   = m_axi_wready;

  assign s_axi_bresp    = m_axi_bresp;
  assign s_axi_bvalid   = m_axi_bvalid;
  assign m_axi_bready   = s_axi_bready;

  assign m_axi_araddr   = {1'b0, s_axi_araddr[C_AXI_ADDR_WIDTH-2:0]};
  assign m_axi_arprot   = s_axi_arprot;
  assign m_axi_arvalid  = s_axi_arvalid;
  assign s_axi_arready  = m_axi_arready;

  assign s_axi_rdata    = m_axi_rdata;
  assign s_axi_rresp    = m_axi_rresp;
  assign s_axi_rvalid   = m_axi_rvalid;
  assign m_axi_rready   = s_axi_rready;

endmodule // axi_addr_remap
