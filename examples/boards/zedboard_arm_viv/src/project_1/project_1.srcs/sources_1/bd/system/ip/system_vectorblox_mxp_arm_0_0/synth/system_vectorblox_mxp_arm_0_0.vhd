-- (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: vectorblox.com:ip:vectorblox_mxp:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY vectorblox_mxp_v1_00_a;
USE vectorblox_mxp_v1_00_a.vectorblox_mxp;

ENTITY system_vectorblox_mxp_arm_0_0 IS
  PORT (
    core_clk : IN STD_LOGIC;
    core_clk_2x : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    m_axi_arready : IN STD_LOGIC;
    m_axi_arvalid : OUT STD_LOGIC;
    m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_arlen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_rready : OUT STD_LOGIC;
    m_axi_rvalid : IN STD_LOGIC;
    m_axi_rdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rlast : IN STD_LOGIC;
    m_axi_awready : IN STD_LOGIC;
    m_axi_awvalid : OUT STD_LOGIC;
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_awlen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_wready : IN STD_LOGIC;
    m_axi_wvalid : OUT STD_LOGIC;
    m_axi_wdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axi_wlast : OUT STD_LOGIC;
    m_axi_bready : OUT STD_LOGIC;
    m_axi_bvalid : IN STD_LOGIC;
    m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_instr_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_instr_awvalid : IN STD_LOGIC;
    s_axi_instr_awready : OUT STD_LOGIC;
    s_axi_instr_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_instr_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axi_instr_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_instr_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_instr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_instr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_instr_wvalid : IN STD_LOGIC;
    s_axi_instr_wlast : IN STD_LOGIC;
    s_axi_instr_wready : OUT STD_LOGIC;
    s_axi_instr_bready : IN STD_LOGIC;
    s_axi_instr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_instr_bvalid : OUT STD_LOGIC;
    s_axi_instr_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_instr_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_instr_arvalid : IN STD_LOGIC;
    s_axi_instr_arready : OUT STD_LOGIC;
    s_axi_instr_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_instr_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axi_instr_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_instr_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_instr_rready : IN STD_LOGIC;
    s_axi_instr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_instr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_instr_rvalid : OUT STD_LOGIC;
    s_axi_instr_rlast : OUT STD_LOGIC;
    s_axi_instr_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC
  );
END system_vectorblox_mxp_arm_0_0;

ARCHITECTURE system_vectorblox_mxp_arm_0_0_arch OF system_vectorblox_mxp_arm_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF system_vectorblox_mxp_arm_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT vectorblox_mxp IS
    GENERIC (
      VECTOR_LANES : INTEGER;
      SCRATCHPAD_KB : INTEGER;
      BURSTLENGTH_BYTES : INTEGER;
      MAX_MASKED_WAVES : INTEGER;
      MASK_PARTITIONS : INTEGER;
      MIN_MULTIPLIER_HW : INTEGER;
      MULFXP_WORD_FRACTION_BITS : INTEGER;
      MULFXP_HALF_FRACTION_BITS : INTEGER;
      MULFXP_BYTE_FRACTION_BITS : INTEGER;
      VECTOR_CUSTOM_INSTRUCTIONS : INTEGER;
      VCI_0_LANES : INTEGER;
      VCI_0_OPCODE_START : INTEGER;
      VCI_0_FUNCTIONS : INTEGER;
      VCI_0_MODIFIES_DEST_ADDR : INTEGER;
      VCI_1_LANES : INTEGER;
      VCI_1_OPCODE_START : INTEGER;
      VCI_1_FUNCTIONS : INTEGER;
      VCI_1_MODIFIES_DEST_ADDR : INTEGER;
      VCI_2_LANES : INTEGER;
      VCI_2_OPCODE_START : INTEGER;
      VCI_2_FUNCTIONS : INTEGER;
      VCI_2_MODIFIES_DEST_ADDR : INTEGER;
      VCI_3_LANES : INTEGER;
      VCI_3_OPCODE_START : INTEGER;
      VCI_3_FUNCTIONS : INTEGER;
      VCI_3_MODIFIES_DEST_ADDR : INTEGER;
      VCI_4_LANES : INTEGER;
      VCI_4_OPCODE_START : INTEGER;
      VCI_4_FUNCTIONS : INTEGER;
      VCI_4_MODIFIES_DEST_ADDR : INTEGER;
      VCI_5_LANES : INTEGER;
      VCI_5_OPCODE_START : INTEGER;
      VCI_5_FUNCTIONS : INTEGER;
      VCI_5_MODIFIES_DEST_ADDR : INTEGER;
      VCI_6_LANES : INTEGER;
      VCI_6_OPCODE_START : INTEGER;
      VCI_6_FUNCTIONS : INTEGER;
      VCI_6_MODIFIES_DEST_ADDR : INTEGER;
      VCI_7_LANES : INTEGER;
      VCI_7_OPCODE_START : INTEGER;
      VCI_7_FUNCTIONS : INTEGER;
      VCI_7_MODIFIES_DEST_ADDR : INTEGER;
      VCI_8_LANES : INTEGER;
      VCI_8_OPCODE_START : INTEGER;
      VCI_8_FUNCTIONS : INTEGER;
      VCI_8_MODIFIES_DEST_ADDR : INTEGER;
      VCI_9_LANES : INTEGER;
      VCI_9_OPCODE_START : INTEGER;
      VCI_9_FUNCTIONS : INTEGER;
      VCI_9_MODIFIES_DEST_ADDR : INTEGER;
      VCI_10_LANES : INTEGER;
      VCI_10_OPCODE_START : INTEGER;
      VCI_10_FUNCTIONS : INTEGER;
      VCI_10_MODIFIES_DEST_ADDR : INTEGER;
      VCI_11_LANES : INTEGER;
      VCI_11_OPCODE_START : INTEGER;
      VCI_11_FUNCTIONS : INTEGER;
      VCI_11_MODIFIES_DEST_ADDR : INTEGER;
      VCI_12_LANES : INTEGER;
      VCI_12_OPCODE_START : INTEGER;
      VCI_12_FUNCTIONS : INTEGER;
      VCI_12_MODIFIES_DEST_ADDR : INTEGER;
      VCI_13_LANES : INTEGER;
      VCI_13_OPCODE_START : INTEGER;
      VCI_13_FUNCTIONS : INTEGER;
      VCI_13_MODIFIES_DEST_ADDR : INTEGER;
      VCI_14_LANES : INTEGER;
      VCI_14_OPCODE_START : INTEGER;
      VCI_14_FUNCTIONS : INTEGER;
      VCI_14_MODIFIES_DEST_ADDR : INTEGER;
      VCI_15_LANES : INTEGER;
      VCI_15_OPCODE_START : INTEGER;
      VCI_15_FUNCTIONS : INTEGER;
      VCI_15_MODIFIES_DEST_ADDR : INTEGER;
      VCUSTOM0_DEPTH : INTEGER;
      VCUSTOM1_DEPTH : INTEGER;
      VCUSTOM2_DEPTH : INTEGER;
      VCUSTOM3_DEPTH : INTEGER;
      VCUSTOM4_DEPTH : INTEGER;
      VCUSTOM5_DEPTH : INTEGER;
      VCUSTOM6_DEPTH : INTEGER;
      VCUSTOM7_DEPTH : INTEGER;
      VCUSTOM8_DEPTH : INTEGER;
      VCUSTOM9_DEPTH : INTEGER;
      VCUSTOM10_DEPTH : INTEGER;
      VCUSTOM11_DEPTH : INTEGER;
      VCUSTOM12_DEPTH : INTEGER;
      VCUSTOM13_DEPTH : INTEGER;
      VCUSTOM14_DEPTH : INTEGER;
      VCUSTOM15_DEPTH : INTEGER;
      C_S_AXI_ADDR_WIDTH : INTEGER;
      C_S_AXI_DATA_WIDTH : INTEGER;
      C_S_AXI_INSTR_ADDR_WIDTH : INTEGER;
      C_S_AXI_INSTR_DATA_WIDTH : INTEGER;
      C_S_AXI_INSTR_ID_WIDTH : INTEGER;
      C_M_AXI_ADDR_WIDTH : INTEGER;
      C_M_AXI_DATA_WIDTH : INTEGER;
      C_M_AXI_LEN_WIDTH : INTEGER;
      C_INSTR_PORT_TYPE : INTEGER
    );
    PORT (
      core_clk : IN STD_LOGIC;
      core_clk_2x : IN STD_LOGIC;
      aresetn : IN STD_LOGIC;
      m_axi_arready : IN STD_LOGIC;
      m_axi_arvalid : OUT STD_LOGIC;
      m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m_axi_arlen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      m_axi_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      m_axi_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      m_axi_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      m_axi_rready : OUT STD_LOGIC;
      m_axi_rvalid : IN STD_LOGIC;
      m_axi_rdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      m_axi_rlast : IN STD_LOGIC;
      m_axi_awready : IN STD_LOGIC;
      m_axi_awvalid : OUT STD_LOGIC;
      m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m_axi_awlen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      m_axi_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      m_axi_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      m_axi_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      m_axi_wready : IN STD_LOGIC;
      m_axi_wvalid : OUT STD_LOGIC;
      m_axi_wdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_axi_wstrb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      m_axi_wlast : OUT STD_LOGIC;
      m_axi_bready : OUT STD_LOGIC;
      m_axi_bvalid : IN STD_LOGIC;
      m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_instr_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_instr_awvalid : IN STD_LOGIC;
      s_axi_instr_awready : OUT STD_LOGIC;
      s_axi_instr_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      s_axi_instr_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s_axi_instr_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s_axi_instr_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_instr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_instr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s_axi_instr_wvalid : IN STD_LOGIC;
      s_axi_instr_wlast : IN STD_LOGIC;
      s_axi_instr_wready : OUT STD_LOGIC;
      s_axi_instr_bready : IN STD_LOGIC;
      s_axi_instr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_instr_bvalid : OUT STD_LOGIC;
      s_axi_instr_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      s_axi_instr_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_instr_arvalid : IN STD_LOGIC;
      s_axi_instr_arready : OUT STD_LOGIC;
      s_axi_instr_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      s_axi_instr_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      s_axi_instr_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s_axi_instr_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_instr_rready : IN STD_LOGIC;
      s_axi_instr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_instr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_instr_rvalid : OUT STD_LOGIC;
      s_axi_instr_rlast : OUT STD_LOGIC;
      s_axi_instr_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      s_axi_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_awvalid : IN STD_LOGIC;
      s_axi_awready : OUT STD_LOGIC;
      s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s_axi_wvalid : IN STD_LOGIC;
      s_axi_wready : OUT STD_LOGIC;
      s_axi_bready : IN STD_LOGIC;
      s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_bvalid : OUT STD_LOGIC;
      s_axi_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_arvalid : IN STD_LOGIC;
      s_axi_arready : OUT STD_LOGIC;
      s_axi_rready : IN STD_LOGIC;
      s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_rvalid : OUT STD_LOGIC;
      m_axis_instr_tlast : OUT STD_LOGIC;
      m_axis_instr_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      m_axis_instr_tvalid : OUT STD_LOGIC;
      m_axis_instr_tready : IN STD_LOGIC;
      s_axis_instr_tlast : IN STD_LOGIC;
      s_axis_instr_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axis_instr_tvalid : IN STD_LOGIC;
      s_axis_instr_tready : OUT STD_LOGIC;
      vci_0_clk : OUT STD_LOGIC;
      vci_0_reset : OUT STD_LOGIC;
      vci_0_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_0_signed : OUT STD_LOGIC;
      vci_0_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_0_vector_start : OUT STD_LOGIC;
      vci_0_vector_end : OUT STD_LOGIC;
      vci_0_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_0_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_0_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_0_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_0_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_0_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_0_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_0_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_0_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_0_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_1_clk : OUT STD_LOGIC;
      vci_1_reset : OUT STD_LOGIC;
      vci_1_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_1_signed : OUT STD_LOGIC;
      vci_1_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_1_vector_start : OUT STD_LOGIC;
      vci_1_vector_end : OUT STD_LOGIC;
      vci_1_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_1_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_1_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_1_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_1_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_1_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_1_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_1_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_1_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_1_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_2_clk : OUT STD_LOGIC;
      vci_2_reset : OUT STD_LOGIC;
      vci_2_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_2_signed : OUT STD_LOGIC;
      vci_2_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_2_vector_start : OUT STD_LOGIC;
      vci_2_vector_end : OUT STD_LOGIC;
      vci_2_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_2_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_2_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_2_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_2_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_2_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_2_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_2_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_2_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_2_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_3_clk : OUT STD_LOGIC;
      vci_3_reset : OUT STD_LOGIC;
      vci_3_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_3_signed : OUT STD_LOGIC;
      vci_3_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_3_vector_start : OUT STD_LOGIC;
      vci_3_vector_end : OUT STD_LOGIC;
      vci_3_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_3_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_3_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_3_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_3_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_3_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_3_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_3_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_3_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_3_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_4_clk : OUT STD_LOGIC;
      vci_4_reset : OUT STD_LOGIC;
      vci_4_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_4_signed : OUT STD_LOGIC;
      vci_4_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_4_vector_start : OUT STD_LOGIC;
      vci_4_vector_end : OUT STD_LOGIC;
      vci_4_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_4_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_4_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_4_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_4_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_4_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_4_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_4_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_4_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_4_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_5_clk : OUT STD_LOGIC;
      vci_5_reset : OUT STD_LOGIC;
      vci_5_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_5_signed : OUT STD_LOGIC;
      vci_5_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_5_vector_start : OUT STD_LOGIC;
      vci_5_vector_end : OUT STD_LOGIC;
      vci_5_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_5_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_5_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_5_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_5_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_5_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_5_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_5_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_5_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_5_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_6_clk : OUT STD_LOGIC;
      vci_6_reset : OUT STD_LOGIC;
      vci_6_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_6_signed : OUT STD_LOGIC;
      vci_6_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_6_vector_start : OUT STD_LOGIC;
      vci_6_vector_end : OUT STD_LOGIC;
      vci_6_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_6_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_6_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_6_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_6_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_6_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_6_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_6_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_6_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_6_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_7_clk : OUT STD_LOGIC;
      vci_7_reset : OUT STD_LOGIC;
      vci_7_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_7_signed : OUT STD_LOGIC;
      vci_7_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_7_vector_start : OUT STD_LOGIC;
      vci_7_vector_end : OUT STD_LOGIC;
      vci_7_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_7_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_7_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_7_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_7_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_7_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_7_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_7_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_7_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_7_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_8_clk : OUT STD_LOGIC;
      vci_8_reset : OUT STD_LOGIC;
      vci_8_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_8_signed : OUT STD_LOGIC;
      vci_8_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_8_vector_start : OUT STD_LOGIC;
      vci_8_vector_end : OUT STD_LOGIC;
      vci_8_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_8_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_8_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_8_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_8_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_8_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_8_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_8_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_8_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_8_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_9_clk : OUT STD_LOGIC;
      vci_9_reset : OUT STD_LOGIC;
      vci_9_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_9_signed : OUT STD_LOGIC;
      vci_9_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_9_vector_start : OUT STD_LOGIC;
      vci_9_vector_end : OUT STD_LOGIC;
      vci_9_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_9_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_9_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_9_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_9_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_9_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_9_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_9_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_9_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_9_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_10_clk : OUT STD_LOGIC;
      vci_10_reset : OUT STD_LOGIC;
      vci_10_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_10_signed : OUT STD_LOGIC;
      vci_10_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_10_vector_start : OUT STD_LOGIC;
      vci_10_vector_end : OUT STD_LOGIC;
      vci_10_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_10_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_10_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_10_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_10_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_10_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_10_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_10_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_10_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_10_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_11_clk : OUT STD_LOGIC;
      vci_11_reset : OUT STD_LOGIC;
      vci_11_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_11_signed : OUT STD_LOGIC;
      vci_11_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_11_vector_start : OUT STD_LOGIC;
      vci_11_vector_end : OUT STD_LOGIC;
      vci_11_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_11_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_11_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_11_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_11_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_11_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_11_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_11_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_11_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_11_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_12_clk : OUT STD_LOGIC;
      vci_12_reset : OUT STD_LOGIC;
      vci_12_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_12_signed : OUT STD_LOGIC;
      vci_12_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_12_vector_start : OUT STD_LOGIC;
      vci_12_vector_end : OUT STD_LOGIC;
      vci_12_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_12_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_12_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_12_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_12_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_12_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_12_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_12_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_12_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_12_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_13_clk : OUT STD_LOGIC;
      vci_13_reset : OUT STD_LOGIC;
      vci_13_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_13_signed : OUT STD_LOGIC;
      vci_13_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_13_vector_start : OUT STD_LOGIC;
      vci_13_vector_end : OUT STD_LOGIC;
      vci_13_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_13_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_13_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_13_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_13_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_13_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_13_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_13_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_13_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_13_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_14_clk : OUT STD_LOGIC;
      vci_14_reset : OUT STD_LOGIC;
      vci_14_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_14_signed : OUT STD_LOGIC;
      vci_14_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_14_vector_start : OUT STD_LOGIC;
      vci_14_vector_end : OUT STD_LOGIC;
      vci_14_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_14_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_14_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_14_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_14_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_14_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_14_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_14_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_14_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_14_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_15_clk : OUT STD_LOGIC;
      vci_15_reset : OUT STD_LOGIC;
      vci_15_valid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      vci_15_signed : OUT STD_LOGIC;
      vci_15_opsize : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      vci_15_vector_start : OUT STD_LOGIC;
      vci_15_vector_end : OUT STD_LOGIC;
      vci_15_byte_valid : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_15_data_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_15_flag_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_15_data_b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_15_flag_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_15_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_15_flag_out : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_15_byteenable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      vci_15_dest_addr_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      vci_15_dest_addr_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT vectorblox_mxp;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF system_vectorblox_mxp_arm_0_0_arch: ARCHITECTURE IS "vectorblox_mxp,Vivado 2014.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF system_vectorblox_mxp_arm_0_0_arch : ARCHITECTURE IS "system_vectorblox_mxp_arm_0_0,vectorblox_mxp,{ipvblox_mxp_1_0=BOUGHT}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF core_clk: SIGNAL IS "xilinx.com:signal:clock:1.0 aclk_intf CLK";
  ATTRIBUTE X_INTERFACE_INFO OF aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 aresetn_intf RST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARLEN";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARBURST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_arcache: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI ARCACHE";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_rlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI RLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWLEN";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWBURST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_awcache: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI AWCACHE";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_wlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI WLAST";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF m_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWLEN";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_awburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR AWBURST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_wlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR WLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_bid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR BID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_arid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_arlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARLEN";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_arsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_arburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR ARBURST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_rlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR RLAST";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_instr_rid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI_INSTR RID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S_AXI RVALID";
BEGIN
  U0 : vectorblox_mxp
    GENERIC MAP (
      VECTOR_LANES => 2,
      SCRATCHPAD_KB => 64,
      BURSTLENGTH_BYTES => 128,
      MAX_MASKED_WAVES => 256,
      MASK_PARTITIONS => 1,
      MIN_MULTIPLIER_HW => 0,
      MULFXP_WORD_FRACTION_BITS => 16,
      MULFXP_HALF_FRACTION_BITS => 15,
      MULFXP_BYTE_FRACTION_BITS => 4,
      VECTOR_CUSTOM_INSTRUCTIONS => 0,
      VCI_0_LANES => 1,
      VCI_0_OPCODE_START => 0,
      VCI_0_FUNCTIONS => 1,
      VCI_0_MODIFIES_DEST_ADDR => 0,
      VCI_1_LANES => 1,
      VCI_1_OPCODE_START => 1,
      VCI_1_FUNCTIONS => 1,
      VCI_1_MODIFIES_DEST_ADDR => 0,
      VCI_2_LANES => 1,
      VCI_2_OPCODE_START => 2,
      VCI_2_FUNCTIONS => 1,
      VCI_2_MODIFIES_DEST_ADDR => 0,
      VCI_3_LANES => 1,
      VCI_3_OPCODE_START => 3,
      VCI_3_FUNCTIONS => 1,
      VCI_3_MODIFIES_DEST_ADDR => 0,
      VCI_4_LANES => 1,
      VCI_4_OPCODE_START => 4,
      VCI_4_FUNCTIONS => 1,
      VCI_4_MODIFIES_DEST_ADDR => 0,
      VCI_5_LANES => 1,
      VCI_5_OPCODE_START => 5,
      VCI_5_FUNCTIONS => 1,
      VCI_5_MODIFIES_DEST_ADDR => 0,
      VCI_6_LANES => 1,
      VCI_6_OPCODE_START => 6,
      VCI_6_FUNCTIONS => 1,
      VCI_6_MODIFIES_DEST_ADDR => 0,
      VCI_7_LANES => 1,
      VCI_7_OPCODE_START => 7,
      VCI_7_FUNCTIONS => 1,
      VCI_7_MODIFIES_DEST_ADDR => 0,
      VCI_8_LANES => 1,
      VCI_8_OPCODE_START => 8,
      VCI_8_FUNCTIONS => 1,
      VCI_8_MODIFIES_DEST_ADDR => 0,
      VCI_9_LANES => 1,
      VCI_9_OPCODE_START => 9,
      VCI_9_FUNCTIONS => 1,
      VCI_9_MODIFIES_DEST_ADDR => 0,
      VCI_10_LANES => 1,
      VCI_10_OPCODE_START => 10,
      VCI_10_FUNCTIONS => 1,
      VCI_10_MODIFIES_DEST_ADDR => 0,
      VCI_11_LANES => 1,
      VCI_11_OPCODE_START => 11,
      VCI_11_FUNCTIONS => 1,
      VCI_11_MODIFIES_DEST_ADDR => 0,
      VCI_12_LANES => 1,
      VCI_12_OPCODE_START => 12,
      VCI_12_FUNCTIONS => 1,
      VCI_12_MODIFIES_DEST_ADDR => 0,
      VCI_13_LANES => 1,
      VCI_13_OPCODE_START => 13,
      VCI_13_FUNCTIONS => 1,
      VCI_13_MODIFIES_DEST_ADDR => 0,
      VCI_14_LANES => 1,
      VCI_14_OPCODE_START => 14,
      VCI_14_FUNCTIONS => 1,
      VCI_14_MODIFIES_DEST_ADDR => 0,
      VCI_15_LANES => 1,
      VCI_15_OPCODE_START => 15,
      VCI_15_FUNCTIONS => 1,
      VCI_15_MODIFIES_DEST_ADDR => 0,
      VCUSTOM0_DEPTH => 0,
      VCUSTOM1_DEPTH => 0,
      VCUSTOM2_DEPTH => 0,
      VCUSTOM3_DEPTH => 0,
      VCUSTOM4_DEPTH => 0,
      VCUSTOM5_DEPTH => 0,
      VCUSTOM6_DEPTH => 0,
      VCUSTOM7_DEPTH => 0,
      VCUSTOM8_DEPTH => 0,
      VCUSTOM9_DEPTH => 0,
      VCUSTOM10_DEPTH => 0,
      VCUSTOM11_DEPTH => 0,
      VCUSTOM12_DEPTH => 0,
      VCUSTOM13_DEPTH => 0,
      VCUSTOM14_DEPTH => 0,
      VCUSTOM15_DEPTH => 0,
      C_S_AXI_ADDR_WIDTH => 32,
      C_S_AXI_DATA_WIDTH => 32,
      C_S_AXI_INSTR_ADDR_WIDTH => 32,
      C_S_AXI_INSTR_DATA_WIDTH => 32,
      C_S_AXI_INSTR_ID_WIDTH => 6,
      C_M_AXI_ADDR_WIDTH => 32,
      C_M_AXI_DATA_WIDTH => 64,
      C_M_AXI_LEN_WIDTH => 4,
      C_INSTR_PORT_TYPE => 2
    )
    PORT MAP (
      core_clk => core_clk,
      core_clk_2x => core_clk_2x,
      aresetn => aresetn,
      m_axi_arready => m_axi_arready,
      m_axi_arvalid => m_axi_arvalid,
      m_axi_araddr => m_axi_araddr,
      m_axi_arlen => m_axi_arlen,
      m_axi_arsize => m_axi_arsize,
      m_axi_arburst => m_axi_arburst,
      m_axi_arprot => m_axi_arprot,
      m_axi_arcache => m_axi_arcache,
      m_axi_rready => m_axi_rready,
      m_axi_rvalid => m_axi_rvalid,
      m_axi_rdata => m_axi_rdata,
      m_axi_rresp => m_axi_rresp,
      m_axi_rlast => m_axi_rlast,
      m_axi_awready => m_axi_awready,
      m_axi_awvalid => m_axi_awvalid,
      m_axi_awaddr => m_axi_awaddr,
      m_axi_awlen => m_axi_awlen,
      m_axi_awsize => m_axi_awsize,
      m_axi_awburst => m_axi_awburst,
      m_axi_awprot => m_axi_awprot,
      m_axi_awcache => m_axi_awcache,
      m_axi_wready => m_axi_wready,
      m_axi_wvalid => m_axi_wvalid,
      m_axi_wdata => m_axi_wdata,
      m_axi_wstrb => m_axi_wstrb,
      m_axi_wlast => m_axi_wlast,
      m_axi_bready => m_axi_bready,
      m_axi_bvalid => m_axi_bvalid,
      m_axi_bresp => m_axi_bresp,
      s_axi_instr_awaddr => s_axi_instr_awaddr,
      s_axi_instr_awvalid => s_axi_instr_awvalid,
      s_axi_instr_awready => s_axi_instr_awready,
      s_axi_instr_awid => s_axi_instr_awid,
      s_axi_instr_awlen => s_axi_instr_awlen,
      s_axi_instr_awsize => s_axi_instr_awsize,
      s_axi_instr_awburst => s_axi_instr_awburst,
      s_axi_instr_wdata => s_axi_instr_wdata,
      s_axi_instr_wstrb => s_axi_instr_wstrb,
      s_axi_instr_wvalid => s_axi_instr_wvalid,
      s_axi_instr_wlast => s_axi_instr_wlast,
      s_axi_instr_wready => s_axi_instr_wready,
      s_axi_instr_bready => s_axi_instr_bready,
      s_axi_instr_bresp => s_axi_instr_bresp,
      s_axi_instr_bvalid => s_axi_instr_bvalid,
      s_axi_instr_bid => s_axi_instr_bid,
      s_axi_instr_araddr => s_axi_instr_araddr,
      s_axi_instr_arvalid => s_axi_instr_arvalid,
      s_axi_instr_arready => s_axi_instr_arready,
      s_axi_instr_arid => s_axi_instr_arid,
      s_axi_instr_arlen => s_axi_instr_arlen,
      s_axi_instr_arsize => s_axi_instr_arsize,
      s_axi_instr_arburst => s_axi_instr_arburst,
      s_axi_instr_rready => s_axi_instr_rready,
      s_axi_instr_rdata => s_axi_instr_rdata,
      s_axi_instr_rresp => s_axi_instr_rresp,
      s_axi_instr_rvalid => s_axi_instr_rvalid,
      s_axi_instr_rlast => s_axi_instr_rlast,
      s_axi_instr_rid => s_axi_instr_rid,
      s_axi_awaddr => s_axi_awaddr,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_awready => s_axi_awready,
      s_axi_wdata => s_axi_wdata,
      s_axi_wstrb => s_axi_wstrb,
      s_axi_wvalid => s_axi_wvalid,
      s_axi_wready => s_axi_wready,
      s_axi_bready => s_axi_bready,
      s_axi_bresp => s_axi_bresp,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_araddr => s_axi_araddr,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_arready => s_axi_arready,
      s_axi_rready => s_axi_rready,
      s_axi_rdata => s_axi_rdata,
      s_axi_rresp => s_axi_rresp,
      s_axi_rvalid => s_axi_rvalid,
      m_axis_instr_tready => '0',
      s_axis_instr_tlast => '0',
      s_axis_instr_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      s_axis_instr_tvalid => '0',
      vci_0_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_0_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_0_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_0_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_1_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_1_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_1_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_1_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_2_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_2_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_2_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_2_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_3_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_3_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_3_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_3_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_4_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_4_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_4_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_4_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_5_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_5_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_5_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_5_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_6_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_6_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_6_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_6_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_7_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_7_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_7_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_7_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_8_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_8_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_8_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_8_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_9_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_9_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_9_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_9_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_10_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_10_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_10_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_10_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_11_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_11_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_11_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_11_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_12_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_12_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_12_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_12_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_13_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_13_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_13_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_13_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_14_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_14_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_14_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_14_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_15_data_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      vci_15_flag_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_15_byteenable => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      vci_15_dest_addr_out => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32))
    );
END system_vectorblox_mxp_arm_0_0_arch;
