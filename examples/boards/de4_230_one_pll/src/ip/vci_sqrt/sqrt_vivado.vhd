-- sqrt_vivado.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_sqrt_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library cordic_v6_0;
use cordic_v6_0.cordic_v6_0;

entity sqrt is
  generic (
    PIPELINE_STAGES : natural  := 8;
    OUTPUT_WIDTH    : positive := 24;
    INPUT_WIDTH     : positive := 48
    );
  port (
    clk     : in  std_logic;
    ena     : in  std_logic;
    q       : out std_logic_vector(OUTPUT_WIDTH-1 downto 0);
    radical : in  std_logic_vector(INPUT_WIDTH-1 downto 0)
    );
end;

architecture rtl of sqrt is
  constant INPUT_WIDTH_BYTES  : positive := (INPUT_WIDTH+7)/8;
  constant DOUT_WIDTH         : positive := (INPUT_WIDTH/2)+1;
  constant DOUT_WIDTH_BYTES   : positive := (DOUT_WIDTH+7)/8;
  constant INPUT_WIDTH_PADDED : positive := INPUT_WIDTH_BYTES*8;
  constant DOUT_WIDTH_PADDED  : positive := DOUT_WIDTH_BYTES*8;

  component cordic_v6_0 is
    generic (
      C_ARCHITECTURE                 : integer;
      C_CORDIC_FUNCTION              : integer;
      C_COARSE_ROTATE                : integer;
      C_DATA_FORMAT                  : integer;
      C_XDEVICEFAMILY                : string;
      C_HAS_ACLKEN                   : integer;
      C_HAS_ACLK                     : integer;
      C_HAS_S_AXIS_CARTESIAN         : integer;
      C_HAS_S_AXIS_PHASE             : integer;
      C_HAS_ARESETN                  : integer;
      C_INPUT_WIDTH                  : integer;
      C_ITERATIONS                   : integer;
      C_OUTPUT_WIDTH                 : integer;
      C_PHASE_FORMAT                 : integer;
      C_PIPELINE_MODE                : integer;
      C_PRECISION                    : integer;
      C_ROUND_MODE                   : integer;
      C_SCALE_COMP                   : integer;
      C_THROTTLE_SCHEME              : integer;
      C_TLAST_RESOLUTION             : integer;
      C_HAS_S_AXIS_PHASE_TUSER       : integer;
      C_HAS_S_AXIS_PHASE_TLAST       : integer;
      C_S_AXIS_PHASE_TDATA_WIDTH     : integer;
      C_S_AXIS_PHASE_TUSER_WIDTH     : integer;
      C_HAS_S_AXIS_CARTESIAN_TUSER   : integer;
      C_HAS_S_AXIS_CARTESIAN_TLAST   : integer;
      C_S_AXIS_CARTESIAN_TDATA_WIDTH : integer;
      C_S_AXIS_CARTESIAN_TUSER_WIDTH : integer;
      C_M_AXIS_DOUT_TDATA_WIDTH      : integer;
      C_M_AXIS_DOUT_TUSER_WIDTH      : integer
      );
    port (
      aclk                    : in  std_logic;
      aclken                  : in  std_logic;
      aresetn                 : in  std_logic;
      s_axis_phase_tvalid     : in  std_logic;
      s_axis_phase_tready     : out std_logic;
      s_axis_phase_tuser      : in  std_logic_vector(0 downto 0);
      s_axis_phase_tlast      : in  std_logic;
      s_axis_phase_tdata      : in  std_logic_vector(INPUT_WIDTH_PADDED-1 downto 0);
      s_axis_cartesian_tvalid : in  std_logic;
      s_axis_cartesian_tready : out std_logic;
      s_axis_cartesian_tuser  : in  std_logic_vector(0 downto 0);
      s_axis_cartesian_tlast  : in  std_logic;
      s_axis_cartesian_tdata  : in  std_logic_vector(INPUT_WIDTH_PADDED-1 downto 0);
      m_axis_dout_tvalid      : out std_logic;
      m_axis_dout_tready      : in  std_logic;
      m_axis_dout_tuser       : out std_logic_vector(0 downto 0);
      m_axis_dout_tlast       : out std_logic;
      m_axis_dout_tdata       : out std_logic_vector(DOUT_WIDTH_PADDED-1 downto 0)
      );
  end component cordic_v6_0;

  signal input_padded : std_logic_vector(INPUT_WIDTH_PADDED-1 downto 0);
  signal dout         : std_logic_vector(DOUT_WIDTH_PADDED-1 downto 0);
begin

  pad_input_gen : if INPUT_WIDTH_PADDED > INPUT_WIDTH generate
    input_padded(INPUT_WIDTH_PADDED-1 downto INPUT_WIDTH) <= (others => '0');
  end generate pad_input_gen;

  input_padded(INPUT_WIDTH-1 downto 0) <= radical;

  the_sqrtr : cordic_v6_0
    generic map (
      C_ARCHITECTURE                 => 2,
      C_CORDIC_FUNCTION              => 6,
      C_COARSE_ROTATE                => 0,
      C_DATA_FORMAT                  => 2,
      C_XDEVICEFAMILY                => "zynq",
      C_HAS_ACLKEN                   => 1,
      C_HAS_ACLK                     => 1,
      C_HAS_S_AXIS_CARTESIAN         => 1,
      C_HAS_S_AXIS_PHASE             => 0,
      C_HAS_ARESETN                  => 0,
      C_INPUT_WIDTH                  => INPUT_WIDTH,
      C_ITERATIONS                   => 0,
      C_OUTPUT_WIDTH                 => DOUT_WIDTH,
      C_PHASE_FORMAT                 => 0,
      C_PIPELINE_MODE                => -2,
      C_PRECISION                    => 0,
      C_ROUND_MODE                   => 0,
      C_SCALE_COMP                   => 0,
      C_THROTTLE_SCHEME              => 3,
      C_TLAST_RESOLUTION             => 0,
      C_HAS_S_AXIS_PHASE_TUSER       => 0,
      C_HAS_S_AXIS_PHASE_TLAST       => 0,
      C_S_AXIS_PHASE_TDATA_WIDTH     => INPUT_WIDTH_PADDED,
      C_S_AXIS_PHASE_TUSER_WIDTH     => 1,
      C_HAS_S_AXIS_CARTESIAN_TUSER   => 0,
      C_HAS_S_AXIS_CARTESIAN_TLAST   => 0,
      C_S_AXIS_CARTESIAN_TDATA_WIDTH => INPUT_WIDTH_PADDED,
      C_S_AXIS_CARTESIAN_TUSER_WIDTH => 1,
      C_M_AXIS_DOUT_TDATA_WIDTH      => DOUT_WIDTH_PADDED,
      C_M_AXIS_DOUT_TUSER_WIDTH      => 1
      )
    port map (
      aclk                    => clk,
      aclken                  => ena,
      aresetn                 => '1',
      s_axis_phase_tvalid     => '0',
      s_axis_phase_tuser      => std_logic_vector(TO_UNSIGNED(0, 1)),
      s_axis_phase_tlast      => '0',
      s_axis_phase_tdata      => std_logic_vector(TO_UNSIGNED(0, 48)),
      s_axis_cartesian_tvalid => '1',
      s_axis_cartesian_tuser  => std_logic_vector(TO_UNSIGNED(0, 1)),
      s_axis_cartesian_tlast  => '0',
      s_axis_cartesian_tdata  => input_padded,
      m_axis_dout_tvalid      => open,
      m_axis_dout_tready      => '0',
      m_axis_dout_tdata       => dout
      );

  q <= dout(OUTPUT_WIDTH-1 downto 0);

end rtl;
