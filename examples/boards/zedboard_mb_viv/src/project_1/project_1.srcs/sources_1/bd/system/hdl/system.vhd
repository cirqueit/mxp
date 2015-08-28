--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.2 (lin64) Build 928826 Thu Jun  5 17:55:10 MDT 2014
--Date        : Fri Aug 28 15:48:53 2015
--Host        : avx running 64-bit Ubuntu 12.04.5 LTS
--Command     : generate_target system.bd
--Design      : system
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m00_couplers_imp_2PVA4I is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m00_couplers_imp_2PVA4I;

architecture STRUCTURE of m00_couplers_imp_2PVA4I is
  signal m00_couplers_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_ARREADY : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_ARVALID : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_AWREADY : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_AWVALID : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_BREADY : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_m00_couplers_BVALID : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_RREADY : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_m00_couplers_RVALID : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_m00_couplers_WREADY : STD_LOGIC;
  signal m00_couplers_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_m00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= m00_couplers_to_m00_couplers_ARADDR(31 downto 0);
  M_AXI_arvalid <= m00_couplers_to_m00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= m00_couplers_to_m00_couplers_AWADDR(31 downto 0);
  M_AXI_awvalid <= m00_couplers_to_m00_couplers_AWVALID;
  M_AXI_bready <= m00_couplers_to_m00_couplers_BREADY;
  M_AXI_rready <= m00_couplers_to_m00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m00_couplers_to_m00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m00_couplers_to_m00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m00_couplers_to_m00_couplers_WVALID;
  S_AXI_arready <= m00_couplers_to_m00_couplers_ARREADY;
  S_AXI_awready <= m00_couplers_to_m00_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m00_couplers_to_m00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m00_couplers_to_m00_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m00_couplers_to_m00_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m00_couplers_to_m00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m00_couplers_to_m00_couplers_RVALID;
  S_AXI_wready <= m00_couplers_to_m00_couplers_WREADY;
  m00_couplers_to_m00_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  m00_couplers_to_m00_couplers_ARREADY <= M_AXI_arready;
  m00_couplers_to_m00_couplers_ARVALID <= S_AXI_arvalid;
  m00_couplers_to_m00_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  m00_couplers_to_m00_couplers_AWREADY <= M_AXI_awready;
  m00_couplers_to_m00_couplers_AWVALID <= S_AXI_awvalid;
  m00_couplers_to_m00_couplers_BREADY <= S_AXI_bready;
  m00_couplers_to_m00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m00_couplers_to_m00_couplers_BVALID <= M_AXI_bvalid;
  m00_couplers_to_m00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m00_couplers_to_m00_couplers_RREADY <= S_AXI_rready;
  m00_couplers_to_m00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m00_couplers_to_m00_couplers_RVALID <= M_AXI_rvalid;
  m00_couplers_to_m00_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m00_couplers_to_m00_couplers_WREADY <= M_AXI_wready;
  m00_couplers_to_m00_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m00_couplers_to_m00_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m00_couplers_imp_7PB8C3 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rlast : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_wlast : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m00_couplers_imp_7PB8C3;

architecture STRUCTURE of m00_couplers_imp_7PB8C3 is
  component system_auto_pc_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_arid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component system_auto_pc_1;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_pc_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_ARID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m00_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_ARREADY : STD_LOGIC;
  signal auto_pc_to_m00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m00_couplers_ARVALID : STD_LOGIC;
  signal auto_pc_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_AWID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m00_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_AWREADY : STD_LOGIC;
  signal auto_pc_to_m00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m00_couplers_AWVALID : STD_LOGIC;
  signal auto_pc_to_m00_couplers_BID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_BREADY : STD_LOGIC;
  signal auto_pc_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_BVALID : STD_LOGIC;
  signal auto_pc_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m00_couplers_RID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_RLAST : STD_LOGIC;
  signal auto_pc_to_m00_couplers_RREADY : STD_LOGIC;
  signal auto_pc_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_RVALID : STD_LOGIC;
  signal auto_pc_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m00_couplers_WID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m00_couplers_WLAST : STD_LOGIC;
  signal auto_pc_to_m00_couplers_WREADY : STD_LOGIC;
  signal auto_pc_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m00_couplers_WVALID : STD_LOGIC;
  signal m00_couplers_to_auto_pc_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_auto_pc_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_ARID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m00_couplers_to_auto_pc_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_auto_pc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_auto_pc_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_ARREADY : STD_LOGIC;
  signal m00_couplers_to_auto_pc_ARREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_auto_pc_ARVALID : STD_LOGIC;
  signal m00_couplers_to_auto_pc_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_auto_pc_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_AWID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal m00_couplers_to_auto_pc_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_auto_pc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_auto_pc_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_AWREADY : STD_LOGIC;
  signal m00_couplers_to_auto_pc_AWREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_auto_pc_AWVALID : STD_LOGIC;
  signal m00_couplers_to_auto_pc_BID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_BREADY : STD_LOGIC;
  signal m00_couplers_to_auto_pc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_BVALID : STD_LOGIC;
  signal m00_couplers_to_auto_pc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_auto_pc_RID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_RLAST : STD_LOGIC;
  signal m00_couplers_to_auto_pc_RREADY : STD_LOGIC;
  signal m00_couplers_to_auto_pc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_auto_pc_RVALID : STD_LOGIC;
  signal m00_couplers_to_auto_pc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_auto_pc_WLAST : STD_LOGIC;
  signal m00_couplers_to_auto_pc_WREADY : STD_LOGIC;
  signal m00_couplers_to_auto_pc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_auto_pc_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= auto_pc_to_m00_couplers_ARADDR(31 downto 0);
  M_AXI_arburst(1 downto 0) <= auto_pc_to_m00_couplers_ARBURST(1 downto 0);
  M_AXI_arcache(3 downto 0) <= auto_pc_to_m00_couplers_ARCACHE(3 downto 0);
  M_AXI_arid(1 downto 0) <= auto_pc_to_m00_couplers_ARID(1 downto 0);
  M_AXI_arlen(3 downto 0) <= auto_pc_to_m00_couplers_ARLEN(3 downto 0);
  M_AXI_arlock(1 downto 0) <= auto_pc_to_m00_couplers_ARLOCK(1 downto 0);
  M_AXI_arprot(2 downto 0) <= auto_pc_to_m00_couplers_ARPROT(2 downto 0);
  M_AXI_arqos(3 downto 0) <= auto_pc_to_m00_couplers_ARQOS(3 downto 0);
  M_AXI_arsize(2 downto 0) <= auto_pc_to_m00_couplers_ARSIZE(2 downto 0);
  M_AXI_arvalid <= auto_pc_to_m00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= auto_pc_to_m00_couplers_AWADDR(31 downto 0);
  M_AXI_awburst(1 downto 0) <= auto_pc_to_m00_couplers_AWBURST(1 downto 0);
  M_AXI_awcache(3 downto 0) <= auto_pc_to_m00_couplers_AWCACHE(3 downto 0);
  M_AXI_awid(1 downto 0) <= auto_pc_to_m00_couplers_AWID(1 downto 0);
  M_AXI_awlen(3 downto 0) <= auto_pc_to_m00_couplers_AWLEN(3 downto 0);
  M_AXI_awlock(1 downto 0) <= auto_pc_to_m00_couplers_AWLOCK(1 downto 0);
  M_AXI_awprot(2 downto 0) <= auto_pc_to_m00_couplers_AWPROT(2 downto 0);
  M_AXI_awqos(3 downto 0) <= auto_pc_to_m00_couplers_AWQOS(3 downto 0);
  M_AXI_awsize(2 downto 0) <= auto_pc_to_m00_couplers_AWSIZE(2 downto 0);
  M_AXI_awvalid <= auto_pc_to_m00_couplers_AWVALID;
  M_AXI_bready <= auto_pc_to_m00_couplers_BREADY;
  M_AXI_rready <= auto_pc_to_m00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_pc_to_m00_couplers_WDATA(31 downto 0);
  M_AXI_wid(1 downto 0) <= auto_pc_to_m00_couplers_WID(1 downto 0);
  M_AXI_wlast <= auto_pc_to_m00_couplers_WLAST;
  M_AXI_wstrb(3 downto 0) <= auto_pc_to_m00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_pc_to_m00_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1(0) <= S_ARESETN(0);
  S_AXI_arready <= m00_couplers_to_auto_pc_ARREADY;
  S_AXI_awready <= m00_couplers_to_auto_pc_AWREADY;
  S_AXI_bid(1 downto 0) <= m00_couplers_to_auto_pc_BID(1 downto 0);
  S_AXI_bresp(1 downto 0) <= m00_couplers_to_auto_pc_BRESP(1 downto 0);
  S_AXI_bvalid <= m00_couplers_to_auto_pc_BVALID;
  S_AXI_rdata(31 downto 0) <= m00_couplers_to_auto_pc_RDATA(31 downto 0);
  S_AXI_rid(1 downto 0) <= m00_couplers_to_auto_pc_RID(1 downto 0);
  S_AXI_rlast <= m00_couplers_to_auto_pc_RLAST;
  S_AXI_rresp(1 downto 0) <= m00_couplers_to_auto_pc_RRESP(1 downto 0);
  S_AXI_rvalid <= m00_couplers_to_auto_pc_RVALID;
  S_AXI_wready <= m00_couplers_to_auto_pc_WREADY;
  auto_pc_to_m00_couplers_ARREADY <= M_AXI_arready;
  auto_pc_to_m00_couplers_AWREADY <= M_AXI_awready;
  auto_pc_to_m00_couplers_BID(1 downto 0) <= M_AXI_bid(1 downto 0);
  auto_pc_to_m00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_pc_to_m00_couplers_BVALID <= M_AXI_bvalid;
  auto_pc_to_m00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_pc_to_m00_couplers_RID(1 downto 0) <= M_AXI_rid(1 downto 0);
  auto_pc_to_m00_couplers_RLAST <= M_AXI_rlast;
  auto_pc_to_m00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_pc_to_m00_couplers_RVALID <= M_AXI_rvalid;
  auto_pc_to_m00_couplers_WREADY <= M_AXI_wready;
  m00_couplers_to_auto_pc_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  m00_couplers_to_auto_pc_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  m00_couplers_to_auto_pc_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  m00_couplers_to_auto_pc_ARID(1 downto 0) <= S_AXI_arid(1 downto 0);
  m00_couplers_to_auto_pc_ARLEN(7 downto 0) <= S_AXI_arlen(7 downto 0);
  m00_couplers_to_auto_pc_ARLOCK(0) <= S_AXI_arlock(0);
  m00_couplers_to_auto_pc_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m00_couplers_to_auto_pc_ARQOS(3 downto 0) <= S_AXI_arqos(3 downto 0);
  m00_couplers_to_auto_pc_ARREGION(3 downto 0) <= S_AXI_arregion(3 downto 0);
  m00_couplers_to_auto_pc_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  m00_couplers_to_auto_pc_ARVALID <= S_AXI_arvalid;
  m00_couplers_to_auto_pc_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  m00_couplers_to_auto_pc_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  m00_couplers_to_auto_pc_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  m00_couplers_to_auto_pc_AWID(1 downto 0) <= S_AXI_awid(1 downto 0);
  m00_couplers_to_auto_pc_AWLEN(7 downto 0) <= S_AXI_awlen(7 downto 0);
  m00_couplers_to_auto_pc_AWLOCK(0) <= S_AXI_awlock(0);
  m00_couplers_to_auto_pc_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m00_couplers_to_auto_pc_AWQOS(3 downto 0) <= S_AXI_awqos(3 downto 0);
  m00_couplers_to_auto_pc_AWREGION(3 downto 0) <= S_AXI_awregion(3 downto 0);
  m00_couplers_to_auto_pc_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  m00_couplers_to_auto_pc_AWVALID <= S_AXI_awvalid;
  m00_couplers_to_auto_pc_BREADY <= S_AXI_bready;
  m00_couplers_to_auto_pc_RREADY <= S_AXI_rready;
  m00_couplers_to_auto_pc_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m00_couplers_to_auto_pc_WLAST <= S_AXI_wlast;
  m00_couplers_to_auto_pc_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m00_couplers_to_auto_pc_WVALID <= S_AXI_wvalid;
auto_pc: component system_auto_pc_1
    port map (
      aclk => S_ACLK_1,
      aresetn => S_ARESETN_1(0),
      m_axi_araddr(31 downto 0) => auto_pc_to_m00_couplers_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => auto_pc_to_m00_couplers_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => auto_pc_to_m00_couplers_ARCACHE(3 downto 0),
      m_axi_arid(1 downto 0) => auto_pc_to_m00_couplers_ARID(1 downto 0),
      m_axi_arlen(3 downto 0) => auto_pc_to_m00_couplers_ARLEN(3 downto 0),
      m_axi_arlock(1 downto 0) => auto_pc_to_m00_couplers_ARLOCK(1 downto 0),
      m_axi_arprot(2 downto 0) => auto_pc_to_m00_couplers_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => auto_pc_to_m00_couplers_ARQOS(3 downto 0),
      m_axi_arready => auto_pc_to_m00_couplers_ARREADY,
      m_axi_arsize(2 downto 0) => auto_pc_to_m00_couplers_ARSIZE(2 downto 0),
      m_axi_arvalid => auto_pc_to_m00_couplers_ARVALID,
      m_axi_awaddr(31 downto 0) => auto_pc_to_m00_couplers_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => auto_pc_to_m00_couplers_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => auto_pc_to_m00_couplers_AWCACHE(3 downto 0),
      m_axi_awid(1 downto 0) => auto_pc_to_m00_couplers_AWID(1 downto 0),
      m_axi_awlen(3 downto 0) => auto_pc_to_m00_couplers_AWLEN(3 downto 0),
      m_axi_awlock(1 downto 0) => auto_pc_to_m00_couplers_AWLOCK(1 downto 0),
      m_axi_awprot(2 downto 0) => auto_pc_to_m00_couplers_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => auto_pc_to_m00_couplers_AWQOS(3 downto 0),
      m_axi_awready => auto_pc_to_m00_couplers_AWREADY,
      m_axi_awsize(2 downto 0) => auto_pc_to_m00_couplers_AWSIZE(2 downto 0),
      m_axi_awvalid => auto_pc_to_m00_couplers_AWVALID,
      m_axi_bid(1 downto 0) => auto_pc_to_m00_couplers_BID(1 downto 0),
      m_axi_bready => auto_pc_to_m00_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_pc_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_pc_to_m00_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_pc_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rid(1 downto 0) => auto_pc_to_m00_couplers_RID(1 downto 0),
      m_axi_rlast => auto_pc_to_m00_couplers_RLAST,
      m_axi_rready => auto_pc_to_m00_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_pc_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_pc_to_m00_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_pc_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wid(1 downto 0) => auto_pc_to_m00_couplers_WID(1 downto 0),
      m_axi_wlast => auto_pc_to_m00_couplers_WLAST,
      m_axi_wready => auto_pc_to_m00_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_pc_to_m00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_pc_to_m00_couplers_WVALID,
      s_axi_araddr(31 downto 0) => m00_couplers_to_auto_pc_ARADDR(31 downto 0),
      s_axi_arburst(1 downto 0) => m00_couplers_to_auto_pc_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => m00_couplers_to_auto_pc_ARCACHE(3 downto 0),
      s_axi_arid(1 downto 0) => m00_couplers_to_auto_pc_ARID(1 downto 0),
      s_axi_arlen(7 downto 0) => m00_couplers_to_auto_pc_ARLEN(7 downto 0),
      s_axi_arlock(0) => m00_couplers_to_auto_pc_ARLOCK(0),
      s_axi_arprot(2 downto 0) => m00_couplers_to_auto_pc_ARPROT(2 downto 0),
      s_axi_arqos(3 downto 0) => m00_couplers_to_auto_pc_ARQOS(3 downto 0),
      s_axi_arready => m00_couplers_to_auto_pc_ARREADY,
      s_axi_arregion(3 downto 0) => m00_couplers_to_auto_pc_ARREGION(3 downto 0),
      s_axi_arsize(2 downto 0) => m00_couplers_to_auto_pc_ARSIZE(2 downto 0),
      s_axi_arvalid => m00_couplers_to_auto_pc_ARVALID,
      s_axi_awaddr(31 downto 0) => m00_couplers_to_auto_pc_AWADDR(31 downto 0),
      s_axi_awburst(1 downto 0) => m00_couplers_to_auto_pc_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => m00_couplers_to_auto_pc_AWCACHE(3 downto 0),
      s_axi_awid(1 downto 0) => m00_couplers_to_auto_pc_AWID(1 downto 0),
      s_axi_awlen(7 downto 0) => m00_couplers_to_auto_pc_AWLEN(7 downto 0),
      s_axi_awlock(0) => m00_couplers_to_auto_pc_AWLOCK(0),
      s_axi_awprot(2 downto 0) => m00_couplers_to_auto_pc_AWPROT(2 downto 0),
      s_axi_awqos(3 downto 0) => m00_couplers_to_auto_pc_AWQOS(3 downto 0),
      s_axi_awready => m00_couplers_to_auto_pc_AWREADY,
      s_axi_awregion(3 downto 0) => m00_couplers_to_auto_pc_AWREGION(3 downto 0),
      s_axi_awsize(2 downto 0) => m00_couplers_to_auto_pc_AWSIZE(2 downto 0),
      s_axi_awvalid => m00_couplers_to_auto_pc_AWVALID,
      s_axi_bid(1 downto 0) => m00_couplers_to_auto_pc_BID(1 downto 0),
      s_axi_bready => m00_couplers_to_auto_pc_BREADY,
      s_axi_bresp(1 downto 0) => m00_couplers_to_auto_pc_BRESP(1 downto 0),
      s_axi_bvalid => m00_couplers_to_auto_pc_BVALID,
      s_axi_rdata(31 downto 0) => m00_couplers_to_auto_pc_RDATA(31 downto 0),
      s_axi_rid(1 downto 0) => m00_couplers_to_auto_pc_RID(1 downto 0),
      s_axi_rlast => m00_couplers_to_auto_pc_RLAST,
      s_axi_rready => m00_couplers_to_auto_pc_RREADY,
      s_axi_rresp(1 downto 0) => m00_couplers_to_auto_pc_RRESP(1 downto 0),
      s_axi_rvalid => m00_couplers_to_auto_pc_RVALID,
      s_axi_wdata(31 downto 0) => m00_couplers_to_auto_pc_WDATA(31 downto 0),
      s_axi_wlast => m00_couplers_to_auto_pc_WLAST,
      s_axi_wready => m00_couplers_to_auto_pc_WREADY,
      s_axi_wstrb(3 downto 0) => m00_couplers_to_auto_pc_WSTRB(3 downto 0),
      s_axi_wvalid => m00_couplers_to_auto_pc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m01_couplers_imp_1RTYIWS is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 4 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 4 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m01_couplers_imp_1RTYIWS;

architecture STRUCTURE of m01_couplers_imp_1RTYIWS is
  signal m01_couplers_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal m01_couplers_to_m01_couplers_ARREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_ARVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal m01_couplers_to_m01_couplers_AWREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_AWVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_BREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_m01_couplers_BVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_m01_couplers_RREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_m01_couplers_RVALID : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_m01_couplers_WREADY : STD_LOGIC;
  signal m01_couplers_to_m01_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m01_couplers_to_m01_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(4 downto 0) <= m01_couplers_to_m01_couplers_ARADDR(4 downto 0);
  M_AXI_arvalid <= m01_couplers_to_m01_couplers_ARVALID;
  M_AXI_awaddr(4 downto 0) <= m01_couplers_to_m01_couplers_AWADDR(4 downto 0);
  M_AXI_awvalid <= m01_couplers_to_m01_couplers_AWVALID;
  M_AXI_bready <= m01_couplers_to_m01_couplers_BREADY;
  M_AXI_rready <= m01_couplers_to_m01_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m01_couplers_to_m01_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m01_couplers_to_m01_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m01_couplers_to_m01_couplers_WVALID;
  S_AXI_arready <= m01_couplers_to_m01_couplers_ARREADY;
  S_AXI_awready <= m01_couplers_to_m01_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m01_couplers_to_m01_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m01_couplers_to_m01_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m01_couplers_to_m01_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m01_couplers_to_m01_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m01_couplers_to_m01_couplers_RVALID;
  S_AXI_wready <= m01_couplers_to_m01_couplers_WREADY;
  m01_couplers_to_m01_couplers_ARADDR(4 downto 0) <= S_AXI_araddr(4 downto 0);
  m01_couplers_to_m01_couplers_ARREADY <= M_AXI_arready;
  m01_couplers_to_m01_couplers_ARVALID <= S_AXI_arvalid;
  m01_couplers_to_m01_couplers_AWADDR(4 downto 0) <= S_AXI_awaddr(4 downto 0);
  m01_couplers_to_m01_couplers_AWREADY <= M_AXI_awready;
  m01_couplers_to_m01_couplers_AWVALID <= S_AXI_awvalid;
  m01_couplers_to_m01_couplers_BREADY <= S_AXI_bready;
  m01_couplers_to_m01_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m01_couplers_to_m01_couplers_BVALID <= M_AXI_bvalid;
  m01_couplers_to_m01_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m01_couplers_to_m01_couplers_RREADY <= S_AXI_rready;
  m01_couplers_to_m01_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m01_couplers_to_m01_couplers_RVALID <= M_AXI_rvalid;
  m01_couplers_to_m01_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m01_couplers_to_m01_couplers_WREADY <= M_AXI_wready;
  m01_couplers_to_m01_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m01_couplers_to_m01_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m02_couplers_imp_3O3M0V is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rlast : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wlast : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m02_couplers_imp_3O3M0V;

architecture STRUCTURE of m02_couplers_imp_3O3M0V is
  component system_auto_pc_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component system_auto_pc_0;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_pc_to_m02_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m02_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m02_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m02_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m02_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_ARREADY : STD_LOGIC;
  signal auto_pc_to_m02_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m02_couplers_ARVALID : STD_LOGIC;
  signal auto_pc_to_m02_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m02_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m02_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m02_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m02_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_AWREADY : STD_LOGIC;
  signal auto_pc_to_m02_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_m02_couplers_AWVALID : STD_LOGIC;
  signal auto_pc_to_m02_couplers_BREADY : STD_LOGIC;
  signal auto_pc_to_m02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m02_couplers_BVALID : STD_LOGIC;
  signal auto_pc_to_m02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m02_couplers_RLAST : STD_LOGIC;
  signal auto_pc_to_m02_couplers_RREADY : STD_LOGIC;
  signal auto_pc_to_m02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_m02_couplers_RVALID : STD_LOGIC;
  signal auto_pc_to_m02_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_m02_couplers_WLAST : STD_LOGIC;
  signal auto_pc_to_m02_couplers_WREADY : STD_LOGIC;
  signal auto_pc_to_m02_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_m02_couplers_WVALID : STD_LOGIC;
  signal m02_couplers_to_auto_pc_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_auto_pc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m02_couplers_to_auto_pc_ARREADY : STD_LOGIC;
  signal m02_couplers_to_auto_pc_ARVALID : STD_LOGIC;
  signal m02_couplers_to_auto_pc_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_auto_pc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m02_couplers_to_auto_pc_AWREADY : STD_LOGIC;
  signal m02_couplers_to_auto_pc_AWVALID : STD_LOGIC;
  signal m02_couplers_to_auto_pc_BREADY : STD_LOGIC;
  signal m02_couplers_to_auto_pc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_auto_pc_BVALID : STD_LOGIC;
  signal m02_couplers_to_auto_pc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_auto_pc_RREADY : STD_LOGIC;
  signal m02_couplers_to_auto_pc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_auto_pc_RVALID : STD_LOGIC;
  signal m02_couplers_to_auto_pc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_auto_pc_WREADY : STD_LOGIC;
  signal m02_couplers_to_auto_pc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_auto_pc_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= auto_pc_to_m02_couplers_ARADDR(31 downto 0);
  M_AXI_arburst(1 downto 0) <= auto_pc_to_m02_couplers_ARBURST(1 downto 0);
  M_AXI_arcache(3 downto 0) <= auto_pc_to_m02_couplers_ARCACHE(3 downto 0);
  M_AXI_arlen(3 downto 0) <= auto_pc_to_m02_couplers_ARLEN(3 downto 0);
  M_AXI_arlock(1 downto 0) <= auto_pc_to_m02_couplers_ARLOCK(1 downto 0);
  M_AXI_arprot(2 downto 0) <= auto_pc_to_m02_couplers_ARPROT(2 downto 0);
  M_AXI_arqos(3 downto 0) <= auto_pc_to_m02_couplers_ARQOS(3 downto 0);
  M_AXI_arsize(2 downto 0) <= auto_pc_to_m02_couplers_ARSIZE(2 downto 0);
  M_AXI_arvalid <= auto_pc_to_m02_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= auto_pc_to_m02_couplers_AWADDR(31 downto 0);
  M_AXI_awburst(1 downto 0) <= auto_pc_to_m02_couplers_AWBURST(1 downto 0);
  M_AXI_awcache(3 downto 0) <= auto_pc_to_m02_couplers_AWCACHE(3 downto 0);
  M_AXI_awlen(3 downto 0) <= auto_pc_to_m02_couplers_AWLEN(3 downto 0);
  M_AXI_awlock(1 downto 0) <= auto_pc_to_m02_couplers_AWLOCK(1 downto 0);
  M_AXI_awprot(2 downto 0) <= auto_pc_to_m02_couplers_AWPROT(2 downto 0);
  M_AXI_awqos(3 downto 0) <= auto_pc_to_m02_couplers_AWQOS(3 downto 0);
  M_AXI_awsize(2 downto 0) <= auto_pc_to_m02_couplers_AWSIZE(2 downto 0);
  M_AXI_awvalid <= auto_pc_to_m02_couplers_AWVALID;
  M_AXI_bready <= auto_pc_to_m02_couplers_BREADY;
  M_AXI_rready <= auto_pc_to_m02_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_pc_to_m02_couplers_WDATA(31 downto 0);
  M_AXI_wlast <= auto_pc_to_m02_couplers_WLAST;
  M_AXI_wstrb(3 downto 0) <= auto_pc_to_m02_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_pc_to_m02_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1(0) <= S_ARESETN(0);
  S_AXI_arready <= m02_couplers_to_auto_pc_ARREADY;
  S_AXI_awready <= m02_couplers_to_auto_pc_AWREADY;
  S_AXI_bresp(1 downto 0) <= m02_couplers_to_auto_pc_BRESP(1 downto 0);
  S_AXI_bvalid <= m02_couplers_to_auto_pc_BVALID;
  S_AXI_rdata(31 downto 0) <= m02_couplers_to_auto_pc_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m02_couplers_to_auto_pc_RRESP(1 downto 0);
  S_AXI_rvalid <= m02_couplers_to_auto_pc_RVALID;
  S_AXI_wready <= m02_couplers_to_auto_pc_WREADY;
  auto_pc_to_m02_couplers_ARREADY <= M_AXI_arready;
  auto_pc_to_m02_couplers_AWREADY <= M_AXI_awready;
  auto_pc_to_m02_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_pc_to_m02_couplers_BVALID <= M_AXI_bvalid;
  auto_pc_to_m02_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_pc_to_m02_couplers_RLAST <= M_AXI_rlast;
  auto_pc_to_m02_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_pc_to_m02_couplers_RVALID <= M_AXI_rvalid;
  auto_pc_to_m02_couplers_WREADY <= M_AXI_wready;
  m02_couplers_to_auto_pc_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  m02_couplers_to_auto_pc_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m02_couplers_to_auto_pc_ARVALID <= S_AXI_arvalid;
  m02_couplers_to_auto_pc_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  m02_couplers_to_auto_pc_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m02_couplers_to_auto_pc_AWVALID <= S_AXI_awvalid;
  m02_couplers_to_auto_pc_BREADY <= S_AXI_bready;
  m02_couplers_to_auto_pc_RREADY <= S_AXI_rready;
  m02_couplers_to_auto_pc_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m02_couplers_to_auto_pc_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m02_couplers_to_auto_pc_WVALID <= S_AXI_wvalid;
auto_pc: component system_auto_pc_0
    port map (
      aclk => S_ACLK_1,
      aresetn => S_ARESETN_1(0),
      m_axi_araddr(31 downto 0) => auto_pc_to_m02_couplers_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => auto_pc_to_m02_couplers_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => auto_pc_to_m02_couplers_ARCACHE(3 downto 0),
      m_axi_arlen(3 downto 0) => auto_pc_to_m02_couplers_ARLEN(3 downto 0),
      m_axi_arlock(1 downto 0) => auto_pc_to_m02_couplers_ARLOCK(1 downto 0),
      m_axi_arprot(2 downto 0) => auto_pc_to_m02_couplers_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => auto_pc_to_m02_couplers_ARQOS(3 downto 0),
      m_axi_arready => auto_pc_to_m02_couplers_ARREADY,
      m_axi_arsize(2 downto 0) => auto_pc_to_m02_couplers_ARSIZE(2 downto 0),
      m_axi_arvalid => auto_pc_to_m02_couplers_ARVALID,
      m_axi_awaddr(31 downto 0) => auto_pc_to_m02_couplers_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => auto_pc_to_m02_couplers_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => auto_pc_to_m02_couplers_AWCACHE(3 downto 0),
      m_axi_awlen(3 downto 0) => auto_pc_to_m02_couplers_AWLEN(3 downto 0),
      m_axi_awlock(1 downto 0) => auto_pc_to_m02_couplers_AWLOCK(1 downto 0),
      m_axi_awprot(2 downto 0) => auto_pc_to_m02_couplers_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => auto_pc_to_m02_couplers_AWQOS(3 downto 0),
      m_axi_awready => auto_pc_to_m02_couplers_AWREADY,
      m_axi_awsize(2 downto 0) => auto_pc_to_m02_couplers_AWSIZE(2 downto 0),
      m_axi_awvalid => auto_pc_to_m02_couplers_AWVALID,
      m_axi_bready => auto_pc_to_m02_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_pc_to_m02_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_pc_to_m02_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_pc_to_m02_couplers_RDATA(31 downto 0),
      m_axi_rlast => auto_pc_to_m02_couplers_RLAST,
      m_axi_rready => auto_pc_to_m02_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_pc_to_m02_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_pc_to_m02_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_pc_to_m02_couplers_WDATA(31 downto 0),
      m_axi_wlast => auto_pc_to_m02_couplers_WLAST,
      m_axi_wready => auto_pc_to_m02_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_pc_to_m02_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_pc_to_m02_couplers_WVALID,
      s_axi_araddr(31 downto 0) => m02_couplers_to_auto_pc_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => m02_couplers_to_auto_pc_ARPROT(2 downto 0),
      s_axi_arready => m02_couplers_to_auto_pc_ARREADY,
      s_axi_arvalid => m02_couplers_to_auto_pc_ARVALID,
      s_axi_awaddr(31 downto 0) => m02_couplers_to_auto_pc_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => m02_couplers_to_auto_pc_AWPROT(2 downto 0),
      s_axi_awready => m02_couplers_to_auto_pc_AWREADY,
      s_axi_awvalid => m02_couplers_to_auto_pc_AWVALID,
      s_axi_bready => m02_couplers_to_auto_pc_BREADY,
      s_axi_bresp(1 downto 0) => m02_couplers_to_auto_pc_BRESP(1 downto 0),
      s_axi_bvalid => m02_couplers_to_auto_pc_BVALID,
      s_axi_rdata(31 downto 0) => m02_couplers_to_auto_pc_RDATA(31 downto 0),
      s_axi_rready => m02_couplers_to_auto_pc_RREADY,
      s_axi_rresp(1 downto 0) => m02_couplers_to_auto_pc_RRESP(1 downto 0),
      s_axi_rvalid => m02_couplers_to_auto_pc_RVALID,
      s_axi_wdata(31 downto 0) => m02_couplers_to_auto_pc_WDATA(31 downto 0),
      s_axi_wready => m02_couplers_to_auto_pc_WREADY,
      s_axi_wstrb(3 downto 0) => m02_couplers_to_auto_pc_WSTRB(3 downto 0),
      s_axi_wvalid => m02_couplers_to_auto_pc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m03_couplers_imp_1QZA70H is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m03_couplers_imp_1QZA70H;

architecture STRUCTURE of m03_couplers_imp_1QZA70H is
  signal m03_couplers_to_m03_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_ARREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_ARVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_AWREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_AWVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_BREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_m03_couplers_BVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_RREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_m03_couplers_RVALID : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_m03_couplers_WREADY : STD_LOGIC;
  signal m03_couplers_to_m03_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m03_couplers_to_m03_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= m03_couplers_to_m03_couplers_ARADDR(31 downto 0);
  M_AXI_arvalid <= m03_couplers_to_m03_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= m03_couplers_to_m03_couplers_AWADDR(31 downto 0);
  M_AXI_awvalid <= m03_couplers_to_m03_couplers_AWVALID;
  M_AXI_bready <= m03_couplers_to_m03_couplers_BREADY;
  M_AXI_rready <= m03_couplers_to_m03_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m03_couplers_to_m03_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m03_couplers_to_m03_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m03_couplers_to_m03_couplers_WVALID;
  S_AXI_arready <= m03_couplers_to_m03_couplers_ARREADY;
  S_AXI_awready <= m03_couplers_to_m03_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m03_couplers_to_m03_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m03_couplers_to_m03_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m03_couplers_to_m03_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m03_couplers_to_m03_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m03_couplers_to_m03_couplers_RVALID;
  S_AXI_wready <= m03_couplers_to_m03_couplers_WREADY;
  m03_couplers_to_m03_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  m03_couplers_to_m03_couplers_ARREADY <= M_AXI_arready;
  m03_couplers_to_m03_couplers_ARVALID <= S_AXI_arvalid;
  m03_couplers_to_m03_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  m03_couplers_to_m03_couplers_AWREADY <= M_AXI_awready;
  m03_couplers_to_m03_couplers_AWVALID <= S_AXI_awvalid;
  m03_couplers_to_m03_couplers_BREADY <= S_AXI_bready;
  m03_couplers_to_m03_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m03_couplers_to_m03_couplers_BVALID <= M_AXI_bvalid;
  m03_couplers_to_m03_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m03_couplers_to_m03_couplers_RREADY <= S_AXI_rready;
  m03_couplers_to_m03_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m03_couplers_to_m03_couplers_RVALID <= M_AXI_rvalid;
  m03_couplers_to_m03_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m03_couplers_to_m03_couplers_WREADY <= M_AXI_wready;
  m03_couplers_to_m03_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m03_couplers_to_m03_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity m04_couplers_imp_1K1O8 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end m04_couplers_imp_1K1O8;

architecture STRUCTURE of m04_couplers_imp_1K1O8 is
  signal m04_couplers_to_m04_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m04_couplers_to_m04_couplers_ARREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_ARVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m04_couplers_to_m04_couplers_AWREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_AWVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_BREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_m04_couplers_BVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_RREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_m04_couplers_RVALID : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_m04_couplers_WREADY : STD_LOGIC;
  signal m04_couplers_to_m04_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m04_couplers_to_m04_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= m04_couplers_to_m04_couplers_ARADDR(31 downto 0);
  M_AXI_arprot(2 downto 0) <= m04_couplers_to_m04_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= m04_couplers_to_m04_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= m04_couplers_to_m04_couplers_AWADDR(31 downto 0);
  M_AXI_awprot(2 downto 0) <= m04_couplers_to_m04_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= m04_couplers_to_m04_couplers_AWVALID;
  M_AXI_bready <= m04_couplers_to_m04_couplers_BREADY;
  M_AXI_rready <= m04_couplers_to_m04_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= m04_couplers_to_m04_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= m04_couplers_to_m04_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= m04_couplers_to_m04_couplers_WVALID;
  S_AXI_arready <= m04_couplers_to_m04_couplers_ARREADY;
  S_AXI_awready <= m04_couplers_to_m04_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= m04_couplers_to_m04_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= m04_couplers_to_m04_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= m04_couplers_to_m04_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= m04_couplers_to_m04_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= m04_couplers_to_m04_couplers_RVALID;
  S_AXI_wready <= m04_couplers_to_m04_couplers_WREADY;
  m04_couplers_to_m04_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  m04_couplers_to_m04_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  m04_couplers_to_m04_couplers_ARREADY <= M_AXI_arready;
  m04_couplers_to_m04_couplers_ARVALID <= S_AXI_arvalid;
  m04_couplers_to_m04_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  m04_couplers_to_m04_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  m04_couplers_to_m04_couplers_AWREADY <= M_AXI_awready;
  m04_couplers_to_m04_couplers_AWVALID <= S_AXI_awvalid;
  m04_couplers_to_m04_couplers_BREADY <= S_AXI_bready;
  m04_couplers_to_m04_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  m04_couplers_to_m04_couplers_BVALID <= M_AXI_bvalid;
  m04_couplers_to_m04_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  m04_couplers_to_m04_couplers_RREADY <= S_AXI_rready;
  m04_couplers_to_m04_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  m04_couplers_to_m04_couplers_RVALID <= M_AXI_rvalid;
  m04_couplers_to_m04_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  m04_couplers_to_m04_couplers_WREADY <= M_AXI_wready;
  m04_couplers_to_m04_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  m04_couplers_to_m04_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_1TQAI8W is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_1TQAI8W;

architecture STRUCTURE of s00_couplers_imp_1TQAI8W is
  signal s00_couplers_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_ARREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_AWREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_BVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_RREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_RVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_WREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= s00_couplers_to_s00_couplers_ARADDR(31 downto 0);
  M_AXI_arprot(2 downto 0) <= s00_couplers_to_s00_couplers_ARPROT(2 downto 0);
  M_AXI_arvalid <= s00_couplers_to_s00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= s00_couplers_to_s00_couplers_AWADDR(31 downto 0);
  M_AXI_awprot(2 downto 0) <= s00_couplers_to_s00_couplers_AWPROT(2 downto 0);
  M_AXI_awvalid <= s00_couplers_to_s00_couplers_AWVALID;
  M_AXI_bready <= s00_couplers_to_s00_couplers_BREADY;
  M_AXI_rready <= s00_couplers_to_s00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= s00_couplers_to_s00_couplers_WDATA(31 downto 0);
  M_AXI_wstrb(3 downto 0) <= s00_couplers_to_s00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= s00_couplers_to_s00_couplers_WVALID;
  S_AXI_arready <= s00_couplers_to_s00_couplers_ARREADY;
  S_AXI_awready <= s00_couplers_to_s00_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_s00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_s00_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= s00_couplers_to_s00_couplers_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_s00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_s00_couplers_RVALID;
  S_AXI_wready <= s00_couplers_to_s00_couplers_WREADY;
  s00_couplers_to_s00_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s00_couplers_to_s00_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s00_couplers_to_s00_couplers_ARREADY <= M_AXI_arready;
  s00_couplers_to_s00_couplers_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_s00_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s00_couplers_to_s00_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s00_couplers_to_s00_couplers_AWREADY <= M_AXI_awready;
  s00_couplers_to_s00_couplers_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_s00_couplers_BREADY <= S_AXI_bready;
  s00_couplers_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  s00_couplers_to_s00_couplers_BVALID <= M_AXI_bvalid;
  s00_couplers_to_s00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  s00_couplers_to_s00_couplers_RREADY <= S_AXI_rready;
  s00_couplers_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  s00_couplers_to_s00_couplers_RVALID <= M_AXI_rvalid;
  s00_couplers_to_s00_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s00_couplers_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_s00_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s00_couplers_to_s00_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_1YQ9MOH is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arlock : out STD_LOGIC;
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awlock : out STD_LOGIC;
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rlast : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wlast : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arlock : in STD_LOGIC;
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awlock : in STD_LOGIC;
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_1YQ9MOH;

architecture STRUCTURE of s00_couplers_imp_1YQ9MOH is
  signal s00_couplers_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_s00_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_s00_couplers_ARLOCK : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_ARREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_ARVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_s00_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_s00_couplers_AWLOCK : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_AWREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_AWVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_s00_couplers_BREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_BVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_s00_couplers_RLAST : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_RVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_WLAST : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= s00_couplers_to_s00_couplers_ARADDR(31 downto 0);
  M_AXI_arburst(1 downto 0) <= s00_couplers_to_s00_couplers_ARBURST(1 downto 0);
  M_AXI_arcache(3 downto 0) <= s00_couplers_to_s00_couplers_ARCACHE(3 downto 0);
  M_AXI_arid(0) <= s00_couplers_to_s00_couplers_ARID(0);
  M_AXI_arlen(7 downto 0) <= s00_couplers_to_s00_couplers_ARLEN(7 downto 0);
  M_AXI_arlock <= s00_couplers_to_s00_couplers_ARLOCK;
  M_AXI_arprot(2 downto 0) <= s00_couplers_to_s00_couplers_ARPROT(2 downto 0);
  M_AXI_arqos(3 downto 0) <= s00_couplers_to_s00_couplers_ARQOS(3 downto 0);
  M_AXI_arsize(2 downto 0) <= s00_couplers_to_s00_couplers_ARSIZE(2 downto 0);
  M_AXI_arvalid <= s00_couplers_to_s00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= s00_couplers_to_s00_couplers_AWADDR(31 downto 0);
  M_AXI_awburst(1 downto 0) <= s00_couplers_to_s00_couplers_AWBURST(1 downto 0);
  M_AXI_awcache(3 downto 0) <= s00_couplers_to_s00_couplers_AWCACHE(3 downto 0);
  M_AXI_awid(0) <= s00_couplers_to_s00_couplers_AWID(0);
  M_AXI_awlen(7 downto 0) <= s00_couplers_to_s00_couplers_AWLEN(7 downto 0);
  M_AXI_awlock <= s00_couplers_to_s00_couplers_AWLOCK;
  M_AXI_awprot(2 downto 0) <= s00_couplers_to_s00_couplers_AWPROT(2 downto 0);
  M_AXI_awqos(3 downto 0) <= s00_couplers_to_s00_couplers_AWQOS(3 downto 0);
  M_AXI_awsize(2 downto 0) <= s00_couplers_to_s00_couplers_AWSIZE(2 downto 0);
  M_AXI_awvalid <= s00_couplers_to_s00_couplers_AWVALID;
  M_AXI_bready <= s00_couplers_to_s00_couplers_BREADY;
  M_AXI_rready <= s00_couplers_to_s00_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= s00_couplers_to_s00_couplers_WDATA(31 downto 0);
  M_AXI_wlast <= s00_couplers_to_s00_couplers_WLAST;
  M_AXI_wstrb(3 downto 0) <= s00_couplers_to_s00_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= s00_couplers_to_s00_couplers_WVALID;
  S_AXI_arready <= s00_couplers_to_s00_couplers_ARREADY;
  S_AXI_awready <= s00_couplers_to_s00_couplers_AWREADY;
  S_AXI_bid(0) <= s00_couplers_to_s00_couplers_BID(0);
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_s00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_s00_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= s00_couplers_to_s00_couplers_RDATA(31 downto 0);
  S_AXI_rid(0) <= s00_couplers_to_s00_couplers_RID(0);
  S_AXI_rlast <= s00_couplers_to_s00_couplers_RLAST;
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_s00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_s00_couplers_RVALID;
  S_AXI_wready <= s00_couplers_to_s00_couplers_WREADY;
  s00_couplers_to_s00_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s00_couplers_to_s00_couplers_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  s00_couplers_to_s00_couplers_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  s00_couplers_to_s00_couplers_ARID(0) <= S_AXI_arid(0);
  s00_couplers_to_s00_couplers_ARLEN(7 downto 0) <= S_AXI_arlen(7 downto 0);
  s00_couplers_to_s00_couplers_ARLOCK <= S_AXI_arlock;
  s00_couplers_to_s00_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s00_couplers_to_s00_couplers_ARQOS(3 downto 0) <= S_AXI_arqos(3 downto 0);
  s00_couplers_to_s00_couplers_ARREADY <= M_AXI_arready;
  s00_couplers_to_s00_couplers_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  s00_couplers_to_s00_couplers_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_s00_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s00_couplers_to_s00_couplers_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  s00_couplers_to_s00_couplers_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  s00_couplers_to_s00_couplers_AWID(0) <= S_AXI_awid(0);
  s00_couplers_to_s00_couplers_AWLEN(7 downto 0) <= S_AXI_awlen(7 downto 0);
  s00_couplers_to_s00_couplers_AWLOCK <= S_AXI_awlock;
  s00_couplers_to_s00_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s00_couplers_to_s00_couplers_AWQOS(3 downto 0) <= S_AXI_awqos(3 downto 0);
  s00_couplers_to_s00_couplers_AWREADY <= M_AXI_awready;
  s00_couplers_to_s00_couplers_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  s00_couplers_to_s00_couplers_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_s00_couplers_BID(0) <= M_AXI_bid(0);
  s00_couplers_to_s00_couplers_BREADY <= S_AXI_bready;
  s00_couplers_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  s00_couplers_to_s00_couplers_BVALID <= M_AXI_bvalid;
  s00_couplers_to_s00_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  s00_couplers_to_s00_couplers_RID(0) <= M_AXI_rid(0);
  s00_couplers_to_s00_couplers_RLAST <= M_AXI_rlast;
  s00_couplers_to_s00_couplers_RREADY <= S_AXI_rready;
  s00_couplers_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  s00_couplers_to_s00_couplers_RVALID <= M_AXI_rvalid;
  s00_couplers_to_s00_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s00_couplers_to_s00_couplers_WLAST <= S_AXI_wlast;
  s00_couplers_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_s00_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s00_couplers_to_s00_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s00_couplers_imp_8QTXOC is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_rlast : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_wlast : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s00_couplers_imp_8QTXOC;

architecture STRUCTURE of s00_couplers_imp_8QTXOC is
  signal s00_couplers_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_ARREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_ARVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_s00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_AWREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_s00_couplers_AWVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_BVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal s00_couplers_to_s00_couplers_RLAST : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_s00_couplers_RVALID : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal s00_couplers_to_s00_couplers_WLAST : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WREADY : STD_LOGIC;
  signal s00_couplers_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_s00_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= s00_couplers_to_s00_couplers_ARADDR(31 downto 0);
  M_AXI_arburst(1 downto 0) <= s00_couplers_to_s00_couplers_ARBURST(1 downto 0);
  M_AXI_arcache(3 downto 0) <= s00_couplers_to_s00_couplers_ARCACHE(3 downto 0);
  M_AXI_arlen(3 downto 0) <= s00_couplers_to_s00_couplers_ARLEN(3 downto 0);
  M_AXI_arprot(2 downto 0) <= s00_couplers_to_s00_couplers_ARPROT(2 downto 0);
  M_AXI_arsize(2 downto 0) <= s00_couplers_to_s00_couplers_ARSIZE(2 downto 0);
  M_AXI_arvalid <= s00_couplers_to_s00_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= s00_couplers_to_s00_couplers_AWADDR(31 downto 0);
  M_AXI_awburst(1 downto 0) <= s00_couplers_to_s00_couplers_AWBURST(1 downto 0);
  M_AXI_awcache(3 downto 0) <= s00_couplers_to_s00_couplers_AWCACHE(3 downto 0);
  M_AXI_awlen(3 downto 0) <= s00_couplers_to_s00_couplers_AWLEN(3 downto 0);
  M_AXI_awprot(2 downto 0) <= s00_couplers_to_s00_couplers_AWPROT(2 downto 0);
  M_AXI_awsize(2 downto 0) <= s00_couplers_to_s00_couplers_AWSIZE(2 downto 0);
  M_AXI_awvalid <= s00_couplers_to_s00_couplers_AWVALID;
  M_AXI_bready <= s00_couplers_to_s00_couplers_BREADY;
  M_AXI_rready <= s00_couplers_to_s00_couplers_RREADY;
  M_AXI_wdata(63 downto 0) <= s00_couplers_to_s00_couplers_WDATA(63 downto 0);
  M_AXI_wlast <= s00_couplers_to_s00_couplers_WLAST;
  M_AXI_wstrb(7 downto 0) <= s00_couplers_to_s00_couplers_WSTRB(7 downto 0);
  M_AXI_wvalid <= s00_couplers_to_s00_couplers_WVALID;
  S_AXI_arready <= s00_couplers_to_s00_couplers_ARREADY;
  S_AXI_awready <= s00_couplers_to_s00_couplers_AWREADY;
  S_AXI_bresp(1 downto 0) <= s00_couplers_to_s00_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= s00_couplers_to_s00_couplers_BVALID;
  S_AXI_rdata(63 downto 0) <= s00_couplers_to_s00_couplers_RDATA(63 downto 0);
  S_AXI_rlast <= s00_couplers_to_s00_couplers_RLAST;
  S_AXI_rresp(1 downto 0) <= s00_couplers_to_s00_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= s00_couplers_to_s00_couplers_RVALID;
  S_AXI_wready <= s00_couplers_to_s00_couplers_WREADY;
  s00_couplers_to_s00_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s00_couplers_to_s00_couplers_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  s00_couplers_to_s00_couplers_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  s00_couplers_to_s00_couplers_ARLEN(3 downto 0) <= S_AXI_arlen(3 downto 0);
  s00_couplers_to_s00_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s00_couplers_to_s00_couplers_ARREADY <= M_AXI_arready;
  s00_couplers_to_s00_couplers_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  s00_couplers_to_s00_couplers_ARVALID <= S_AXI_arvalid;
  s00_couplers_to_s00_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s00_couplers_to_s00_couplers_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  s00_couplers_to_s00_couplers_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  s00_couplers_to_s00_couplers_AWLEN(3 downto 0) <= S_AXI_awlen(3 downto 0);
  s00_couplers_to_s00_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s00_couplers_to_s00_couplers_AWREADY <= M_AXI_awready;
  s00_couplers_to_s00_couplers_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  s00_couplers_to_s00_couplers_AWVALID <= S_AXI_awvalid;
  s00_couplers_to_s00_couplers_BREADY <= S_AXI_bready;
  s00_couplers_to_s00_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  s00_couplers_to_s00_couplers_BVALID <= M_AXI_bvalid;
  s00_couplers_to_s00_couplers_RDATA(63 downto 0) <= M_AXI_rdata(63 downto 0);
  s00_couplers_to_s00_couplers_RLAST <= M_AXI_rlast;
  s00_couplers_to_s00_couplers_RREADY <= S_AXI_rready;
  s00_couplers_to_s00_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  s00_couplers_to_s00_couplers_RVALID <= M_AXI_rvalid;
  s00_couplers_to_s00_couplers_WDATA(63 downto 0) <= S_AXI_wdata(63 downto 0);
  s00_couplers_to_s00_couplers_WLAST <= S_AXI_wlast;
  s00_couplers_to_s00_couplers_WREADY <= M_AXI_wready;
  s00_couplers_to_s00_couplers_WSTRB(7 downto 0) <= S_AXI_wstrb(7 downto 0);
  s00_couplers_to_s00_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s01_couplers_imp_4RDUEN is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arlock : out STD_LOGIC;
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awlock : out STD_LOGIC;
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_rlast : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wlast : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arlock : in STD_LOGIC;
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awlock : in STD_LOGIC;
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s01_couplers_imp_4RDUEN;

architecture STRUCTURE of s01_couplers_imp_4RDUEN is
  signal s01_couplers_to_s01_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_s01_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_s01_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_s01_couplers_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_s01_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s01_couplers_to_s01_couplers_ARLOCK : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_s01_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_s01_couplers_ARREADY : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_s01_couplers_ARVALID : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_s01_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_s01_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_s01_couplers_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_s01_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s01_couplers_to_s01_couplers_AWLOCK : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_s01_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_s01_couplers_AWREADY : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_s01_couplers_AWVALID : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_s01_couplers_BREADY : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_s01_couplers_BVALID : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_s01_couplers_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_s01_couplers_RLAST : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_RREADY : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_s01_couplers_RVALID : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_s01_couplers_WLAST : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_WREADY : STD_LOGIC;
  signal s01_couplers_to_s01_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_s01_couplers_WVALID : STD_LOGIC;
begin
  M_AXI_araddr(31 downto 0) <= s01_couplers_to_s01_couplers_ARADDR(31 downto 0);
  M_AXI_arburst(1 downto 0) <= s01_couplers_to_s01_couplers_ARBURST(1 downto 0);
  M_AXI_arcache(3 downto 0) <= s01_couplers_to_s01_couplers_ARCACHE(3 downto 0);
  M_AXI_arid(0) <= s01_couplers_to_s01_couplers_ARID(0);
  M_AXI_arlen(7 downto 0) <= s01_couplers_to_s01_couplers_ARLEN(7 downto 0);
  M_AXI_arlock <= s01_couplers_to_s01_couplers_ARLOCK;
  M_AXI_arprot(2 downto 0) <= s01_couplers_to_s01_couplers_ARPROT(2 downto 0);
  M_AXI_arqos(3 downto 0) <= s01_couplers_to_s01_couplers_ARQOS(3 downto 0);
  M_AXI_arsize(2 downto 0) <= s01_couplers_to_s01_couplers_ARSIZE(2 downto 0);
  M_AXI_arvalid <= s01_couplers_to_s01_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= s01_couplers_to_s01_couplers_AWADDR(31 downto 0);
  M_AXI_awburst(1 downto 0) <= s01_couplers_to_s01_couplers_AWBURST(1 downto 0);
  M_AXI_awcache(3 downto 0) <= s01_couplers_to_s01_couplers_AWCACHE(3 downto 0);
  M_AXI_awid(0) <= s01_couplers_to_s01_couplers_AWID(0);
  M_AXI_awlen(7 downto 0) <= s01_couplers_to_s01_couplers_AWLEN(7 downto 0);
  M_AXI_awlock <= s01_couplers_to_s01_couplers_AWLOCK;
  M_AXI_awprot(2 downto 0) <= s01_couplers_to_s01_couplers_AWPROT(2 downto 0);
  M_AXI_awqos(3 downto 0) <= s01_couplers_to_s01_couplers_AWQOS(3 downto 0);
  M_AXI_awsize(2 downto 0) <= s01_couplers_to_s01_couplers_AWSIZE(2 downto 0);
  M_AXI_awvalid <= s01_couplers_to_s01_couplers_AWVALID;
  M_AXI_bready <= s01_couplers_to_s01_couplers_BREADY;
  M_AXI_rready <= s01_couplers_to_s01_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= s01_couplers_to_s01_couplers_WDATA(31 downto 0);
  M_AXI_wlast <= s01_couplers_to_s01_couplers_WLAST;
  M_AXI_wstrb(3 downto 0) <= s01_couplers_to_s01_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= s01_couplers_to_s01_couplers_WVALID;
  S_AXI_arready <= s01_couplers_to_s01_couplers_ARREADY;
  S_AXI_awready <= s01_couplers_to_s01_couplers_AWREADY;
  S_AXI_bid(0) <= s01_couplers_to_s01_couplers_BID(0);
  S_AXI_bresp(1 downto 0) <= s01_couplers_to_s01_couplers_BRESP(1 downto 0);
  S_AXI_bvalid <= s01_couplers_to_s01_couplers_BVALID;
  S_AXI_rdata(31 downto 0) <= s01_couplers_to_s01_couplers_RDATA(31 downto 0);
  S_AXI_rid(0) <= s01_couplers_to_s01_couplers_RID(0);
  S_AXI_rlast <= s01_couplers_to_s01_couplers_RLAST;
  S_AXI_rresp(1 downto 0) <= s01_couplers_to_s01_couplers_RRESP(1 downto 0);
  S_AXI_rvalid <= s01_couplers_to_s01_couplers_RVALID;
  S_AXI_wready <= s01_couplers_to_s01_couplers_WREADY;
  s01_couplers_to_s01_couplers_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s01_couplers_to_s01_couplers_ARBURST(1 downto 0) <= S_AXI_arburst(1 downto 0);
  s01_couplers_to_s01_couplers_ARCACHE(3 downto 0) <= S_AXI_arcache(3 downto 0);
  s01_couplers_to_s01_couplers_ARID(0) <= S_AXI_arid(0);
  s01_couplers_to_s01_couplers_ARLEN(7 downto 0) <= S_AXI_arlen(7 downto 0);
  s01_couplers_to_s01_couplers_ARLOCK <= S_AXI_arlock;
  s01_couplers_to_s01_couplers_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s01_couplers_to_s01_couplers_ARQOS(3 downto 0) <= S_AXI_arqos(3 downto 0);
  s01_couplers_to_s01_couplers_ARREADY <= M_AXI_arready;
  s01_couplers_to_s01_couplers_ARSIZE(2 downto 0) <= S_AXI_arsize(2 downto 0);
  s01_couplers_to_s01_couplers_ARVALID <= S_AXI_arvalid;
  s01_couplers_to_s01_couplers_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s01_couplers_to_s01_couplers_AWBURST(1 downto 0) <= S_AXI_awburst(1 downto 0);
  s01_couplers_to_s01_couplers_AWCACHE(3 downto 0) <= S_AXI_awcache(3 downto 0);
  s01_couplers_to_s01_couplers_AWID(0) <= S_AXI_awid(0);
  s01_couplers_to_s01_couplers_AWLEN(7 downto 0) <= S_AXI_awlen(7 downto 0);
  s01_couplers_to_s01_couplers_AWLOCK <= S_AXI_awlock;
  s01_couplers_to_s01_couplers_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s01_couplers_to_s01_couplers_AWQOS(3 downto 0) <= S_AXI_awqos(3 downto 0);
  s01_couplers_to_s01_couplers_AWREADY <= M_AXI_awready;
  s01_couplers_to_s01_couplers_AWSIZE(2 downto 0) <= S_AXI_awsize(2 downto 0);
  s01_couplers_to_s01_couplers_AWVALID <= S_AXI_awvalid;
  s01_couplers_to_s01_couplers_BID(0) <= M_AXI_bid(0);
  s01_couplers_to_s01_couplers_BREADY <= S_AXI_bready;
  s01_couplers_to_s01_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  s01_couplers_to_s01_couplers_BVALID <= M_AXI_bvalid;
  s01_couplers_to_s01_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  s01_couplers_to_s01_couplers_RID(0) <= M_AXI_rid(0);
  s01_couplers_to_s01_couplers_RLAST <= M_AXI_rlast;
  s01_couplers_to_s01_couplers_RREADY <= S_AXI_rready;
  s01_couplers_to_s01_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  s01_couplers_to_s01_couplers_RVALID <= M_AXI_rvalid;
  s01_couplers_to_s01_couplers_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s01_couplers_to_s01_couplers_WLAST <= S_AXI_wlast;
  s01_couplers_to_s01_couplers_WREADY <= M_AXI_wready;
  s01_couplers_to_s01_couplers_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s01_couplers_to_s01_couplers_WVALID <= S_AXI_wvalid;
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity s02_couplers_imp_1XEF8Z0 is
  port (
    M_ACLK : in STD_LOGIC;
    M_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_arready : in STD_LOGIC;
    M_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_arvalid : out STD_LOGIC;
    M_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_awready : in STD_LOGIC;
    M_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_awvalid : out STD_LOGIC;
    M_AXI_bready : out STD_LOGIC;
    M_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_bvalid : in STD_LOGIC;
    M_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_rlast : in STD_LOGIC;
    M_AXI_rready : out STD_LOGIC;
    M_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_rvalid : in STD_LOGIC;
    M_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_wlast : out STD_LOGIC;
    M_AXI_wready : in STD_LOGIC;
    M_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_wvalid : out STD_LOGIC;
    S_ACLK : in STD_LOGIC;
    S_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_wvalid : in STD_LOGIC
  );
end s02_couplers_imp_1XEF8Z0;

architecture STRUCTURE of s02_couplers_imp_1XEF8Z0 is
  component system_auto_pc_2 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component system_auto_pc_2;
  signal S_ACLK_1 : STD_LOGIC;
  signal S_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_pc_to_s02_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s02_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s02_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s02_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal auto_pc_to_s02_couplers_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_pc_to_s02_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s02_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s02_couplers_ARREADY : STD_LOGIC;
  signal auto_pc_to_s02_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s02_couplers_ARVALID : STD_LOGIC;
  signal auto_pc_to_s02_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s02_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s02_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s02_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal auto_pc_to_s02_couplers_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal auto_pc_to_s02_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s02_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s02_couplers_AWREADY : STD_LOGIC;
  signal auto_pc_to_s02_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal auto_pc_to_s02_couplers_AWVALID : STD_LOGIC;
  signal auto_pc_to_s02_couplers_BREADY : STD_LOGIC;
  signal auto_pc_to_s02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s02_couplers_BVALID : STD_LOGIC;
  signal auto_pc_to_s02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s02_couplers_RLAST : STD_LOGIC;
  signal auto_pc_to_s02_couplers_RREADY : STD_LOGIC;
  signal auto_pc_to_s02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal auto_pc_to_s02_couplers_RVALID : STD_LOGIC;
  signal auto_pc_to_s02_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal auto_pc_to_s02_couplers_WLAST : STD_LOGIC;
  signal auto_pc_to_s02_couplers_WREADY : STD_LOGIC;
  signal auto_pc_to_s02_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal auto_pc_to_s02_couplers_WVALID : STD_LOGIC;
  signal s02_couplers_to_auto_pc_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_auto_pc_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s02_couplers_to_auto_pc_ARREADY : STD_LOGIC;
  signal s02_couplers_to_auto_pc_ARVALID : STD_LOGIC;
  signal s02_couplers_to_auto_pc_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_auto_pc_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s02_couplers_to_auto_pc_AWREADY : STD_LOGIC;
  signal s02_couplers_to_auto_pc_AWVALID : STD_LOGIC;
  signal s02_couplers_to_auto_pc_BREADY : STD_LOGIC;
  signal s02_couplers_to_auto_pc_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s02_couplers_to_auto_pc_BVALID : STD_LOGIC;
  signal s02_couplers_to_auto_pc_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_auto_pc_RREADY : STD_LOGIC;
  signal s02_couplers_to_auto_pc_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s02_couplers_to_auto_pc_RVALID : STD_LOGIC;
  signal s02_couplers_to_auto_pc_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_auto_pc_WREADY : STD_LOGIC;
  signal s02_couplers_to_auto_pc_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s02_couplers_to_auto_pc_WVALID : STD_LOGIC;
  signal NLW_auto_pc_m_axi_arregion_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_auto_pc_m_axi_awregion_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
begin
  M_AXI_araddr(31 downto 0) <= auto_pc_to_s02_couplers_ARADDR(31 downto 0);
  M_AXI_arburst(1 downto 0) <= auto_pc_to_s02_couplers_ARBURST(1 downto 0);
  M_AXI_arcache(3 downto 0) <= auto_pc_to_s02_couplers_ARCACHE(3 downto 0);
  M_AXI_arlen(7 downto 0) <= auto_pc_to_s02_couplers_ARLEN(7 downto 0);
  M_AXI_arlock(0) <= auto_pc_to_s02_couplers_ARLOCK(0);
  M_AXI_arprot(2 downto 0) <= auto_pc_to_s02_couplers_ARPROT(2 downto 0);
  M_AXI_arqos(3 downto 0) <= auto_pc_to_s02_couplers_ARQOS(3 downto 0);
  M_AXI_arsize(2 downto 0) <= auto_pc_to_s02_couplers_ARSIZE(2 downto 0);
  M_AXI_arvalid <= auto_pc_to_s02_couplers_ARVALID;
  M_AXI_awaddr(31 downto 0) <= auto_pc_to_s02_couplers_AWADDR(31 downto 0);
  M_AXI_awburst(1 downto 0) <= auto_pc_to_s02_couplers_AWBURST(1 downto 0);
  M_AXI_awcache(3 downto 0) <= auto_pc_to_s02_couplers_AWCACHE(3 downto 0);
  M_AXI_awlen(7 downto 0) <= auto_pc_to_s02_couplers_AWLEN(7 downto 0);
  M_AXI_awlock(0) <= auto_pc_to_s02_couplers_AWLOCK(0);
  M_AXI_awprot(2 downto 0) <= auto_pc_to_s02_couplers_AWPROT(2 downto 0);
  M_AXI_awqos(3 downto 0) <= auto_pc_to_s02_couplers_AWQOS(3 downto 0);
  M_AXI_awsize(2 downto 0) <= auto_pc_to_s02_couplers_AWSIZE(2 downto 0);
  M_AXI_awvalid <= auto_pc_to_s02_couplers_AWVALID;
  M_AXI_bready <= auto_pc_to_s02_couplers_BREADY;
  M_AXI_rready <= auto_pc_to_s02_couplers_RREADY;
  M_AXI_wdata(31 downto 0) <= auto_pc_to_s02_couplers_WDATA(31 downto 0);
  M_AXI_wlast <= auto_pc_to_s02_couplers_WLAST;
  M_AXI_wstrb(3 downto 0) <= auto_pc_to_s02_couplers_WSTRB(3 downto 0);
  M_AXI_wvalid <= auto_pc_to_s02_couplers_WVALID;
  S_ACLK_1 <= S_ACLK;
  S_ARESETN_1(0) <= S_ARESETN(0);
  S_AXI_arready <= s02_couplers_to_auto_pc_ARREADY;
  S_AXI_awready <= s02_couplers_to_auto_pc_AWREADY;
  S_AXI_bresp(1 downto 0) <= s02_couplers_to_auto_pc_BRESP(1 downto 0);
  S_AXI_bvalid <= s02_couplers_to_auto_pc_BVALID;
  S_AXI_rdata(31 downto 0) <= s02_couplers_to_auto_pc_RDATA(31 downto 0);
  S_AXI_rresp(1 downto 0) <= s02_couplers_to_auto_pc_RRESP(1 downto 0);
  S_AXI_rvalid <= s02_couplers_to_auto_pc_RVALID;
  S_AXI_wready <= s02_couplers_to_auto_pc_WREADY;
  auto_pc_to_s02_couplers_ARREADY <= M_AXI_arready;
  auto_pc_to_s02_couplers_AWREADY <= M_AXI_awready;
  auto_pc_to_s02_couplers_BRESP(1 downto 0) <= M_AXI_bresp(1 downto 0);
  auto_pc_to_s02_couplers_BVALID <= M_AXI_bvalid;
  auto_pc_to_s02_couplers_RDATA(31 downto 0) <= M_AXI_rdata(31 downto 0);
  auto_pc_to_s02_couplers_RLAST <= M_AXI_rlast;
  auto_pc_to_s02_couplers_RRESP(1 downto 0) <= M_AXI_rresp(1 downto 0);
  auto_pc_to_s02_couplers_RVALID <= M_AXI_rvalid;
  auto_pc_to_s02_couplers_WREADY <= M_AXI_wready;
  s02_couplers_to_auto_pc_ARADDR(31 downto 0) <= S_AXI_araddr(31 downto 0);
  s02_couplers_to_auto_pc_ARPROT(2 downto 0) <= S_AXI_arprot(2 downto 0);
  s02_couplers_to_auto_pc_ARVALID <= S_AXI_arvalid;
  s02_couplers_to_auto_pc_AWADDR(31 downto 0) <= S_AXI_awaddr(31 downto 0);
  s02_couplers_to_auto_pc_AWPROT(2 downto 0) <= S_AXI_awprot(2 downto 0);
  s02_couplers_to_auto_pc_AWVALID <= S_AXI_awvalid;
  s02_couplers_to_auto_pc_BREADY <= S_AXI_bready;
  s02_couplers_to_auto_pc_RREADY <= S_AXI_rready;
  s02_couplers_to_auto_pc_WDATA(31 downto 0) <= S_AXI_wdata(31 downto 0);
  s02_couplers_to_auto_pc_WSTRB(3 downto 0) <= S_AXI_wstrb(3 downto 0);
  s02_couplers_to_auto_pc_WVALID <= S_AXI_wvalid;
auto_pc: component system_auto_pc_2
    port map (
      aclk => S_ACLK_1,
      aresetn => S_ARESETN_1(0),
      m_axi_araddr(31 downto 0) => auto_pc_to_s02_couplers_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => auto_pc_to_s02_couplers_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => auto_pc_to_s02_couplers_ARCACHE(3 downto 0),
      m_axi_arlen(7 downto 0) => auto_pc_to_s02_couplers_ARLEN(7 downto 0),
      m_axi_arlock(0) => auto_pc_to_s02_couplers_ARLOCK(0),
      m_axi_arprot(2 downto 0) => auto_pc_to_s02_couplers_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => auto_pc_to_s02_couplers_ARQOS(3 downto 0),
      m_axi_arready => auto_pc_to_s02_couplers_ARREADY,
      m_axi_arregion(3 downto 0) => NLW_auto_pc_m_axi_arregion_UNCONNECTED(3 downto 0),
      m_axi_arsize(2 downto 0) => auto_pc_to_s02_couplers_ARSIZE(2 downto 0),
      m_axi_arvalid => auto_pc_to_s02_couplers_ARVALID,
      m_axi_awaddr(31 downto 0) => auto_pc_to_s02_couplers_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => auto_pc_to_s02_couplers_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => auto_pc_to_s02_couplers_AWCACHE(3 downto 0),
      m_axi_awlen(7 downto 0) => auto_pc_to_s02_couplers_AWLEN(7 downto 0),
      m_axi_awlock(0) => auto_pc_to_s02_couplers_AWLOCK(0),
      m_axi_awprot(2 downto 0) => auto_pc_to_s02_couplers_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => auto_pc_to_s02_couplers_AWQOS(3 downto 0),
      m_axi_awready => auto_pc_to_s02_couplers_AWREADY,
      m_axi_awregion(3 downto 0) => NLW_auto_pc_m_axi_awregion_UNCONNECTED(3 downto 0),
      m_axi_awsize(2 downto 0) => auto_pc_to_s02_couplers_AWSIZE(2 downto 0),
      m_axi_awvalid => auto_pc_to_s02_couplers_AWVALID,
      m_axi_bready => auto_pc_to_s02_couplers_BREADY,
      m_axi_bresp(1 downto 0) => auto_pc_to_s02_couplers_BRESP(1 downto 0),
      m_axi_bvalid => auto_pc_to_s02_couplers_BVALID,
      m_axi_rdata(31 downto 0) => auto_pc_to_s02_couplers_RDATA(31 downto 0),
      m_axi_rlast => auto_pc_to_s02_couplers_RLAST,
      m_axi_rready => auto_pc_to_s02_couplers_RREADY,
      m_axi_rresp(1 downto 0) => auto_pc_to_s02_couplers_RRESP(1 downto 0),
      m_axi_rvalid => auto_pc_to_s02_couplers_RVALID,
      m_axi_wdata(31 downto 0) => auto_pc_to_s02_couplers_WDATA(31 downto 0),
      m_axi_wlast => auto_pc_to_s02_couplers_WLAST,
      m_axi_wready => auto_pc_to_s02_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => auto_pc_to_s02_couplers_WSTRB(3 downto 0),
      m_axi_wvalid => auto_pc_to_s02_couplers_WVALID,
      s_axi_araddr(31 downto 0) => s02_couplers_to_auto_pc_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => s02_couplers_to_auto_pc_ARPROT(2 downto 0),
      s_axi_arready => s02_couplers_to_auto_pc_ARREADY,
      s_axi_arvalid => s02_couplers_to_auto_pc_ARVALID,
      s_axi_awaddr(31 downto 0) => s02_couplers_to_auto_pc_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => s02_couplers_to_auto_pc_AWPROT(2 downto 0),
      s_axi_awready => s02_couplers_to_auto_pc_AWREADY,
      s_axi_awvalid => s02_couplers_to_auto_pc_AWVALID,
      s_axi_bready => s02_couplers_to_auto_pc_BREADY,
      s_axi_bresp(1 downto 0) => s02_couplers_to_auto_pc_BRESP(1 downto 0),
      s_axi_bvalid => s02_couplers_to_auto_pc_BVALID,
      s_axi_rdata(31 downto 0) => s02_couplers_to_auto_pc_RDATA(31 downto 0),
      s_axi_rready => s02_couplers_to_auto_pc_RREADY,
      s_axi_rresp(1 downto 0) => s02_couplers_to_auto_pc_RRESP(1 downto 0),
      s_axi_rvalid => s02_couplers_to_auto_pc_RVALID,
      s_axi_wdata(31 downto 0) => s02_couplers_to_auto_pc_WDATA(31 downto 0),
      s_axi_wready => s02_couplers_to_auto_pc_WREADY,
      s_axi_wstrb(3 downto 0) => s02_couplers_to_auto_pc_WSTRB(3 downto 0),
      s_axi_wvalid => s02_couplers_to_auto_pc_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_axi4lite_0_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rready : out STD_LOGIC;
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    M01_ACLK : in STD_LOGIC;
    M01_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M01_AXI_araddr : out STD_LOGIC_VECTOR ( 4 downto 0 );
    M01_AXI_arready : in STD_LOGIC;
    M01_AXI_arvalid : out STD_LOGIC;
    M01_AXI_awaddr : out STD_LOGIC_VECTOR ( 4 downto 0 );
    M01_AXI_awready : in STD_LOGIC;
    M01_AXI_awvalid : out STD_LOGIC;
    M01_AXI_bready : out STD_LOGIC;
    M01_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_bvalid : in STD_LOGIC;
    M01_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_rready : out STD_LOGIC;
    M01_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_rvalid : in STD_LOGIC;
    M01_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_wready : in STD_LOGIC;
    M01_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M01_AXI_wvalid : out STD_LOGIC;
    M02_ACLK : in STD_LOGIC;
    M02_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M02_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M02_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_arready : in STD_LOGIC;
    M02_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M02_AXI_arvalid : out STD_LOGIC;
    M02_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M02_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_awready : in STD_LOGIC;
    M02_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M02_AXI_awvalid : out STD_LOGIC;
    M02_AXI_bready : out STD_LOGIC;
    M02_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_bvalid : in STD_LOGIC;
    M02_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_rlast : in STD_LOGIC;
    M02_AXI_rready : out STD_LOGIC;
    M02_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_rvalid : in STD_LOGIC;
    M02_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_wlast : out STD_LOGIC;
    M02_AXI_wready : in STD_LOGIC;
    M02_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_wvalid : out STD_LOGIC;
    M03_ACLK : in STD_LOGIC;
    M03_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M03_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_arready : in STD_LOGIC;
    M03_AXI_arvalid : out STD_LOGIC;
    M03_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_awready : in STD_LOGIC;
    M03_AXI_awvalid : out STD_LOGIC;
    M03_AXI_bready : out STD_LOGIC;
    M03_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_bvalid : in STD_LOGIC;
    M03_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_rready : out STD_LOGIC;
    M03_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_rvalid : in STD_LOGIC;
    M03_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_wready : in STD_LOGIC;
    M03_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_wvalid : out STD_LOGIC;
    M04_ACLK : in STD_LOGIC;
    M04_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M04_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M04_AXI_arready : in STD_LOGIC;
    M04_AXI_arvalid : out STD_LOGIC;
    M04_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M04_AXI_awready : in STD_LOGIC;
    M04_AXI_awvalid : out STD_LOGIC;
    M04_AXI_bready : out STD_LOGIC;
    M04_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_bvalid : in STD_LOGIC;
    M04_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_rready : out STD_LOGIC;
    M04_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_rvalid : in STD_LOGIC;
    M04_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_wready : in STD_LOGIC;
    M04_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M04_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC
  );
end system_axi4lite_0_0;

architecture STRUCTURE of system_axi4lite_0_0 is
  component system_xbar_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 14 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 19 downto 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 14 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 159 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 9 downto 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 4 downto 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 4 downto 0 )
  );
  end component system_xbar_0;
  component system_s00_mmu_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component system_s00_mmu_0;
  signal M00_ACLK_1 : STD_LOGIC;
  signal M00_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal M01_ACLK_1 : STD_LOGIC;
  signal M01_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal M02_ACLK_1 : STD_LOGIC;
  signal M02_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal M03_ACLK_1 : STD_LOGIC;
  signal M03_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal M04_ACLK_1 : STD_LOGIC;
  signal M04_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal S00_ACLK_1 : STD_LOGIC;
  signal S00_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal S00_AXI_1_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S00_AXI_1_ARREADY : STD_LOGIC;
  signal S00_AXI_1_ARVALID : STD_LOGIC;
  signal S00_AXI_1_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S00_AXI_1_AWREADY : STD_LOGIC;
  signal S00_AXI_1_AWVALID : STD_LOGIC;
  signal S00_AXI_1_BREADY : STD_LOGIC;
  signal S00_AXI_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal S00_AXI_1_BVALID : STD_LOGIC;
  signal S00_AXI_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_RREADY : STD_LOGIC;
  signal S00_AXI_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal S00_AXI_1_RVALID : STD_LOGIC;
  signal S00_AXI_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_WREADY : STD_LOGIC;
  signal S00_AXI_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal S00_AXI_1_WVALID : STD_LOGIC;
  signal axi4lite_0_ACLK_net : STD_LOGIC;
  signal axi4lite_0_ARESETN_net : STD_LOGIC_VECTOR ( 0 to 0 );
  signal m00_couplers_to_axi4lite_0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi4lite_0_ARREADY : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_ARVALID : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi4lite_0_AWREADY : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_AWVALID : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_BREADY : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi4lite_0_BVALID : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi4lite_0_RREADY : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi4lite_0_RVALID : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi4lite_0_WREADY : STD_LOGIC;
  signal m00_couplers_to_axi4lite_0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi4lite_0_WVALID : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_ARADDR : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal m01_couplers_to_axi4lite_0_ARREADY : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_ARVALID : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_AWADDR : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal m01_couplers_to_axi4lite_0_AWREADY : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_AWVALID : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_BREADY : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_axi4lite_0_BVALID : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_axi4lite_0_RREADY : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m01_couplers_to_axi4lite_0_RVALID : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m01_couplers_to_axi4lite_0_WREADY : STD_LOGIC;
  signal m01_couplers_to_axi4lite_0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m01_couplers_to_axi4lite_0_WVALID : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARREADY : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m02_couplers_to_axi4lite_0_ARVALID : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWREADY : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m02_couplers_to_axi4lite_0_AWVALID : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_BREADY : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_axi4lite_0_BVALID : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_axi4lite_0_RLAST : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_RREADY : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m02_couplers_to_axi4lite_0_RVALID : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m02_couplers_to_axi4lite_0_WLAST : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_WREADY : STD_LOGIC;
  signal m02_couplers_to_axi4lite_0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m02_couplers_to_axi4lite_0_WVALID : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_axi4lite_0_ARREADY : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_ARVALID : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_axi4lite_0_AWREADY : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_AWVALID : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_BREADY : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_axi4lite_0_BVALID : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_axi4lite_0_RREADY : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m03_couplers_to_axi4lite_0_RVALID : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m03_couplers_to_axi4lite_0_WREADY : STD_LOGIC;
  signal m03_couplers_to_axi4lite_0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m03_couplers_to_axi4lite_0_WVALID : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_axi4lite_0_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m04_couplers_to_axi4lite_0_ARREADY : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_ARVALID : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_axi4lite_0_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m04_couplers_to_axi4lite_0_AWREADY : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_AWVALID : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_BREADY : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_axi4lite_0_BVALID : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_axi4lite_0_RREADY : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m04_couplers_to_axi4lite_0_RVALID : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m04_couplers_to_axi4lite_0_WREADY : STD_LOGIC;
  signal m04_couplers_to_axi4lite_0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m04_couplers_to_axi4lite_0_WVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_WVALID : STD_LOGIC;
  signal s00_mmu_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_mmu_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_mmu_M_AXI_ARREADY : STD_LOGIC;
  signal s00_mmu_M_AXI_ARVALID : STD_LOGIC;
  signal s00_mmu_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_mmu_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_mmu_M_AXI_AWREADY : STD_LOGIC;
  signal s00_mmu_M_AXI_AWVALID : STD_LOGIC;
  signal s00_mmu_M_AXI_BREADY : STD_LOGIC;
  signal s00_mmu_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_mmu_M_AXI_BVALID : STD_LOGIC;
  signal s00_mmu_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_mmu_M_AXI_RREADY : STD_LOGIC;
  signal s00_mmu_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_mmu_M_AXI_RVALID : STD_LOGIC;
  signal s00_mmu_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_mmu_M_AXI_WREADY : STD_LOGIC;
  signal s00_mmu_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_mmu_M_AXI_WVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m01_couplers_ARADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_ARVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_AWADDR : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_AWVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m01_couplers_RREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m01_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m01_couplers_WDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal xbar_to_m01_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m01_couplers_WSTRB : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal xbar_to_m01_couplers_WVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal xbar_to_m02_couplers_ARADDR : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_ARPROT : STD_LOGIC_VECTOR ( 8 downto 6 );
  signal xbar_to_m02_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_ARVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_AWADDR : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_AWPROT : STD_LOGIC_VECTOR ( 8 downto 6 );
  signal xbar_to_m02_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_AWVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_BREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m02_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m02_couplers_RREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m02_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m02_couplers_WDATA : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal xbar_to_m02_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m02_couplers_WSTRB : STD_LOGIC_VECTOR ( 11 downto 8 );
  signal xbar_to_m02_couplers_WVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal xbar_to_m03_couplers_ARADDR : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_ARVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_AWADDR : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_AWVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_BREADY : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m03_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m03_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m03_couplers_RREADY : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m03_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m03_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m03_couplers_WDATA : STD_LOGIC_VECTOR ( 127 downto 96 );
  signal xbar_to_m03_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m03_couplers_WSTRB : STD_LOGIC_VECTOR ( 15 downto 12 );
  signal xbar_to_m03_couplers_WVALID : STD_LOGIC_VECTOR ( 3 to 3 );
  signal xbar_to_m04_couplers_ARADDR : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_ARPROT : STD_LOGIC_VECTOR ( 14 downto 12 );
  signal xbar_to_m04_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_ARVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_AWADDR : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_AWPROT : STD_LOGIC_VECTOR ( 14 downto 12 );
  signal xbar_to_m04_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_AWVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_BREADY : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m04_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m04_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m04_couplers_RREADY : STD_LOGIC_VECTOR ( 4 to 4 );
  signal xbar_to_m04_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m04_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m04_couplers_WDATA : STD_LOGIC_VECTOR ( 159 downto 128 );
  signal xbar_to_m04_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m04_couplers_WSTRB : STD_LOGIC_VECTOR ( 19 downto 16 );
  signal xbar_to_m04_couplers_WVALID : STD_LOGIC_VECTOR ( 4 to 4 );
  signal NLW_xbar_m_axi_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_xbar_m_axi_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
begin
  M00_ACLK_1 <= M00_ACLK;
  M00_ARESETN_1(0) <= M00_ARESETN(0);
  M00_AXI_araddr(31 downto 0) <= m00_couplers_to_axi4lite_0_ARADDR(31 downto 0);
  M00_AXI_arvalid <= m00_couplers_to_axi4lite_0_ARVALID;
  M00_AXI_awaddr(31 downto 0) <= m00_couplers_to_axi4lite_0_AWADDR(31 downto 0);
  M00_AXI_awvalid <= m00_couplers_to_axi4lite_0_AWVALID;
  M00_AXI_bready <= m00_couplers_to_axi4lite_0_BREADY;
  M00_AXI_rready <= m00_couplers_to_axi4lite_0_RREADY;
  M00_AXI_wdata(31 downto 0) <= m00_couplers_to_axi4lite_0_WDATA(31 downto 0);
  M00_AXI_wstrb(3 downto 0) <= m00_couplers_to_axi4lite_0_WSTRB(3 downto 0);
  M00_AXI_wvalid <= m00_couplers_to_axi4lite_0_WVALID;
  M01_ACLK_1 <= M01_ACLK;
  M01_ARESETN_1(0) <= M01_ARESETN(0);
  M01_AXI_araddr(4 downto 0) <= m01_couplers_to_axi4lite_0_ARADDR(4 downto 0);
  M01_AXI_arvalid <= m01_couplers_to_axi4lite_0_ARVALID;
  M01_AXI_awaddr(4 downto 0) <= m01_couplers_to_axi4lite_0_AWADDR(4 downto 0);
  M01_AXI_awvalid <= m01_couplers_to_axi4lite_0_AWVALID;
  M01_AXI_bready <= m01_couplers_to_axi4lite_0_BREADY;
  M01_AXI_rready <= m01_couplers_to_axi4lite_0_RREADY;
  M01_AXI_wdata(31 downto 0) <= m01_couplers_to_axi4lite_0_WDATA(31 downto 0);
  M01_AXI_wstrb(3 downto 0) <= m01_couplers_to_axi4lite_0_WSTRB(3 downto 0);
  M01_AXI_wvalid <= m01_couplers_to_axi4lite_0_WVALID;
  M02_ACLK_1 <= M02_ACLK;
  M02_ARESETN_1(0) <= M02_ARESETN(0);
  M02_AXI_araddr(31 downto 0) <= m02_couplers_to_axi4lite_0_ARADDR(31 downto 0);
  M02_AXI_arburst(1 downto 0) <= m02_couplers_to_axi4lite_0_ARBURST(1 downto 0);
  M02_AXI_arcache(3 downto 0) <= m02_couplers_to_axi4lite_0_ARCACHE(3 downto 0);
  M02_AXI_arlen(3 downto 0) <= m02_couplers_to_axi4lite_0_ARLEN(3 downto 0);
  M02_AXI_arlock(1 downto 0) <= m02_couplers_to_axi4lite_0_ARLOCK(1 downto 0);
  M02_AXI_arprot(2 downto 0) <= m02_couplers_to_axi4lite_0_ARPROT(2 downto 0);
  M02_AXI_arqos(3 downto 0) <= m02_couplers_to_axi4lite_0_ARQOS(3 downto 0);
  M02_AXI_arsize(2 downto 0) <= m02_couplers_to_axi4lite_0_ARSIZE(2 downto 0);
  M02_AXI_arvalid <= m02_couplers_to_axi4lite_0_ARVALID;
  M02_AXI_awaddr(31 downto 0) <= m02_couplers_to_axi4lite_0_AWADDR(31 downto 0);
  M02_AXI_awburst(1 downto 0) <= m02_couplers_to_axi4lite_0_AWBURST(1 downto 0);
  M02_AXI_awcache(3 downto 0) <= m02_couplers_to_axi4lite_0_AWCACHE(3 downto 0);
  M02_AXI_awlen(3 downto 0) <= m02_couplers_to_axi4lite_0_AWLEN(3 downto 0);
  M02_AXI_awlock(1 downto 0) <= m02_couplers_to_axi4lite_0_AWLOCK(1 downto 0);
  M02_AXI_awprot(2 downto 0) <= m02_couplers_to_axi4lite_0_AWPROT(2 downto 0);
  M02_AXI_awqos(3 downto 0) <= m02_couplers_to_axi4lite_0_AWQOS(3 downto 0);
  M02_AXI_awsize(2 downto 0) <= m02_couplers_to_axi4lite_0_AWSIZE(2 downto 0);
  M02_AXI_awvalid <= m02_couplers_to_axi4lite_0_AWVALID;
  M02_AXI_bready <= m02_couplers_to_axi4lite_0_BREADY;
  M02_AXI_rready <= m02_couplers_to_axi4lite_0_RREADY;
  M02_AXI_wdata(31 downto 0) <= m02_couplers_to_axi4lite_0_WDATA(31 downto 0);
  M02_AXI_wlast <= m02_couplers_to_axi4lite_0_WLAST;
  M02_AXI_wstrb(3 downto 0) <= m02_couplers_to_axi4lite_0_WSTRB(3 downto 0);
  M02_AXI_wvalid <= m02_couplers_to_axi4lite_0_WVALID;
  M03_ACLK_1 <= M03_ACLK;
  M03_ARESETN_1(0) <= M03_ARESETN(0);
  M03_AXI_araddr(31 downto 0) <= m03_couplers_to_axi4lite_0_ARADDR(31 downto 0);
  M03_AXI_arvalid <= m03_couplers_to_axi4lite_0_ARVALID;
  M03_AXI_awaddr(31 downto 0) <= m03_couplers_to_axi4lite_0_AWADDR(31 downto 0);
  M03_AXI_awvalid <= m03_couplers_to_axi4lite_0_AWVALID;
  M03_AXI_bready <= m03_couplers_to_axi4lite_0_BREADY;
  M03_AXI_rready <= m03_couplers_to_axi4lite_0_RREADY;
  M03_AXI_wdata(31 downto 0) <= m03_couplers_to_axi4lite_0_WDATA(31 downto 0);
  M03_AXI_wstrb(3 downto 0) <= m03_couplers_to_axi4lite_0_WSTRB(3 downto 0);
  M03_AXI_wvalid <= m03_couplers_to_axi4lite_0_WVALID;
  M04_ACLK_1 <= M04_ACLK;
  M04_ARESETN_1(0) <= M04_ARESETN(0);
  M04_AXI_araddr(31 downto 0) <= m04_couplers_to_axi4lite_0_ARADDR(31 downto 0);
  M04_AXI_arprot(2 downto 0) <= m04_couplers_to_axi4lite_0_ARPROT(2 downto 0);
  M04_AXI_arvalid <= m04_couplers_to_axi4lite_0_ARVALID;
  M04_AXI_awaddr(31 downto 0) <= m04_couplers_to_axi4lite_0_AWADDR(31 downto 0);
  M04_AXI_awprot(2 downto 0) <= m04_couplers_to_axi4lite_0_AWPROT(2 downto 0);
  M04_AXI_awvalid <= m04_couplers_to_axi4lite_0_AWVALID;
  M04_AXI_bready <= m04_couplers_to_axi4lite_0_BREADY;
  M04_AXI_rready <= m04_couplers_to_axi4lite_0_RREADY;
  M04_AXI_wdata(31 downto 0) <= m04_couplers_to_axi4lite_0_WDATA(31 downto 0);
  M04_AXI_wstrb(3 downto 0) <= m04_couplers_to_axi4lite_0_WSTRB(3 downto 0);
  M04_AXI_wvalid <= m04_couplers_to_axi4lite_0_WVALID;
  S00_ACLK_1 <= S00_ACLK;
  S00_ARESETN_1(0) <= S00_ARESETN(0);
  S00_AXI_1_ARADDR(31 downto 0) <= S00_AXI_araddr(31 downto 0);
  S00_AXI_1_ARPROT(2 downto 0) <= S00_AXI_arprot(2 downto 0);
  S00_AXI_1_ARVALID <= S00_AXI_arvalid;
  S00_AXI_1_AWADDR(31 downto 0) <= S00_AXI_awaddr(31 downto 0);
  S00_AXI_1_AWPROT(2 downto 0) <= S00_AXI_awprot(2 downto 0);
  S00_AXI_1_AWVALID <= S00_AXI_awvalid;
  S00_AXI_1_BREADY <= S00_AXI_bready;
  S00_AXI_1_RREADY <= S00_AXI_rready;
  S00_AXI_1_WDATA(31 downto 0) <= S00_AXI_wdata(31 downto 0);
  S00_AXI_1_WSTRB(3 downto 0) <= S00_AXI_wstrb(3 downto 0);
  S00_AXI_1_WVALID <= S00_AXI_wvalid;
  S00_AXI_arready <= S00_AXI_1_ARREADY;
  S00_AXI_awready <= S00_AXI_1_AWREADY;
  S00_AXI_bresp(1 downto 0) <= S00_AXI_1_BRESP(1 downto 0);
  S00_AXI_bvalid <= S00_AXI_1_BVALID;
  S00_AXI_rdata(31 downto 0) <= S00_AXI_1_RDATA(31 downto 0);
  S00_AXI_rresp(1 downto 0) <= S00_AXI_1_RRESP(1 downto 0);
  S00_AXI_rvalid <= S00_AXI_1_RVALID;
  S00_AXI_wready <= S00_AXI_1_WREADY;
  axi4lite_0_ACLK_net <= ACLK;
  axi4lite_0_ARESETN_net(0) <= ARESETN(0);
  m00_couplers_to_axi4lite_0_ARREADY <= M00_AXI_arready;
  m00_couplers_to_axi4lite_0_AWREADY <= M00_AXI_awready;
  m00_couplers_to_axi4lite_0_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  m00_couplers_to_axi4lite_0_BVALID <= M00_AXI_bvalid;
  m00_couplers_to_axi4lite_0_RDATA(31 downto 0) <= M00_AXI_rdata(31 downto 0);
  m00_couplers_to_axi4lite_0_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  m00_couplers_to_axi4lite_0_RVALID <= M00_AXI_rvalid;
  m00_couplers_to_axi4lite_0_WREADY <= M00_AXI_wready;
  m01_couplers_to_axi4lite_0_ARREADY <= M01_AXI_arready;
  m01_couplers_to_axi4lite_0_AWREADY <= M01_AXI_awready;
  m01_couplers_to_axi4lite_0_BRESP(1 downto 0) <= M01_AXI_bresp(1 downto 0);
  m01_couplers_to_axi4lite_0_BVALID <= M01_AXI_bvalid;
  m01_couplers_to_axi4lite_0_RDATA(31 downto 0) <= M01_AXI_rdata(31 downto 0);
  m01_couplers_to_axi4lite_0_RRESP(1 downto 0) <= M01_AXI_rresp(1 downto 0);
  m01_couplers_to_axi4lite_0_RVALID <= M01_AXI_rvalid;
  m01_couplers_to_axi4lite_0_WREADY <= M01_AXI_wready;
  m02_couplers_to_axi4lite_0_ARREADY <= M02_AXI_arready;
  m02_couplers_to_axi4lite_0_AWREADY <= M02_AXI_awready;
  m02_couplers_to_axi4lite_0_BRESP(1 downto 0) <= M02_AXI_bresp(1 downto 0);
  m02_couplers_to_axi4lite_0_BVALID <= M02_AXI_bvalid;
  m02_couplers_to_axi4lite_0_RDATA(31 downto 0) <= M02_AXI_rdata(31 downto 0);
  m02_couplers_to_axi4lite_0_RLAST <= M02_AXI_rlast;
  m02_couplers_to_axi4lite_0_RRESP(1 downto 0) <= M02_AXI_rresp(1 downto 0);
  m02_couplers_to_axi4lite_0_RVALID <= M02_AXI_rvalid;
  m02_couplers_to_axi4lite_0_WREADY <= M02_AXI_wready;
  m03_couplers_to_axi4lite_0_ARREADY <= M03_AXI_arready;
  m03_couplers_to_axi4lite_0_AWREADY <= M03_AXI_awready;
  m03_couplers_to_axi4lite_0_BRESP(1 downto 0) <= M03_AXI_bresp(1 downto 0);
  m03_couplers_to_axi4lite_0_BVALID <= M03_AXI_bvalid;
  m03_couplers_to_axi4lite_0_RDATA(31 downto 0) <= M03_AXI_rdata(31 downto 0);
  m03_couplers_to_axi4lite_0_RRESP(1 downto 0) <= M03_AXI_rresp(1 downto 0);
  m03_couplers_to_axi4lite_0_RVALID <= M03_AXI_rvalid;
  m03_couplers_to_axi4lite_0_WREADY <= M03_AXI_wready;
  m04_couplers_to_axi4lite_0_ARREADY <= M04_AXI_arready;
  m04_couplers_to_axi4lite_0_AWREADY <= M04_AXI_awready;
  m04_couplers_to_axi4lite_0_BRESP(1 downto 0) <= M04_AXI_bresp(1 downto 0);
  m04_couplers_to_axi4lite_0_BVALID <= M04_AXI_bvalid;
  m04_couplers_to_axi4lite_0_RDATA(31 downto 0) <= M04_AXI_rdata(31 downto 0);
  m04_couplers_to_axi4lite_0_RRESP(1 downto 0) <= M04_AXI_rresp(1 downto 0);
  m04_couplers_to_axi4lite_0_RVALID <= M04_AXI_rvalid;
  m04_couplers_to_axi4lite_0_WREADY <= M04_AXI_wready;
m00_couplers: entity work.m00_couplers_imp_2PVA4I
    port map (
      M_ACLK => M00_ACLK_1,
      M_ARESETN(0) => M00_ARESETN_1(0),
      M_AXI_araddr(31 downto 0) => m00_couplers_to_axi4lite_0_ARADDR(31 downto 0),
      M_AXI_arready => m00_couplers_to_axi4lite_0_ARREADY,
      M_AXI_arvalid => m00_couplers_to_axi4lite_0_ARVALID,
      M_AXI_awaddr(31 downto 0) => m00_couplers_to_axi4lite_0_AWADDR(31 downto 0),
      M_AXI_awready => m00_couplers_to_axi4lite_0_AWREADY,
      M_AXI_awvalid => m00_couplers_to_axi4lite_0_AWVALID,
      M_AXI_bready => m00_couplers_to_axi4lite_0_BREADY,
      M_AXI_bresp(1 downto 0) => m00_couplers_to_axi4lite_0_BRESP(1 downto 0),
      M_AXI_bvalid => m00_couplers_to_axi4lite_0_BVALID,
      M_AXI_rdata(31 downto 0) => m00_couplers_to_axi4lite_0_RDATA(31 downto 0),
      M_AXI_rready => m00_couplers_to_axi4lite_0_RREADY,
      M_AXI_rresp(1 downto 0) => m00_couplers_to_axi4lite_0_RRESP(1 downto 0),
      M_AXI_rvalid => m00_couplers_to_axi4lite_0_RVALID,
      M_AXI_wdata(31 downto 0) => m00_couplers_to_axi4lite_0_WDATA(31 downto 0),
      M_AXI_wready => m00_couplers_to_axi4lite_0_WREADY,
      M_AXI_wstrb(3 downto 0) => m00_couplers_to_axi4lite_0_WSTRB(3 downto 0),
      M_AXI_wvalid => m00_couplers_to_axi4lite_0_WVALID,
      S_ACLK => axi4lite_0_ACLK_net,
      S_ARESETN(0) => axi4lite_0_ARESETN_net(0),
      S_AXI_araddr(31 downto 0) => xbar_to_m00_couplers_ARADDR(31 downto 0),
      S_AXI_arready => xbar_to_m00_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m00_couplers_ARVALID(0),
      S_AXI_awaddr(31 downto 0) => xbar_to_m00_couplers_AWADDR(31 downto 0),
      S_AXI_awready => xbar_to_m00_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m00_couplers_AWVALID(0),
      S_AXI_bready => xbar_to_m00_couplers_BREADY(0),
      S_AXI_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m00_couplers_RREADY(0),
      S_AXI_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      S_AXI_wready => xbar_to_m00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => xbar_to_m00_couplers_WVALID(0)
    );
m01_couplers: entity work.m01_couplers_imp_1RTYIWS
    port map (
      M_ACLK => M01_ACLK_1,
      M_ARESETN(0) => M01_ARESETN_1(0),
      M_AXI_araddr(4 downto 0) => m01_couplers_to_axi4lite_0_ARADDR(4 downto 0),
      M_AXI_arready => m01_couplers_to_axi4lite_0_ARREADY,
      M_AXI_arvalid => m01_couplers_to_axi4lite_0_ARVALID,
      M_AXI_awaddr(4 downto 0) => m01_couplers_to_axi4lite_0_AWADDR(4 downto 0),
      M_AXI_awready => m01_couplers_to_axi4lite_0_AWREADY,
      M_AXI_awvalid => m01_couplers_to_axi4lite_0_AWVALID,
      M_AXI_bready => m01_couplers_to_axi4lite_0_BREADY,
      M_AXI_bresp(1 downto 0) => m01_couplers_to_axi4lite_0_BRESP(1 downto 0),
      M_AXI_bvalid => m01_couplers_to_axi4lite_0_BVALID,
      M_AXI_rdata(31 downto 0) => m01_couplers_to_axi4lite_0_RDATA(31 downto 0),
      M_AXI_rready => m01_couplers_to_axi4lite_0_RREADY,
      M_AXI_rresp(1 downto 0) => m01_couplers_to_axi4lite_0_RRESP(1 downto 0),
      M_AXI_rvalid => m01_couplers_to_axi4lite_0_RVALID,
      M_AXI_wdata(31 downto 0) => m01_couplers_to_axi4lite_0_WDATA(31 downto 0),
      M_AXI_wready => m01_couplers_to_axi4lite_0_WREADY,
      M_AXI_wstrb(3 downto 0) => m01_couplers_to_axi4lite_0_WSTRB(3 downto 0),
      M_AXI_wvalid => m01_couplers_to_axi4lite_0_WVALID,
      S_ACLK => axi4lite_0_ACLK_net,
      S_ARESETN(0) => axi4lite_0_ARESETN_net(0),
      S_AXI_araddr(4 downto 0) => xbar_to_m01_couplers_ARADDR(36 downto 32),
      S_AXI_arready => xbar_to_m01_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m01_couplers_ARVALID(1),
      S_AXI_awaddr(4 downto 0) => xbar_to_m01_couplers_AWADDR(36 downto 32),
      S_AXI_awready => xbar_to_m01_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m01_couplers_AWVALID(1),
      S_AXI_bready => xbar_to_m01_couplers_BREADY(1),
      S_AXI_bresp(1 downto 0) => xbar_to_m01_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m01_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m01_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m01_couplers_RREADY(1),
      S_AXI_rresp(1 downto 0) => xbar_to_m01_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m01_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m01_couplers_WDATA(63 downto 32),
      S_AXI_wready => xbar_to_m01_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m01_couplers_WSTRB(7 downto 4),
      S_AXI_wvalid => xbar_to_m01_couplers_WVALID(1)
    );
m02_couplers: entity work.m02_couplers_imp_3O3M0V
    port map (
      M_ACLK => M02_ACLK_1,
      M_ARESETN(0) => M02_ARESETN_1(0),
      M_AXI_araddr(31 downto 0) => m02_couplers_to_axi4lite_0_ARADDR(31 downto 0),
      M_AXI_arburst(1 downto 0) => m02_couplers_to_axi4lite_0_ARBURST(1 downto 0),
      M_AXI_arcache(3 downto 0) => m02_couplers_to_axi4lite_0_ARCACHE(3 downto 0),
      M_AXI_arlen(3 downto 0) => m02_couplers_to_axi4lite_0_ARLEN(3 downto 0),
      M_AXI_arlock(1 downto 0) => m02_couplers_to_axi4lite_0_ARLOCK(1 downto 0),
      M_AXI_arprot(2 downto 0) => m02_couplers_to_axi4lite_0_ARPROT(2 downto 0),
      M_AXI_arqos(3 downto 0) => m02_couplers_to_axi4lite_0_ARQOS(3 downto 0),
      M_AXI_arready => m02_couplers_to_axi4lite_0_ARREADY,
      M_AXI_arsize(2 downto 0) => m02_couplers_to_axi4lite_0_ARSIZE(2 downto 0),
      M_AXI_arvalid => m02_couplers_to_axi4lite_0_ARVALID,
      M_AXI_awaddr(31 downto 0) => m02_couplers_to_axi4lite_0_AWADDR(31 downto 0),
      M_AXI_awburst(1 downto 0) => m02_couplers_to_axi4lite_0_AWBURST(1 downto 0),
      M_AXI_awcache(3 downto 0) => m02_couplers_to_axi4lite_0_AWCACHE(3 downto 0),
      M_AXI_awlen(3 downto 0) => m02_couplers_to_axi4lite_0_AWLEN(3 downto 0),
      M_AXI_awlock(1 downto 0) => m02_couplers_to_axi4lite_0_AWLOCK(1 downto 0),
      M_AXI_awprot(2 downto 0) => m02_couplers_to_axi4lite_0_AWPROT(2 downto 0),
      M_AXI_awqos(3 downto 0) => m02_couplers_to_axi4lite_0_AWQOS(3 downto 0),
      M_AXI_awready => m02_couplers_to_axi4lite_0_AWREADY,
      M_AXI_awsize(2 downto 0) => m02_couplers_to_axi4lite_0_AWSIZE(2 downto 0),
      M_AXI_awvalid => m02_couplers_to_axi4lite_0_AWVALID,
      M_AXI_bready => m02_couplers_to_axi4lite_0_BREADY,
      M_AXI_bresp(1 downto 0) => m02_couplers_to_axi4lite_0_BRESP(1 downto 0),
      M_AXI_bvalid => m02_couplers_to_axi4lite_0_BVALID,
      M_AXI_rdata(31 downto 0) => m02_couplers_to_axi4lite_0_RDATA(31 downto 0),
      M_AXI_rlast => m02_couplers_to_axi4lite_0_RLAST,
      M_AXI_rready => m02_couplers_to_axi4lite_0_RREADY,
      M_AXI_rresp(1 downto 0) => m02_couplers_to_axi4lite_0_RRESP(1 downto 0),
      M_AXI_rvalid => m02_couplers_to_axi4lite_0_RVALID,
      M_AXI_wdata(31 downto 0) => m02_couplers_to_axi4lite_0_WDATA(31 downto 0),
      M_AXI_wlast => m02_couplers_to_axi4lite_0_WLAST,
      M_AXI_wready => m02_couplers_to_axi4lite_0_WREADY,
      M_AXI_wstrb(3 downto 0) => m02_couplers_to_axi4lite_0_WSTRB(3 downto 0),
      M_AXI_wvalid => m02_couplers_to_axi4lite_0_WVALID,
      S_ACLK => axi4lite_0_ACLK_net,
      S_ARESETN(0) => axi4lite_0_ARESETN_net(0),
      S_AXI_araddr(31 downto 0) => xbar_to_m02_couplers_ARADDR(95 downto 64),
      S_AXI_arprot(2 downto 0) => xbar_to_m02_couplers_ARPROT(8 downto 6),
      S_AXI_arready => xbar_to_m02_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m02_couplers_ARVALID(2),
      S_AXI_awaddr(31 downto 0) => xbar_to_m02_couplers_AWADDR(95 downto 64),
      S_AXI_awprot(2 downto 0) => xbar_to_m02_couplers_AWPROT(8 downto 6),
      S_AXI_awready => xbar_to_m02_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m02_couplers_AWVALID(2),
      S_AXI_bready => xbar_to_m02_couplers_BREADY(2),
      S_AXI_bresp(1 downto 0) => xbar_to_m02_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m02_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m02_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m02_couplers_RREADY(2),
      S_AXI_rresp(1 downto 0) => xbar_to_m02_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m02_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m02_couplers_WDATA(95 downto 64),
      S_AXI_wready => xbar_to_m02_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m02_couplers_WSTRB(11 downto 8),
      S_AXI_wvalid => xbar_to_m02_couplers_WVALID(2)
    );
m03_couplers: entity work.m03_couplers_imp_1QZA70H
    port map (
      M_ACLK => M03_ACLK_1,
      M_ARESETN(0) => M03_ARESETN_1(0),
      M_AXI_araddr(31 downto 0) => m03_couplers_to_axi4lite_0_ARADDR(31 downto 0),
      M_AXI_arready => m03_couplers_to_axi4lite_0_ARREADY,
      M_AXI_arvalid => m03_couplers_to_axi4lite_0_ARVALID,
      M_AXI_awaddr(31 downto 0) => m03_couplers_to_axi4lite_0_AWADDR(31 downto 0),
      M_AXI_awready => m03_couplers_to_axi4lite_0_AWREADY,
      M_AXI_awvalid => m03_couplers_to_axi4lite_0_AWVALID,
      M_AXI_bready => m03_couplers_to_axi4lite_0_BREADY,
      M_AXI_bresp(1 downto 0) => m03_couplers_to_axi4lite_0_BRESP(1 downto 0),
      M_AXI_bvalid => m03_couplers_to_axi4lite_0_BVALID,
      M_AXI_rdata(31 downto 0) => m03_couplers_to_axi4lite_0_RDATA(31 downto 0),
      M_AXI_rready => m03_couplers_to_axi4lite_0_RREADY,
      M_AXI_rresp(1 downto 0) => m03_couplers_to_axi4lite_0_RRESP(1 downto 0),
      M_AXI_rvalid => m03_couplers_to_axi4lite_0_RVALID,
      M_AXI_wdata(31 downto 0) => m03_couplers_to_axi4lite_0_WDATA(31 downto 0),
      M_AXI_wready => m03_couplers_to_axi4lite_0_WREADY,
      M_AXI_wstrb(3 downto 0) => m03_couplers_to_axi4lite_0_WSTRB(3 downto 0),
      M_AXI_wvalid => m03_couplers_to_axi4lite_0_WVALID,
      S_ACLK => axi4lite_0_ACLK_net,
      S_ARESETN(0) => axi4lite_0_ARESETN_net(0),
      S_AXI_araddr(31 downto 0) => xbar_to_m03_couplers_ARADDR(127 downto 96),
      S_AXI_arready => xbar_to_m03_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m03_couplers_ARVALID(3),
      S_AXI_awaddr(31 downto 0) => xbar_to_m03_couplers_AWADDR(127 downto 96),
      S_AXI_awready => xbar_to_m03_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m03_couplers_AWVALID(3),
      S_AXI_bready => xbar_to_m03_couplers_BREADY(3),
      S_AXI_bresp(1 downto 0) => xbar_to_m03_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m03_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m03_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m03_couplers_RREADY(3),
      S_AXI_rresp(1 downto 0) => xbar_to_m03_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m03_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m03_couplers_WDATA(127 downto 96),
      S_AXI_wready => xbar_to_m03_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m03_couplers_WSTRB(15 downto 12),
      S_AXI_wvalid => xbar_to_m03_couplers_WVALID(3)
    );
m04_couplers: entity work.m04_couplers_imp_1K1O8
    port map (
      M_ACLK => M04_ACLK_1,
      M_ARESETN(0) => M04_ARESETN_1(0),
      M_AXI_araddr(31 downto 0) => m04_couplers_to_axi4lite_0_ARADDR(31 downto 0),
      M_AXI_arprot(2 downto 0) => m04_couplers_to_axi4lite_0_ARPROT(2 downto 0),
      M_AXI_arready => m04_couplers_to_axi4lite_0_ARREADY,
      M_AXI_arvalid => m04_couplers_to_axi4lite_0_ARVALID,
      M_AXI_awaddr(31 downto 0) => m04_couplers_to_axi4lite_0_AWADDR(31 downto 0),
      M_AXI_awprot(2 downto 0) => m04_couplers_to_axi4lite_0_AWPROT(2 downto 0),
      M_AXI_awready => m04_couplers_to_axi4lite_0_AWREADY,
      M_AXI_awvalid => m04_couplers_to_axi4lite_0_AWVALID,
      M_AXI_bready => m04_couplers_to_axi4lite_0_BREADY,
      M_AXI_bresp(1 downto 0) => m04_couplers_to_axi4lite_0_BRESP(1 downto 0),
      M_AXI_bvalid => m04_couplers_to_axi4lite_0_BVALID,
      M_AXI_rdata(31 downto 0) => m04_couplers_to_axi4lite_0_RDATA(31 downto 0),
      M_AXI_rready => m04_couplers_to_axi4lite_0_RREADY,
      M_AXI_rresp(1 downto 0) => m04_couplers_to_axi4lite_0_RRESP(1 downto 0),
      M_AXI_rvalid => m04_couplers_to_axi4lite_0_RVALID,
      M_AXI_wdata(31 downto 0) => m04_couplers_to_axi4lite_0_WDATA(31 downto 0),
      M_AXI_wready => m04_couplers_to_axi4lite_0_WREADY,
      M_AXI_wstrb(3 downto 0) => m04_couplers_to_axi4lite_0_WSTRB(3 downto 0),
      M_AXI_wvalid => m04_couplers_to_axi4lite_0_WVALID,
      S_ACLK => axi4lite_0_ACLK_net,
      S_ARESETN(0) => axi4lite_0_ARESETN_net(0),
      S_AXI_araddr(31 downto 0) => xbar_to_m04_couplers_ARADDR(159 downto 128),
      S_AXI_arprot(2 downto 0) => xbar_to_m04_couplers_ARPROT(14 downto 12),
      S_AXI_arready => xbar_to_m04_couplers_ARREADY,
      S_AXI_arvalid => xbar_to_m04_couplers_ARVALID(4),
      S_AXI_awaddr(31 downto 0) => xbar_to_m04_couplers_AWADDR(159 downto 128),
      S_AXI_awprot(2 downto 0) => xbar_to_m04_couplers_AWPROT(14 downto 12),
      S_AXI_awready => xbar_to_m04_couplers_AWREADY,
      S_AXI_awvalid => xbar_to_m04_couplers_AWVALID(4),
      S_AXI_bready => xbar_to_m04_couplers_BREADY(4),
      S_AXI_bresp(1 downto 0) => xbar_to_m04_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m04_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m04_couplers_RDATA(31 downto 0),
      S_AXI_rready => xbar_to_m04_couplers_RREADY(4),
      S_AXI_rresp(1 downto 0) => xbar_to_m04_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m04_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m04_couplers_WDATA(159 downto 128),
      S_AXI_wready => xbar_to_m04_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m04_couplers_WSTRB(19 downto 16),
      S_AXI_wvalid => xbar_to_m04_couplers_WVALID(4)
    );
s00_couplers: entity work.s00_couplers_imp_1TQAI8W
    port map (
      M_ACLK => axi4lite_0_ACLK_net,
      M_ARESETN(0) => axi4lite_0_ARESETN_net(0),
      M_AXI_araddr(31 downto 0) => s00_couplers_to_xbar_ARADDR(31 downto 0),
      M_AXI_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arready => s00_couplers_to_xbar_ARREADY(0),
      M_AXI_arvalid => s00_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(31 downto 0) => s00_couplers_to_xbar_AWADDR(31 downto 0),
      M_AXI_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awready => s00_couplers_to_xbar_AWREADY(0),
      M_AXI_awvalid => s00_couplers_to_xbar_AWVALID,
      M_AXI_bready => s00_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_xbar_BVALID(0),
      M_AXI_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      M_AXI_rready => s00_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_xbar_RVALID(0),
      M_AXI_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wready => s00_couplers_to_xbar_WREADY(0),
      M_AXI_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s00_couplers_to_xbar_WVALID,
      S_ACLK => S00_ACLK_1,
      S_ARESETN(0) => S00_ARESETN_1(0),
      S_AXI_araddr(31 downto 0) => s00_mmu_M_AXI_ARADDR(31 downto 0),
      S_AXI_arprot(2 downto 0) => s00_mmu_M_AXI_ARPROT(2 downto 0),
      S_AXI_arready => s00_mmu_M_AXI_ARREADY,
      S_AXI_arvalid => s00_mmu_M_AXI_ARVALID,
      S_AXI_awaddr(31 downto 0) => s00_mmu_M_AXI_AWADDR(31 downto 0),
      S_AXI_awprot(2 downto 0) => s00_mmu_M_AXI_AWPROT(2 downto 0),
      S_AXI_awready => s00_mmu_M_AXI_AWREADY,
      S_AXI_awvalid => s00_mmu_M_AXI_AWVALID,
      S_AXI_bready => s00_mmu_M_AXI_BREADY,
      S_AXI_bresp(1 downto 0) => s00_mmu_M_AXI_BRESP(1 downto 0),
      S_AXI_bvalid => s00_mmu_M_AXI_BVALID,
      S_AXI_rdata(31 downto 0) => s00_mmu_M_AXI_RDATA(31 downto 0),
      S_AXI_rready => s00_mmu_M_AXI_RREADY,
      S_AXI_rresp(1 downto 0) => s00_mmu_M_AXI_RRESP(1 downto 0),
      S_AXI_rvalid => s00_mmu_M_AXI_RVALID,
      S_AXI_wdata(31 downto 0) => s00_mmu_M_AXI_WDATA(31 downto 0),
      S_AXI_wready => s00_mmu_M_AXI_WREADY,
      S_AXI_wstrb(3 downto 0) => s00_mmu_M_AXI_WSTRB(3 downto 0),
      S_AXI_wvalid => s00_mmu_M_AXI_WVALID
    );
s00_mmu: component system_s00_mmu_0
    port map (
      aclk => S00_ACLK_1,
      aresetn => S00_ARESETN_1(0),
      m_axi_araddr(31 downto 0) => s00_mmu_M_AXI_ARADDR(31 downto 0),
      m_axi_arprot(2 downto 0) => s00_mmu_M_AXI_ARPROT(2 downto 0),
      m_axi_arready => s00_mmu_M_AXI_ARREADY,
      m_axi_arvalid => s00_mmu_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => s00_mmu_M_AXI_AWADDR(31 downto 0),
      m_axi_awprot(2 downto 0) => s00_mmu_M_AXI_AWPROT(2 downto 0),
      m_axi_awready => s00_mmu_M_AXI_AWREADY,
      m_axi_awvalid => s00_mmu_M_AXI_AWVALID,
      m_axi_bready => s00_mmu_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => s00_mmu_M_AXI_BRESP(1 downto 0),
      m_axi_bvalid => s00_mmu_M_AXI_BVALID,
      m_axi_rdata(31 downto 0) => s00_mmu_M_AXI_RDATA(31 downto 0),
      m_axi_rready => s00_mmu_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => s00_mmu_M_AXI_RRESP(1 downto 0),
      m_axi_rvalid => s00_mmu_M_AXI_RVALID,
      m_axi_wdata(31 downto 0) => s00_mmu_M_AXI_WDATA(31 downto 0),
      m_axi_wready => s00_mmu_M_AXI_WREADY,
      m_axi_wstrb(3 downto 0) => s00_mmu_M_AXI_WSTRB(3 downto 0),
      m_axi_wvalid => s00_mmu_M_AXI_WVALID,
      s_axi_araddr(31 downto 0) => S00_AXI_1_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => S00_AXI_1_ARPROT(2 downto 0),
      s_axi_arready => S00_AXI_1_ARREADY,
      s_axi_arvalid => S00_AXI_1_ARVALID,
      s_axi_awaddr(31 downto 0) => S00_AXI_1_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => S00_AXI_1_AWPROT(2 downto 0),
      s_axi_awready => S00_AXI_1_AWREADY,
      s_axi_awvalid => S00_AXI_1_AWVALID,
      s_axi_bready => S00_AXI_1_BREADY,
      s_axi_bresp(1 downto 0) => S00_AXI_1_BRESP(1 downto 0),
      s_axi_bvalid => S00_AXI_1_BVALID,
      s_axi_rdata(31 downto 0) => S00_AXI_1_RDATA(31 downto 0),
      s_axi_rready => S00_AXI_1_RREADY,
      s_axi_rresp(1 downto 0) => S00_AXI_1_RRESP(1 downto 0),
      s_axi_rvalid => S00_AXI_1_RVALID,
      s_axi_wdata(31 downto 0) => S00_AXI_1_WDATA(31 downto 0),
      s_axi_wready => S00_AXI_1_WREADY,
      s_axi_wstrb(3 downto 0) => S00_AXI_1_WSTRB(3 downto 0),
      s_axi_wvalid => S00_AXI_1_WVALID
    );
xbar: component system_xbar_0
    port map (
      aclk => axi4lite_0_ACLK_net,
      aresetn => axi4lite_0_ARESETN_net(0),
      m_axi_araddr(159 downto 128) => xbar_to_m04_couplers_ARADDR(159 downto 128),
      m_axi_araddr(127 downto 96) => xbar_to_m03_couplers_ARADDR(127 downto 96),
      m_axi_araddr(95 downto 64) => xbar_to_m02_couplers_ARADDR(95 downto 64),
      m_axi_araddr(63 downto 32) => xbar_to_m01_couplers_ARADDR(63 downto 32),
      m_axi_araddr(31 downto 0) => xbar_to_m00_couplers_ARADDR(31 downto 0),
      m_axi_arprot(14 downto 12) => xbar_to_m04_couplers_ARPROT(14 downto 12),
      m_axi_arprot(11 downto 9) => NLW_xbar_m_axi_arprot_UNCONNECTED(11 downto 9),
      m_axi_arprot(8 downto 6) => xbar_to_m02_couplers_ARPROT(8 downto 6),
      m_axi_arprot(5 downto 0) => NLW_xbar_m_axi_arprot_UNCONNECTED(5 downto 0),
      m_axi_arready(4) => xbar_to_m04_couplers_ARREADY,
      m_axi_arready(3) => xbar_to_m03_couplers_ARREADY,
      m_axi_arready(2) => xbar_to_m02_couplers_ARREADY,
      m_axi_arready(1) => xbar_to_m01_couplers_ARREADY,
      m_axi_arready(0) => xbar_to_m00_couplers_ARREADY,
      m_axi_arvalid(4) => xbar_to_m04_couplers_ARVALID(4),
      m_axi_arvalid(3) => xbar_to_m03_couplers_ARVALID(3),
      m_axi_arvalid(2) => xbar_to_m02_couplers_ARVALID(2),
      m_axi_arvalid(1) => xbar_to_m01_couplers_ARVALID(1),
      m_axi_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      m_axi_awaddr(159 downto 128) => xbar_to_m04_couplers_AWADDR(159 downto 128),
      m_axi_awaddr(127 downto 96) => xbar_to_m03_couplers_AWADDR(127 downto 96),
      m_axi_awaddr(95 downto 64) => xbar_to_m02_couplers_AWADDR(95 downto 64),
      m_axi_awaddr(63 downto 32) => xbar_to_m01_couplers_AWADDR(63 downto 32),
      m_axi_awaddr(31 downto 0) => xbar_to_m00_couplers_AWADDR(31 downto 0),
      m_axi_awprot(14 downto 12) => xbar_to_m04_couplers_AWPROT(14 downto 12),
      m_axi_awprot(11 downto 9) => NLW_xbar_m_axi_awprot_UNCONNECTED(11 downto 9),
      m_axi_awprot(8 downto 6) => xbar_to_m02_couplers_AWPROT(8 downto 6),
      m_axi_awprot(5 downto 0) => NLW_xbar_m_axi_awprot_UNCONNECTED(5 downto 0),
      m_axi_awready(4) => xbar_to_m04_couplers_AWREADY,
      m_axi_awready(3) => xbar_to_m03_couplers_AWREADY,
      m_axi_awready(2) => xbar_to_m02_couplers_AWREADY,
      m_axi_awready(1) => xbar_to_m01_couplers_AWREADY,
      m_axi_awready(0) => xbar_to_m00_couplers_AWREADY,
      m_axi_awvalid(4) => xbar_to_m04_couplers_AWVALID(4),
      m_axi_awvalid(3) => xbar_to_m03_couplers_AWVALID(3),
      m_axi_awvalid(2) => xbar_to_m02_couplers_AWVALID(2),
      m_axi_awvalid(1) => xbar_to_m01_couplers_AWVALID(1),
      m_axi_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      m_axi_bready(4) => xbar_to_m04_couplers_BREADY(4),
      m_axi_bready(3) => xbar_to_m03_couplers_BREADY(3),
      m_axi_bready(2) => xbar_to_m02_couplers_BREADY(2),
      m_axi_bready(1) => xbar_to_m01_couplers_BREADY(1),
      m_axi_bready(0) => xbar_to_m00_couplers_BREADY(0),
      m_axi_bresp(9 downto 8) => xbar_to_m04_couplers_BRESP(1 downto 0),
      m_axi_bresp(7 downto 6) => xbar_to_m03_couplers_BRESP(1 downto 0),
      m_axi_bresp(5 downto 4) => xbar_to_m02_couplers_BRESP(1 downto 0),
      m_axi_bresp(3 downto 2) => xbar_to_m01_couplers_BRESP(1 downto 0),
      m_axi_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid(4) => xbar_to_m04_couplers_BVALID,
      m_axi_bvalid(3) => xbar_to_m03_couplers_BVALID,
      m_axi_bvalid(2) => xbar_to_m02_couplers_BVALID,
      m_axi_bvalid(1) => xbar_to_m01_couplers_BVALID,
      m_axi_bvalid(0) => xbar_to_m00_couplers_BVALID,
      m_axi_rdata(159 downto 128) => xbar_to_m04_couplers_RDATA(31 downto 0),
      m_axi_rdata(127 downto 96) => xbar_to_m03_couplers_RDATA(31 downto 0),
      m_axi_rdata(95 downto 64) => xbar_to_m02_couplers_RDATA(31 downto 0),
      m_axi_rdata(63 downto 32) => xbar_to_m01_couplers_RDATA(31 downto 0),
      m_axi_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rready(4) => xbar_to_m04_couplers_RREADY(4),
      m_axi_rready(3) => xbar_to_m03_couplers_RREADY(3),
      m_axi_rready(2) => xbar_to_m02_couplers_RREADY(2),
      m_axi_rready(1) => xbar_to_m01_couplers_RREADY(1),
      m_axi_rready(0) => xbar_to_m00_couplers_RREADY(0),
      m_axi_rresp(9 downto 8) => xbar_to_m04_couplers_RRESP(1 downto 0),
      m_axi_rresp(7 downto 6) => xbar_to_m03_couplers_RRESP(1 downto 0),
      m_axi_rresp(5 downto 4) => xbar_to_m02_couplers_RRESP(1 downto 0),
      m_axi_rresp(3 downto 2) => xbar_to_m01_couplers_RRESP(1 downto 0),
      m_axi_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid(4) => xbar_to_m04_couplers_RVALID,
      m_axi_rvalid(3) => xbar_to_m03_couplers_RVALID,
      m_axi_rvalid(2) => xbar_to_m02_couplers_RVALID,
      m_axi_rvalid(1) => xbar_to_m01_couplers_RVALID,
      m_axi_rvalid(0) => xbar_to_m00_couplers_RVALID,
      m_axi_wdata(159 downto 128) => xbar_to_m04_couplers_WDATA(159 downto 128),
      m_axi_wdata(127 downto 96) => xbar_to_m03_couplers_WDATA(127 downto 96),
      m_axi_wdata(95 downto 64) => xbar_to_m02_couplers_WDATA(95 downto 64),
      m_axi_wdata(63 downto 32) => xbar_to_m01_couplers_WDATA(63 downto 32),
      m_axi_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wready(4) => xbar_to_m04_couplers_WREADY,
      m_axi_wready(3) => xbar_to_m03_couplers_WREADY,
      m_axi_wready(2) => xbar_to_m02_couplers_WREADY,
      m_axi_wready(1) => xbar_to_m01_couplers_WREADY,
      m_axi_wready(0) => xbar_to_m00_couplers_WREADY,
      m_axi_wstrb(19 downto 16) => xbar_to_m04_couplers_WSTRB(19 downto 16),
      m_axi_wstrb(15 downto 12) => xbar_to_m03_couplers_WSTRB(15 downto 12),
      m_axi_wstrb(11 downto 8) => xbar_to_m02_couplers_WSTRB(11 downto 8),
      m_axi_wstrb(7 downto 4) => xbar_to_m01_couplers_WSTRB(7 downto 4),
      m_axi_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid(4) => xbar_to_m04_couplers_WVALID(4),
      m_axi_wvalid(3) => xbar_to_m03_couplers_WVALID(3),
      m_axi_wvalid(2) => xbar_to_m02_couplers_WVALID(2),
      m_axi_wvalid(1) => xbar_to_m01_couplers_WVALID(1),
      m_axi_wvalid(0) => xbar_to_m00_couplers_WVALID(0),
      s_axi_araddr(31 downto 0) => s00_couplers_to_xbar_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arready(0) => s00_couplers_to_xbar_ARREADY(0),
      s_axi_arvalid(0) => s00_couplers_to_xbar_ARVALID,
      s_axi_awaddr(31 downto 0) => s00_couplers_to_xbar_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awready(0) => s00_couplers_to_xbar_AWREADY(0),
      s_axi_awvalid(0) => s00_couplers_to_xbar_AWVALID,
      s_axi_bready(0) => s00_couplers_to_xbar_BREADY,
      s_axi_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      s_axi_bvalid(0) => s00_couplers_to_xbar_BVALID(0),
      s_axi_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      s_axi_rready(0) => s00_couplers_to_xbar_RREADY,
      s_axi_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      s_axi_rvalid(0) => s00_couplers_to_xbar_RVALID(0),
      s_axi_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wready(0) => s00_couplers_to_xbar_WREADY(0),
      s_axi_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wvalid(0) => s00_couplers_to_xbar_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_axi_hp_0_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awlock : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_bid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC;
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_arlock : in STD_LOGIC;
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_awlock : in STD_LOGIC;
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC;
    S01_ACLK : in STD_LOGIC;
    S01_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_arlock : in STD_LOGIC;
    S01_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_arready : out STD_LOGIC;
    S01_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_arvalid : in STD_LOGIC;
    S01_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S01_AXI_awlock : in STD_LOGIC;
    S01_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_awready : out STD_LOGIC;
    S01_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S01_AXI_awvalid : in STD_LOGIC;
    S01_AXI_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_bready : in STD_LOGIC;
    S01_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_bvalid : out STD_LOGIC;
    S01_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    S01_AXI_rlast : out STD_LOGIC;
    S01_AXI_rready : in STD_LOGIC;
    S01_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S01_AXI_rvalid : out STD_LOGIC;
    S01_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S01_AXI_wlast : in STD_LOGIC;
    S01_AXI_wready : out STD_LOGIC;
    S01_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S01_AXI_wvalid : in STD_LOGIC;
    S02_ACLK : in STD_LOGIC;
    S02_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S02_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S02_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S02_AXI_arready : out STD_LOGIC;
    S02_AXI_arvalid : in STD_LOGIC;
    S02_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S02_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S02_AXI_awready : out STD_LOGIC;
    S02_AXI_awvalid : in STD_LOGIC;
    S02_AXI_bready : in STD_LOGIC;
    S02_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S02_AXI_bvalid : out STD_LOGIC;
    S02_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S02_AXI_rready : in STD_LOGIC;
    S02_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S02_AXI_rvalid : out STD_LOGIC;
    S02_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S02_AXI_wready : out STD_LOGIC;
    S02_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S02_AXI_wvalid : in STD_LOGIC
  );
end system_axi_hp_0_0;

architecture STRUCTURE of system_axi_hp_0_0 is
  component system_xbar_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 95 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_awlock : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awcache : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awqos : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_awvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 95 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_wlast : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_wready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_bid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_bvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_bready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 95 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arlock : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arcache : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arqos : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_arvalid : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arready : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_rid : out STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 95 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_rlast : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_rvalid : out STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_rready : in STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arid : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rid : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rready : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component system_xbar_1;
  signal GND_1 : STD_LOGIC;
  signal M00_ACLK_1 : STD_LOGIC;
  signal M00_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal S00_ACLK_1 : STD_LOGIC;
  signal S00_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal S01_ACLK_1 : STD_LOGIC;
  signal S01_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal S02_ACLK_1 : STD_LOGIC;
  signal S02_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_ACLK_net : STD_LOGIC;
  signal axi_hp_0_ARESETN_net : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s00_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARLOCK : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARREADY : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s00_couplers_ARVALID : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s00_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWLOCK : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWREADY : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s00_couplers_AWVALID : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s00_couplers_BREADY : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s00_couplers_BVALID : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s00_couplers_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s00_couplers_RLAST : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_RREADY : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s00_couplers_RVALID : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s00_couplers_WLAST : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_WREADY : STD_LOGIC;
  signal axi_hp_0_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s00_couplers_WVALID : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s01_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARLOCK : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARREADY : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s01_couplers_ARVALID : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s01_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWLOCK : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWREADY : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s01_couplers_AWVALID : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s01_couplers_BREADY : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s01_couplers_BVALID : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s01_couplers_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_0_to_s01_couplers_RLAST : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_RREADY : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s01_couplers_RVALID : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s01_couplers_WLAST : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_WREADY : STD_LOGIC;
  signal axi_hp_0_to_s01_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s01_couplers_WVALID : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s02_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s02_couplers_ARREADY : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_ARVALID : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s02_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_0_to_s02_couplers_AWREADY : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_AWVALID : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_BREADY : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s02_couplers_BVALID : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s02_couplers_RREADY : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_0_to_s02_couplers_RVALID : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_0_to_s02_couplers_WREADY : STD_LOGIC;
  signal axi_hp_0_to_s02_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_0_to_s02_couplers_WVALID : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARREADY : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_axi_hp_0_ARVALID : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWREADY : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal m00_couplers_to_axi_hp_0_AWVALID : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_BID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_BREADY : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_BVALID : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi_hp_0_RID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_RLAST : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_RREADY : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_RVALID : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal m00_couplers_to_axi_hp_0_WID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal m00_couplers_to_axi_hp_0_WLAST : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_WREADY : STD_LOGIC;
  signal m00_couplers_to_axi_hp_0_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal m00_couplers_to_axi_hp_0_WVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_xbar_ARLOCK : STD_LOGIC;
  signal s00_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_xbar_AWLOCK : STD_LOGIC;
  signal s00_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s00_couplers_to_xbar_BID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_RID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_RLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s00_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_xbar_WLAST : STD_LOGIC;
  signal s00_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s00_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_xbar_WVALID : STD_LOGIC;
  signal s01_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_xbar_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_xbar_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_xbar_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_xbar_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s01_couplers_to_xbar_ARLOCK : STD_LOGIC;
  signal s01_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_xbar_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s01_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_xbar_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s01_couplers_to_xbar_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_xbar_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s01_couplers_to_xbar_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s01_couplers_to_xbar_AWLOCK : STD_LOGIC;
  signal s01_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_xbar_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s01_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s01_couplers_to_xbar_BID : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal s01_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s01_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal s01_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 63 downto 32 );
  signal s01_couplers_to_xbar_RID : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal s01_couplers_to_xbar_RLAST : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s01_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal s01_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s01_couplers_to_xbar_WLAST : STD_LOGIC;
  signal s01_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 1 to 1 );
  signal s01_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s01_couplers_to_xbar_WVALID : STD_LOGIC;
  signal s02_couplers_to_xbar_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_xbar_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s02_couplers_to_xbar_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s02_couplers_to_xbar_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s02_couplers_to_xbar_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s02_couplers_to_xbar_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s02_couplers_to_xbar_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s02_couplers_to_xbar_ARREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal s02_couplers_to_xbar_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s02_couplers_to_xbar_ARVALID : STD_LOGIC;
  signal s02_couplers_to_xbar_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_xbar_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s02_couplers_to_xbar_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s02_couplers_to_xbar_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s02_couplers_to_xbar_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s02_couplers_to_xbar_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s02_couplers_to_xbar_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s02_couplers_to_xbar_AWREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal s02_couplers_to_xbar_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s02_couplers_to_xbar_AWVALID : STD_LOGIC;
  signal s02_couplers_to_xbar_BREADY : STD_LOGIC;
  signal s02_couplers_to_xbar_BRESP : STD_LOGIC_VECTOR ( 5 downto 4 );
  signal s02_couplers_to_xbar_BVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal s02_couplers_to_xbar_RDATA : STD_LOGIC_VECTOR ( 95 downto 64 );
  signal s02_couplers_to_xbar_RLAST : STD_LOGIC_VECTOR ( 2 to 2 );
  signal s02_couplers_to_xbar_RREADY : STD_LOGIC;
  signal s02_couplers_to_xbar_RRESP : STD_LOGIC_VECTOR ( 5 downto 4 );
  signal s02_couplers_to_xbar_RVALID : STD_LOGIC_VECTOR ( 2 to 2 );
  signal s02_couplers_to_xbar_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s02_couplers_to_xbar_WLAST : STD_LOGIC;
  signal s02_couplers_to_xbar_WREADY : STD_LOGIC_VECTOR ( 2 to 2 );
  signal s02_couplers_to_xbar_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s02_couplers_to_xbar_WVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_ARID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xbar_to_m00_couplers_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_to_m00_couplers_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_ARREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_ARREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_to_m00_couplers_ARVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_AWID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal xbar_to_m00_couplers_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_to_m00_couplers_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_AWREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_AWREGION : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal xbar_to_m00_couplers_AWVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_BREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_BVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_RID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_RLAST : STD_LOGIC;
  signal xbar_to_m00_couplers_RREADY : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal xbar_to_m00_couplers_RVALID : STD_LOGIC;
  signal xbar_to_m00_couplers_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal xbar_to_m00_couplers_WLAST : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xbar_to_m00_couplers_WREADY : STD_LOGIC;
  signal xbar_to_m00_couplers_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal xbar_to_m00_couplers_WVALID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_xbar_s_axi_arid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_xbar_s_axi_awid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal NLW_xbar_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 4 );
  signal NLW_xbar_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 4 );
begin
  M00_ACLK_1 <= M00_ACLK;
  M00_ARESETN_1(0) <= M00_ARESETN(0);
  M00_AXI_araddr(31 downto 0) <= m00_couplers_to_axi_hp_0_ARADDR(31 downto 0);
  M00_AXI_arburst(1 downto 0) <= m00_couplers_to_axi_hp_0_ARBURST(1 downto 0);
  M00_AXI_arcache(3 downto 0) <= m00_couplers_to_axi_hp_0_ARCACHE(3 downto 0);
  M00_AXI_arid(1 downto 0) <= m00_couplers_to_axi_hp_0_ARID(1 downto 0);
  M00_AXI_arlen(3 downto 0) <= m00_couplers_to_axi_hp_0_ARLEN(3 downto 0);
  M00_AXI_arlock(1 downto 0) <= m00_couplers_to_axi_hp_0_ARLOCK(1 downto 0);
  M00_AXI_arprot(2 downto 0) <= m00_couplers_to_axi_hp_0_ARPROT(2 downto 0);
  M00_AXI_arqos(3 downto 0) <= m00_couplers_to_axi_hp_0_ARQOS(3 downto 0);
  M00_AXI_arsize(2 downto 0) <= m00_couplers_to_axi_hp_0_ARSIZE(2 downto 0);
  M00_AXI_arvalid <= m00_couplers_to_axi_hp_0_ARVALID;
  M00_AXI_awaddr(31 downto 0) <= m00_couplers_to_axi_hp_0_AWADDR(31 downto 0);
  M00_AXI_awburst(1 downto 0) <= m00_couplers_to_axi_hp_0_AWBURST(1 downto 0);
  M00_AXI_awcache(3 downto 0) <= m00_couplers_to_axi_hp_0_AWCACHE(3 downto 0);
  M00_AXI_awid(1 downto 0) <= m00_couplers_to_axi_hp_0_AWID(1 downto 0);
  M00_AXI_awlen(3 downto 0) <= m00_couplers_to_axi_hp_0_AWLEN(3 downto 0);
  M00_AXI_awlock(1 downto 0) <= m00_couplers_to_axi_hp_0_AWLOCK(1 downto 0);
  M00_AXI_awprot(2 downto 0) <= m00_couplers_to_axi_hp_0_AWPROT(2 downto 0);
  M00_AXI_awqos(3 downto 0) <= m00_couplers_to_axi_hp_0_AWQOS(3 downto 0);
  M00_AXI_awsize(2 downto 0) <= m00_couplers_to_axi_hp_0_AWSIZE(2 downto 0);
  M00_AXI_awvalid <= m00_couplers_to_axi_hp_0_AWVALID;
  M00_AXI_bready <= m00_couplers_to_axi_hp_0_BREADY;
  M00_AXI_rready <= m00_couplers_to_axi_hp_0_RREADY;
  M00_AXI_wdata(31 downto 0) <= m00_couplers_to_axi_hp_0_WDATA(31 downto 0);
  M00_AXI_wid(1 downto 0) <= m00_couplers_to_axi_hp_0_WID(1 downto 0);
  M00_AXI_wlast <= m00_couplers_to_axi_hp_0_WLAST;
  M00_AXI_wstrb(3 downto 0) <= m00_couplers_to_axi_hp_0_WSTRB(3 downto 0);
  M00_AXI_wvalid <= m00_couplers_to_axi_hp_0_WVALID;
  S00_ACLK_1 <= S00_ACLK;
  S00_ARESETN_1(0) <= S00_ARESETN(0);
  S00_AXI_arready <= axi_hp_0_to_s00_couplers_ARREADY;
  S00_AXI_awready <= axi_hp_0_to_s00_couplers_AWREADY;
  S00_AXI_bid(0) <= axi_hp_0_to_s00_couplers_BID(0);
  S00_AXI_bresp(1 downto 0) <= axi_hp_0_to_s00_couplers_BRESP(1 downto 0);
  S00_AXI_bvalid <= axi_hp_0_to_s00_couplers_BVALID;
  S00_AXI_rdata(31 downto 0) <= axi_hp_0_to_s00_couplers_RDATA(31 downto 0);
  S00_AXI_rid(0) <= axi_hp_0_to_s00_couplers_RID(0);
  S00_AXI_rlast <= axi_hp_0_to_s00_couplers_RLAST;
  S00_AXI_rresp(1 downto 0) <= axi_hp_0_to_s00_couplers_RRESP(1 downto 0);
  S00_AXI_rvalid <= axi_hp_0_to_s00_couplers_RVALID;
  S00_AXI_wready <= axi_hp_0_to_s00_couplers_WREADY;
  S01_ACLK_1 <= S01_ACLK;
  S01_ARESETN_1(0) <= S01_ARESETN(0);
  S01_AXI_arready <= axi_hp_0_to_s01_couplers_ARREADY;
  S01_AXI_awready <= axi_hp_0_to_s01_couplers_AWREADY;
  S01_AXI_bid(0) <= axi_hp_0_to_s01_couplers_BID(0);
  S01_AXI_bresp(1 downto 0) <= axi_hp_0_to_s01_couplers_BRESP(1 downto 0);
  S01_AXI_bvalid <= axi_hp_0_to_s01_couplers_BVALID;
  S01_AXI_rdata(31 downto 0) <= axi_hp_0_to_s01_couplers_RDATA(31 downto 0);
  S01_AXI_rid(0) <= axi_hp_0_to_s01_couplers_RID(0);
  S01_AXI_rlast <= axi_hp_0_to_s01_couplers_RLAST;
  S01_AXI_rresp(1 downto 0) <= axi_hp_0_to_s01_couplers_RRESP(1 downto 0);
  S01_AXI_rvalid <= axi_hp_0_to_s01_couplers_RVALID;
  S01_AXI_wready <= axi_hp_0_to_s01_couplers_WREADY;
  S02_ACLK_1 <= S02_ACLK;
  S02_ARESETN_1(0) <= S02_ARESETN(0);
  S02_AXI_arready <= axi_hp_0_to_s02_couplers_ARREADY;
  S02_AXI_awready <= axi_hp_0_to_s02_couplers_AWREADY;
  S02_AXI_bresp(1 downto 0) <= axi_hp_0_to_s02_couplers_BRESP(1 downto 0);
  S02_AXI_bvalid <= axi_hp_0_to_s02_couplers_BVALID;
  S02_AXI_rdata(31 downto 0) <= axi_hp_0_to_s02_couplers_RDATA(31 downto 0);
  S02_AXI_rresp(1 downto 0) <= axi_hp_0_to_s02_couplers_RRESP(1 downto 0);
  S02_AXI_rvalid <= axi_hp_0_to_s02_couplers_RVALID;
  S02_AXI_wready <= axi_hp_0_to_s02_couplers_WREADY;
  axi_hp_0_ACLK_net <= ACLK;
  axi_hp_0_ARESETN_net(0) <= ARESETN(0);
  axi_hp_0_to_s00_couplers_ARADDR(31 downto 0) <= S00_AXI_araddr(31 downto 0);
  axi_hp_0_to_s00_couplers_ARBURST(1 downto 0) <= S00_AXI_arburst(1 downto 0);
  axi_hp_0_to_s00_couplers_ARCACHE(3 downto 0) <= S00_AXI_arcache(3 downto 0);
  axi_hp_0_to_s00_couplers_ARID(0) <= S00_AXI_arid(0);
  axi_hp_0_to_s00_couplers_ARLEN(7 downto 0) <= S00_AXI_arlen(7 downto 0);
  axi_hp_0_to_s00_couplers_ARLOCK <= S00_AXI_arlock;
  axi_hp_0_to_s00_couplers_ARPROT(2 downto 0) <= S00_AXI_arprot(2 downto 0);
  axi_hp_0_to_s00_couplers_ARQOS(3 downto 0) <= S00_AXI_arqos(3 downto 0);
  axi_hp_0_to_s00_couplers_ARSIZE(2 downto 0) <= S00_AXI_arsize(2 downto 0);
  axi_hp_0_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  axi_hp_0_to_s00_couplers_AWADDR(31 downto 0) <= S00_AXI_awaddr(31 downto 0);
  axi_hp_0_to_s00_couplers_AWBURST(1 downto 0) <= S00_AXI_awburst(1 downto 0);
  axi_hp_0_to_s00_couplers_AWCACHE(3 downto 0) <= S00_AXI_awcache(3 downto 0);
  axi_hp_0_to_s00_couplers_AWID(0) <= S00_AXI_awid(0);
  axi_hp_0_to_s00_couplers_AWLEN(7 downto 0) <= S00_AXI_awlen(7 downto 0);
  axi_hp_0_to_s00_couplers_AWLOCK <= S00_AXI_awlock;
  axi_hp_0_to_s00_couplers_AWPROT(2 downto 0) <= S00_AXI_awprot(2 downto 0);
  axi_hp_0_to_s00_couplers_AWQOS(3 downto 0) <= S00_AXI_awqos(3 downto 0);
  axi_hp_0_to_s00_couplers_AWSIZE(2 downto 0) <= S00_AXI_awsize(2 downto 0);
  axi_hp_0_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  axi_hp_0_to_s00_couplers_BREADY <= S00_AXI_bready;
  axi_hp_0_to_s00_couplers_RREADY <= S00_AXI_rready;
  axi_hp_0_to_s00_couplers_WDATA(31 downto 0) <= S00_AXI_wdata(31 downto 0);
  axi_hp_0_to_s00_couplers_WLAST <= S00_AXI_wlast;
  axi_hp_0_to_s00_couplers_WSTRB(3 downto 0) <= S00_AXI_wstrb(3 downto 0);
  axi_hp_0_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  axi_hp_0_to_s01_couplers_ARADDR(31 downto 0) <= S01_AXI_araddr(31 downto 0);
  axi_hp_0_to_s01_couplers_ARBURST(1 downto 0) <= S01_AXI_arburst(1 downto 0);
  axi_hp_0_to_s01_couplers_ARCACHE(3 downto 0) <= S01_AXI_arcache(3 downto 0);
  axi_hp_0_to_s01_couplers_ARID(0) <= S01_AXI_arid(0);
  axi_hp_0_to_s01_couplers_ARLEN(7 downto 0) <= S01_AXI_arlen(7 downto 0);
  axi_hp_0_to_s01_couplers_ARLOCK <= S01_AXI_arlock;
  axi_hp_0_to_s01_couplers_ARPROT(2 downto 0) <= S01_AXI_arprot(2 downto 0);
  axi_hp_0_to_s01_couplers_ARQOS(3 downto 0) <= S01_AXI_arqos(3 downto 0);
  axi_hp_0_to_s01_couplers_ARSIZE(2 downto 0) <= S01_AXI_arsize(2 downto 0);
  axi_hp_0_to_s01_couplers_ARVALID <= S01_AXI_arvalid;
  axi_hp_0_to_s01_couplers_AWADDR(31 downto 0) <= S01_AXI_awaddr(31 downto 0);
  axi_hp_0_to_s01_couplers_AWBURST(1 downto 0) <= S01_AXI_awburst(1 downto 0);
  axi_hp_0_to_s01_couplers_AWCACHE(3 downto 0) <= S01_AXI_awcache(3 downto 0);
  axi_hp_0_to_s01_couplers_AWID(0) <= S01_AXI_awid(0);
  axi_hp_0_to_s01_couplers_AWLEN(7 downto 0) <= S01_AXI_awlen(7 downto 0);
  axi_hp_0_to_s01_couplers_AWLOCK <= S01_AXI_awlock;
  axi_hp_0_to_s01_couplers_AWPROT(2 downto 0) <= S01_AXI_awprot(2 downto 0);
  axi_hp_0_to_s01_couplers_AWQOS(3 downto 0) <= S01_AXI_awqos(3 downto 0);
  axi_hp_0_to_s01_couplers_AWSIZE(2 downto 0) <= S01_AXI_awsize(2 downto 0);
  axi_hp_0_to_s01_couplers_AWVALID <= S01_AXI_awvalid;
  axi_hp_0_to_s01_couplers_BREADY <= S01_AXI_bready;
  axi_hp_0_to_s01_couplers_RREADY <= S01_AXI_rready;
  axi_hp_0_to_s01_couplers_WDATA(31 downto 0) <= S01_AXI_wdata(31 downto 0);
  axi_hp_0_to_s01_couplers_WLAST <= S01_AXI_wlast;
  axi_hp_0_to_s01_couplers_WSTRB(3 downto 0) <= S01_AXI_wstrb(3 downto 0);
  axi_hp_0_to_s01_couplers_WVALID <= S01_AXI_wvalid;
  axi_hp_0_to_s02_couplers_ARADDR(31 downto 0) <= S02_AXI_araddr(31 downto 0);
  axi_hp_0_to_s02_couplers_ARPROT(2 downto 0) <= S02_AXI_arprot(2 downto 0);
  axi_hp_0_to_s02_couplers_ARVALID <= S02_AXI_arvalid;
  axi_hp_0_to_s02_couplers_AWADDR(31 downto 0) <= S02_AXI_awaddr(31 downto 0);
  axi_hp_0_to_s02_couplers_AWPROT(2 downto 0) <= S02_AXI_awprot(2 downto 0);
  axi_hp_0_to_s02_couplers_AWVALID <= S02_AXI_awvalid;
  axi_hp_0_to_s02_couplers_BREADY <= S02_AXI_bready;
  axi_hp_0_to_s02_couplers_RREADY <= S02_AXI_rready;
  axi_hp_0_to_s02_couplers_WDATA(31 downto 0) <= S02_AXI_wdata(31 downto 0);
  axi_hp_0_to_s02_couplers_WSTRB(3 downto 0) <= S02_AXI_wstrb(3 downto 0);
  axi_hp_0_to_s02_couplers_WVALID <= S02_AXI_wvalid;
  m00_couplers_to_axi_hp_0_ARREADY <= M00_AXI_arready;
  m00_couplers_to_axi_hp_0_AWREADY <= M00_AXI_awready;
  m00_couplers_to_axi_hp_0_BID(1 downto 0) <= M00_AXI_bid(1 downto 0);
  m00_couplers_to_axi_hp_0_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  m00_couplers_to_axi_hp_0_BVALID <= M00_AXI_bvalid;
  m00_couplers_to_axi_hp_0_RDATA(31 downto 0) <= M00_AXI_rdata(31 downto 0);
  m00_couplers_to_axi_hp_0_RID(1 downto 0) <= M00_AXI_rid(1 downto 0);
  m00_couplers_to_axi_hp_0_RLAST <= M00_AXI_rlast;
  m00_couplers_to_axi_hp_0_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  m00_couplers_to_axi_hp_0_RVALID <= M00_AXI_rvalid;
  m00_couplers_to_axi_hp_0_WREADY <= M00_AXI_wready;
GND: unisim.vcomponents.GND
    port map (
      G => GND_1
    );
m00_couplers: entity work.m00_couplers_imp_7PB8C3
    port map (
      M_ACLK => M00_ACLK_1,
      M_ARESETN(0) => M00_ARESETN_1(0),
      M_AXI_araddr(31 downto 0) => m00_couplers_to_axi_hp_0_ARADDR(31 downto 0),
      M_AXI_arburst(1 downto 0) => m00_couplers_to_axi_hp_0_ARBURST(1 downto 0),
      M_AXI_arcache(3 downto 0) => m00_couplers_to_axi_hp_0_ARCACHE(3 downto 0),
      M_AXI_arid(1 downto 0) => m00_couplers_to_axi_hp_0_ARID(1 downto 0),
      M_AXI_arlen(3 downto 0) => m00_couplers_to_axi_hp_0_ARLEN(3 downto 0),
      M_AXI_arlock(1 downto 0) => m00_couplers_to_axi_hp_0_ARLOCK(1 downto 0),
      M_AXI_arprot(2 downto 0) => m00_couplers_to_axi_hp_0_ARPROT(2 downto 0),
      M_AXI_arqos(3 downto 0) => m00_couplers_to_axi_hp_0_ARQOS(3 downto 0),
      M_AXI_arready => m00_couplers_to_axi_hp_0_ARREADY,
      M_AXI_arsize(2 downto 0) => m00_couplers_to_axi_hp_0_ARSIZE(2 downto 0),
      M_AXI_arvalid => m00_couplers_to_axi_hp_0_ARVALID,
      M_AXI_awaddr(31 downto 0) => m00_couplers_to_axi_hp_0_AWADDR(31 downto 0),
      M_AXI_awburst(1 downto 0) => m00_couplers_to_axi_hp_0_AWBURST(1 downto 0),
      M_AXI_awcache(3 downto 0) => m00_couplers_to_axi_hp_0_AWCACHE(3 downto 0),
      M_AXI_awid(1 downto 0) => m00_couplers_to_axi_hp_0_AWID(1 downto 0),
      M_AXI_awlen(3 downto 0) => m00_couplers_to_axi_hp_0_AWLEN(3 downto 0),
      M_AXI_awlock(1 downto 0) => m00_couplers_to_axi_hp_0_AWLOCK(1 downto 0),
      M_AXI_awprot(2 downto 0) => m00_couplers_to_axi_hp_0_AWPROT(2 downto 0),
      M_AXI_awqos(3 downto 0) => m00_couplers_to_axi_hp_0_AWQOS(3 downto 0),
      M_AXI_awready => m00_couplers_to_axi_hp_0_AWREADY,
      M_AXI_awsize(2 downto 0) => m00_couplers_to_axi_hp_0_AWSIZE(2 downto 0),
      M_AXI_awvalid => m00_couplers_to_axi_hp_0_AWVALID,
      M_AXI_bid(1 downto 0) => m00_couplers_to_axi_hp_0_BID(1 downto 0),
      M_AXI_bready => m00_couplers_to_axi_hp_0_BREADY,
      M_AXI_bresp(1 downto 0) => m00_couplers_to_axi_hp_0_BRESP(1 downto 0),
      M_AXI_bvalid => m00_couplers_to_axi_hp_0_BVALID,
      M_AXI_rdata(31 downto 0) => m00_couplers_to_axi_hp_0_RDATA(31 downto 0),
      M_AXI_rid(1 downto 0) => m00_couplers_to_axi_hp_0_RID(1 downto 0),
      M_AXI_rlast => m00_couplers_to_axi_hp_0_RLAST,
      M_AXI_rready => m00_couplers_to_axi_hp_0_RREADY,
      M_AXI_rresp(1 downto 0) => m00_couplers_to_axi_hp_0_RRESP(1 downto 0),
      M_AXI_rvalid => m00_couplers_to_axi_hp_0_RVALID,
      M_AXI_wdata(31 downto 0) => m00_couplers_to_axi_hp_0_WDATA(31 downto 0),
      M_AXI_wid(1 downto 0) => m00_couplers_to_axi_hp_0_WID(1 downto 0),
      M_AXI_wlast => m00_couplers_to_axi_hp_0_WLAST,
      M_AXI_wready => m00_couplers_to_axi_hp_0_WREADY,
      M_AXI_wstrb(3 downto 0) => m00_couplers_to_axi_hp_0_WSTRB(3 downto 0),
      M_AXI_wvalid => m00_couplers_to_axi_hp_0_WVALID,
      S_ACLK => axi_hp_0_ACLK_net,
      S_ARESETN(0) => axi_hp_0_ARESETN_net(0),
      S_AXI_araddr(31 downto 0) => xbar_to_m00_couplers_ARADDR(31 downto 0),
      S_AXI_arburst(1 downto 0) => xbar_to_m00_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => xbar_to_m00_couplers_ARCACHE(3 downto 0),
      S_AXI_arid(1 downto 0) => xbar_to_m00_couplers_ARID(1 downto 0),
      S_AXI_arlen(7 downto 0) => xbar_to_m00_couplers_ARLEN(7 downto 0),
      S_AXI_arlock(0) => xbar_to_m00_couplers_ARLOCK(0),
      S_AXI_arprot(2 downto 0) => xbar_to_m00_couplers_ARPROT(2 downto 0),
      S_AXI_arqos(3 downto 0) => xbar_to_m00_couplers_ARQOS(3 downto 0),
      S_AXI_arready => xbar_to_m00_couplers_ARREADY,
      S_AXI_arregion(3 downto 0) => xbar_to_m00_couplers_ARREGION(3 downto 0),
      S_AXI_arsize(2 downto 0) => xbar_to_m00_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => xbar_to_m00_couplers_ARVALID(0),
      S_AXI_awaddr(31 downto 0) => xbar_to_m00_couplers_AWADDR(31 downto 0),
      S_AXI_awburst(1 downto 0) => xbar_to_m00_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => xbar_to_m00_couplers_AWCACHE(3 downto 0),
      S_AXI_awid(1 downto 0) => xbar_to_m00_couplers_AWID(1 downto 0),
      S_AXI_awlen(7 downto 0) => xbar_to_m00_couplers_AWLEN(7 downto 0),
      S_AXI_awlock(0) => xbar_to_m00_couplers_AWLOCK(0),
      S_AXI_awprot(2 downto 0) => xbar_to_m00_couplers_AWPROT(2 downto 0),
      S_AXI_awqos(3 downto 0) => xbar_to_m00_couplers_AWQOS(3 downto 0),
      S_AXI_awready => xbar_to_m00_couplers_AWREADY,
      S_AXI_awregion(3 downto 0) => xbar_to_m00_couplers_AWREGION(3 downto 0),
      S_AXI_awsize(2 downto 0) => xbar_to_m00_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => xbar_to_m00_couplers_AWVALID(0),
      S_AXI_bid(1 downto 0) => xbar_to_m00_couplers_BID(1 downto 0),
      S_AXI_bready => xbar_to_m00_couplers_BREADY(0),
      S_AXI_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => xbar_to_m00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      S_AXI_rid(1 downto 0) => xbar_to_m00_couplers_RID(1 downto 0),
      S_AXI_rlast => xbar_to_m00_couplers_RLAST,
      S_AXI_rready => xbar_to_m00_couplers_RREADY(0),
      S_AXI_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => xbar_to_m00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      S_AXI_wlast => xbar_to_m00_couplers_WLAST(0),
      S_AXI_wready => xbar_to_m00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => xbar_to_m00_couplers_WVALID(0)
    );
s00_couplers: entity work.s00_couplers_imp_1YQ9MOH
    port map (
      M_ACLK => axi_hp_0_ACLK_net,
      M_ARESETN(0) => axi_hp_0_ARESETN_net(0),
      M_AXI_araddr(31 downto 0) => s00_couplers_to_xbar_ARADDR(31 downto 0),
      M_AXI_arburst(1 downto 0) => s00_couplers_to_xbar_ARBURST(1 downto 0),
      M_AXI_arcache(3 downto 0) => s00_couplers_to_xbar_ARCACHE(3 downto 0),
      M_AXI_arid(0) => s00_couplers_to_xbar_ARID(0),
      M_AXI_arlen(7 downto 0) => s00_couplers_to_xbar_ARLEN(7 downto 0),
      M_AXI_arlock => s00_couplers_to_xbar_ARLOCK,
      M_AXI_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arqos(3 downto 0) => s00_couplers_to_xbar_ARQOS(3 downto 0),
      M_AXI_arready => s00_couplers_to_xbar_ARREADY(0),
      M_AXI_arsize(2 downto 0) => s00_couplers_to_xbar_ARSIZE(2 downto 0),
      M_AXI_arvalid => s00_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(31 downto 0) => s00_couplers_to_xbar_AWADDR(31 downto 0),
      M_AXI_awburst(1 downto 0) => s00_couplers_to_xbar_AWBURST(1 downto 0),
      M_AXI_awcache(3 downto 0) => s00_couplers_to_xbar_AWCACHE(3 downto 0),
      M_AXI_awid(0) => s00_couplers_to_xbar_AWID(0),
      M_AXI_awlen(7 downto 0) => s00_couplers_to_xbar_AWLEN(7 downto 0),
      M_AXI_awlock => s00_couplers_to_xbar_AWLOCK,
      M_AXI_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awqos(3 downto 0) => s00_couplers_to_xbar_AWQOS(3 downto 0),
      M_AXI_awready => s00_couplers_to_xbar_AWREADY(0),
      M_AXI_awsize(2 downto 0) => s00_couplers_to_xbar_AWSIZE(2 downto 0),
      M_AXI_awvalid => s00_couplers_to_xbar_AWVALID,
      M_AXI_bid(0) => s00_couplers_to_xbar_BID(0),
      M_AXI_bready => s00_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_xbar_BVALID(0),
      M_AXI_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      M_AXI_rid(0) => s00_couplers_to_xbar_RID(0),
      M_AXI_rlast => s00_couplers_to_xbar_RLAST(0),
      M_AXI_rready => s00_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_xbar_RVALID(0),
      M_AXI_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wlast => s00_couplers_to_xbar_WLAST,
      M_AXI_wready => s00_couplers_to_xbar_WREADY(0),
      M_AXI_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s00_couplers_to_xbar_WVALID,
      S_ACLK => S00_ACLK_1,
      S_ARESETN(0) => S00_ARESETN_1(0),
      S_AXI_araddr(31 downto 0) => axi_hp_0_to_s00_couplers_ARADDR(31 downto 0),
      S_AXI_arburst(1 downto 0) => axi_hp_0_to_s00_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => axi_hp_0_to_s00_couplers_ARCACHE(3 downto 0),
      S_AXI_arid(0) => axi_hp_0_to_s00_couplers_ARID(0),
      S_AXI_arlen(7 downto 0) => axi_hp_0_to_s00_couplers_ARLEN(7 downto 0),
      S_AXI_arlock => axi_hp_0_to_s00_couplers_ARLOCK,
      S_AXI_arprot(2 downto 0) => axi_hp_0_to_s00_couplers_ARPROT(2 downto 0),
      S_AXI_arqos(3 downto 0) => axi_hp_0_to_s00_couplers_ARQOS(3 downto 0),
      S_AXI_arready => axi_hp_0_to_s00_couplers_ARREADY,
      S_AXI_arsize(2 downto 0) => axi_hp_0_to_s00_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => axi_hp_0_to_s00_couplers_ARVALID,
      S_AXI_awaddr(31 downto 0) => axi_hp_0_to_s00_couplers_AWADDR(31 downto 0),
      S_AXI_awburst(1 downto 0) => axi_hp_0_to_s00_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => axi_hp_0_to_s00_couplers_AWCACHE(3 downto 0),
      S_AXI_awid(0) => axi_hp_0_to_s00_couplers_AWID(0),
      S_AXI_awlen(7 downto 0) => axi_hp_0_to_s00_couplers_AWLEN(7 downto 0),
      S_AXI_awlock => axi_hp_0_to_s00_couplers_AWLOCK,
      S_AXI_awprot(2 downto 0) => axi_hp_0_to_s00_couplers_AWPROT(2 downto 0),
      S_AXI_awqos(3 downto 0) => axi_hp_0_to_s00_couplers_AWQOS(3 downto 0),
      S_AXI_awready => axi_hp_0_to_s00_couplers_AWREADY,
      S_AXI_awsize(2 downto 0) => axi_hp_0_to_s00_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => axi_hp_0_to_s00_couplers_AWVALID,
      S_AXI_bid(0) => axi_hp_0_to_s00_couplers_BID(0),
      S_AXI_bready => axi_hp_0_to_s00_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => axi_hp_0_to_s00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => axi_hp_0_to_s00_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => axi_hp_0_to_s00_couplers_RDATA(31 downto 0),
      S_AXI_rid(0) => axi_hp_0_to_s00_couplers_RID(0),
      S_AXI_rlast => axi_hp_0_to_s00_couplers_RLAST,
      S_AXI_rready => axi_hp_0_to_s00_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => axi_hp_0_to_s00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => axi_hp_0_to_s00_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => axi_hp_0_to_s00_couplers_WDATA(31 downto 0),
      S_AXI_wlast => axi_hp_0_to_s00_couplers_WLAST,
      S_AXI_wready => axi_hp_0_to_s00_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => axi_hp_0_to_s00_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => axi_hp_0_to_s00_couplers_WVALID
    );
s01_couplers: entity work.s01_couplers_imp_4RDUEN
    port map (
      M_ACLK => axi_hp_0_ACLK_net,
      M_ARESETN(0) => axi_hp_0_ARESETN_net(0),
      M_AXI_araddr(31 downto 0) => s01_couplers_to_xbar_ARADDR(31 downto 0),
      M_AXI_arburst(1 downto 0) => s01_couplers_to_xbar_ARBURST(1 downto 0),
      M_AXI_arcache(3 downto 0) => s01_couplers_to_xbar_ARCACHE(3 downto 0),
      M_AXI_arid(0) => s01_couplers_to_xbar_ARID(0),
      M_AXI_arlen(7 downto 0) => s01_couplers_to_xbar_ARLEN(7 downto 0),
      M_AXI_arlock => s01_couplers_to_xbar_ARLOCK,
      M_AXI_arprot(2 downto 0) => s01_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arqos(3 downto 0) => s01_couplers_to_xbar_ARQOS(3 downto 0),
      M_AXI_arready => s01_couplers_to_xbar_ARREADY(1),
      M_AXI_arsize(2 downto 0) => s01_couplers_to_xbar_ARSIZE(2 downto 0),
      M_AXI_arvalid => s01_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(31 downto 0) => s01_couplers_to_xbar_AWADDR(31 downto 0),
      M_AXI_awburst(1 downto 0) => s01_couplers_to_xbar_AWBURST(1 downto 0),
      M_AXI_awcache(3 downto 0) => s01_couplers_to_xbar_AWCACHE(3 downto 0),
      M_AXI_awid(0) => s01_couplers_to_xbar_AWID(0),
      M_AXI_awlen(7 downto 0) => s01_couplers_to_xbar_AWLEN(7 downto 0),
      M_AXI_awlock => s01_couplers_to_xbar_AWLOCK,
      M_AXI_awprot(2 downto 0) => s01_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awqos(3 downto 0) => s01_couplers_to_xbar_AWQOS(3 downto 0),
      M_AXI_awready => s01_couplers_to_xbar_AWREADY(1),
      M_AXI_awsize(2 downto 0) => s01_couplers_to_xbar_AWSIZE(2 downto 0),
      M_AXI_awvalid => s01_couplers_to_xbar_AWVALID,
      M_AXI_bid(0) => s01_couplers_to_xbar_BID(2),
      M_AXI_bready => s01_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s01_couplers_to_xbar_BRESP(3 downto 2),
      M_AXI_bvalid => s01_couplers_to_xbar_BVALID(1),
      M_AXI_rdata(31 downto 0) => s01_couplers_to_xbar_RDATA(63 downto 32),
      M_AXI_rid(0) => s01_couplers_to_xbar_RID(2),
      M_AXI_rlast => s01_couplers_to_xbar_RLAST(1),
      M_AXI_rready => s01_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s01_couplers_to_xbar_RRESP(3 downto 2),
      M_AXI_rvalid => s01_couplers_to_xbar_RVALID(1),
      M_AXI_wdata(31 downto 0) => s01_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wlast => s01_couplers_to_xbar_WLAST,
      M_AXI_wready => s01_couplers_to_xbar_WREADY(1),
      M_AXI_wstrb(3 downto 0) => s01_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s01_couplers_to_xbar_WVALID,
      S_ACLK => S01_ACLK_1,
      S_ARESETN(0) => S01_ARESETN_1(0),
      S_AXI_araddr(31 downto 0) => axi_hp_0_to_s01_couplers_ARADDR(31 downto 0),
      S_AXI_arburst(1 downto 0) => axi_hp_0_to_s01_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => axi_hp_0_to_s01_couplers_ARCACHE(3 downto 0),
      S_AXI_arid(0) => axi_hp_0_to_s01_couplers_ARID(0),
      S_AXI_arlen(7 downto 0) => axi_hp_0_to_s01_couplers_ARLEN(7 downto 0),
      S_AXI_arlock => axi_hp_0_to_s01_couplers_ARLOCK,
      S_AXI_arprot(2 downto 0) => axi_hp_0_to_s01_couplers_ARPROT(2 downto 0),
      S_AXI_arqos(3 downto 0) => axi_hp_0_to_s01_couplers_ARQOS(3 downto 0),
      S_AXI_arready => axi_hp_0_to_s01_couplers_ARREADY,
      S_AXI_arsize(2 downto 0) => axi_hp_0_to_s01_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => axi_hp_0_to_s01_couplers_ARVALID,
      S_AXI_awaddr(31 downto 0) => axi_hp_0_to_s01_couplers_AWADDR(31 downto 0),
      S_AXI_awburst(1 downto 0) => axi_hp_0_to_s01_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => axi_hp_0_to_s01_couplers_AWCACHE(3 downto 0),
      S_AXI_awid(0) => axi_hp_0_to_s01_couplers_AWID(0),
      S_AXI_awlen(7 downto 0) => axi_hp_0_to_s01_couplers_AWLEN(7 downto 0),
      S_AXI_awlock => axi_hp_0_to_s01_couplers_AWLOCK,
      S_AXI_awprot(2 downto 0) => axi_hp_0_to_s01_couplers_AWPROT(2 downto 0),
      S_AXI_awqos(3 downto 0) => axi_hp_0_to_s01_couplers_AWQOS(3 downto 0),
      S_AXI_awready => axi_hp_0_to_s01_couplers_AWREADY,
      S_AXI_awsize(2 downto 0) => axi_hp_0_to_s01_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => axi_hp_0_to_s01_couplers_AWVALID,
      S_AXI_bid(0) => axi_hp_0_to_s01_couplers_BID(0),
      S_AXI_bready => axi_hp_0_to_s01_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => axi_hp_0_to_s01_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => axi_hp_0_to_s01_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => axi_hp_0_to_s01_couplers_RDATA(31 downto 0),
      S_AXI_rid(0) => axi_hp_0_to_s01_couplers_RID(0),
      S_AXI_rlast => axi_hp_0_to_s01_couplers_RLAST,
      S_AXI_rready => axi_hp_0_to_s01_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => axi_hp_0_to_s01_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => axi_hp_0_to_s01_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => axi_hp_0_to_s01_couplers_WDATA(31 downto 0),
      S_AXI_wlast => axi_hp_0_to_s01_couplers_WLAST,
      S_AXI_wready => axi_hp_0_to_s01_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => axi_hp_0_to_s01_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => axi_hp_0_to_s01_couplers_WVALID
    );
s02_couplers: entity work.s02_couplers_imp_1XEF8Z0
    port map (
      M_ACLK => axi_hp_0_ACLK_net,
      M_ARESETN(0) => axi_hp_0_ARESETN_net(0),
      M_AXI_araddr(31 downto 0) => s02_couplers_to_xbar_ARADDR(31 downto 0),
      M_AXI_arburst(1 downto 0) => s02_couplers_to_xbar_ARBURST(1 downto 0),
      M_AXI_arcache(3 downto 0) => s02_couplers_to_xbar_ARCACHE(3 downto 0),
      M_AXI_arlen(7 downto 0) => s02_couplers_to_xbar_ARLEN(7 downto 0),
      M_AXI_arlock(0) => s02_couplers_to_xbar_ARLOCK(0),
      M_AXI_arprot(2 downto 0) => s02_couplers_to_xbar_ARPROT(2 downto 0),
      M_AXI_arqos(3 downto 0) => s02_couplers_to_xbar_ARQOS(3 downto 0),
      M_AXI_arready => s02_couplers_to_xbar_ARREADY(2),
      M_AXI_arsize(2 downto 0) => s02_couplers_to_xbar_ARSIZE(2 downto 0),
      M_AXI_arvalid => s02_couplers_to_xbar_ARVALID,
      M_AXI_awaddr(31 downto 0) => s02_couplers_to_xbar_AWADDR(31 downto 0),
      M_AXI_awburst(1 downto 0) => s02_couplers_to_xbar_AWBURST(1 downto 0),
      M_AXI_awcache(3 downto 0) => s02_couplers_to_xbar_AWCACHE(3 downto 0),
      M_AXI_awlen(7 downto 0) => s02_couplers_to_xbar_AWLEN(7 downto 0),
      M_AXI_awlock(0) => s02_couplers_to_xbar_AWLOCK(0),
      M_AXI_awprot(2 downto 0) => s02_couplers_to_xbar_AWPROT(2 downto 0),
      M_AXI_awqos(3 downto 0) => s02_couplers_to_xbar_AWQOS(3 downto 0),
      M_AXI_awready => s02_couplers_to_xbar_AWREADY(2),
      M_AXI_awsize(2 downto 0) => s02_couplers_to_xbar_AWSIZE(2 downto 0),
      M_AXI_awvalid => s02_couplers_to_xbar_AWVALID,
      M_AXI_bready => s02_couplers_to_xbar_BREADY,
      M_AXI_bresp(1 downto 0) => s02_couplers_to_xbar_BRESP(5 downto 4),
      M_AXI_bvalid => s02_couplers_to_xbar_BVALID(2),
      M_AXI_rdata(31 downto 0) => s02_couplers_to_xbar_RDATA(95 downto 64),
      M_AXI_rlast => s02_couplers_to_xbar_RLAST(2),
      M_AXI_rready => s02_couplers_to_xbar_RREADY,
      M_AXI_rresp(1 downto 0) => s02_couplers_to_xbar_RRESP(5 downto 4),
      M_AXI_rvalid => s02_couplers_to_xbar_RVALID(2),
      M_AXI_wdata(31 downto 0) => s02_couplers_to_xbar_WDATA(31 downto 0),
      M_AXI_wlast => s02_couplers_to_xbar_WLAST,
      M_AXI_wready => s02_couplers_to_xbar_WREADY(2),
      M_AXI_wstrb(3 downto 0) => s02_couplers_to_xbar_WSTRB(3 downto 0),
      M_AXI_wvalid => s02_couplers_to_xbar_WVALID,
      S_ACLK => S02_ACLK_1,
      S_ARESETN(0) => S02_ARESETN_1(0),
      S_AXI_araddr(31 downto 0) => axi_hp_0_to_s02_couplers_ARADDR(31 downto 0),
      S_AXI_arprot(2 downto 0) => axi_hp_0_to_s02_couplers_ARPROT(2 downto 0),
      S_AXI_arready => axi_hp_0_to_s02_couplers_ARREADY,
      S_AXI_arvalid => axi_hp_0_to_s02_couplers_ARVALID,
      S_AXI_awaddr(31 downto 0) => axi_hp_0_to_s02_couplers_AWADDR(31 downto 0),
      S_AXI_awprot(2 downto 0) => axi_hp_0_to_s02_couplers_AWPROT(2 downto 0),
      S_AXI_awready => axi_hp_0_to_s02_couplers_AWREADY,
      S_AXI_awvalid => axi_hp_0_to_s02_couplers_AWVALID,
      S_AXI_bready => axi_hp_0_to_s02_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => axi_hp_0_to_s02_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => axi_hp_0_to_s02_couplers_BVALID,
      S_AXI_rdata(31 downto 0) => axi_hp_0_to_s02_couplers_RDATA(31 downto 0),
      S_AXI_rready => axi_hp_0_to_s02_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => axi_hp_0_to_s02_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => axi_hp_0_to_s02_couplers_RVALID,
      S_AXI_wdata(31 downto 0) => axi_hp_0_to_s02_couplers_WDATA(31 downto 0),
      S_AXI_wready => axi_hp_0_to_s02_couplers_WREADY,
      S_AXI_wstrb(3 downto 0) => axi_hp_0_to_s02_couplers_WSTRB(3 downto 0),
      S_AXI_wvalid => axi_hp_0_to_s02_couplers_WVALID
    );
xbar: component system_xbar_1
    port map (
      aclk => axi_hp_0_ACLK_net,
      aresetn => axi_hp_0_ARESETN_net(0),
      m_axi_araddr(31 downto 0) => xbar_to_m00_couplers_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => xbar_to_m00_couplers_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => xbar_to_m00_couplers_ARCACHE(3 downto 0),
      m_axi_arid(1 downto 0) => xbar_to_m00_couplers_ARID(1 downto 0),
      m_axi_arlen(7 downto 0) => xbar_to_m00_couplers_ARLEN(7 downto 0),
      m_axi_arlock(0) => xbar_to_m00_couplers_ARLOCK(0),
      m_axi_arprot(2 downto 0) => xbar_to_m00_couplers_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => xbar_to_m00_couplers_ARQOS(3 downto 0),
      m_axi_arready(0) => xbar_to_m00_couplers_ARREADY,
      m_axi_arregion(3 downto 0) => xbar_to_m00_couplers_ARREGION(3 downto 0),
      m_axi_arsize(2 downto 0) => xbar_to_m00_couplers_ARSIZE(2 downto 0),
      m_axi_arvalid(0) => xbar_to_m00_couplers_ARVALID(0),
      m_axi_awaddr(31 downto 0) => xbar_to_m00_couplers_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => xbar_to_m00_couplers_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => xbar_to_m00_couplers_AWCACHE(3 downto 0),
      m_axi_awid(1 downto 0) => xbar_to_m00_couplers_AWID(1 downto 0),
      m_axi_awlen(7 downto 0) => xbar_to_m00_couplers_AWLEN(7 downto 0),
      m_axi_awlock(0) => xbar_to_m00_couplers_AWLOCK(0),
      m_axi_awprot(2 downto 0) => xbar_to_m00_couplers_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => xbar_to_m00_couplers_AWQOS(3 downto 0),
      m_axi_awready(0) => xbar_to_m00_couplers_AWREADY,
      m_axi_awregion(3 downto 0) => xbar_to_m00_couplers_AWREGION(3 downto 0),
      m_axi_awsize(2 downto 0) => xbar_to_m00_couplers_AWSIZE(2 downto 0),
      m_axi_awvalid(0) => xbar_to_m00_couplers_AWVALID(0),
      m_axi_bid(1 downto 0) => xbar_to_m00_couplers_BID(1 downto 0),
      m_axi_bready(0) => xbar_to_m00_couplers_BREADY(0),
      m_axi_bresp(1 downto 0) => xbar_to_m00_couplers_BRESP(1 downto 0),
      m_axi_bvalid(0) => xbar_to_m00_couplers_BVALID,
      m_axi_rdata(31 downto 0) => xbar_to_m00_couplers_RDATA(31 downto 0),
      m_axi_rid(1 downto 0) => xbar_to_m00_couplers_RID(1 downto 0),
      m_axi_rlast(0) => xbar_to_m00_couplers_RLAST,
      m_axi_rready(0) => xbar_to_m00_couplers_RREADY(0),
      m_axi_rresp(1 downto 0) => xbar_to_m00_couplers_RRESP(1 downto 0),
      m_axi_rvalid(0) => xbar_to_m00_couplers_RVALID,
      m_axi_wdata(31 downto 0) => xbar_to_m00_couplers_WDATA(31 downto 0),
      m_axi_wlast(0) => xbar_to_m00_couplers_WLAST(0),
      m_axi_wready(0) => xbar_to_m00_couplers_WREADY,
      m_axi_wstrb(3 downto 0) => xbar_to_m00_couplers_WSTRB(3 downto 0),
      m_axi_wvalid(0) => xbar_to_m00_couplers_WVALID(0),
      s_axi_araddr(95 downto 64) => s02_couplers_to_xbar_ARADDR(31 downto 0),
      s_axi_araddr(63 downto 32) => s01_couplers_to_xbar_ARADDR(31 downto 0),
      s_axi_araddr(31 downto 0) => s00_couplers_to_xbar_ARADDR(31 downto 0),
      s_axi_arburst(5 downto 4) => s02_couplers_to_xbar_ARBURST(1 downto 0),
      s_axi_arburst(3 downto 2) => s01_couplers_to_xbar_ARBURST(1 downto 0),
      s_axi_arburst(1 downto 0) => s00_couplers_to_xbar_ARBURST(1 downto 0),
      s_axi_arcache(11 downto 8) => s02_couplers_to_xbar_ARCACHE(3 downto 0),
      s_axi_arcache(7 downto 4) => s01_couplers_to_xbar_ARCACHE(3 downto 0),
      s_axi_arcache(3 downto 0) => s00_couplers_to_xbar_ARCACHE(3 downto 0),
      s_axi_arid(5) => GND_1,
      s_axi_arid(4) => GND_1,
      s_axi_arid(3) => NLW_xbar_s_axi_arid_UNCONNECTED(3),
      s_axi_arid(2) => s01_couplers_to_xbar_ARID(0),
      s_axi_arid(1) => NLW_xbar_s_axi_arid_UNCONNECTED(1),
      s_axi_arid(0) => s00_couplers_to_xbar_ARID(0),
      s_axi_arlen(23 downto 16) => s02_couplers_to_xbar_ARLEN(7 downto 0),
      s_axi_arlen(15 downto 8) => s01_couplers_to_xbar_ARLEN(7 downto 0),
      s_axi_arlen(7 downto 0) => s00_couplers_to_xbar_ARLEN(7 downto 0),
      s_axi_arlock(2) => s02_couplers_to_xbar_ARLOCK(0),
      s_axi_arlock(1) => s01_couplers_to_xbar_ARLOCK,
      s_axi_arlock(0) => s00_couplers_to_xbar_ARLOCK,
      s_axi_arprot(8 downto 6) => s02_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arprot(5 downto 3) => s01_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arprot(2 downto 0) => s00_couplers_to_xbar_ARPROT(2 downto 0),
      s_axi_arqos(11 downto 8) => s02_couplers_to_xbar_ARQOS(3 downto 0),
      s_axi_arqos(7 downto 4) => s01_couplers_to_xbar_ARQOS(3 downto 0),
      s_axi_arqos(3 downto 0) => s00_couplers_to_xbar_ARQOS(3 downto 0),
      s_axi_arready(2) => s02_couplers_to_xbar_ARREADY(2),
      s_axi_arready(1) => s01_couplers_to_xbar_ARREADY(1),
      s_axi_arready(0) => s00_couplers_to_xbar_ARREADY(0),
      s_axi_arsize(8 downto 6) => s02_couplers_to_xbar_ARSIZE(2 downto 0),
      s_axi_arsize(5 downto 3) => s01_couplers_to_xbar_ARSIZE(2 downto 0),
      s_axi_arsize(2 downto 0) => s00_couplers_to_xbar_ARSIZE(2 downto 0),
      s_axi_arvalid(2) => s02_couplers_to_xbar_ARVALID,
      s_axi_arvalid(1) => s01_couplers_to_xbar_ARVALID,
      s_axi_arvalid(0) => s00_couplers_to_xbar_ARVALID,
      s_axi_awaddr(95 downto 64) => s02_couplers_to_xbar_AWADDR(31 downto 0),
      s_axi_awaddr(63 downto 32) => s01_couplers_to_xbar_AWADDR(31 downto 0),
      s_axi_awaddr(31 downto 0) => s00_couplers_to_xbar_AWADDR(31 downto 0),
      s_axi_awburst(5 downto 4) => s02_couplers_to_xbar_AWBURST(1 downto 0),
      s_axi_awburst(3 downto 2) => s01_couplers_to_xbar_AWBURST(1 downto 0),
      s_axi_awburst(1 downto 0) => s00_couplers_to_xbar_AWBURST(1 downto 0),
      s_axi_awcache(11 downto 8) => s02_couplers_to_xbar_AWCACHE(3 downto 0),
      s_axi_awcache(7 downto 4) => s01_couplers_to_xbar_AWCACHE(3 downto 0),
      s_axi_awcache(3 downto 0) => s00_couplers_to_xbar_AWCACHE(3 downto 0),
      s_axi_awid(5) => GND_1,
      s_axi_awid(4) => GND_1,
      s_axi_awid(3) => NLW_xbar_s_axi_awid_UNCONNECTED(3),
      s_axi_awid(2) => s01_couplers_to_xbar_AWID(0),
      s_axi_awid(1) => NLW_xbar_s_axi_awid_UNCONNECTED(1),
      s_axi_awid(0) => s00_couplers_to_xbar_AWID(0),
      s_axi_awlen(23 downto 16) => s02_couplers_to_xbar_AWLEN(7 downto 0),
      s_axi_awlen(15 downto 8) => s01_couplers_to_xbar_AWLEN(7 downto 0),
      s_axi_awlen(7 downto 0) => s00_couplers_to_xbar_AWLEN(7 downto 0),
      s_axi_awlock(2) => s02_couplers_to_xbar_AWLOCK(0),
      s_axi_awlock(1) => s01_couplers_to_xbar_AWLOCK,
      s_axi_awlock(0) => s00_couplers_to_xbar_AWLOCK,
      s_axi_awprot(8 downto 6) => s02_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awprot(5 downto 3) => s01_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awprot(2 downto 0) => s00_couplers_to_xbar_AWPROT(2 downto 0),
      s_axi_awqos(11 downto 8) => s02_couplers_to_xbar_AWQOS(3 downto 0),
      s_axi_awqos(7 downto 4) => s01_couplers_to_xbar_AWQOS(3 downto 0),
      s_axi_awqos(3 downto 0) => s00_couplers_to_xbar_AWQOS(3 downto 0),
      s_axi_awready(2) => s02_couplers_to_xbar_AWREADY(2),
      s_axi_awready(1) => s01_couplers_to_xbar_AWREADY(1),
      s_axi_awready(0) => s00_couplers_to_xbar_AWREADY(0),
      s_axi_awsize(8 downto 6) => s02_couplers_to_xbar_AWSIZE(2 downto 0),
      s_axi_awsize(5 downto 3) => s01_couplers_to_xbar_AWSIZE(2 downto 0),
      s_axi_awsize(2 downto 0) => s00_couplers_to_xbar_AWSIZE(2 downto 0),
      s_axi_awvalid(2) => s02_couplers_to_xbar_AWVALID,
      s_axi_awvalid(1) => s01_couplers_to_xbar_AWVALID,
      s_axi_awvalid(0) => s00_couplers_to_xbar_AWVALID,
      s_axi_bid(5 downto 4) => NLW_xbar_s_axi_bid_UNCONNECTED(5 downto 4),
      s_axi_bid(3 downto 2) => s01_couplers_to_xbar_BID(3 downto 2),
      s_axi_bid(1 downto 0) => s00_couplers_to_xbar_BID(1 downto 0),
      s_axi_bready(2) => s02_couplers_to_xbar_BREADY,
      s_axi_bready(1) => s01_couplers_to_xbar_BREADY,
      s_axi_bready(0) => s00_couplers_to_xbar_BREADY,
      s_axi_bresp(5 downto 4) => s02_couplers_to_xbar_BRESP(5 downto 4),
      s_axi_bresp(3 downto 2) => s01_couplers_to_xbar_BRESP(3 downto 2),
      s_axi_bresp(1 downto 0) => s00_couplers_to_xbar_BRESP(1 downto 0),
      s_axi_bvalid(2) => s02_couplers_to_xbar_BVALID(2),
      s_axi_bvalid(1) => s01_couplers_to_xbar_BVALID(1),
      s_axi_bvalid(0) => s00_couplers_to_xbar_BVALID(0),
      s_axi_rdata(95 downto 64) => s02_couplers_to_xbar_RDATA(95 downto 64),
      s_axi_rdata(63 downto 32) => s01_couplers_to_xbar_RDATA(63 downto 32),
      s_axi_rdata(31 downto 0) => s00_couplers_to_xbar_RDATA(31 downto 0),
      s_axi_rid(5 downto 4) => NLW_xbar_s_axi_rid_UNCONNECTED(5 downto 4),
      s_axi_rid(3 downto 2) => s01_couplers_to_xbar_RID(3 downto 2),
      s_axi_rid(1 downto 0) => s00_couplers_to_xbar_RID(1 downto 0),
      s_axi_rlast(2) => s02_couplers_to_xbar_RLAST(2),
      s_axi_rlast(1) => s01_couplers_to_xbar_RLAST(1),
      s_axi_rlast(0) => s00_couplers_to_xbar_RLAST(0),
      s_axi_rready(2) => s02_couplers_to_xbar_RREADY,
      s_axi_rready(1) => s01_couplers_to_xbar_RREADY,
      s_axi_rready(0) => s00_couplers_to_xbar_RREADY,
      s_axi_rresp(5 downto 4) => s02_couplers_to_xbar_RRESP(5 downto 4),
      s_axi_rresp(3 downto 2) => s01_couplers_to_xbar_RRESP(3 downto 2),
      s_axi_rresp(1 downto 0) => s00_couplers_to_xbar_RRESP(1 downto 0),
      s_axi_rvalid(2) => s02_couplers_to_xbar_RVALID(2),
      s_axi_rvalid(1) => s01_couplers_to_xbar_RVALID(1),
      s_axi_rvalid(0) => s00_couplers_to_xbar_RVALID(0),
      s_axi_wdata(95 downto 64) => s02_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wdata(63 downto 32) => s01_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wdata(31 downto 0) => s00_couplers_to_xbar_WDATA(31 downto 0),
      s_axi_wlast(2) => s02_couplers_to_xbar_WLAST,
      s_axi_wlast(1) => s01_couplers_to_xbar_WLAST,
      s_axi_wlast(0) => s00_couplers_to_xbar_WLAST,
      s_axi_wready(2) => s02_couplers_to_xbar_WREADY(2),
      s_axi_wready(1) => s01_couplers_to_xbar_WREADY(1),
      s_axi_wready(0) => s00_couplers_to_xbar_WREADY(0),
      s_axi_wstrb(11 downto 8) => s02_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wstrb(7 downto 4) => s01_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wstrb(3 downto 0) => s00_couplers_to_xbar_WSTRB(3 downto 0),
      s_axi_wvalid(2) => s02_couplers_to_xbar_WVALID,
      s_axi_wvalid(1) => s01_couplers_to_xbar_WVALID,
      s_axi_wvalid(0) => s00_couplers_to_xbar_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_axi_hp_2_0 is
  port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_ACLK : in STD_LOGIC;
    M00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXI_rlast : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC;
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M00_AXI_wlast : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    S00_ACLK : in STD_LOGIC;
    S00_ARESETN : in STD_LOGIC_VECTOR ( 0 to 0 );
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awlen : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    S00_AXI_rlast : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S00_AXI_wlast : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC
  );
end system_axi_hp_2_0;

architecture STRUCTURE of system_axi_hp_2_0 is
  signal S00_ACLK_1 : STD_LOGIC;
  signal S00_ARESETN_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_2_ACLK_net : STD_LOGIC;
  signal axi_hp_2_ARESETN_net : STD_LOGIC_VECTOR ( 0 to 0 );
  signal axi_hp_2_to_s00_couplers_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_2_to_s00_couplers_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_to_s00_couplers_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_to_s00_couplers_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_to_s00_couplers_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_to_s00_couplers_ARREADY : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_to_s00_couplers_ARVALID : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_2_to_s00_couplers_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_to_s00_couplers_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_to_s00_couplers_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_to_s00_couplers_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_to_s00_couplers_AWREADY : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_to_s00_couplers_AWVALID : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_BREADY : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_to_s00_couplers_BVALID : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_RDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal axi_hp_2_to_s00_couplers_RLAST : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_RREADY : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_to_s00_couplers_RVALID : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_WDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal axi_hp_2_to_s00_couplers_WLAST : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_WREADY : STD_LOGIC;
  signal axi_hp_2_to_s00_couplers_WSTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_hp_2_to_s00_couplers_WVALID : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_axi_hp_2_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_axi_hp_2_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_axi_hp_2_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_axi_hp_2_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_axi_hp_2_ARREADY : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_axi_hp_2_ARVALID : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal s00_couplers_to_axi_hp_2_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_axi_hp_2_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_axi_hp_2_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal s00_couplers_to_axi_hp_2_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_axi_hp_2_AWREADY : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal s00_couplers_to_axi_hp_2_AWVALID : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_BREADY : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_axi_hp_2_BVALID : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_RDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal s00_couplers_to_axi_hp_2_RLAST : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_RREADY : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal s00_couplers_to_axi_hp_2_RVALID : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_WDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal s00_couplers_to_axi_hp_2_WLAST : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_WREADY : STD_LOGIC;
  signal s00_couplers_to_axi_hp_2_WSTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal s00_couplers_to_axi_hp_2_WVALID : STD_LOGIC;
begin
  M00_AXI_araddr(31 downto 0) <= s00_couplers_to_axi_hp_2_ARADDR(31 downto 0);
  M00_AXI_arburst(1 downto 0) <= s00_couplers_to_axi_hp_2_ARBURST(1 downto 0);
  M00_AXI_arcache(3 downto 0) <= s00_couplers_to_axi_hp_2_ARCACHE(3 downto 0);
  M00_AXI_arlen(3 downto 0) <= s00_couplers_to_axi_hp_2_ARLEN(3 downto 0);
  M00_AXI_arprot(2 downto 0) <= s00_couplers_to_axi_hp_2_ARPROT(2 downto 0);
  M00_AXI_arsize(2 downto 0) <= s00_couplers_to_axi_hp_2_ARSIZE(2 downto 0);
  M00_AXI_arvalid <= s00_couplers_to_axi_hp_2_ARVALID;
  M00_AXI_awaddr(31 downto 0) <= s00_couplers_to_axi_hp_2_AWADDR(31 downto 0);
  M00_AXI_awburst(1 downto 0) <= s00_couplers_to_axi_hp_2_AWBURST(1 downto 0);
  M00_AXI_awcache(3 downto 0) <= s00_couplers_to_axi_hp_2_AWCACHE(3 downto 0);
  M00_AXI_awlen(3 downto 0) <= s00_couplers_to_axi_hp_2_AWLEN(3 downto 0);
  M00_AXI_awprot(2 downto 0) <= s00_couplers_to_axi_hp_2_AWPROT(2 downto 0);
  M00_AXI_awsize(2 downto 0) <= s00_couplers_to_axi_hp_2_AWSIZE(2 downto 0);
  M00_AXI_awvalid <= s00_couplers_to_axi_hp_2_AWVALID;
  M00_AXI_bready <= s00_couplers_to_axi_hp_2_BREADY;
  M00_AXI_rready <= s00_couplers_to_axi_hp_2_RREADY;
  M00_AXI_wdata(63 downto 0) <= s00_couplers_to_axi_hp_2_WDATA(63 downto 0);
  M00_AXI_wlast <= s00_couplers_to_axi_hp_2_WLAST;
  M00_AXI_wstrb(7 downto 0) <= s00_couplers_to_axi_hp_2_WSTRB(7 downto 0);
  M00_AXI_wvalid <= s00_couplers_to_axi_hp_2_WVALID;
  S00_ACLK_1 <= S00_ACLK;
  S00_ARESETN_1(0) <= S00_ARESETN(0);
  S00_AXI_arready <= axi_hp_2_to_s00_couplers_ARREADY;
  S00_AXI_awready <= axi_hp_2_to_s00_couplers_AWREADY;
  S00_AXI_bresp(1 downto 0) <= axi_hp_2_to_s00_couplers_BRESP(1 downto 0);
  S00_AXI_bvalid <= axi_hp_2_to_s00_couplers_BVALID;
  S00_AXI_rdata(63 downto 0) <= axi_hp_2_to_s00_couplers_RDATA(63 downto 0);
  S00_AXI_rlast <= axi_hp_2_to_s00_couplers_RLAST;
  S00_AXI_rresp(1 downto 0) <= axi_hp_2_to_s00_couplers_RRESP(1 downto 0);
  S00_AXI_rvalid <= axi_hp_2_to_s00_couplers_RVALID;
  S00_AXI_wready <= axi_hp_2_to_s00_couplers_WREADY;
  axi_hp_2_ACLK_net <= M00_ACLK;
  axi_hp_2_ARESETN_net(0) <= M00_ARESETN(0);
  axi_hp_2_to_s00_couplers_ARADDR(31 downto 0) <= S00_AXI_araddr(31 downto 0);
  axi_hp_2_to_s00_couplers_ARBURST(1 downto 0) <= S00_AXI_arburst(1 downto 0);
  axi_hp_2_to_s00_couplers_ARCACHE(3 downto 0) <= S00_AXI_arcache(3 downto 0);
  axi_hp_2_to_s00_couplers_ARLEN(3 downto 0) <= S00_AXI_arlen(3 downto 0);
  axi_hp_2_to_s00_couplers_ARPROT(2 downto 0) <= S00_AXI_arprot(2 downto 0);
  axi_hp_2_to_s00_couplers_ARSIZE(2 downto 0) <= S00_AXI_arsize(2 downto 0);
  axi_hp_2_to_s00_couplers_ARVALID <= S00_AXI_arvalid;
  axi_hp_2_to_s00_couplers_AWADDR(31 downto 0) <= S00_AXI_awaddr(31 downto 0);
  axi_hp_2_to_s00_couplers_AWBURST(1 downto 0) <= S00_AXI_awburst(1 downto 0);
  axi_hp_2_to_s00_couplers_AWCACHE(3 downto 0) <= S00_AXI_awcache(3 downto 0);
  axi_hp_2_to_s00_couplers_AWLEN(3 downto 0) <= S00_AXI_awlen(3 downto 0);
  axi_hp_2_to_s00_couplers_AWPROT(2 downto 0) <= S00_AXI_awprot(2 downto 0);
  axi_hp_2_to_s00_couplers_AWSIZE(2 downto 0) <= S00_AXI_awsize(2 downto 0);
  axi_hp_2_to_s00_couplers_AWVALID <= S00_AXI_awvalid;
  axi_hp_2_to_s00_couplers_BREADY <= S00_AXI_bready;
  axi_hp_2_to_s00_couplers_RREADY <= S00_AXI_rready;
  axi_hp_2_to_s00_couplers_WDATA(63 downto 0) <= S00_AXI_wdata(63 downto 0);
  axi_hp_2_to_s00_couplers_WLAST <= S00_AXI_wlast;
  axi_hp_2_to_s00_couplers_WSTRB(7 downto 0) <= S00_AXI_wstrb(7 downto 0);
  axi_hp_2_to_s00_couplers_WVALID <= S00_AXI_wvalid;
  s00_couplers_to_axi_hp_2_ARREADY <= M00_AXI_arready;
  s00_couplers_to_axi_hp_2_AWREADY <= M00_AXI_awready;
  s00_couplers_to_axi_hp_2_BRESP(1 downto 0) <= M00_AXI_bresp(1 downto 0);
  s00_couplers_to_axi_hp_2_BVALID <= M00_AXI_bvalid;
  s00_couplers_to_axi_hp_2_RDATA(63 downto 0) <= M00_AXI_rdata(63 downto 0);
  s00_couplers_to_axi_hp_2_RLAST <= M00_AXI_rlast;
  s00_couplers_to_axi_hp_2_RRESP(1 downto 0) <= M00_AXI_rresp(1 downto 0);
  s00_couplers_to_axi_hp_2_RVALID <= M00_AXI_rvalid;
  s00_couplers_to_axi_hp_2_WREADY <= M00_AXI_wready;
s00_couplers: entity work.s00_couplers_imp_8QTXOC
    port map (
      M_ACLK => axi_hp_2_ACLK_net,
      M_ARESETN(0) => axi_hp_2_ARESETN_net(0),
      M_AXI_araddr(31 downto 0) => s00_couplers_to_axi_hp_2_ARADDR(31 downto 0),
      M_AXI_arburst(1 downto 0) => s00_couplers_to_axi_hp_2_ARBURST(1 downto 0),
      M_AXI_arcache(3 downto 0) => s00_couplers_to_axi_hp_2_ARCACHE(3 downto 0),
      M_AXI_arlen(3 downto 0) => s00_couplers_to_axi_hp_2_ARLEN(3 downto 0),
      M_AXI_arprot(2 downto 0) => s00_couplers_to_axi_hp_2_ARPROT(2 downto 0),
      M_AXI_arready => s00_couplers_to_axi_hp_2_ARREADY,
      M_AXI_arsize(2 downto 0) => s00_couplers_to_axi_hp_2_ARSIZE(2 downto 0),
      M_AXI_arvalid => s00_couplers_to_axi_hp_2_ARVALID,
      M_AXI_awaddr(31 downto 0) => s00_couplers_to_axi_hp_2_AWADDR(31 downto 0),
      M_AXI_awburst(1 downto 0) => s00_couplers_to_axi_hp_2_AWBURST(1 downto 0),
      M_AXI_awcache(3 downto 0) => s00_couplers_to_axi_hp_2_AWCACHE(3 downto 0),
      M_AXI_awlen(3 downto 0) => s00_couplers_to_axi_hp_2_AWLEN(3 downto 0),
      M_AXI_awprot(2 downto 0) => s00_couplers_to_axi_hp_2_AWPROT(2 downto 0),
      M_AXI_awready => s00_couplers_to_axi_hp_2_AWREADY,
      M_AXI_awsize(2 downto 0) => s00_couplers_to_axi_hp_2_AWSIZE(2 downto 0),
      M_AXI_awvalid => s00_couplers_to_axi_hp_2_AWVALID,
      M_AXI_bready => s00_couplers_to_axi_hp_2_BREADY,
      M_AXI_bresp(1 downto 0) => s00_couplers_to_axi_hp_2_BRESP(1 downto 0),
      M_AXI_bvalid => s00_couplers_to_axi_hp_2_BVALID,
      M_AXI_rdata(63 downto 0) => s00_couplers_to_axi_hp_2_RDATA(63 downto 0),
      M_AXI_rlast => s00_couplers_to_axi_hp_2_RLAST,
      M_AXI_rready => s00_couplers_to_axi_hp_2_RREADY,
      M_AXI_rresp(1 downto 0) => s00_couplers_to_axi_hp_2_RRESP(1 downto 0),
      M_AXI_rvalid => s00_couplers_to_axi_hp_2_RVALID,
      M_AXI_wdata(63 downto 0) => s00_couplers_to_axi_hp_2_WDATA(63 downto 0),
      M_AXI_wlast => s00_couplers_to_axi_hp_2_WLAST,
      M_AXI_wready => s00_couplers_to_axi_hp_2_WREADY,
      M_AXI_wstrb(7 downto 0) => s00_couplers_to_axi_hp_2_WSTRB(7 downto 0),
      M_AXI_wvalid => s00_couplers_to_axi_hp_2_WVALID,
      S_ACLK => S00_ACLK_1,
      S_ARESETN(0) => S00_ARESETN_1(0),
      S_AXI_araddr(31 downto 0) => axi_hp_2_to_s00_couplers_ARADDR(31 downto 0),
      S_AXI_arburst(1 downto 0) => axi_hp_2_to_s00_couplers_ARBURST(1 downto 0),
      S_AXI_arcache(3 downto 0) => axi_hp_2_to_s00_couplers_ARCACHE(3 downto 0),
      S_AXI_arlen(3 downto 0) => axi_hp_2_to_s00_couplers_ARLEN(3 downto 0),
      S_AXI_arprot(2 downto 0) => axi_hp_2_to_s00_couplers_ARPROT(2 downto 0),
      S_AXI_arready => axi_hp_2_to_s00_couplers_ARREADY,
      S_AXI_arsize(2 downto 0) => axi_hp_2_to_s00_couplers_ARSIZE(2 downto 0),
      S_AXI_arvalid => axi_hp_2_to_s00_couplers_ARVALID,
      S_AXI_awaddr(31 downto 0) => axi_hp_2_to_s00_couplers_AWADDR(31 downto 0),
      S_AXI_awburst(1 downto 0) => axi_hp_2_to_s00_couplers_AWBURST(1 downto 0),
      S_AXI_awcache(3 downto 0) => axi_hp_2_to_s00_couplers_AWCACHE(3 downto 0),
      S_AXI_awlen(3 downto 0) => axi_hp_2_to_s00_couplers_AWLEN(3 downto 0),
      S_AXI_awprot(2 downto 0) => axi_hp_2_to_s00_couplers_AWPROT(2 downto 0),
      S_AXI_awready => axi_hp_2_to_s00_couplers_AWREADY,
      S_AXI_awsize(2 downto 0) => axi_hp_2_to_s00_couplers_AWSIZE(2 downto 0),
      S_AXI_awvalid => axi_hp_2_to_s00_couplers_AWVALID,
      S_AXI_bready => axi_hp_2_to_s00_couplers_BREADY,
      S_AXI_bresp(1 downto 0) => axi_hp_2_to_s00_couplers_BRESP(1 downto 0),
      S_AXI_bvalid => axi_hp_2_to_s00_couplers_BVALID,
      S_AXI_rdata(63 downto 0) => axi_hp_2_to_s00_couplers_RDATA(63 downto 0),
      S_AXI_rlast => axi_hp_2_to_s00_couplers_RLAST,
      S_AXI_rready => axi_hp_2_to_s00_couplers_RREADY,
      S_AXI_rresp(1 downto 0) => axi_hp_2_to_s00_couplers_RRESP(1 downto 0),
      S_AXI_rvalid => axi_hp_2_to_s00_couplers_RVALID,
      S_AXI_wdata(63 downto 0) => axi_hp_2_to_s00_couplers_WDATA(63 downto 0),
      S_AXI_wlast => axi_hp_2_to_s00_couplers_WLAST,
      S_AXI_wready => axi_hp_2_to_s00_couplers_WREADY,
      S_AXI_wstrb(7 downto 0) => axi_hp_2_to_s00_couplers_WSTRB(7 downto 0),
      S_AXI_wvalid => axi_hp_2_to_s00_couplers_WVALID
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of system : entity is "system,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLanguage=VHDL,numBlks=31,numReposBlks=17,numNonXlnxBlks=2,numHierBlks=14,maxHierDepth=0}";
end system;

architecture STRUCTURE of system is
  component system_axi_addr_remap_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component system_axi_addr_remap_0_0;
  component system_axi_timer_0_0 is
  port (
    capturetrig0 : in STD_LOGIC;
    capturetrig1 : in STD_LOGIC;
    generateout0 : out STD_LOGIC;
    generateout1 : out STD_LOGIC;
    pwm0 : out STD_LOGIC;
    interrupt : out STD_LOGIC;
    freeze : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  end component system_axi_timer_0_0;
  component system_clk_wiz_0_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component system_clk_wiz_0_0;
  component system_lmb_bram_if_cntlr_0_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component system_lmb_bram_if_cntlr_0_0;
  component system_lmb_bram_if_cntlr_0_bram_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component system_lmb_bram_if_cntlr_0_bram_0;
  component system_lmb_bram_if_cntlr_1_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component system_lmb_bram_if_cntlr_1_0;
  component system_mdm_0_0 is
  port (
    S_AXI_ACLK : in STD_LOGIC;
    S_AXI_ARESETN : in STD_LOGIC;
    Interrupt : out STD_LOGIC;
    Debug_SYS_Rst : out STD_LOGIC;
    S_AXI_AWADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_AWVALID : in STD_LOGIC;
    S_AXI_AWREADY : out STD_LOGIC;
    S_AXI_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_WVALID : in STD_LOGIC;
    S_AXI_WREADY : out STD_LOGIC;
    S_AXI_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_BVALID : out STD_LOGIC;
    S_AXI_BREADY : in STD_LOGIC;
    S_AXI_ARADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_ARVALID : in STD_LOGIC;
    S_AXI_ARREADY : out STD_LOGIC;
    S_AXI_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_RVALID : out STD_LOGIC;
    S_AXI_RREADY : in STD_LOGIC;
    Dbg_Clk_0 : out STD_LOGIC;
    Dbg_TDI_0 : out STD_LOGIC;
    Dbg_TDO_0 : in STD_LOGIC;
    Dbg_Reg_En_0 : out STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Capture_0 : out STD_LOGIC;
    Dbg_Shift_0 : out STD_LOGIC;
    Dbg_Update_0 : out STD_LOGIC;
    Dbg_Rst_0 : out STD_LOGIC
  );
  end component system_mdm_0_0;
  component system_microblaze_0_0 is
  port (
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    Interrupt : in STD_LOGIC;
    Interrupt_Address : in STD_LOGIC_VECTOR ( 0 to 31 );
    Interrupt_Ack : out STD_LOGIC_VECTOR ( 0 to 1 );
    Instr_Addr : out STD_LOGIC_VECTOR ( 0 to 31 );
    Instr : in STD_LOGIC_VECTOR ( 0 to 31 );
    IFetch : out STD_LOGIC;
    I_AS : out STD_LOGIC;
    IReady : in STD_LOGIC;
    IWAIT : in STD_LOGIC;
    ICE : in STD_LOGIC;
    IUE : in STD_LOGIC;
    Data_Addr : out STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Read : in STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Write : out STD_LOGIC_VECTOR ( 0 to 31 );
    D_AS : out STD_LOGIC;
    Read_Strobe : out STD_LOGIC;
    Write_Strobe : out STD_LOGIC;
    DReady : in STD_LOGIC;
    DWait : in STD_LOGIC;
    DCE : in STD_LOGIC;
    DUE : in STD_LOGIC;
    Byte_Enable : out STD_LOGIC_VECTOR ( 0 to 3 );
    M_AXI_DP_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DP_AWVALID : out STD_LOGIC;
    M_AXI_DP_AWREADY : in STD_LOGIC;
    M_AXI_DP_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DP_WVALID : out STD_LOGIC;
    M_AXI_DP_WREADY : in STD_LOGIC;
    M_AXI_DP_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DP_BVALID : in STD_LOGIC;
    M_AXI_DP_BREADY : out STD_LOGIC;
    M_AXI_DP_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DP_ARVALID : out STD_LOGIC;
    M_AXI_DP_ARREADY : in STD_LOGIC;
    M_AXI_DP_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DP_RVALID : in STD_LOGIC;
    M_AXI_DP_RREADY : out STD_LOGIC;
    Dbg_Clk : in STD_LOGIC;
    Dbg_TDI : in STD_LOGIC;
    Dbg_TDO : out STD_LOGIC;
    Dbg_Reg_En : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Shift : in STD_LOGIC;
    Dbg_Capture : in STD_LOGIC;
    Dbg_Update : in STD_LOGIC;
    Debug_Rst : in STD_LOGIC;
    M0_AXIS_TLAST : out STD_LOGIC;
    M0_AXIS_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_AXIS_TVALID : out STD_LOGIC;
    M0_AXIS_TREADY : in STD_LOGIC;
    S0_AXIS_TLAST : in STD_LOGIC;
    S0_AXIS_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S0_AXIS_TVALID : in STD_LOGIC;
    S0_AXIS_TREADY : out STD_LOGIC;
    M_AXI_IC_AWID : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_IC_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_IC_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_IC_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_IC_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_IC_AWLOCK : out STD_LOGIC;
    M_AXI_IC_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_IC_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_IC_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_IC_AWVALID : out STD_LOGIC;
    M_AXI_IC_AWREADY : in STD_LOGIC;
    M_AXI_IC_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_IC_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_IC_WLAST : out STD_LOGIC;
    M_AXI_IC_WVALID : out STD_LOGIC;
    M_AXI_IC_WREADY : in STD_LOGIC;
    M_AXI_IC_BID : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_IC_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_IC_BVALID : in STD_LOGIC;
    M_AXI_IC_BREADY : out STD_LOGIC;
    M_AXI_IC_ARID : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_IC_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_IC_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_IC_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_IC_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_IC_ARLOCK : out STD_LOGIC;
    M_AXI_IC_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_IC_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_IC_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_IC_ARVALID : out STD_LOGIC;
    M_AXI_IC_ARREADY : in STD_LOGIC;
    M_AXI_IC_RID : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_IC_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_IC_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_IC_RLAST : in STD_LOGIC;
    M_AXI_IC_RVALID : in STD_LOGIC;
    M_AXI_IC_RREADY : out STD_LOGIC;
    M_AXI_DC_AWID : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_DC_AWADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DC_AWLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_DC_AWSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DC_AWBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DC_AWLOCK : out STD_LOGIC;
    M_AXI_DC_AWCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DC_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DC_AWQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DC_AWVALID : out STD_LOGIC;
    M_AXI_DC_AWREADY : in STD_LOGIC;
    M_AXI_DC_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DC_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DC_WLAST : out STD_LOGIC;
    M_AXI_DC_WVALID : out STD_LOGIC;
    M_AXI_DC_WREADY : in STD_LOGIC;
    M_AXI_DC_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DC_BID : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_DC_BVALID : in STD_LOGIC;
    M_AXI_DC_BREADY : out STD_LOGIC;
    M_AXI_DC_ARID : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_DC_ARADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DC_ARLEN : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_DC_ARSIZE : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DC_ARBURST : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DC_ARLOCK : out STD_LOGIC;
    M_AXI_DC_ARCACHE : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DC_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DC_ARQOS : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DC_ARVALID : out STD_LOGIC;
    M_AXI_DC_ARREADY : in STD_LOGIC;
    M_AXI_DC_RID : in STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_DC_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DC_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DC_RLAST : in STD_LOGIC;
    M_AXI_DC_RVALID : in STD_LOGIC;
    M_AXI_DC_RREADY : out STD_LOGIC
  );
  end component system_microblaze_0_0;
  component system_proc_sys_reset_0_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component system_proc_sys_reset_0_0;
  component system_processing_system7_0_0 is
  port (
    TTC0_WAVE0_OUT : out STD_LOGIC;
    TTC0_WAVE1_OUT : out STD_LOGIC;
    TTC0_WAVE2_OUT : out STD_LOGIC;
    USB0_PORT_INDCTL : out STD_LOGIC_VECTOR ( 1 downto 0 );
    USB0_VBUS_PWRSELECT : out STD_LOGIC;
    USB0_VBUS_PWRFAULT : in STD_LOGIC;
    S_AXI_GP0_ARREADY : out STD_LOGIC;
    S_AXI_GP0_AWREADY : out STD_LOGIC;
    S_AXI_GP0_BVALID : out STD_LOGIC;
    S_AXI_GP0_RLAST : out STD_LOGIC;
    S_AXI_GP0_RVALID : out STD_LOGIC;
    S_AXI_GP0_WREADY : out STD_LOGIC;
    S_AXI_GP0_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_GP0_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_GP0_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_GP0_BID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_GP0_RID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_GP0_ACLK : in STD_LOGIC;
    S_AXI_GP0_ARVALID : in STD_LOGIC;
    S_AXI_GP0_AWVALID : in STD_LOGIC;
    S_AXI_GP0_BREADY : in STD_LOGIC;
    S_AXI_GP0_RREADY : in STD_LOGIC;
    S_AXI_GP0_WLAST : in STD_LOGIC;
    S_AXI_GP0_WVALID : in STD_LOGIC;
    S_AXI_GP0_ARBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_GP0_ARLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_GP0_ARSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_GP0_AWBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_GP0_AWLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_GP0_AWSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_GP0_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_GP0_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_GP0_ARADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_GP0_AWADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_GP0_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_GP0_ARCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_ARLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_ARQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_AWCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_AWLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_AWQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_GP0_ARID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_GP0_AWID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_GP0_WID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_ARREADY : out STD_LOGIC;
    S_AXI_HP0_AWREADY : out STD_LOGIC;
    S_AXI_HP0_BVALID : out STD_LOGIC;
    S_AXI_HP0_RLAST : out STD_LOGIC;
    S_AXI_HP0_RVALID : out STD_LOGIC;
    S_AXI_HP0_WREADY : out STD_LOGIC;
    S_AXI_HP0_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_BID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_RID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_RCOUNT : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_HP0_WCOUNT : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_HP0_RACOUNT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_WACOUNT : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_ACLK : in STD_LOGIC;
    S_AXI_HP0_ARVALID : in STD_LOGIC;
    S_AXI_HP0_AWVALID : in STD_LOGIC;
    S_AXI_HP0_BREADY : in STD_LOGIC;
    S_AXI_HP0_RDISSUECAP1_EN : in STD_LOGIC;
    S_AXI_HP0_RREADY : in STD_LOGIC;
    S_AXI_HP0_WLAST : in STD_LOGIC;
    S_AXI_HP0_WRISSUECAP1_EN : in STD_LOGIC;
    S_AXI_HP0_WVALID : in STD_LOGIC;
    S_AXI_HP0_ARBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_ARLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_ARSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_AWBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_AWLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP0_AWSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP0_ARADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_AWADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_ARCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_ARLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_ARQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_AWCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_AWLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_AWQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP0_ARID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_AWID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_WID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP0_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP0_WSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_ARREADY : out STD_LOGIC;
    S_AXI_HP2_AWREADY : out STD_LOGIC;
    S_AXI_HP2_BVALID : out STD_LOGIC;
    S_AXI_HP2_RLAST : out STD_LOGIC;
    S_AXI_HP2_RVALID : out STD_LOGIC;
    S_AXI_HP2_WREADY : out STD_LOGIC;
    S_AXI_HP2_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP2_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP2_BID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP2_RID : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP2_RDATA : out STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_HP2_RCOUNT : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_HP2_WCOUNT : out STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_HP2_RACOUNT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP2_WACOUNT : out STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP2_ACLK : in STD_LOGIC;
    S_AXI_HP2_ARVALID : in STD_LOGIC;
    S_AXI_HP2_AWVALID : in STD_LOGIC;
    S_AXI_HP2_BREADY : in STD_LOGIC;
    S_AXI_HP2_RDISSUECAP1_EN : in STD_LOGIC;
    S_AXI_HP2_RREADY : in STD_LOGIC;
    S_AXI_HP2_WLAST : in STD_LOGIC;
    S_AXI_HP2_WRISSUECAP1_EN : in STD_LOGIC;
    S_AXI_HP2_WVALID : in STD_LOGIC;
    S_AXI_HP2_ARBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP2_ARLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP2_ARSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP2_AWBURST : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP2_AWLOCK : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_HP2_AWSIZE : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP2_ARPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP2_AWPROT : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_HP2_ARADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP2_AWADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_HP2_ARCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_ARLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_ARQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_AWCACHE : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_AWLEN : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_AWQOS : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_HP2_ARID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP2_AWID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP2_WID : in STD_LOGIC_VECTOR ( 5 downto 0 );
    S_AXI_HP2_WDATA : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_HP2_WSTRB : in STD_LOGIC_VECTOR ( 7 downto 0 );
    FCLK_CLK0 : out STD_LOGIC;
    FCLK_RESET0_N : out STD_LOGIC;
    MIO : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    DDR_CAS_n : inout STD_LOGIC;
    DDR_CKE : inout STD_LOGIC;
    DDR_Clk_n : inout STD_LOGIC;
    DDR_Clk : inout STD_LOGIC;
    DDR_CS_n : inout STD_LOGIC;
    DDR_DRSTB : inout STD_LOGIC;
    DDR_ODT : inout STD_LOGIC;
    DDR_RAS_n : inout STD_LOGIC;
    DDR_WEB : inout STD_LOGIC;
    DDR_BankAddr : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_Addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_VRN : inout STD_LOGIC;
    DDR_VRP : inout STD_LOGIC;
    DDR_DM : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQ : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_DQS_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQS : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    PS_SRSTB : inout STD_LOGIC;
    PS_CLK : inout STD_LOGIC;
    PS_PORB : inout STD_LOGIC
  );
  end component system_processing_system7_0_0;
  component system_vectorblox_mxp_0_0 is
  port (
    core_clk : in STD_LOGIC;
    core_clk_2x : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_arvalid : out STD_LOGIC;
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_rready : out STD_LOGIC;
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wready : in STD_LOGIC;
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    m_axis_instr_tlast : out STD_LOGIC;
    m_axis_instr_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_instr_tvalid : out STD_LOGIC;
    m_axis_instr_tready : in STD_LOGIC;
    s_axis_instr_tlast : in STD_LOGIC;
    s_axis_instr_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_instr_tvalid : in STD_LOGIC;
    s_axis_instr_tready : out STD_LOGIC
  );
  end component system_vectorblox_mxp_0_0;
  signal GND_1 : STD_LOGIC;
  signal S00_AXI_1_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S00_AXI_1_ARREADY : STD_LOGIC;
  signal S00_AXI_1_ARVALID : STD_LOGIC;
  signal S00_AXI_1_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S00_AXI_1_AWREADY : STD_LOGIC;
  signal S00_AXI_1_AWVALID : STD_LOGIC;
  signal S00_AXI_1_BREADY : STD_LOGIC;
  signal S00_AXI_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal S00_AXI_1_BVALID : STD_LOGIC;
  signal S00_AXI_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_RREADY : STD_LOGIC;
  signal S00_AXI_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal S00_AXI_1_RVALID : STD_LOGIC;
  signal S00_AXI_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S00_AXI_1_WREADY : STD_LOGIC;
  signal S00_AXI_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal S00_AXI_1_WVALID : STD_LOGIC;
  signal S02_AXI_1_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S02_AXI_1_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S02_AXI_1_ARREADY : STD_LOGIC;
  signal S02_AXI_1_ARVALID : STD_LOGIC;
  signal S02_AXI_1_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S02_AXI_1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal S02_AXI_1_AWREADY : STD_LOGIC;
  signal S02_AXI_1_AWVALID : STD_LOGIC;
  signal S02_AXI_1_BREADY : STD_LOGIC;
  signal S02_AXI_1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal S02_AXI_1_BVALID : STD_LOGIC;
  signal S02_AXI_1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S02_AXI_1_RREADY : STD_LOGIC;
  signal S02_AXI_1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal S02_AXI_1_RVALID : STD_LOGIC;
  signal S02_AXI_1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal S02_AXI_1_WREADY : STD_LOGIC;
  signal S02_AXI_1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal S02_AXI_1_WVALID : STD_LOGIC;
  signal VCC_1 : STD_LOGIC;
  signal axi4lite_0_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M00_AXI_ARREADY : STD_LOGIC;
  signal axi4lite_0_M00_AXI_ARVALID : STD_LOGIC;
  signal axi4lite_0_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M00_AXI_AWREADY : STD_LOGIC;
  signal axi4lite_0_M00_AXI_AWVALID : STD_LOGIC;
  signal axi4lite_0_M00_AXI_BREADY : STD_LOGIC;
  signal axi4lite_0_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M00_AXI_BVALID : STD_LOGIC;
  signal axi4lite_0_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M00_AXI_RREADY : STD_LOGIC;
  signal axi4lite_0_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M00_AXI_RVALID : STD_LOGIC;
  signal axi4lite_0_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M00_AXI_WREADY : STD_LOGIC;
  signal axi4lite_0_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M00_AXI_WVALID : STD_LOGIC;
  signal axi4lite_0_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal axi4lite_0_M01_AXI_ARREADY : STD_LOGIC;
  signal axi4lite_0_M01_AXI_ARVALID : STD_LOGIC;
  signal axi4lite_0_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal axi4lite_0_M01_AXI_AWREADY : STD_LOGIC;
  signal axi4lite_0_M01_AXI_AWVALID : STD_LOGIC;
  signal axi4lite_0_M01_AXI_BREADY : STD_LOGIC;
  signal axi4lite_0_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M01_AXI_BVALID : STD_LOGIC;
  signal axi4lite_0_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M01_AXI_RREADY : STD_LOGIC;
  signal axi4lite_0_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M01_AXI_RVALID : STD_LOGIC;
  signal axi4lite_0_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M01_AXI_WREADY : STD_LOGIC;
  signal axi4lite_0_M01_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M01_AXI_WVALID : STD_LOGIC;
  signal axi4lite_0_M02_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M02_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M02_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M02_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi4lite_0_M02_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_ARREADY : STD_LOGIC;
  signal axi4lite_0_M02_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi4lite_0_M02_AXI_ARVALID : STD_LOGIC;
  signal axi4lite_0_M02_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M02_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M02_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M02_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi4lite_0_M02_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_AWREADY : STD_LOGIC;
  signal axi4lite_0_M02_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi4lite_0_M02_AXI_AWVALID : STD_LOGIC;
  signal axi4lite_0_M02_AXI_BREADY : STD_LOGIC;
  signal axi4lite_0_M02_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M02_AXI_BVALID : STD_LOGIC;
  signal axi4lite_0_M02_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M02_AXI_RLAST : STD_LOGIC;
  signal axi4lite_0_M02_AXI_RREADY : STD_LOGIC;
  signal axi4lite_0_M02_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M02_AXI_RVALID : STD_LOGIC;
  signal axi4lite_0_M02_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M02_AXI_WLAST : STD_LOGIC;
  signal axi4lite_0_M02_AXI_WREADY : STD_LOGIC;
  signal axi4lite_0_M02_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M02_AXI_WVALID : STD_LOGIC;
  signal axi4lite_0_M03_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M03_AXI_ARREADY : STD_LOGIC;
  signal axi4lite_0_M03_AXI_ARVALID : STD_LOGIC;
  signal axi4lite_0_M03_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M03_AXI_AWREADY : STD_LOGIC;
  signal axi4lite_0_M03_AXI_AWVALID : STD_LOGIC;
  signal axi4lite_0_M03_AXI_BREADY : STD_LOGIC;
  signal axi4lite_0_M03_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M03_AXI_BVALID : STD_LOGIC;
  signal axi4lite_0_M03_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M03_AXI_RREADY : STD_LOGIC;
  signal axi4lite_0_M03_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M03_AXI_RVALID : STD_LOGIC;
  signal axi4lite_0_M03_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M03_AXI_WREADY : STD_LOGIC;
  signal axi4lite_0_M03_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M03_AXI_WVALID : STD_LOGIC;
  signal axi4lite_0_M04_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M04_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi4lite_0_M04_AXI_ARREADY : STD_LOGIC;
  signal axi4lite_0_M04_AXI_ARVALID : STD_LOGIC;
  signal axi4lite_0_M04_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M04_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi4lite_0_M04_AXI_AWREADY : STD_LOGIC;
  signal axi4lite_0_M04_AXI_AWVALID : STD_LOGIC;
  signal axi4lite_0_M04_AXI_BREADY : STD_LOGIC;
  signal axi4lite_0_M04_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M04_AXI_BVALID : STD_LOGIC;
  signal axi4lite_0_M04_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M04_AXI_RREADY : STD_LOGIC;
  signal axi4lite_0_M04_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi4lite_0_M04_AXI_RVALID : STD_LOGIC;
  signal axi4lite_0_M04_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi4lite_0_M04_AXI_WREADY : STD_LOGIC;
  signal axi4lite_0_M04_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi4lite_0_M04_AXI_WVALID : STD_LOGIC;
  signal axi_hp_2_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_2_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_M00_AXI_ARREADY : STD_LOGIC;
  signal axi_hp_2_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_M00_AXI_ARVALID : STD_LOGIC;
  signal axi_hp_2_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_hp_2_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_hp_2_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_M00_AXI_AWREADY : STD_LOGIC;
  signal axi_hp_2_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_hp_2_M00_AXI_AWVALID : STD_LOGIC;
  signal axi_hp_2_M00_AXI_BREADY : STD_LOGIC;
  signal axi_hp_2_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_M00_AXI_BVALID : STD_LOGIC;
  signal axi_hp_2_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal axi_hp_2_M00_AXI_RLAST : STD_LOGIC;
  signal axi_hp_2_M00_AXI_RREADY : STD_LOGIC;
  signal axi_hp_2_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_hp_2_M00_AXI_RVALID : STD_LOGIC;
  signal axi_hp_2_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal axi_hp_2_M00_AXI_WLAST : STD_LOGIC;
  signal axi_hp_2_M00_AXI_WREADY : STD_LOGIC;
  signal axi_hp_2_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal axi_hp_2_M00_AXI_WVALID : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARREADY : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_mem_intercon_M00_AXI_ARVALID : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWLOCK : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWREADY : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_mem_intercon_M00_AXI_AWVALID : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_BID : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal axi_mem_intercon_M00_AXI_BREADY : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_BVALID : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_mem_intercon_M00_AXI_RID : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal axi_mem_intercon_M00_AXI_RLAST : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_RREADY : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_RVALID : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_mem_intercon_M00_AXI_WID : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_mem_intercon_M00_AXI_WLAST : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_WREADY : STD_LOGIC;
  signal axi_mem_intercon_M00_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_mem_intercon_M00_AXI_WVALID : STD_LOGIC;
  signal clk_wiz_0_clk_out2 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal lmb_bram_if_cntlr_0_BRAM_PORT_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal lmb_bram_if_cntlr_0_BRAM_PORT_CLK : STD_LOGIC;
  signal lmb_bram_if_cntlr_0_BRAM_PORT_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal lmb_bram_if_cntlr_0_BRAM_PORT_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal lmb_bram_if_cntlr_0_BRAM_PORT_EN : STD_LOGIC;
  signal lmb_bram_if_cntlr_0_BRAM_PORT_RST : STD_LOGIC;
  signal lmb_bram_if_cntlr_0_BRAM_PORT_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal lmb_bram_if_cntlr_1_BRAM_PORT_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal lmb_bram_if_cntlr_1_BRAM_PORT_CLK : STD_LOGIC;
  signal lmb_bram_if_cntlr_1_BRAM_PORT_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal lmb_bram_if_cntlr_1_BRAM_PORT_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal lmb_bram_if_cntlr_1_BRAM_PORT_EN : STD_LOGIC;
  signal lmb_bram_if_cntlr_1_BRAM_PORT_RST : STD_LOGIC;
  signal lmb_bram_if_cntlr_1_BRAM_PORT_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal mdm_0_Debug_SYS_Rst : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_CAPTURE : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_CLK : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_REG_EN : STD_LOGIC_VECTOR ( 0 to 7 );
  signal mdm_0_MBDEBUG_0_RST : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_SHIFT : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_TDI : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_TDO : STD_LOGIC;
  signal mdm_0_MBDEBUG_0_UPDATE : STD_LOGIC;
  signal microblaze_0_DLMB_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_0_DLMB_ADDRSTROBE : STD_LOGIC;
  signal microblaze_0_DLMB_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal microblaze_0_DLMB_CE : STD_LOGIC;
  signal microblaze_0_DLMB_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_0_DLMB_READSTROBE : STD_LOGIC;
  signal microblaze_0_DLMB_READY : STD_LOGIC;
  signal microblaze_0_DLMB_UE : STD_LOGIC;
  signal microblaze_0_DLMB_WAIT : STD_LOGIC;
  signal microblaze_0_DLMB_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_0_DLMB_WRITESTROBE : STD_LOGIC;
  signal microblaze_0_ILMB_ABUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_0_ILMB_ADDRSTROBE : STD_LOGIC;
  signal microblaze_0_ILMB_CE : STD_LOGIC;
  signal microblaze_0_ILMB_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal microblaze_0_ILMB_READSTROBE : STD_LOGIC;
  signal microblaze_0_ILMB_READY : STD_LOGIC;
  signal microblaze_0_ILMB_UE : STD_LOGIC;
  signal microblaze_0_ILMB_WAIT : STD_LOGIC;
  signal microblaze_0_M0_AXIS_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M0_AXIS_TLAST : STD_LOGIC;
  signal microblaze_0_M0_AXIS_TREADY : STD_LOGIC;
  signal microblaze_0_M0_AXIS_TVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_DC_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_DC_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_DC_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_DC_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal microblaze_0_M_AXI_DC_ARLOCK : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_DC_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_DC_ARREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_DC_ARVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_DC_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_DC_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_DC_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_DC_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal microblaze_0_M_AXI_DC_AWLOCK : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_DC_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_DC_AWREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_DC_AWVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_DC_BREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_DC_BVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_DC_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_DC_RLAST : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_RREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_DC_RVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_DC_WLAST : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_WREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_DC_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_DC_WVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_IC_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_IC_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_IC_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_IC_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal microblaze_0_M_AXI_IC_ARLOCK : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_IC_ARQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_IC_ARREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_IC_ARVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_IC_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_IC_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_IC_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_IC_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal microblaze_0_M_AXI_IC_AWLOCK : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_IC_AWQOS : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_IC_AWREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal microblaze_0_M_AXI_IC_AWVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_IC_BREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_IC_BVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_IC_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal microblaze_0_M_AXI_IC_RLAST : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_RREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal microblaze_0_M_AXI_IC_RVALID : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal microblaze_0_M_AXI_IC_WLAST : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_WREADY : STD_LOGIC;
  signal microblaze_0_M_AXI_IC_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal microblaze_0_M_AXI_IC_WVALID : STD_LOGIC;
  signal proc_sys_reset_0_bus_struct_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal processing_system7_0_DDR_ADDR : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal processing_system7_0_DDR_BA : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_DDR_CAS_N : STD_LOGIC;
  signal processing_system7_0_DDR_CKE : STD_LOGIC;
  signal processing_system7_0_DDR_CK_N : STD_LOGIC;
  signal processing_system7_0_DDR_CK_P : STD_LOGIC;
  signal processing_system7_0_DDR_CS_N : STD_LOGIC;
  signal processing_system7_0_DDR_DM : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_DQ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_DDR_DQS_N : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_DQS_P : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_ODT : STD_LOGIC;
  signal processing_system7_0_DDR_RAS_N : STD_LOGIC;
  signal processing_system7_0_DDR_RESET_N : STD_LOGIC;
  signal processing_system7_0_DDR_WE_N : STD_LOGIC;
  signal processing_system7_0_FCLK_CLK0 : STD_LOGIC;
  signal processing_system7_0_FCLK_RESET0_N : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_DDR_VRN : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_DDR_VRP : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_MIO : STD_LOGIC_VECTOR ( 53 downto 0 );
  signal processing_system7_0_FIXED_IO_PS_CLK : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_PORB : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_SRSTB : STD_LOGIC;
  signal rst_processing_system7_0_100M_interconnect_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_processing_system7_0_100M_mb_reset : STD_LOGIC;
  signal rst_processing_system7_0_100M_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal sysclk : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXIS_INSTR_TDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal vectorblox_mxp_0_M_AXIS_INSTR_TLAST : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXIS_INSTR_TREADY : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXIS_INSTR_TVALID : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal vectorblox_mxp_0_M_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal vectorblox_mxp_0_M_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal vectorblox_mxp_0_M_AXI_ARLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal vectorblox_mxp_0_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal vectorblox_mxp_0_M_AXI_ARREADY : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal vectorblox_mxp_0_M_AXI_ARVALID : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal vectorblox_mxp_0_M_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal vectorblox_mxp_0_M_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal vectorblox_mxp_0_M_AXI_AWLEN : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal vectorblox_mxp_0_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal vectorblox_mxp_0_M_AXI_AWREADY : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal vectorblox_mxp_0_M_AXI_AWVALID : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_BREADY : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal vectorblox_mxp_0_M_AXI_BVALID : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_RDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal vectorblox_mxp_0_M_AXI_RLAST : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_RREADY : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal vectorblox_mxp_0_M_AXI_RVALID : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_WDATA : STD_LOGIC_VECTOR ( 63 downto 0 );
  signal vectorblox_mxp_0_M_AXI_WLAST : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_WREADY : STD_LOGIC;
  signal vectorblox_mxp_0_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal vectorblox_mxp_0_M_AXI_WVALID : STD_LOGIC;
  signal NLW_axi_timer_0_generateout0_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_timer_0_generateout1_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_timer_0_interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_axi_timer_0_pwm0_UNCONNECTED : STD_LOGIC;
  signal NLW_mdm_0_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_microblaze_0_Interrupt_Ack_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 1 );
  signal NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_processing_system7_0_TTC0_WAVE0_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE1_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE2_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_USB0_VBUS_PWRSELECT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_S_AXI_GP0_BID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_GP0_RID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_ARID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 2 );
  signal NLW_processing_system7_0_S_AXI_HP0_AWID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 2 );
  signal NLW_processing_system7_0_S_AXI_HP0_RACOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_RCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_WACOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_WCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP0_WID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 2 );
  signal NLW_processing_system7_0_S_AXI_HP2_BID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP2_RACOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP2_RCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP2_RID_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP2_WACOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal NLW_processing_system7_0_S_AXI_HP2_WCOUNT_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_processing_system7_0_USB0_PORT_INDCTL_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute BMM_INFO_ADDRESS_SPACE : string;
  attribute BMM_INFO_ADDRESS_SPACE of lmb_bram_if_cntlr_0 : label is "byte  0x20000000 32 >  system lmb_bram_if_cntlr_0_bram";
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of lmb_bram_if_cntlr_0 : label is "yes";
  attribute BMM_INFO_PROCESSOR : string;
  attribute BMM_INFO_PROCESSOR of microblaze_0 : label is "microblaze-le > system lmb_bram_if_cntlr_0";
  attribute KEEP_HIERARCHY of microblaze_0 : label is "yes";
begin
GND: unisim.vcomponents.GND
    port map (
      G => GND_1
    );
VCC: unisim.vcomponents.VCC
    port map (
      P => VCC_1
    );
axi4lite_0: entity work.system_axi4lite_0_0
    port map (
      ACLK => sysclk,
      ARESETN(0) => rst_processing_system7_0_100M_interconnect_aresetn(0),
      M00_ACLK => sysclk,
      M00_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M00_AXI_araddr(31 downto 0) => axi4lite_0_M00_AXI_ARADDR(31 downto 0),
      M00_AXI_arready => axi4lite_0_M00_AXI_ARREADY,
      M00_AXI_arvalid => axi4lite_0_M00_AXI_ARVALID,
      M00_AXI_awaddr(31 downto 0) => axi4lite_0_M00_AXI_AWADDR(31 downto 0),
      M00_AXI_awready => axi4lite_0_M00_AXI_AWREADY,
      M00_AXI_awvalid => axi4lite_0_M00_AXI_AWVALID,
      M00_AXI_bready => axi4lite_0_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => axi4lite_0_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => axi4lite_0_M00_AXI_BVALID,
      M00_AXI_rdata(31 downto 0) => axi4lite_0_M00_AXI_RDATA(31 downto 0),
      M00_AXI_rready => axi4lite_0_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => axi4lite_0_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => axi4lite_0_M00_AXI_RVALID,
      M00_AXI_wdata(31 downto 0) => axi4lite_0_M00_AXI_WDATA(31 downto 0),
      M00_AXI_wready => axi4lite_0_M00_AXI_WREADY,
      M00_AXI_wstrb(3 downto 0) => axi4lite_0_M00_AXI_WSTRB(3 downto 0),
      M00_AXI_wvalid => axi4lite_0_M00_AXI_WVALID,
      M01_ACLK => sysclk,
      M01_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M01_AXI_araddr(4 downto 0) => axi4lite_0_M01_AXI_ARADDR(4 downto 0),
      M01_AXI_arready => axi4lite_0_M01_AXI_ARREADY,
      M01_AXI_arvalid => axi4lite_0_M01_AXI_ARVALID,
      M01_AXI_awaddr(4 downto 0) => axi4lite_0_M01_AXI_AWADDR(4 downto 0),
      M01_AXI_awready => axi4lite_0_M01_AXI_AWREADY,
      M01_AXI_awvalid => axi4lite_0_M01_AXI_AWVALID,
      M01_AXI_bready => axi4lite_0_M01_AXI_BREADY,
      M01_AXI_bresp(1 downto 0) => axi4lite_0_M01_AXI_BRESP(1 downto 0),
      M01_AXI_bvalid => axi4lite_0_M01_AXI_BVALID,
      M01_AXI_rdata(31 downto 0) => axi4lite_0_M01_AXI_RDATA(31 downto 0),
      M01_AXI_rready => axi4lite_0_M01_AXI_RREADY,
      M01_AXI_rresp(1 downto 0) => axi4lite_0_M01_AXI_RRESP(1 downto 0),
      M01_AXI_rvalid => axi4lite_0_M01_AXI_RVALID,
      M01_AXI_wdata(31 downto 0) => axi4lite_0_M01_AXI_WDATA(31 downto 0),
      M01_AXI_wready => axi4lite_0_M01_AXI_WREADY,
      M01_AXI_wstrb(3 downto 0) => axi4lite_0_M01_AXI_WSTRB(3 downto 0),
      M01_AXI_wvalid => axi4lite_0_M01_AXI_WVALID,
      M02_ACLK => sysclk,
      M02_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M02_AXI_araddr(31 downto 0) => axi4lite_0_M02_AXI_ARADDR(31 downto 0),
      M02_AXI_arburst(1 downto 0) => axi4lite_0_M02_AXI_ARBURST(1 downto 0),
      M02_AXI_arcache(3 downto 0) => axi4lite_0_M02_AXI_ARCACHE(3 downto 0),
      M02_AXI_arlen(3 downto 0) => axi4lite_0_M02_AXI_ARLEN(3 downto 0),
      M02_AXI_arlock(1 downto 0) => axi4lite_0_M02_AXI_ARLOCK(1 downto 0),
      M02_AXI_arprot(2 downto 0) => axi4lite_0_M02_AXI_ARPROT(2 downto 0),
      M02_AXI_arqos(3 downto 0) => axi4lite_0_M02_AXI_ARQOS(3 downto 0),
      M02_AXI_arready => axi4lite_0_M02_AXI_ARREADY,
      M02_AXI_arsize(2 downto 0) => axi4lite_0_M02_AXI_ARSIZE(2 downto 0),
      M02_AXI_arvalid => axi4lite_0_M02_AXI_ARVALID,
      M02_AXI_awaddr(31 downto 0) => axi4lite_0_M02_AXI_AWADDR(31 downto 0),
      M02_AXI_awburst(1 downto 0) => axi4lite_0_M02_AXI_AWBURST(1 downto 0),
      M02_AXI_awcache(3 downto 0) => axi4lite_0_M02_AXI_AWCACHE(3 downto 0),
      M02_AXI_awlen(3 downto 0) => axi4lite_0_M02_AXI_AWLEN(3 downto 0),
      M02_AXI_awlock(1 downto 0) => axi4lite_0_M02_AXI_AWLOCK(1 downto 0),
      M02_AXI_awprot(2 downto 0) => axi4lite_0_M02_AXI_AWPROT(2 downto 0),
      M02_AXI_awqos(3 downto 0) => axi4lite_0_M02_AXI_AWQOS(3 downto 0),
      M02_AXI_awready => axi4lite_0_M02_AXI_AWREADY,
      M02_AXI_awsize(2 downto 0) => axi4lite_0_M02_AXI_AWSIZE(2 downto 0),
      M02_AXI_awvalid => axi4lite_0_M02_AXI_AWVALID,
      M02_AXI_bready => axi4lite_0_M02_AXI_BREADY,
      M02_AXI_bresp(1 downto 0) => axi4lite_0_M02_AXI_BRESP(1 downto 0),
      M02_AXI_bvalid => axi4lite_0_M02_AXI_BVALID,
      M02_AXI_rdata(31 downto 0) => axi4lite_0_M02_AXI_RDATA(31 downto 0),
      M02_AXI_rlast => axi4lite_0_M02_AXI_RLAST,
      M02_AXI_rready => axi4lite_0_M02_AXI_RREADY,
      M02_AXI_rresp(1 downto 0) => axi4lite_0_M02_AXI_RRESP(1 downto 0),
      M02_AXI_rvalid => axi4lite_0_M02_AXI_RVALID,
      M02_AXI_wdata(31 downto 0) => axi4lite_0_M02_AXI_WDATA(31 downto 0),
      M02_AXI_wlast => axi4lite_0_M02_AXI_WLAST,
      M02_AXI_wready => axi4lite_0_M02_AXI_WREADY,
      M02_AXI_wstrb(3 downto 0) => axi4lite_0_M02_AXI_WSTRB(3 downto 0),
      M02_AXI_wvalid => axi4lite_0_M02_AXI_WVALID,
      M03_ACLK => sysclk,
      M03_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M03_AXI_araddr(31 downto 0) => axi4lite_0_M03_AXI_ARADDR(31 downto 0),
      M03_AXI_arready => axi4lite_0_M03_AXI_ARREADY,
      M03_AXI_arvalid => axi4lite_0_M03_AXI_ARVALID,
      M03_AXI_awaddr(31 downto 0) => axi4lite_0_M03_AXI_AWADDR(31 downto 0),
      M03_AXI_awready => axi4lite_0_M03_AXI_AWREADY,
      M03_AXI_awvalid => axi4lite_0_M03_AXI_AWVALID,
      M03_AXI_bready => axi4lite_0_M03_AXI_BREADY,
      M03_AXI_bresp(1 downto 0) => axi4lite_0_M03_AXI_BRESP(1 downto 0),
      M03_AXI_bvalid => axi4lite_0_M03_AXI_BVALID,
      M03_AXI_rdata(31 downto 0) => axi4lite_0_M03_AXI_RDATA(31 downto 0),
      M03_AXI_rready => axi4lite_0_M03_AXI_RREADY,
      M03_AXI_rresp(1 downto 0) => axi4lite_0_M03_AXI_RRESP(1 downto 0),
      M03_AXI_rvalid => axi4lite_0_M03_AXI_RVALID,
      M03_AXI_wdata(31 downto 0) => axi4lite_0_M03_AXI_WDATA(31 downto 0),
      M03_AXI_wready => axi4lite_0_M03_AXI_WREADY,
      M03_AXI_wstrb(3 downto 0) => axi4lite_0_M03_AXI_WSTRB(3 downto 0),
      M03_AXI_wvalid => axi4lite_0_M03_AXI_WVALID,
      M04_ACLK => sysclk,
      M04_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M04_AXI_araddr(31 downto 0) => axi4lite_0_M04_AXI_ARADDR(31 downto 0),
      M04_AXI_arprot(2 downto 0) => axi4lite_0_M04_AXI_ARPROT(2 downto 0),
      M04_AXI_arready => axi4lite_0_M04_AXI_ARREADY,
      M04_AXI_arvalid => axi4lite_0_M04_AXI_ARVALID,
      M04_AXI_awaddr(31 downto 0) => axi4lite_0_M04_AXI_AWADDR(31 downto 0),
      M04_AXI_awprot(2 downto 0) => axi4lite_0_M04_AXI_AWPROT(2 downto 0),
      M04_AXI_awready => axi4lite_0_M04_AXI_AWREADY,
      M04_AXI_awvalid => axi4lite_0_M04_AXI_AWVALID,
      M04_AXI_bready => axi4lite_0_M04_AXI_BREADY,
      M04_AXI_bresp(1 downto 0) => axi4lite_0_M04_AXI_BRESP(1 downto 0),
      M04_AXI_bvalid => axi4lite_0_M04_AXI_BVALID,
      M04_AXI_rdata(31 downto 0) => axi4lite_0_M04_AXI_RDATA(31 downto 0),
      M04_AXI_rready => axi4lite_0_M04_AXI_RREADY,
      M04_AXI_rresp(1 downto 0) => axi4lite_0_M04_AXI_RRESP(1 downto 0),
      M04_AXI_rvalid => axi4lite_0_M04_AXI_RVALID,
      M04_AXI_wdata(31 downto 0) => axi4lite_0_M04_AXI_WDATA(31 downto 0),
      M04_AXI_wready => axi4lite_0_M04_AXI_WREADY,
      M04_AXI_wstrb(3 downto 0) => axi4lite_0_M04_AXI_WSTRB(3 downto 0),
      M04_AXI_wvalid => axi4lite_0_M04_AXI_WVALID,
      S00_ACLK => sysclk,
      S00_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      S00_AXI_araddr(31 downto 0) => S00_AXI_1_ARADDR(31 downto 0),
      S00_AXI_arprot(2 downto 0) => S00_AXI_1_ARPROT(2 downto 0),
      S00_AXI_arready => S00_AXI_1_ARREADY,
      S00_AXI_arvalid => S00_AXI_1_ARVALID,
      S00_AXI_awaddr(31 downto 0) => S00_AXI_1_AWADDR(31 downto 0),
      S00_AXI_awprot(2 downto 0) => S00_AXI_1_AWPROT(2 downto 0),
      S00_AXI_awready => S00_AXI_1_AWREADY,
      S00_AXI_awvalid => S00_AXI_1_AWVALID,
      S00_AXI_bready => S00_AXI_1_BREADY,
      S00_AXI_bresp(1 downto 0) => S00_AXI_1_BRESP(1 downto 0),
      S00_AXI_bvalid => S00_AXI_1_BVALID,
      S00_AXI_rdata(31 downto 0) => S00_AXI_1_RDATA(31 downto 0),
      S00_AXI_rready => S00_AXI_1_RREADY,
      S00_AXI_rresp(1 downto 0) => S00_AXI_1_RRESP(1 downto 0),
      S00_AXI_rvalid => S00_AXI_1_RVALID,
      S00_AXI_wdata(31 downto 0) => S00_AXI_1_WDATA(31 downto 0),
      S00_AXI_wready => S00_AXI_1_WREADY,
      S00_AXI_wstrb(3 downto 0) => S00_AXI_1_WSTRB(3 downto 0),
      S00_AXI_wvalid => S00_AXI_1_WVALID
    );
axi_addr_remap_0: component system_axi_addr_remap_0_0
    port map (
      aclk => sysclk,
      aresetn => rst_processing_system7_0_100M_peripheral_aresetn(0),
      m_axi_araddr(31 downto 0) => S02_AXI_1_ARADDR(31 downto 0),
      m_axi_arprot(2 downto 0) => S02_AXI_1_ARPROT(2 downto 0),
      m_axi_arready => S02_AXI_1_ARREADY,
      m_axi_arvalid => S02_AXI_1_ARVALID,
      m_axi_awaddr(31 downto 0) => S02_AXI_1_AWADDR(31 downto 0),
      m_axi_awprot(2 downto 0) => S02_AXI_1_AWPROT(2 downto 0),
      m_axi_awready => S02_AXI_1_AWREADY,
      m_axi_awvalid => S02_AXI_1_AWVALID,
      m_axi_bready => S02_AXI_1_BREADY,
      m_axi_bresp(1 downto 0) => S02_AXI_1_BRESP(1 downto 0),
      m_axi_bvalid => S02_AXI_1_BVALID,
      m_axi_rdata(31 downto 0) => S02_AXI_1_RDATA(31 downto 0),
      m_axi_rready => S02_AXI_1_RREADY,
      m_axi_rresp(1 downto 0) => S02_AXI_1_RRESP(1 downto 0),
      m_axi_rvalid => S02_AXI_1_RVALID,
      m_axi_wdata(31 downto 0) => S02_AXI_1_WDATA(31 downto 0),
      m_axi_wready => S02_AXI_1_WREADY,
      m_axi_wstrb(3 downto 0) => S02_AXI_1_WSTRB(3 downto 0),
      m_axi_wvalid => S02_AXI_1_WVALID,
      s_axi_araddr(31 downto 0) => axi4lite_0_M04_AXI_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => axi4lite_0_M04_AXI_ARPROT(2 downto 0),
      s_axi_arready => axi4lite_0_M04_AXI_ARREADY,
      s_axi_arvalid => axi4lite_0_M04_AXI_ARVALID,
      s_axi_awaddr(31 downto 0) => axi4lite_0_M04_AXI_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => axi4lite_0_M04_AXI_AWPROT(2 downto 0),
      s_axi_awready => axi4lite_0_M04_AXI_AWREADY,
      s_axi_awvalid => axi4lite_0_M04_AXI_AWVALID,
      s_axi_bready => axi4lite_0_M04_AXI_BREADY,
      s_axi_bresp(1 downto 0) => axi4lite_0_M04_AXI_BRESP(1 downto 0),
      s_axi_bvalid => axi4lite_0_M04_AXI_BVALID,
      s_axi_rdata(31 downto 0) => axi4lite_0_M04_AXI_RDATA(31 downto 0),
      s_axi_rready => axi4lite_0_M04_AXI_RREADY,
      s_axi_rresp(1 downto 0) => axi4lite_0_M04_AXI_RRESP(1 downto 0),
      s_axi_rvalid => axi4lite_0_M04_AXI_RVALID,
      s_axi_wdata(31 downto 0) => axi4lite_0_M04_AXI_WDATA(31 downto 0),
      s_axi_wready => axi4lite_0_M04_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => axi4lite_0_M04_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => axi4lite_0_M04_AXI_WVALID
    );
axi_hp_0: entity work.system_axi_hp_0_0
    port map (
      ACLK => sysclk,
      ARESETN(0) => rst_processing_system7_0_100M_interconnect_aresetn(0),
      M00_ACLK => sysclk,
      M00_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M00_AXI_araddr(31 downto 0) => axi_mem_intercon_M00_AXI_ARADDR(31 downto 0),
      M00_AXI_arburst(1 downto 0) => axi_mem_intercon_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => axi_mem_intercon_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arid(1 downto 0) => axi_mem_intercon_M00_AXI_ARID(1 downto 0),
      M00_AXI_arlen(3 downto 0) => axi_mem_intercon_M00_AXI_ARLEN(3 downto 0),
      M00_AXI_arlock(1 downto 0) => axi_mem_intercon_M00_AXI_ARLOCK(1 downto 0),
      M00_AXI_arprot(2 downto 0) => axi_mem_intercon_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arqos(3 downto 0) => axi_mem_intercon_M00_AXI_ARQOS(3 downto 0),
      M00_AXI_arready => axi_mem_intercon_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => axi_mem_intercon_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => axi_mem_intercon_M00_AXI_ARVALID,
      M00_AXI_awaddr(31 downto 0) => axi_mem_intercon_M00_AXI_AWADDR(31 downto 0),
      M00_AXI_awburst(1 downto 0) => axi_mem_intercon_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => axi_mem_intercon_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awid(1 downto 0) => axi_mem_intercon_M00_AXI_AWID(1 downto 0),
      M00_AXI_awlen(3 downto 0) => axi_mem_intercon_M00_AXI_AWLEN(3 downto 0),
      M00_AXI_awlock(1 downto 0) => axi_mem_intercon_M00_AXI_AWLOCK(1 downto 0),
      M00_AXI_awprot(2 downto 0) => axi_mem_intercon_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awqos(3 downto 0) => axi_mem_intercon_M00_AXI_AWQOS(3 downto 0),
      M00_AXI_awready => axi_mem_intercon_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => axi_mem_intercon_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => axi_mem_intercon_M00_AXI_AWVALID,
      M00_AXI_bid(1 downto 0) => axi_mem_intercon_M00_AXI_BID(1 downto 0),
      M00_AXI_bready => axi_mem_intercon_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => axi_mem_intercon_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => axi_mem_intercon_M00_AXI_BVALID,
      M00_AXI_rdata(31 downto 0) => axi_mem_intercon_M00_AXI_RDATA(31 downto 0),
      M00_AXI_rid(1 downto 0) => axi_mem_intercon_M00_AXI_RID(1 downto 0),
      M00_AXI_rlast => axi_mem_intercon_M00_AXI_RLAST,
      M00_AXI_rready => axi_mem_intercon_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => axi_mem_intercon_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => axi_mem_intercon_M00_AXI_RVALID,
      M00_AXI_wdata(31 downto 0) => axi_mem_intercon_M00_AXI_WDATA(31 downto 0),
      M00_AXI_wid(1 downto 0) => axi_mem_intercon_M00_AXI_WID(1 downto 0),
      M00_AXI_wlast => axi_mem_intercon_M00_AXI_WLAST,
      M00_AXI_wready => axi_mem_intercon_M00_AXI_WREADY,
      M00_AXI_wstrb(3 downto 0) => axi_mem_intercon_M00_AXI_WSTRB(3 downto 0),
      M00_AXI_wvalid => axi_mem_intercon_M00_AXI_WVALID,
      S00_ACLK => sysclk,
      S00_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      S00_AXI_araddr(31 downto 0) => microblaze_0_M_AXI_DC_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => microblaze_0_M_AXI_DC_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => microblaze_0_M_AXI_DC_ARCACHE(3 downto 0),
      S00_AXI_arid(0) => microblaze_0_M_AXI_DC_ARID(0),
      S00_AXI_arlen(7 downto 0) => microblaze_0_M_AXI_DC_ARLEN(7 downto 0),
      S00_AXI_arlock => microblaze_0_M_AXI_DC_ARLOCK,
      S00_AXI_arprot(2 downto 0) => microblaze_0_M_AXI_DC_ARPROT(2 downto 0),
      S00_AXI_arqos(3 downto 0) => microblaze_0_M_AXI_DC_ARQOS(3 downto 0),
      S00_AXI_arready => microblaze_0_M_AXI_DC_ARREADY,
      S00_AXI_arsize(2 downto 0) => microblaze_0_M_AXI_DC_ARSIZE(2 downto 0),
      S00_AXI_arvalid => microblaze_0_M_AXI_DC_ARVALID,
      S00_AXI_awaddr(31 downto 0) => microblaze_0_M_AXI_DC_AWADDR(31 downto 0),
      S00_AXI_awburst(1 downto 0) => microblaze_0_M_AXI_DC_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => microblaze_0_M_AXI_DC_AWCACHE(3 downto 0),
      S00_AXI_awid(0) => microblaze_0_M_AXI_DC_AWID(0),
      S00_AXI_awlen(7 downto 0) => microblaze_0_M_AXI_DC_AWLEN(7 downto 0),
      S00_AXI_awlock => microblaze_0_M_AXI_DC_AWLOCK,
      S00_AXI_awprot(2 downto 0) => microblaze_0_M_AXI_DC_AWPROT(2 downto 0),
      S00_AXI_awqos(3 downto 0) => microblaze_0_M_AXI_DC_AWQOS(3 downto 0),
      S00_AXI_awready => microblaze_0_M_AXI_DC_AWREADY,
      S00_AXI_awsize(2 downto 0) => microblaze_0_M_AXI_DC_AWSIZE(2 downto 0),
      S00_AXI_awvalid => microblaze_0_M_AXI_DC_AWVALID,
      S00_AXI_bid(0) => microblaze_0_M_AXI_DC_BID(0),
      S00_AXI_bready => microblaze_0_M_AXI_DC_BREADY,
      S00_AXI_bresp(1 downto 0) => microblaze_0_M_AXI_DC_BRESP(1 downto 0),
      S00_AXI_bvalid => microblaze_0_M_AXI_DC_BVALID,
      S00_AXI_rdata(31 downto 0) => microblaze_0_M_AXI_DC_RDATA(31 downto 0),
      S00_AXI_rid(0) => microblaze_0_M_AXI_DC_RID(0),
      S00_AXI_rlast => microblaze_0_M_AXI_DC_RLAST,
      S00_AXI_rready => microblaze_0_M_AXI_DC_RREADY,
      S00_AXI_rresp(1 downto 0) => microblaze_0_M_AXI_DC_RRESP(1 downto 0),
      S00_AXI_rvalid => microblaze_0_M_AXI_DC_RVALID,
      S00_AXI_wdata(31 downto 0) => microblaze_0_M_AXI_DC_WDATA(31 downto 0),
      S00_AXI_wlast => microblaze_0_M_AXI_DC_WLAST,
      S00_AXI_wready => microblaze_0_M_AXI_DC_WREADY,
      S00_AXI_wstrb(3 downto 0) => microblaze_0_M_AXI_DC_WSTRB(3 downto 0),
      S00_AXI_wvalid => microblaze_0_M_AXI_DC_WVALID,
      S01_ACLK => sysclk,
      S01_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      S01_AXI_araddr(31 downto 0) => microblaze_0_M_AXI_IC_ARADDR(31 downto 0),
      S01_AXI_arburst(1 downto 0) => microblaze_0_M_AXI_IC_ARBURST(1 downto 0),
      S01_AXI_arcache(3 downto 0) => microblaze_0_M_AXI_IC_ARCACHE(3 downto 0),
      S01_AXI_arid(0) => microblaze_0_M_AXI_IC_ARID(0),
      S01_AXI_arlen(7 downto 0) => microblaze_0_M_AXI_IC_ARLEN(7 downto 0),
      S01_AXI_arlock => microblaze_0_M_AXI_IC_ARLOCK,
      S01_AXI_arprot(2 downto 0) => microblaze_0_M_AXI_IC_ARPROT(2 downto 0),
      S01_AXI_arqos(3 downto 0) => microblaze_0_M_AXI_IC_ARQOS(3 downto 0),
      S01_AXI_arready => microblaze_0_M_AXI_IC_ARREADY,
      S01_AXI_arsize(2 downto 0) => microblaze_0_M_AXI_IC_ARSIZE(2 downto 0),
      S01_AXI_arvalid => microblaze_0_M_AXI_IC_ARVALID,
      S01_AXI_awaddr(31 downto 0) => microblaze_0_M_AXI_IC_AWADDR(31 downto 0),
      S01_AXI_awburst(1 downto 0) => microblaze_0_M_AXI_IC_AWBURST(1 downto 0),
      S01_AXI_awcache(3 downto 0) => microblaze_0_M_AXI_IC_AWCACHE(3 downto 0),
      S01_AXI_awid(0) => microblaze_0_M_AXI_IC_AWID(0),
      S01_AXI_awlen(7 downto 0) => microblaze_0_M_AXI_IC_AWLEN(7 downto 0),
      S01_AXI_awlock => microblaze_0_M_AXI_IC_AWLOCK,
      S01_AXI_awprot(2 downto 0) => microblaze_0_M_AXI_IC_AWPROT(2 downto 0),
      S01_AXI_awqos(3 downto 0) => microblaze_0_M_AXI_IC_AWQOS(3 downto 0),
      S01_AXI_awready => microblaze_0_M_AXI_IC_AWREADY,
      S01_AXI_awsize(2 downto 0) => microblaze_0_M_AXI_IC_AWSIZE(2 downto 0),
      S01_AXI_awvalid => microblaze_0_M_AXI_IC_AWVALID,
      S01_AXI_bid(0) => microblaze_0_M_AXI_IC_BID(0),
      S01_AXI_bready => microblaze_0_M_AXI_IC_BREADY,
      S01_AXI_bresp(1 downto 0) => microblaze_0_M_AXI_IC_BRESP(1 downto 0),
      S01_AXI_bvalid => microblaze_0_M_AXI_IC_BVALID,
      S01_AXI_rdata(31 downto 0) => microblaze_0_M_AXI_IC_RDATA(31 downto 0),
      S01_AXI_rid(0) => microblaze_0_M_AXI_IC_RID(0),
      S01_AXI_rlast => microblaze_0_M_AXI_IC_RLAST,
      S01_AXI_rready => microblaze_0_M_AXI_IC_RREADY,
      S01_AXI_rresp(1 downto 0) => microblaze_0_M_AXI_IC_RRESP(1 downto 0),
      S01_AXI_rvalid => microblaze_0_M_AXI_IC_RVALID,
      S01_AXI_wdata(31 downto 0) => microblaze_0_M_AXI_IC_WDATA(31 downto 0),
      S01_AXI_wlast => microblaze_0_M_AXI_IC_WLAST,
      S01_AXI_wready => microblaze_0_M_AXI_IC_WREADY,
      S01_AXI_wstrb(3 downto 0) => microblaze_0_M_AXI_IC_WSTRB(3 downto 0),
      S01_AXI_wvalid => microblaze_0_M_AXI_IC_WVALID,
      S02_ACLK => sysclk,
      S02_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      S02_AXI_araddr(31 downto 0) => S02_AXI_1_ARADDR(31 downto 0),
      S02_AXI_arprot(2 downto 0) => S02_AXI_1_ARPROT(2 downto 0),
      S02_AXI_arready => S02_AXI_1_ARREADY,
      S02_AXI_arvalid => S02_AXI_1_ARVALID,
      S02_AXI_awaddr(31 downto 0) => S02_AXI_1_AWADDR(31 downto 0),
      S02_AXI_awprot(2 downto 0) => S02_AXI_1_AWPROT(2 downto 0),
      S02_AXI_awready => S02_AXI_1_AWREADY,
      S02_AXI_awvalid => S02_AXI_1_AWVALID,
      S02_AXI_bready => S02_AXI_1_BREADY,
      S02_AXI_bresp(1 downto 0) => S02_AXI_1_BRESP(1 downto 0),
      S02_AXI_bvalid => S02_AXI_1_BVALID,
      S02_AXI_rdata(31 downto 0) => S02_AXI_1_RDATA(31 downto 0),
      S02_AXI_rready => S02_AXI_1_RREADY,
      S02_AXI_rresp(1 downto 0) => S02_AXI_1_RRESP(1 downto 0),
      S02_AXI_rvalid => S02_AXI_1_RVALID,
      S02_AXI_wdata(31 downto 0) => S02_AXI_1_WDATA(31 downto 0),
      S02_AXI_wready => S02_AXI_1_WREADY,
      S02_AXI_wstrb(3 downto 0) => S02_AXI_1_WSTRB(3 downto 0),
      S02_AXI_wvalid => S02_AXI_1_WVALID
    );
axi_hp_2: entity work.system_axi_hp_2_0
    port map (
      ACLK => sysclk,
      ARESETN(0) => rst_processing_system7_0_100M_interconnect_aresetn(0),
      M00_ACLK => sysclk,
      M00_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      M00_AXI_araddr(31 downto 0) => axi_hp_2_M00_AXI_ARADDR(31 downto 0),
      M00_AXI_arburst(1 downto 0) => axi_hp_2_M00_AXI_ARBURST(1 downto 0),
      M00_AXI_arcache(3 downto 0) => axi_hp_2_M00_AXI_ARCACHE(3 downto 0),
      M00_AXI_arlen(3 downto 0) => axi_hp_2_M00_AXI_ARLEN(3 downto 0),
      M00_AXI_arprot(2 downto 0) => axi_hp_2_M00_AXI_ARPROT(2 downto 0),
      M00_AXI_arready => axi_hp_2_M00_AXI_ARREADY,
      M00_AXI_arsize(2 downto 0) => axi_hp_2_M00_AXI_ARSIZE(2 downto 0),
      M00_AXI_arvalid => axi_hp_2_M00_AXI_ARVALID,
      M00_AXI_awaddr(31 downto 0) => axi_hp_2_M00_AXI_AWADDR(31 downto 0),
      M00_AXI_awburst(1 downto 0) => axi_hp_2_M00_AXI_AWBURST(1 downto 0),
      M00_AXI_awcache(3 downto 0) => axi_hp_2_M00_AXI_AWCACHE(3 downto 0),
      M00_AXI_awlen(3 downto 0) => axi_hp_2_M00_AXI_AWLEN(3 downto 0),
      M00_AXI_awprot(2 downto 0) => axi_hp_2_M00_AXI_AWPROT(2 downto 0),
      M00_AXI_awready => axi_hp_2_M00_AXI_AWREADY,
      M00_AXI_awsize(2 downto 0) => axi_hp_2_M00_AXI_AWSIZE(2 downto 0),
      M00_AXI_awvalid => axi_hp_2_M00_AXI_AWVALID,
      M00_AXI_bready => axi_hp_2_M00_AXI_BREADY,
      M00_AXI_bresp(1 downto 0) => axi_hp_2_M00_AXI_BRESP(1 downto 0),
      M00_AXI_bvalid => axi_hp_2_M00_AXI_BVALID,
      M00_AXI_rdata(63 downto 0) => axi_hp_2_M00_AXI_RDATA(63 downto 0),
      M00_AXI_rlast => axi_hp_2_M00_AXI_RLAST,
      M00_AXI_rready => axi_hp_2_M00_AXI_RREADY,
      M00_AXI_rresp(1 downto 0) => axi_hp_2_M00_AXI_RRESP(1 downto 0),
      M00_AXI_rvalid => axi_hp_2_M00_AXI_RVALID,
      M00_AXI_wdata(63 downto 0) => axi_hp_2_M00_AXI_WDATA(63 downto 0),
      M00_AXI_wlast => axi_hp_2_M00_AXI_WLAST,
      M00_AXI_wready => axi_hp_2_M00_AXI_WREADY,
      M00_AXI_wstrb(7 downto 0) => axi_hp_2_M00_AXI_WSTRB(7 downto 0),
      M00_AXI_wvalid => axi_hp_2_M00_AXI_WVALID,
      S00_ACLK => sysclk,
      S00_ARESETN(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      S00_AXI_araddr(31 downto 0) => vectorblox_mxp_0_M_AXI_ARADDR(31 downto 0),
      S00_AXI_arburst(1 downto 0) => vectorblox_mxp_0_M_AXI_ARBURST(1 downto 0),
      S00_AXI_arcache(3 downto 0) => vectorblox_mxp_0_M_AXI_ARCACHE(3 downto 0),
      S00_AXI_arlen(3 downto 0) => vectorblox_mxp_0_M_AXI_ARLEN(3 downto 0),
      S00_AXI_arprot(2 downto 0) => vectorblox_mxp_0_M_AXI_ARPROT(2 downto 0),
      S00_AXI_arready => vectorblox_mxp_0_M_AXI_ARREADY,
      S00_AXI_arsize(2 downto 0) => vectorblox_mxp_0_M_AXI_ARSIZE(2 downto 0),
      S00_AXI_arvalid => vectorblox_mxp_0_M_AXI_ARVALID,
      S00_AXI_awaddr(31 downto 0) => vectorblox_mxp_0_M_AXI_AWADDR(31 downto 0),
      S00_AXI_awburst(1 downto 0) => vectorblox_mxp_0_M_AXI_AWBURST(1 downto 0),
      S00_AXI_awcache(3 downto 0) => vectorblox_mxp_0_M_AXI_AWCACHE(3 downto 0),
      S00_AXI_awlen(3 downto 0) => vectorblox_mxp_0_M_AXI_AWLEN(3 downto 0),
      S00_AXI_awprot(2 downto 0) => vectorblox_mxp_0_M_AXI_AWPROT(2 downto 0),
      S00_AXI_awready => vectorblox_mxp_0_M_AXI_AWREADY,
      S00_AXI_awsize(2 downto 0) => vectorblox_mxp_0_M_AXI_AWSIZE(2 downto 0),
      S00_AXI_awvalid => vectorblox_mxp_0_M_AXI_AWVALID,
      S00_AXI_bready => vectorblox_mxp_0_M_AXI_BREADY,
      S00_AXI_bresp(1 downto 0) => vectorblox_mxp_0_M_AXI_BRESP(1 downto 0),
      S00_AXI_bvalid => vectorblox_mxp_0_M_AXI_BVALID,
      S00_AXI_rdata(63 downto 0) => vectorblox_mxp_0_M_AXI_RDATA(63 downto 0),
      S00_AXI_rlast => vectorblox_mxp_0_M_AXI_RLAST,
      S00_AXI_rready => vectorblox_mxp_0_M_AXI_RREADY,
      S00_AXI_rresp(1 downto 0) => vectorblox_mxp_0_M_AXI_RRESP(1 downto 0),
      S00_AXI_rvalid => vectorblox_mxp_0_M_AXI_RVALID,
      S00_AXI_wdata(63 downto 0) => vectorblox_mxp_0_M_AXI_WDATA(63 downto 0),
      S00_AXI_wlast => vectorblox_mxp_0_M_AXI_WLAST,
      S00_AXI_wready => vectorblox_mxp_0_M_AXI_WREADY,
      S00_AXI_wstrb(7 downto 0) => vectorblox_mxp_0_M_AXI_WSTRB(7 downto 0),
      S00_AXI_wvalid => vectorblox_mxp_0_M_AXI_WVALID
    );
axi_timer_0: component system_axi_timer_0_0
    port map (
      capturetrig0 => GND_1,
      capturetrig1 => GND_1,
      freeze => GND_1,
      generateout0 => NLW_axi_timer_0_generateout0_UNCONNECTED,
      generateout1 => NLW_axi_timer_0_generateout1_UNCONNECTED,
      interrupt => NLW_axi_timer_0_interrupt_UNCONNECTED,
      pwm0 => NLW_axi_timer_0_pwm0_UNCONNECTED,
      s_axi_aclk => sysclk,
      s_axi_araddr(4 downto 0) => axi4lite_0_M01_AXI_ARADDR(4 downto 0),
      s_axi_aresetn => rst_processing_system7_0_100M_peripheral_aresetn(0),
      s_axi_arready => axi4lite_0_M01_AXI_ARREADY,
      s_axi_arvalid => axi4lite_0_M01_AXI_ARVALID,
      s_axi_awaddr(4 downto 0) => axi4lite_0_M01_AXI_AWADDR(4 downto 0),
      s_axi_awready => axi4lite_0_M01_AXI_AWREADY,
      s_axi_awvalid => axi4lite_0_M01_AXI_AWVALID,
      s_axi_bready => axi4lite_0_M01_AXI_BREADY,
      s_axi_bresp(1 downto 0) => axi4lite_0_M01_AXI_BRESP(1 downto 0),
      s_axi_bvalid => axi4lite_0_M01_AXI_BVALID,
      s_axi_rdata(31 downto 0) => axi4lite_0_M01_AXI_RDATA(31 downto 0),
      s_axi_rready => axi4lite_0_M01_AXI_RREADY,
      s_axi_rresp(1 downto 0) => axi4lite_0_M01_AXI_RRESP(1 downto 0),
      s_axi_rvalid => axi4lite_0_M01_AXI_RVALID,
      s_axi_wdata(31 downto 0) => axi4lite_0_M01_AXI_WDATA(31 downto 0),
      s_axi_wready => axi4lite_0_M01_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => axi4lite_0_M01_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => axi4lite_0_M01_AXI_WVALID
    );
clk_wiz_0: component system_clk_wiz_0_0
    port map (
      clk_in1 => processing_system7_0_FCLK_CLK0,
      clk_out1 => sysclk,
      clk_out2 => clk_wiz_0_clk_out2,
      locked => clk_wiz_0_locked,
      resetn => processing_system7_0_FCLK_RESET0_N
    );
lmb_bram_if_cntlr_0: component system_lmb_bram_if_cntlr_0_0
    port map (
      BRAM_Addr_A(0 to 31) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(0 to 31),
      BRAM_Clk_A => lmb_bram_if_cntlr_0_BRAM_PORT_CLK,
      BRAM_Din_A(0) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(31),
      BRAM_Din_A(1) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(30),
      BRAM_Din_A(2) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(29),
      BRAM_Din_A(3) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(28),
      BRAM_Din_A(4) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(27),
      BRAM_Din_A(5) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(26),
      BRAM_Din_A(6) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(25),
      BRAM_Din_A(7) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(24),
      BRAM_Din_A(8) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(23),
      BRAM_Din_A(9) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(22),
      BRAM_Din_A(10) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(21),
      BRAM_Din_A(11) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(20),
      BRAM_Din_A(12) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(19),
      BRAM_Din_A(13) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(18),
      BRAM_Din_A(14) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(17),
      BRAM_Din_A(15) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(16),
      BRAM_Din_A(16) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(15),
      BRAM_Din_A(17) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(14),
      BRAM_Din_A(18) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(13),
      BRAM_Din_A(19) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(12),
      BRAM_Din_A(20) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(11),
      BRAM_Din_A(21) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(10),
      BRAM_Din_A(22) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(9),
      BRAM_Din_A(23) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(8),
      BRAM_Din_A(24) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(7),
      BRAM_Din_A(25) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(6),
      BRAM_Din_A(26) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(5),
      BRAM_Din_A(27) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(4),
      BRAM_Din_A(28) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(3),
      BRAM_Din_A(29) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(2),
      BRAM_Din_A(30) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(1),
      BRAM_Din_A(31) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(0),
      BRAM_Dout_A(0 to 31) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(0 to 31),
      BRAM_EN_A => lmb_bram_if_cntlr_0_BRAM_PORT_EN,
      BRAM_Rst_A => lmb_bram_if_cntlr_0_BRAM_PORT_RST,
      BRAM_WEN_A(0 to 3) => lmb_bram_if_cntlr_0_BRAM_PORT_WE(0 to 3),
      LMB_ABus(0 to 31) => microblaze_0_DLMB_ABUS(0 to 31),
      LMB_AddrStrobe => microblaze_0_DLMB_ADDRSTROBE,
      LMB_BE(0 to 3) => microblaze_0_DLMB_BE(0 to 3),
      LMB_Clk => sysclk,
      LMB_ReadStrobe => microblaze_0_DLMB_READSTROBE,
      LMB_Rst => proc_sys_reset_0_bus_struct_reset(0),
      LMB_WriteDBus(0 to 31) => microblaze_0_DLMB_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => microblaze_0_DLMB_WRITESTROBE,
      Sl_CE => microblaze_0_DLMB_CE,
      Sl_DBus(0 to 31) => microblaze_0_DLMB_READDBUS(0 to 31),
      Sl_Ready => microblaze_0_DLMB_READY,
      Sl_UE => microblaze_0_DLMB_UE,
      Sl_Wait => microblaze_0_DLMB_WAIT
    );
lmb_bram_if_cntlr_0_bram: component system_lmb_bram_if_cntlr_0_bram_0
    port map (
      addra(31) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(0),
      addra(30) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(1),
      addra(29) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(2),
      addra(28) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(3),
      addra(27) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(4),
      addra(26) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(5),
      addra(25) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(6),
      addra(24) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(7),
      addra(23) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(8),
      addra(22) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(9),
      addra(21) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(10),
      addra(20) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(11),
      addra(19) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(12),
      addra(18) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(13),
      addra(17) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(14),
      addra(16) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(15),
      addra(15) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(16),
      addra(14) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(17),
      addra(13) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(18),
      addra(12) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(19),
      addra(11) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(20),
      addra(10) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(21),
      addra(9) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(22),
      addra(8) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(23),
      addra(7) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(24),
      addra(6) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(25),
      addra(5) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(26),
      addra(4) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(27),
      addra(3) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(28),
      addra(2) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(29),
      addra(1) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(30),
      addra(0) => lmb_bram_if_cntlr_0_BRAM_PORT_ADDR(31),
      addrb(31) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(0),
      addrb(30) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(1),
      addrb(29) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(2),
      addrb(28) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(3),
      addrb(27) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(4),
      addrb(26) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(5),
      addrb(25) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(6),
      addrb(24) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(7),
      addrb(23) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(8),
      addrb(22) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(9),
      addrb(21) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(10),
      addrb(20) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(11),
      addrb(19) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(12),
      addrb(18) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(13),
      addrb(17) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(14),
      addrb(16) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(15),
      addrb(15) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(16),
      addrb(14) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(17),
      addrb(13) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(18),
      addrb(12) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(19),
      addrb(11) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(20),
      addrb(10) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(21),
      addrb(9) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(22),
      addrb(8) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(23),
      addrb(7) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(24),
      addrb(6) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(25),
      addrb(5) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(26),
      addrb(4) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(27),
      addrb(3) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(28),
      addrb(2) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(29),
      addrb(1) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(30),
      addrb(0) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(31),
      clka => lmb_bram_if_cntlr_0_BRAM_PORT_CLK,
      clkb => lmb_bram_if_cntlr_1_BRAM_PORT_CLK,
      dina(31) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(0),
      dina(30) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(1),
      dina(29) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(2),
      dina(28) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(3),
      dina(27) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(4),
      dina(26) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(5),
      dina(25) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(6),
      dina(24) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(7),
      dina(23) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(8),
      dina(22) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(9),
      dina(21) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(10),
      dina(20) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(11),
      dina(19) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(12),
      dina(18) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(13),
      dina(17) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(14),
      dina(16) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(15),
      dina(15) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(16),
      dina(14) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(17),
      dina(13) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(18),
      dina(12) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(19),
      dina(11) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(20),
      dina(10) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(21),
      dina(9) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(22),
      dina(8) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(23),
      dina(7) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(24),
      dina(6) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(25),
      dina(5) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(26),
      dina(4) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(27),
      dina(3) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(28),
      dina(2) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(29),
      dina(1) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(30),
      dina(0) => lmb_bram_if_cntlr_0_BRAM_PORT_DIN(31),
      dinb(31) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(0),
      dinb(30) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(1),
      dinb(29) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(2),
      dinb(28) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(3),
      dinb(27) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(4),
      dinb(26) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(5),
      dinb(25) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(6),
      dinb(24) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(7),
      dinb(23) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(8),
      dinb(22) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(9),
      dinb(21) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(10),
      dinb(20) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(11),
      dinb(19) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(12),
      dinb(18) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(13),
      dinb(17) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(14),
      dinb(16) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(15),
      dinb(15) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(16),
      dinb(14) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(17),
      dinb(13) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(18),
      dinb(12) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(19),
      dinb(11) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(20),
      dinb(10) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(21),
      dinb(9) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(22),
      dinb(8) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(23),
      dinb(7) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(24),
      dinb(6) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(25),
      dinb(5) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(26),
      dinb(4) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(27),
      dinb(3) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(28),
      dinb(2) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(29),
      dinb(1) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(30),
      dinb(0) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(31),
      douta(31 downto 0) => lmb_bram_if_cntlr_0_BRAM_PORT_DOUT(31 downto 0),
      doutb(31 downto 0) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(31 downto 0),
      ena => lmb_bram_if_cntlr_0_BRAM_PORT_EN,
      enb => lmb_bram_if_cntlr_1_BRAM_PORT_EN,
      rsta => lmb_bram_if_cntlr_0_BRAM_PORT_RST,
      rstb => lmb_bram_if_cntlr_1_BRAM_PORT_RST,
      wea(3) => lmb_bram_if_cntlr_0_BRAM_PORT_WE(0),
      wea(2) => lmb_bram_if_cntlr_0_BRAM_PORT_WE(1),
      wea(1) => lmb_bram_if_cntlr_0_BRAM_PORT_WE(2),
      wea(0) => lmb_bram_if_cntlr_0_BRAM_PORT_WE(3),
      web(3) => lmb_bram_if_cntlr_1_BRAM_PORT_WE(0),
      web(2) => lmb_bram_if_cntlr_1_BRAM_PORT_WE(1),
      web(1) => lmb_bram_if_cntlr_1_BRAM_PORT_WE(2),
      web(0) => lmb_bram_if_cntlr_1_BRAM_PORT_WE(3)
    );
lmb_bram_if_cntlr_1: component system_lmb_bram_if_cntlr_1_0
    port map (
      BRAM_Addr_A(0 to 31) => lmb_bram_if_cntlr_1_BRAM_PORT_ADDR(0 to 31),
      BRAM_Clk_A => lmb_bram_if_cntlr_1_BRAM_PORT_CLK,
      BRAM_Din_A(0) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(31),
      BRAM_Din_A(1) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(30),
      BRAM_Din_A(2) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(29),
      BRAM_Din_A(3) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(28),
      BRAM_Din_A(4) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(27),
      BRAM_Din_A(5) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(26),
      BRAM_Din_A(6) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(25),
      BRAM_Din_A(7) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(24),
      BRAM_Din_A(8) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(23),
      BRAM_Din_A(9) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(22),
      BRAM_Din_A(10) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(21),
      BRAM_Din_A(11) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(20),
      BRAM_Din_A(12) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(19),
      BRAM_Din_A(13) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(18),
      BRAM_Din_A(14) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(17),
      BRAM_Din_A(15) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(16),
      BRAM_Din_A(16) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(15),
      BRAM_Din_A(17) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(14),
      BRAM_Din_A(18) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(13),
      BRAM_Din_A(19) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(12),
      BRAM_Din_A(20) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(11),
      BRAM_Din_A(21) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(10),
      BRAM_Din_A(22) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(9),
      BRAM_Din_A(23) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(8),
      BRAM_Din_A(24) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(7),
      BRAM_Din_A(25) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(6),
      BRAM_Din_A(26) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(5),
      BRAM_Din_A(27) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(4),
      BRAM_Din_A(28) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(3),
      BRAM_Din_A(29) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(2),
      BRAM_Din_A(30) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(1),
      BRAM_Din_A(31) => lmb_bram_if_cntlr_1_BRAM_PORT_DOUT(0),
      BRAM_Dout_A(0 to 31) => lmb_bram_if_cntlr_1_BRAM_PORT_DIN(0 to 31),
      BRAM_EN_A => lmb_bram_if_cntlr_1_BRAM_PORT_EN,
      BRAM_Rst_A => lmb_bram_if_cntlr_1_BRAM_PORT_RST,
      BRAM_WEN_A(0 to 3) => lmb_bram_if_cntlr_1_BRAM_PORT_WE(0 to 3),
      LMB_ABus(0 to 31) => microblaze_0_ILMB_ABUS(0 to 31),
      LMB_AddrStrobe => microblaze_0_ILMB_ADDRSTROBE,
      LMB_BE(0) => GND_1,
      LMB_BE(1) => GND_1,
      LMB_BE(2) => GND_1,
      LMB_BE(3) => GND_1,
      LMB_Clk => sysclk,
      LMB_ReadStrobe => microblaze_0_ILMB_READSTROBE,
      LMB_Rst => proc_sys_reset_0_bus_struct_reset(0),
      LMB_WriteDBus(0) => GND_1,
      LMB_WriteDBus(1) => GND_1,
      LMB_WriteDBus(2) => GND_1,
      LMB_WriteDBus(3) => GND_1,
      LMB_WriteDBus(4) => GND_1,
      LMB_WriteDBus(5) => GND_1,
      LMB_WriteDBus(6) => GND_1,
      LMB_WriteDBus(7) => GND_1,
      LMB_WriteDBus(8) => GND_1,
      LMB_WriteDBus(9) => GND_1,
      LMB_WriteDBus(10) => GND_1,
      LMB_WriteDBus(11) => GND_1,
      LMB_WriteDBus(12) => GND_1,
      LMB_WriteDBus(13) => GND_1,
      LMB_WriteDBus(14) => GND_1,
      LMB_WriteDBus(15) => GND_1,
      LMB_WriteDBus(16) => GND_1,
      LMB_WriteDBus(17) => GND_1,
      LMB_WriteDBus(18) => GND_1,
      LMB_WriteDBus(19) => GND_1,
      LMB_WriteDBus(20) => GND_1,
      LMB_WriteDBus(21) => GND_1,
      LMB_WriteDBus(22) => GND_1,
      LMB_WriteDBus(23) => GND_1,
      LMB_WriteDBus(24) => GND_1,
      LMB_WriteDBus(25) => GND_1,
      LMB_WriteDBus(26) => GND_1,
      LMB_WriteDBus(27) => GND_1,
      LMB_WriteDBus(28) => GND_1,
      LMB_WriteDBus(29) => GND_1,
      LMB_WriteDBus(30) => GND_1,
      LMB_WriteDBus(31) => GND_1,
      LMB_WriteStrobe => GND_1,
      Sl_CE => microblaze_0_ILMB_CE,
      Sl_DBus(0 to 31) => microblaze_0_ILMB_READDBUS(0 to 31),
      Sl_Ready => microblaze_0_ILMB_READY,
      Sl_UE => microblaze_0_ILMB_UE,
      Sl_Wait => microblaze_0_ILMB_WAIT
    );
mdm_0: component system_mdm_0_0
    port map (
      Dbg_Capture_0 => mdm_0_MBDEBUG_0_CAPTURE,
      Dbg_Clk_0 => mdm_0_MBDEBUG_0_CLK,
      Dbg_Reg_En_0(0 to 7) => mdm_0_MBDEBUG_0_REG_EN(0 to 7),
      Dbg_Rst_0 => mdm_0_MBDEBUG_0_RST,
      Dbg_Shift_0 => mdm_0_MBDEBUG_0_SHIFT,
      Dbg_TDI_0 => mdm_0_MBDEBUG_0_TDI,
      Dbg_TDO_0 => mdm_0_MBDEBUG_0_TDO,
      Dbg_Update_0 => mdm_0_MBDEBUG_0_UPDATE,
      Debug_SYS_Rst => mdm_0_Debug_SYS_Rst,
      Interrupt => NLW_mdm_0_Interrupt_UNCONNECTED,
      S_AXI_ACLK => sysclk,
      S_AXI_ARADDR(31 downto 0) => axi4lite_0_M00_AXI_ARADDR(31 downto 0),
      S_AXI_ARESETN => rst_processing_system7_0_100M_peripheral_aresetn(0),
      S_AXI_ARREADY => axi4lite_0_M00_AXI_ARREADY,
      S_AXI_ARVALID => axi4lite_0_M00_AXI_ARVALID,
      S_AXI_AWADDR(31 downto 0) => axi4lite_0_M00_AXI_AWADDR(31 downto 0),
      S_AXI_AWREADY => axi4lite_0_M00_AXI_AWREADY,
      S_AXI_AWVALID => axi4lite_0_M00_AXI_AWVALID,
      S_AXI_BREADY => axi4lite_0_M00_AXI_BREADY,
      S_AXI_BRESP(1 downto 0) => axi4lite_0_M00_AXI_BRESP(1 downto 0),
      S_AXI_BVALID => axi4lite_0_M00_AXI_BVALID,
      S_AXI_RDATA(31 downto 0) => axi4lite_0_M00_AXI_RDATA(31 downto 0),
      S_AXI_RREADY => axi4lite_0_M00_AXI_RREADY,
      S_AXI_RRESP(1 downto 0) => axi4lite_0_M00_AXI_RRESP(1 downto 0),
      S_AXI_RVALID => axi4lite_0_M00_AXI_RVALID,
      S_AXI_WDATA(31 downto 0) => axi4lite_0_M00_AXI_WDATA(31 downto 0),
      S_AXI_WREADY => axi4lite_0_M00_AXI_WREADY,
      S_AXI_WSTRB(3 downto 0) => axi4lite_0_M00_AXI_WSTRB(3 downto 0),
      S_AXI_WVALID => axi4lite_0_M00_AXI_WVALID
    );
microblaze_0: component system_microblaze_0_0
    port map (
      Byte_Enable(0 to 3) => microblaze_0_DLMB_BE(0 to 3),
      Clk => sysclk,
      DCE => microblaze_0_DLMB_CE,
      DReady => microblaze_0_DLMB_READY,
      DUE => microblaze_0_DLMB_UE,
      DWait => microblaze_0_DLMB_WAIT,
      D_AS => microblaze_0_DLMB_ADDRSTROBE,
      Data_Addr(0 to 31) => microblaze_0_DLMB_ABUS(0 to 31),
      Data_Read(0 to 31) => microblaze_0_DLMB_READDBUS(0 to 31),
      Data_Write(0 to 31) => microblaze_0_DLMB_WRITEDBUS(0 to 31),
      Dbg_Capture => mdm_0_MBDEBUG_0_CAPTURE,
      Dbg_Clk => mdm_0_MBDEBUG_0_CLK,
      Dbg_Reg_En(0 to 7) => mdm_0_MBDEBUG_0_REG_EN(0 to 7),
      Dbg_Shift => mdm_0_MBDEBUG_0_SHIFT,
      Dbg_TDI => mdm_0_MBDEBUG_0_TDI,
      Dbg_TDO => mdm_0_MBDEBUG_0_TDO,
      Dbg_Update => mdm_0_MBDEBUG_0_UPDATE,
      Debug_Rst => mdm_0_MBDEBUG_0_RST,
      ICE => microblaze_0_ILMB_CE,
      IFetch => microblaze_0_ILMB_READSTROBE,
      IReady => microblaze_0_ILMB_READY,
      IUE => microblaze_0_ILMB_UE,
      IWAIT => microblaze_0_ILMB_WAIT,
      I_AS => microblaze_0_ILMB_ADDRSTROBE,
      Instr(0 to 31) => microblaze_0_ILMB_READDBUS(0 to 31),
      Instr_Addr(0 to 31) => microblaze_0_ILMB_ABUS(0 to 31),
      Interrupt => GND_1,
      Interrupt_Ack(0 to 1) => NLW_microblaze_0_Interrupt_Ack_UNCONNECTED(0 to 1),
      Interrupt_Address(0) => GND_1,
      Interrupt_Address(1) => GND_1,
      Interrupt_Address(2) => GND_1,
      Interrupt_Address(3) => GND_1,
      Interrupt_Address(4) => GND_1,
      Interrupt_Address(5) => GND_1,
      Interrupt_Address(6) => GND_1,
      Interrupt_Address(7) => GND_1,
      Interrupt_Address(8) => GND_1,
      Interrupt_Address(9) => GND_1,
      Interrupt_Address(10) => GND_1,
      Interrupt_Address(11) => GND_1,
      Interrupt_Address(12) => GND_1,
      Interrupt_Address(13) => GND_1,
      Interrupt_Address(14) => GND_1,
      Interrupt_Address(15) => GND_1,
      Interrupt_Address(16) => GND_1,
      Interrupt_Address(17) => GND_1,
      Interrupt_Address(18) => GND_1,
      Interrupt_Address(19) => GND_1,
      Interrupt_Address(20) => GND_1,
      Interrupt_Address(21) => GND_1,
      Interrupt_Address(22) => GND_1,
      Interrupt_Address(23) => GND_1,
      Interrupt_Address(24) => GND_1,
      Interrupt_Address(25) => GND_1,
      Interrupt_Address(26) => GND_1,
      Interrupt_Address(27) => GND_1,
      Interrupt_Address(28) => GND_1,
      Interrupt_Address(29) => GND_1,
      Interrupt_Address(30) => GND_1,
      Interrupt_Address(31) => GND_1,
      M0_AXIS_TDATA(31 downto 0) => microblaze_0_M0_AXIS_TDATA(31 downto 0),
      M0_AXIS_TLAST => microblaze_0_M0_AXIS_TLAST,
      M0_AXIS_TREADY => microblaze_0_M0_AXIS_TREADY,
      M0_AXIS_TVALID => microblaze_0_M0_AXIS_TVALID,
      M_AXI_DC_ARADDR(31 downto 0) => microblaze_0_M_AXI_DC_ARADDR(31 downto 0),
      M_AXI_DC_ARBURST(1 downto 0) => microblaze_0_M_AXI_DC_ARBURST(1 downto 0),
      M_AXI_DC_ARCACHE(3 downto 0) => microblaze_0_M_AXI_DC_ARCACHE(3 downto 0),
      M_AXI_DC_ARID(0) => microblaze_0_M_AXI_DC_ARID(0),
      M_AXI_DC_ARLEN(7 downto 0) => microblaze_0_M_AXI_DC_ARLEN(7 downto 0),
      M_AXI_DC_ARLOCK => microblaze_0_M_AXI_DC_ARLOCK,
      M_AXI_DC_ARPROT(2 downto 0) => microblaze_0_M_AXI_DC_ARPROT(2 downto 0),
      M_AXI_DC_ARQOS(3 downto 0) => microblaze_0_M_AXI_DC_ARQOS(3 downto 0),
      M_AXI_DC_ARREADY => microblaze_0_M_AXI_DC_ARREADY,
      M_AXI_DC_ARSIZE(2 downto 0) => microblaze_0_M_AXI_DC_ARSIZE(2 downto 0),
      M_AXI_DC_ARVALID => microblaze_0_M_AXI_DC_ARVALID,
      M_AXI_DC_AWADDR(31 downto 0) => microblaze_0_M_AXI_DC_AWADDR(31 downto 0),
      M_AXI_DC_AWBURST(1 downto 0) => microblaze_0_M_AXI_DC_AWBURST(1 downto 0),
      M_AXI_DC_AWCACHE(3 downto 0) => microblaze_0_M_AXI_DC_AWCACHE(3 downto 0),
      M_AXI_DC_AWID(0) => microblaze_0_M_AXI_DC_AWID(0),
      M_AXI_DC_AWLEN(7 downto 0) => microblaze_0_M_AXI_DC_AWLEN(7 downto 0),
      M_AXI_DC_AWLOCK => microblaze_0_M_AXI_DC_AWLOCK,
      M_AXI_DC_AWPROT(2 downto 0) => microblaze_0_M_AXI_DC_AWPROT(2 downto 0),
      M_AXI_DC_AWQOS(3 downto 0) => microblaze_0_M_AXI_DC_AWQOS(3 downto 0),
      M_AXI_DC_AWREADY => microblaze_0_M_AXI_DC_AWREADY,
      M_AXI_DC_AWSIZE(2 downto 0) => microblaze_0_M_AXI_DC_AWSIZE(2 downto 0),
      M_AXI_DC_AWVALID => microblaze_0_M_AXI_DC_AWVALID,
      M_AXI_DC_BID(0) => microblaze_0_M_AXI_DC_BID(0),
      M_AXI_DC_BREADY => microblaze_0_M_AXI_DC_BREADY,
      M_AXI_DC_BRESP(1 downto 0) => microblaze_0_M_AXI_DC_BRESP(1 downto 0),
      M_AXI_DC_BVALID => microblaze_0_M_AXI_DC_BVALID,
      M_AXI_DC_RDATA(31 downto 0) => microblaze_0_M_AXI_DC_RDATA(31 downto 0),
      M_AXI_DC_RID(0) => microblaze_0_M_AXI_DC_RID(0),
      M_AXI_DC_RLAST => microblaze_0_M_AXI_DC_RLAST,
      M_AXI_DC_RREADY => microblaze_0_M_AXI_DC_RREADY,
      M_AXI_DC_RRESP(1 downto 0) => microblaze_0_M_AXI_DC_RRESP(1 downto 0),
      M_AXI_DC_RVALID => microblaze_0_M_AXI_DC_RVALID,
      M_AXI_DC_WDATA(31 downto 0) => microblaze_0_M_AXI_DC_WDATA(31 downto 0),
      M_AXI_DC_WLAST => microblaze_0_M_AXI_DC_WLAST,
      M_AXI_DC_WREADY => microblaze_0_M_AXI_DC_WREADY,
      M_AXI_DC_WSTRB(3 downto 0) => microblaze_0_M_AXI_DC_WSTRB(3 downto 0),
      M_AXI_DC_WVALID => microblaze_0_M_AXI_DC_WVALID,
      M_AXI_DP_ARADDR(31 downto 0) => S00_AXI_1_ARADDR(31 downto 0),
      M_AXI_DP_ARPROT(2 downto 0) => S00_AXI_1_ARPROT(2 downto 0),
      M_AXI_DP_ARREADY => S00_AXI_1_ARREADY,
      M_AXI_DP_ARVALID => S00_AXI_1_ARVALID,
      M_AXI_DP_AWADDR(31 downto 0) => S00_AXI_1_AWADDR(31 downto 0),
      M_AXI_DP_AWPROT(2 downto 0) => S00_AXI_1_AWPROT(2 downto 0),
      M_AXI_DP_AWREADY => S00_AXI_1_AWREADY,
      M_AXI_DP_AWVALID => S00_AXI_1_AWVALID,
      M_AXI_DP_BREADY => S00_AXI_1_BREADY,
      M_AXI_DP_BRESP(1 downto 0) => S00_AXI_1_BRESP(1 downto 0),
      M_AXI_DP_BVALID => S00_AXI_1_BVALID,
      M_AXI_DP_RDATA(31 downto 0) => S00_AXI_1_RDATA(31 downto 0),
      M_AXI_DP_RREADY => S00_AXI_1_RREADY,
      M_AXI_DP_RRESP(1 downto 0) => S00_AXI_1_RRESP(1 downto 0),
      M_AXI_DP_RVALID => S00_AXI_1_RVALID,
      M_AXI_DP_WDATA(31 downto 0) => S00_AXI_1_WDATA(31 downto 0),
      M_AXI_DP_WREADY => S00_AXI_1_WREADY,
      M_AXI_DP_WSTRB(3 downto 0) => S00_AXI_1_WSTRB(3 downto 0),
      M_AXI_DP_WVALID => S00_AXI_1_WVALID,
      M_AXI_IC_ARADDR(31 downto 0) => microblaze_0_M_AXI_IC_ARADDR(31 downto 0),
      M_AXI_IC_ARBURST(1 downto 0) => microblaze_0_M_AXI_IC_ARBURST(1 downto 0),
      M_AXI_IC_ARCACHE(3 downto 0) => microblaze_0_M_AXI_IC_ARCACHE(3 downto 0),
      M_AXI_IC_ARID(0) => microblaze_0_M_AXI_IC_ARID(0),
      M_AXI_IC_ARLEN(7 downto 0) => microblaze_0_M_AXI_IC_ARLEN(7 downto 0),
      M_AXI_IC_ARLOCK => microblaze_0_M_AXI_IC_ARLOCK,
      M_AXI_IC_ARPROT(2 downto 0) => microblaze_0_M_AXI_IC_ARPROT(2 downto 0),
      M_AXI_IC_ARQOS(3 downto 0) => microblaze_0_M_AXI_IC_ARQOS(3 downto 0),
      M_AXI_IC_ARREADY => microblaze_0_M_AXI_IC_ARREADY,
      M_AXI_IC_ARSIZE(2 downto 0) => microblaze_0_M_AXI_IC_ARSIZE(2 downto 0),
      M_AXI_IC_ARVALID => microblaze_0_M_AXI_IC_ARVALID,
      M_AXI_IC_AWADDR(31 downto 0) => microblaze_0_M_AXI_IC_AWADDR(31 downto 0),
      M_AXI_IC_AWBURST(1 downto 0) => microblaze_0_M_AXI_IC_AWBURST(1 downto 0),
      M_AXI_IC_AWCACHE(3 downto 0) => microblaze_0_M_AXI_IC_AWCACHE(3 downto 0),
      M_AXI_IC_AWID(0) => microblaze_0_M_AXI_IC_AWID(0),
      M_AXI_IC_AWLEN(7 downto 0) => microblaze_0_M_AXI_IC_AWLEN(7 downto 0),
      M_AXI_IC_AWLOCK => microblaze_0_M_AXI_IC_AWLOCK,
      M_AXI_IC_AWPROT(2 downto 0) => microblaze_0_M_AXI_IC_AWPROT(2 downto 0),
      M_AXI_IC_AWQOS(3 downto 0) => microblaze_0_M_AXI_IC_AWQOS(3 downto 0),
      M_AXI_IC_AWREADY => microblaze_0_M_AXI_IC_AWREADY,
      M_AXI_IC_AWSIZE(2 downto 0) => microblaze_0_M_AXI_IC_AWSIZE(2 downto 0),
      M_AXI_IC_AWVALID => microblaze_0_M_AXI_IC_AWVALID,
      M_AXI_IC_BID(0) => microblaze_0_M_AXI_IC_BID(0),
      M_AXI_IC_BREADY => microblaze_0_M_AXI_IC_BREADY,
      M_AXI_IC_BRESP(1 downto 0) => microblaze_0_M_AXI_IC_BRESP(1 downto 0),
      M_AXI_IC_BVALID => microblaze_0_M_AXI_IC_BVALID,
      M_AXI_IC_RDATA(31 downto 0) => microblaze_0_M_AXI_IC_RDATA(31 downto 0),
      M_AXI_IC_RID(0) => microblaze_0_M_AXI_IC_RID(0),
      M_AXI_IC_RLAST => microblaze_0_M_AXI_IC_RLAST,
      M_AXI_IC_RREADY => microblaze_0_M_AXI_IC_RREADY,
      M_AXI_IC_RRESP(1 downto 0) => microblaze_0_M_AXI_IC_RRESP(1 downto 0),
      M_AXI_IC_RVALID => microblaze_0_M_AXI_IC_RVALID,
      M_AXI_IC_WDATA(31 downto 0) => microblaze_0_M_AXI_IC_WDATA(31 downto 0),
      M_AXI_IC_WLAST => microblaze_0_M_AXI_IC_WLAST,
      M_AXI_IC_WREADY => microblaze_0_M_AXI_IC_WREADY,
      M_AXI_IC_WSTRB(3 downto 0) => microblaze_0_M_AXI_IC_WSTRB(3 downto 0),
      M_AXI_IC_WVALID => microblaze_0_M_AXI_IC_WVALID,
      Read_Strobe => microblaze_0_DLMB_READSTROBE,
      Reset => rst_processing_system7_0_100M_mb_reset,
      S0_AXIS_TDATA(31 downto 0) => vectorblox_mxp_0_M_AXIS_INSTR_TDATA(31 downto 0),
      S0_AXIS_TLAST => vectorblox_mxp_0_M_AXIS_INSTR_TLAST,
      S0_AXIS_TREADY => vectorblox_mxp_0_M_AXIS_INSTR_TREADY,
      S0_AXIS_TVALID => vectorblox_mxp_0_M_AXIS_INSTR_TVALID,
      Write_Strobe => microblaze_0_DLMB_WRITESTROBE
    );
proc_sys_reset_0: component system_proc_sys_reset_0_0
    port map (
      aux_reset_in => VCC_1,
      bus_struct_reset(0) => proc_sys_reset_0_bus_struct_reset(0),
      dcm_locked => clk_wiz_0_locked,
      ext_reset_in => processing_system7_0_FCLK_RESET0_N,
      interconnect_aresetn(0) => rst_processing_system7_0_100M_interconnect_aresetn(0),
      mb_debug_sys_rst => mdm_0_Debug_SYS_Rst,
      mb_reset => rst_processing_system7_0_100M_mb_reset,
      peripheral_aresetn(0) => rst_processing_system7_0_100M_peripheral_aresetn(0),
      peripheral_reset(0) => NLW_proc_sys_reset_0_peripheral_reset_UNCONNECTED(0),
      slowest_sync_clk => sysclk
    );
processing_system7_0: component system_processing_system7_0_0
    port map (
      DDR_Addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_BankAddr(2 downto 0) => DDR_ba(2 downto 0),
      DDR_CAS_n => DDR_cas_n,
      DDR_CKE => DDR_cke,
      DDR_CS_n => DDR_cs_n,
      DDR_Clk => DDR_ck_p,
      DDR_Clk_n => DDR_ck_n,
      DDR_DM(3 downto 0) => DDR_dm(3 downto 0),
      DDR_DQ(31 downto 0) => DDR_dq(31 downto 0),
      DDR_DQS(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_DQS_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_DRSTB => DDR_reset_n,
      DDR_ODT => DDR_odt,
      DDR_RAS_n => DDR_ras_n,
      DDR_VRN => FIXED_IO_ddr_vrn,
      DDR_VRP => FIXED_IO_ddr_vrp,
      DDR_WEB => DDR_we_n,
      FCLK_CLK0 => processing_system7_0_FCLK_CLK0,
      FCLK_RESET0_N => processing_system7_0_FCLK_RESET0_N,
      MIO(53 downto 0) => FIXED_IO_mio(53 downto 0),
      PS_CLK => FIXED_IO_ps_clk,
      PS_PORB => FIXED_IO_ps_porb,
      PS_SRSTB => FIXED_IO_ps_srstb,
      S_AXI_GP0_ACLK => sysclk,
      S_AXI_GP0_ARADDR(31 downto 0) => axi4lite_0_M02_AXI_ARADDR(31 downto 0),
      S_AXI_GP0_ARBURST(1 downto 0) => axi4lite_0_M02_AXI_ARBURST(1 downto 0),
      S_AXI_GP0_ARCACHE(3 downto 0) => axi4lite_0_M02_AXI_ARCACHE(3 downto 0),
      S_AXI_GP0_ARID(5) => GND_1,
      S_AXI_GP0_ARID(4) => GND_1,
      S_AXI_GP0_ARID(3) => GND_1,
      S_AXI_GP0_ARID(2) => GND_1,
      S_AXI_GP0_ARID(1) => GND_1,
      S_AXI_GP0_ARID(0) => GND_1,
      S_AXI_GP0_ARLEN(3 downto 0) => axi4lite_0_M02_AXI_ARLEN(3 downto 0),
      S_AXI_GP0_ARLOCK(1 downto 0) => axi4lite_0_M02_AXI_ARLOCK(1 downto 0),
      S_AXI_GP0_ARPROT(2 downto 0) => axi4lite_0_M02_AXI_ARPROT(2 downto 0),
      S_AXI_GP0_ARQOS(3 downto 0) => axi4lite_0_M02_AXI_ARQOS(3 downto 0),
      S_AXI_GP0_ARREADY => axi4lite_0_M02_AXI_ARREADY,
      S_AXI_GP0_ARSIZE(2 downto 0) => axi4lite_0_M02_AXI_ARSIZE(2 downto 0),
      S_AXI_GP0_ARVALID => axi4lite_0_M02_AXI_ARVALID,
      S_AXI_GP0_AWADDR(31 downto 0) => axi4lite_0_M02_AXI_AWADDR(31 downto 0),
      S_AXI_GP0_AWBURST(1 downto 0) => axi4lite_0_M02_AXI_AWBURST(1 downto 0),
      S_AXI_GP0_AWCACHE(3 downto 0) => axi4lite_0_M02_AXI_AWCACHE(3 downto 0),
      S_AXI_GP0_AWID(5) => GND_1,
      S_AXI_GP0_AWID(4) => GND_1,
      S_AXI_GP0_AWID(3) => GND_1,
      S_AXI_GP0_AWID(2) => GND_1,
      S_AXI_GP0_AWID(1) => GND_1,
      S_AXI_GP0_AWID(0) => GND_1,
      S_AXI_GP0_AWLEN(3 downto 0) => axi4lite_0_M02_AXI_AWLEN(3 downto 0),
      S_AXI_GP0_AWLOCK(1 downto 0) => axi4lite_0_M02_AXI_AWLOCK(1 downto 0),
      S_AXI_GP0_AWPROT(2 downto 0) => axi4lite_0_M02_AXI_AWPROT(2 downto 0),
      S_AXI_GP0_AWQOS(3 downto 0) => axi4lite_0_M02_AXI_AWQOS(3 downto 0),
      S_AXI_GP0_AWREADY => axi4lite_0_M02_AXI_AWREADY,
      S_AXI_GP0_AWSIZE(2 downto 0) => axi4lite_0_M02_AXI_AWSIZE(2 downto 0),
      S_AXI_GP0_AWVALID => axi4lite_0_M02_AXI_AWVALID,
      S_AXI_GP0_BID(5 downto 0) => NLW_processing_system7_0_S_AXI_GP0_BID_UNCONNECTED(5 downto 0),
      S_AXI_GP0_BREADY => axi4lite_0_M02_AXI_BREADY,
      S_AXI_GP0_BRESP(1 downto 0) => axi4lite_0_M02_AXI_BRESP(1 downto 0),
      S_AXI_GP0_BVALID => axi4lite_0_M02_AXI_BVALID,
      S_AXI_GP0_RDATA(31 downto 0) => axi4lite_0_M02_AXI_RDATA(31 downto 0),
      S_AXI_GP0_RID(5 downto 0) => NLW_processing_system7_0_S_AXI_GP0_RID_UNCONNECTED(5 downto 0),
      S_AXI_GP0_RLAST => axi4lite_0_M02_AXI_RLAST,
      S_AXI_GP0_RREADY => axi4lite_0_M02_AXI_RREADY,
      S_AXI_GP0_RRESP(1 downto 0) => axi4lite_0_M02_AXI_RRESP(1 downto 0),
      S_AXI_GP0_RVALID => axi4lite_0_M02_AXI_RVALID,
      S_AXI_GP0_WDATA(31 downto 0) => axi4lite_0_M02_AXI_WDATA(31 downto 0),
      S_AXI_GP0_WID(5) => GND_1,
      S_AXI_GP0_WID(4) => GND_1,
      S_AXI_GP0_WID(3) => GND_1,
      S_AXI_GP0_WID(2) => GND_1,
      S_AXI_GP0_WID(1) => GND_1,
      S_AXI_GP0_WID(0) => GND_1,
      S_AXI_GP0_WLAST => axi4lite_0_M02_AXI_WLAST,
      S_AXI_GP0_WREADY => axi4lite_0_M02_AXI_WREADY,
      S_AXI_GP0_WSTRB(3 downto 0) => axi4lite_0_M02_AXI_WSTRB(3 downto 0),
      S_AXI_GP0_WVALID => axi4lite_0_M02_AXI_WVALID,
      S_AXI_HP0_ACLK => sysclk,
      S_AXI_HP0_ARADDR(31 downto 0) => axi_mem_intercon_M00_AXI_ARADDR(31 downto 0),
      S_AXI_HP0_ARBURST(1 downto 0) => axi_mem_intercon_M00_AXI_ARBURST(1 downto 0),
      S_AXI_HP0_ARCACHE(3 downto 0) => axi_mem_intercon_M00_AXI_ARCACHE(3 downto 0),
      S_AXI_HP0_ARID(5 downto 2) => NLW_processing_system7_0_S_AXI_HP0_ARID_UNCONNECTED(5 downto 2),
      S_AXI_HP0_ARID(1 downto 0) => axi_mem_intercon_M00_AXI_ARID(1 downto 0),
      S_AXI_HP0_ARLEN(3 downto 0) => axi_mem_intercon_M00_AXI_ARLEN(3 downto 0),
      S_AXI_HP0_ARLOCK(1 downto 0) => axi_mem_intercon_M00_AXI_ARLOCK(1 downto 0),
      S_AXI_HP0_ARPROT(2 downto 0) => axi_mem_intercon_M00_AXI_ARPROT(2 downto 0),
      S_AXI_HP0_ARQOS(3 downto 0) => axi_mem_intercon_M00_AXI_ARQOS(3 downto 0),
      S_AXI_HP0_ARREADY => axi_mem_intercon_M00_AXI_ARREADY,
      S_AXI_HP0_ARSIZE(2 downto 0) => axi_mem_intercon_M00_AXI_ARSIZE(2 downto 0),
      S_AXI_HP0_ARVALID => axi_mem_intercon_M00_AXI_ARVALID,
      S_AXI_HP0_AWADDR(31 downto 0) => axi_mem_intercon_M00_AXI_AWADDR(31 downto 0),
      S_AXI_HP0_AWBURST(1 downto 0) => axi_mem_intercon_M00_AXI_AWBURST(1 downto 0),
      S_AXI_HP0_AWCACHE(3 downto 0) => axi_mem_intercon_M00_AXI_AWCACHE(3 downto 0),
      S_AXI_HP0_AWID(5 downto 2) => NLW_processing_system7_0_S_AXI_HP0_AWID_UNCONNECTED(5 downto 2),
      S_AXI_HP0_AWID(1 downto 0) => axi_mem_intercon_M00_AXI_AWID(1 downto 0),
      S_AXI_HP0_AWLEN(3 downto 0) => axi_mem_intercon_M00_AXI_AWLEN(3 downto 0),
      S_AXI_HP0_AWLOCK(1 downto 0) => axi_mem_intercon_M00_AXI_AWLOCK(1 downto 0),
      S_AXI_HP0_AWPROT(2 downto 0) => axi_mem_intercon_M00_AXI_AWPROT(2 downto 0),
      S_AXI_HP0_AWQOS(3 downto 0) => axi_mem_intercon_M00_AXI_AWQOS(3 downto 0),
      S_AXI_HP0_AWREADY => axi_mem_intercon_M00_AXI_AWREADY,
      S_AXI_HP0_AWSIZE(2 downto 0) => axi_mem_intercon_M00_AXI_AWSIZE(2 downto 0),
      S_AXI_HP0_AWVALID => axi_mem_intercon_M00_AXI_AWVALID,
      S_AXI_HP0_BID(5 downto 0) => axi_mem_intercon_M00_AXI_BID(5 downto 0),
      S_AXI_HP0_BREADY => axi_mem_intercon_M00_AXI_BREADY,
      S_AXI_HP0_BRESP(1 downto 0) => axi_mem_intercon_M00_AXI_BRESP(1 downto 0),
      S_AXI_HP0_BVALID => axi_mem_intercon_M00_AXI_BVALID,
      S_AXI_HP0_RACOUNT(2 downto 0) => NLW_processing_system7_0_S_AXI_HP0_RACOUNT_UNCONNECTED(2 downto 0),
      S_AXI_HP0_RCOUNT(7 downto 0) => NLW_processing_system7_0_S_AXI_HP0_RCOUNT_UNCONNECTED(7 downto 0),
      S_AXI_HP0_RDATA(31 downto 0) => axi_mem_intercon_M00_AXI_RDATA(31 downto 0),
      S_AXI_HP0_RDISSUECAP1_EN => GND_1,
      S_AXI_HP0_RID(5 downto 0) => axi_mem_intercon_M00_AXI_RID(5 downto 0),
      S_AXI_HP0_RLAST => axi_mem_intercon_M00_AXI_RLAST,
      S_AXI_HP0_RREADY => axi_mem_intercon_M00_AXI_RREADY,
      S_AXI_HP0_RRESP(1 downto 0) => axi_mem_intercon_M00_AXI_RRESP(1 downto 0),
      S_AXI_HP0_RVALID => axi_mem_intercon_M00_AXI_RVALID,
      S_AXI_HP0_WACOUNT(5 downto 0) => NLW_processing_system7_0_S_AXI_HP0_WACOUNT_UNCONNECTED(5 downto 0),
      S_AXI_HP0_WCOUNT(7 downto 0) => NLW_processing_system7_0_S_AXI_HP0_WCOUNT_UNCONNECTED(7 downto 0),
      S_AXI_HP0_WDATA(31 downto 0) => axi_mem_intercon_M00_AXI_WDATA(31 downto 0),
      S_AXI_HP0_WID(5 downto 2) => NLW_processing_system7_0_S_AXI_HP0_WID_UNCONNECTED(5 downto 2),
      S_AXI_HP0_WID(1 downto 0) => axi_mem_intercon_M00_AXI_WID(1 downto 0),
      S_AXI_HP0_WLAST => axi_mem_intercon_M00_AXI_WLAST,
      S_AXI_HP0_WREADY => axi_mem_intercon_M00_AXI_WREADY,
      S_AXI_HP0_WRISSUECAP1_EN => GND_1,
      S_AXI_HP0_WSTRB(3 downto 0) => axi_mem_intercon_M00_AXI_WSTRB(3 downto 0),
      S_AXI_HP0_WVALID => axi_mem_intercon_M00_AXI_WVALID,
      S_AXI_HP2_ACLK => sysclk,
      S_AXI_HP2_ARADDR(31 downto 0) => axi_hp_2_M00_AXI_ARADDR(31 downto 0),
      S_AXI_HP2_ARBURST(1 downto 0) => axi_hp_2_M00_AXI_ARBURST(1 downto 0),
      S_AXI_HP2_ARCACHE(3 downto 0) => axi_hp_2_M00_AXI_ARCACHE(3 downto 0),
      S_AXI_HP2_ARID(5) => GND_1,
      S_AXI_HP2_ARID(4) => GND_1,
      S_AXI_HP2_ARID(3) => GND_1,
      S_AXI_HP2_ARID(2) => GND_1,
      S_AXI_HP2_ARID(1) => GND_1,
      S_AXI_HP2_ARID(0) => GND_1,
      S_AXI_HP2_ARLEN(3 downto 0) => axi_hp_2_M00_AXI_ARLEN(3 downto 0),
      S_AXI_HP2_ARLOCK(1) => GND_1,
      S_AXI_HP2_ARLOCK(0) => GND_1,
      S_AXI_HP2_ARPROT(2 downto 0) => axi_hp_2_M00_AXI_ARPROT(2 downto 0),
      S_AXI_HP2_ARQOS(3) => GND_1,
      S_AXI_HP2_ARQOS(2) => GND_1,
      S_AXI_HP2_ARQOS(1) => GND_1,
      S_AXI_HP2_ARQOS(0) => GND_1,
      S_AXI_HP2_ARREADY => axi_hp_2_M00_AXI_ARREADY,
      S_AXI_HP2_ARSIZE(2 downto 0) => axi_hp_2_M00_AXI_ARSIZE(2 downto 0),
      S_AXI_HP2_ARVALID => axi_hp_2_M00_AXI_ARVALID,
      S_AXI_HP2_AWADDR(31 downto 0) => axi_hp_2_M00_AXI_AWADDR(31 downto 0),
      S_AXI_HP2_AWBURST(1 downto 0) => axi_hp_2_M00_AXI_AWBURST(1 downto 0),
      S_AXI_HP2_AWCACHE(3 downto 0) => axi_hp_2_M00_AXI_AWCACHE(3 downto 0),
      S_AXI_HP2_AWID(5) => GND_1,
      S_AXI_HP2_AWID(4) => GND_1,
      S_AXI_HP2_AWID(3) => GND_1,
      S_AXI_HP2_AWID(2) => GND_1,
      S_AXI_HP2_AWID(1) => GND_1,
      S_AXI_HP2_AWID(0) => GND_1,
      S_AXI_HP2_AWLEN(3 downto 0) => axi_hp_2_M00_AXI_AWLEN(3 downto 0),
      S_AXI_HP2_AWLOCK(1) => GND_1,
      S_AXI_HP2_AWLOCK(0) => GND_1,
      S_AXI_HP2_AWPROT(2 downto 0) => axi_hp_2_M00_AXI_AWPROT(2 downto 0),
      S_AXI_HP2_AWQOS(3) => GND_1,
      S_AXI_HP2_AWQOS(2) => GND_1,
      S_AXI_HP2_AWQOS(1) => GND_1,
      S_AXI_HP2_AWQOS(0) => GND_1,
      S_AXI_HP2_AWREADY => axi_hp_2_M00_AXI_AWREADY,
      S_AXI_HP2_AWSIZE(2 downto 0) => axi_hp_2_M00_AXI_AWSIZE(2 downto 0),
      S_AXI_HP2_AWVALID => axi_hp_2_M00_AXI_AWVALID,
      S_AXI_HP2_BID(5 downto 0) => NLW_processing_system7_0_S_AXI_HP2_BID_UNCONNECTED(5 downto 0),
      S_AXI_HP2_BREADY => axi_hp_2_M00_AXI_BREADY,
      S_AXI_HP2_BRESP(1 downto 0) => axi_hp_2_M00_AXI_BRESP(1 downto 0),
      S_AXI_HP2_BVALID => axi_hp_2_M00_AXI_BVALID,
      S_AXI_HP2_RACOUNT(2 downto 0) => NLW_processing_system7_0_S_AXI_HP2_RACOUNT_UNCONNECTED(2 downto 0),
      S_AXI_HP2_RCOUNT(7 downto 0) => NLW_processing_system7_0_S_AXI_HP2_RCOUNT_UNCONNECTED(7 downto 0),
      S_AXI_HP2_RDATA(63 downto 0) => axi_hp_2_M00_AXI_RDATA(63 downto 0),
      S_AXI_HP2_RDISSUECAP1_EN => GND_1,
      S_AXI_HP2_RID(5 downto 0) => NLW_processing_system7_0_S_AXI_HP2_RID_UNCONNECTED(5 downto 0),
      S_AXI_HP2_RLAST => axi_hp_2_M00_AXI_RLAST,
      S_AXI_HP2_RREADY => axi_hp_2_M00_AXI_RREADY,
      S_AXI_HP2_RRESP(1 downto 0) => axi_hp_2_M00_AXI_RRESP(1 downto 0),
      S_AXI_HP2_RVALID => axi_hp_2_M00_AXI_RVALID,
      S_AXI_HP2_WACOUNT(5 downto 0) => NLW_processing_system7_0_S_AXI_HP2_WACOUNT_UNCONNECTED(5 downto 0),
      S_AXI_HP2_WCOUNT(7 downto 0) => NLW_processing_system7_0_S_AXI_HP2_WCOUNT_UNCONNECTED(7 downto 0),
      S_AXI_HP2_WDATA(63 downto 0) => axi_hp_2_M00_AXI_WDATA(63 downto 0),
      S_AXI_HP2_WID(5) => GND_1,
      S_AXI_HP2_WID(4) => GND_1,
      S_AXI_HP2_WID(3) => GND_1,
      S_AXI_HP2_WID(2) => GND_1,
      S_AXI_HP2_WID(1) => GND_1,
      S_AXI_HP2_WID(0) => GND_1,
      S_AXI_HP2_WLAST => axi_hp_2_M00_AXI_WLAST,
      S_AXI_HP2_WREADY => axi_hp_2_M00_AXI_WREADY,
      S_AXI_HP2_WRISSUECAP1_EN => GND_1,
      S_AXI_HP2_WSTRB(7 downto 0) => axi_hp_2_M00_AXI_WSTRB(7 downto 0),
      S_AXI_HP2_WVALID => axi_hp_2_M00_AXI_WVALID,
      TTC0_WAVE0_OUT => NLW_processing_system7_0_TTC0_WAVE0_OUT_UNCONNECTED,
      TTC0_WAVE1_OUT => NLW_processing_system7_0_TTC0_WAVE1_OUT_UNCONNECTED,
      TTC0_WAVE2_OUT => NLW_processing_system7_0_TTC0_WAVE2_OUT_UNCONNECTED,
      USB0_PORT_INDCTL(1 downto 0) => NLW_processing_system7_0_USB0_PORT_INDCTL_UNCONNECTED(1 downto 0),
      USB0_VBUS_PWRFAULT => GND_1,
      USB0_VBUS_PWRSELECT => NLW_processing_system7_0_USB0_VBUS_PWRSELECT_UNCONNECTED
    );
vectorblox_mxp_0: component system_vectorblox_mxp_0_0
    port map (
      aresetn => rst_processing_system7_0_100M_peripheral_aresetn(0),
      core_clk => sysclk,
      core_clk_2x => clk_wiz_0_clk_out2,
      m_axi_araddr(31 downto 0) => vectorblox_mxp_0_M_AXI_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => vectorblox_mxp_0_M_AXI_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => vectorblox_mxp_0_M_AXI_ARCACHE(3 downto 0),
      m_axi_arlen(3 downto 0) => vectorblox_mxp_0_M_AXI_ARLEN(3 downto 0),
      m_axi_arprot(2 downto 0) => vectorblox_mxp_0_M_AXI_ARPROT(2 downto 0),
      m_axi_arready => vectorblox_mxp_0_M_AXI_ARREADY,
      m_axi_arsize(2 downto 0) => vectorblox_mxp_0_M_AXI_ARSIZE(2 downto 0),
      m_axi_arvalid => vectorblox_mxp_0_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => vectorblox_mxp_0_M_AXI_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => vectorblox_mxp_0_M_AXI_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => vectorblox_mxp_0_M_AXI_AWCACHE(3 downto 0),
      m_axi_awlen(3 downto 0) => vectorblox_mxp_0_M_AXI_AWLEN(3 downto 0),
      m_axi_awprot(2 downto 0) => vectorblox_mxp_0_M_AXI_AWPROT(2 downto 0),
      m_axi_awready => vectorblox_mxp_0_M_AXI_AWREADY,
      m_axi_awsize(2 downto 0) => vectorblox_mxp_0_M_AXI_AWSIZE(2 downto 0),
      m_axi_awvalid => vectorblox_mxp_0_M_AXI_AWVALID,
      m_axi_bready => vectorblox_mxp_0_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => vectorblox_mxp_0_M_AXI_BRESP(1 downto 0),
      m_axi_bvalid => vectorblox_mxp_0_M_AXI_BVALID,
      m_axi_rdata(63 downto 0) => vectorblox_mxp_0_M_AXI_RDATA(63 downto 0),
      m_axi_rlast => vectorblox_mxp_0_M_AXI_RLAST,
      m_axi_rready => vectorblox_mxp_0_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => vectorblox_mxp_0_M_AXI_RRESP(1 downto 0),
      m_axi_rvalid => vectorblox_mxp_0_M_AXI_RVALID,
      m_axi_wdata(63 downto 0) => vectorblox_mxp_0_M_AXI_WDATA(63 downto 0),
      m_axi_wlast => vectorblox_mxp_0_M_AXI_WLAST,
      m_axi_wready => vectorblox_mxp_0_M_AXI_WREADY,
      m_axi_wstrb(7 downto 0) => vectorblox_mxp_0_M_AXI_WSTRB(7 downto 0),
      m_axi_wvalid => vectorblox_mxp_0_M_AXI_WVALID,
      m_axis_instr_tdata(31 downto 0) => vectorblox_mxp_0_M_AXIS_INSTR_TDATA(31 downto 0),
      m_axis_instr_tlast => vectorblox_mxp_0_M_AXIS_INSTR_TLAST,
      m_axis_instr_tready => vectorblox_mxp_0_M_AXIS_INSTR_TREADY,
      m_axis_instr_tvalid => vectorblox_mxp_0_M_AXIS_INSTR_TVALID,
      s_axi_araddr(31 downto 0) => axi4lite_0_M03_AXI_ARADDR(31 downto 0),
      s_axi_arready => axi4lite_0_M03_AXI_ARREADY,
      s_axi_arvalid => axi4lite_0_M03_AXI_ARVALID,
      s_axi_awaddr(31 downto 0) => axi4lite_0_M03_AXI_AWADDR(31 downto 0),
      s_axi_awready => axi4lite_0_M03_AXI_AWREADY,
      s_axi_awvalid => axi4lite_0_M03_AXI_AWVALID,
      s_axi_bready => axi4lite_0_M03_AXI_BREADY,
      s_axi_bresp(1 downto 0) => axi4lite_0_M03_AXI_BRESP(1 downto 0),
      s_axi_bvalid => axi4lite_0_M03_AXI_BVALID,
      s_axi_rdata(31 downto 0) => axi4lite_0_M03_AXI_RDATA(31 downto 0),
      s_axi_rready => axi4lite_0_M03_AXI_RREADY,
      s_axi_rresp(1 downto 0) => axi4lite_0_M03_AXI_RRESP(1 downto 0),
      s_axi_rvalid => axi4lite_0_M03_AXI_RVALID,
      s_axi_wdata(31 downto 0) => axi4lite_0_M03_AXI_WDATA(31 downto 0),
      s_axi_wready => axi4lite_0_M03_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => axi4lite_0_M03_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => axi4lite_0_M03_AXI_WVALID,
      s_axis_instr_tdata(31 downto 0) => microblaze_0_M0_AXIS_TDATA(31 downto 0),
      s_axis_instr_tlast => microblaze_0_M0_AXIS_TLAST,
      s_axis_instr_tready => microblaze_0_M0_AXIS_TREADY,
      s_axis_instr_tvalid => microblaze_0_M0_AXIS_TVALID
    );
end STRUCTURE;
