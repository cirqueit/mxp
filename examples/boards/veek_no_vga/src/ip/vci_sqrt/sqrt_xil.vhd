-- sqrt_xil.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_sqrt_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sqrt is
  generic (
    PIPELINE_STAGES : natural  := 8;
    OUTPUT_WIDTH    : positive := 24;
    INPUT_WIDTH     : positive := 48
    );
  port (
    clk       : in  std_logic;
    ena       : in  std_logic;
    q         : out std_logic_vector (OUTPUT_WIDTH-1 downto 0);
    radical   : in  std_logic_vector (INPUT_WIDTH-1 downto 0)
    );
end;

architecture rtl of sqrt is

  constant COREGEN_OUTPUT_WIDTH : integer := 25;
  constant COREGEN_INPUT_WIDTH  : integer := 48;

  -- tdata widths are multiples of 8-bits
  constant OUTPUT_TDATA_WIDTH : integer := 32;
  constant INPUT_TDATA_WIDTH  : integer := 48;

  -- Generated from component: xilinx.com:ip:cordic:5.0
  -- CSET aclken=false
  -- CSET architectural_configuration=Parallel
  -- CSET aresetn=false
  -- CSET cartesian_has_tlast=false
  -- CSET cartesian_has_tuser=false
  -- CSET cartesian_tuser_width=1
  -- CSET coarse_rotation=false
  -- CSET compensation_scaling=No_Scale_Compensation
  -- CSET component_name=cordic_v5_0
  -- CSET data_format=UnsignedInteger
  -- CSET flow_control=NonBlocking
  -- CSET functional_selection=Square_Root
  -- CSET input_width=48
  -- CSET iterations=0
  -- CSET optimize_goal=Performance
  -- CSET out_tlast_behv=Null
  -- CSET out_tready=false
  -- CSET output_width=25
  -- CSET phase_format=Radians
  -- CSET phase_has_tlast=false
  -- CSET phase_has_tuser=false
  -- CSET phase_tuser_width=1
  -- CSET pipelining_mode=Maximum
  -- CSET precision=0
  -- CSET round_mode=Truncate

  COMPONENT cordic_v5_0
    PORT (
      aclk : IN STD_LOGIC;
      s_axis_cartesian_tvalid : IN STD_LOGIC;
      s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(INPUT_TDATA_WIDTH-1 DOWNTO 0);
      m_axis_dout_tvalid : OUT STD_LOGIC;
      m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(OUTPUT_TDATA_WIDTH-1 DOWNTO 0)
    );
  END COMPONENT;

  signal input_padded : std_logic_vector(INPUT_TDATA_WIDTH-1 downto 0);
  signal dout : std_logic_vector(OUTPUT_TDATA_WIDTH-1 downto 0);
begin

  pad_input_gen: if INPUT_TDATA_WIDTH > INPUT_WIDTH generate
    input_padded(INPUT_TDATA_WIDTH-1 downto INPUT_WIDTH) <= (others => '0');
  end generate pad_input_gen;

  input_padded(INPUT_WIDTH-1 downto 0) <= radical;

  the_sqrtr : cordic_v5_0
    port map (
      aclk                    => clk,
      s_axis_cartesian_tvalid => ena,
      s_axis_cartesian_tdata  => input_padded,
      m_axis_dout_tvalid      => open,
      m_axis_dout_tdata       => dout
      );

  q <= dout(OUTPUT_WIDTH-1 downto 0);

  assert PIPELINE_STAGES = COREGEN_OUTPUT_WIDTH
    report "PIPELINE_STAGES (" & integer'image(PIPELINE_STAGES) & ") must be "  &
    integer'image(COREGEN_OUTPUT_WIDTH)
    severity failure;

  assert INPUT_TDATA_WIDTH >= INPUT_WIDTH
    report "INPUT_WIDTH ("  & integer'image(INPUT_WIDTH) & ") must be <= " &
    integer'image(INPUT_TDATA_WIDTH)
    severity failure;

  assert OUTPUT_TDATA_WIDTH >= OUTPUT_WIDTH
    report "OUTPUT_WIDTH ("  & integer'image(OUTPUT_WIDTH) & ") must be <= " &
    integer'image(OUTPUT_TDATA_WIDTH)
    severity failure;

  assert INPUT_TDATA_WIDTH >= COREGEN_INPUT_WIDTH
    report "COREGEN_INPUT_WIDTH (" & integer'image(COREGEN_INPUT_WIDTH) &
    ") must be <= " & integer'image(INPUT_TDATA_WIDTH)
    severity failure;

  assert OUTPUT_TDATA_WIDTH >= COREGEN_OUTPUT_WIDTH
    report "COREGEN_OUTPUT_WIDTH (" & integer'image(COREGEN_OUTPUT_WIDTH) &
    ") must be <= " & integer'image(OUTPUT_TDATA_WIDTH)
    severity failure;

  assert COREGEN_INPUT_WIDTH >= INPUT_WIDTH
    report "INPUT_WIDTH (" & integer'image(INPUT_WIDTH) & ") must be <= " &
    integer'image(COREGEN_INPUT_WIDTH)
    severity failure;

  assert COREGEN_OUTPUT_WIDTH = OUTPUT_WIDTH+1
    report "OUTPUT_WIDTH (" & integer'image(OUTPUT_WIDTH) & ") must be " &
    integer'image(COREGEN_OUTPUT_WIDTH-1)
    severity failure;

end rtl;
