-- synthesis library vci_atan_lib
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library cordic_v6_0;
use cordic_v6_0.cordic_v6_0;

entity cordic_atan_xil is
  generic (
    VCI_DELAY : natural := 18;
    PRECISION : natural := 0
    );
  port (
    clk          : in  std_logic;
    clk_en       : in  std_logic;
    real_in      : in  std_logic_vector(15 downto 0);
    imaginary_in : in  std_logic_vector(15 downto 0);
    phase_out    : out std_logic_vector(15 downto 0)
    );
end cordic_atan_xil;

architecture cordic_atan_xil_arch of cordic_atan_xil is
  attribute DowngradeIPIdentifiedWarnings                         : string;
  attribute DowngradeIPIdentifiedWarnings of cordic_atan_xil_arch : architecture is "yes";

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
      s_axis_phase_tdata      : in  std_logic_vector(15 downto 0);
      s_axis_cartesian_tvalid : in  std_logic;
      s_axis_cartesian_tready : out std_logic;
      s_axis_cartesian_tuser  : in  std_logic_vector(0 downto 0);
      s_axis_cartesian_tlast  : in  std_logic;
      s_axis_cartesian_tdata  : in  std_logic_vector(31 downto 0);
      m_axis_dout_tvalid      : out std_logic;
      m_axis_dout_tready      : in  std_logic;
      m_axis_dout_tuser       : out std_logic_vector(0 downto 0);
      m_axis_dout_tlast       : out std_logic;
      m_axis_dout_tdata       : out std_logic_vector(15 downto 0)
      );
  end component cordic_v6_0;
  attribute X_CORE_INFO                                  : string;
  attribute X_CORE_INFO of cordic_atan_xil_arch          : architecture is "cordic_v6_0,Vivado 2014.2";
  attribute CHECK_LICENSE_TYPE                           : string;
  attribute CHECK_LICENSE_TYPE of cordic_atan_xil_arch   : architecture is "cordic_atan_xil,cordic_v6_0,{}";
  attribute CORE_GENERATION_INFO                         : string;
  attribute CORE_GENERATION_INFO of cordic_atan_xil_arch : architecture is "cordic_atan_xil,cordic_v6_0,{x_ipProduct=Vivado 2014.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=cordic,x_ipVersion=6.0,x_ipCoreRevision=4,x_ipLanguage=VERILOG,C_ARCHITECTURE=2,C_CORDIC_FUNCTION=3,C_COARSE_ROTATE=1,C_DATA_FORMAT=0,C_XDEVICEFAMILY=zynq,C_HAS_ACLKEN=1,C_HAS_ACLK=1,C_HAS_S_AXIS_CARTESIAN=1,C_HAS_S_AXIS_PHASE=0,C_HAS_ARESETN=0,C_INPUT_WIDTH=16,C_ITERATIONS=0,C_OUTPUT_WIDTH=16,C_PHASE_FORMAT=0,C_PIPELINE_MODE=-2,C_PRECISION=0,C_ROUND_MODE=0,C_SCALE_COMP=0,C_THROTTLE_SCHEME=3,C_TLAST_RESOLUTION=0,C_HAS_S_AXIS_PHASE_TUSER=0,C_HAS_S_AXIS_PHASE_TLAST=0,C_S_AXIS_PHASE_TDATA_WIDTH=16,C_S_AXIS_PHASE_TUSER_WIDTH=1,C_HAS_S_AXIS_CARTESIAN_TUSER=0,C_HAS_S_AXIS_CARTESIAN_TLAST=0,C_S_AXIS_CARTESIAN_TDATA_WIDTH=32,C_S_AXIS_CARTESIAN_TUSER_WIDTH=1,C_M_AXIS_DOUT_TDATA_WIDTH=16,C_M_AXIS_DOUT_TUSER_WIDTH=1}";
  attribute X_INTERFACE_INFO                             : string;
  attribute X_INTERFACE_INFO of clk                      : signal is "xilinx.com:signal:clock:1.0 aclk_intf CLK";
  attribute X_INTERFACE_INFO of clk_en                   : signal is "xilinx.com:signal:clockenable:1.0 aclken_intf CE";
--  attribute X_INTERFACE_INFO of s_axis_cartesian_tvalid  : signal is "xilinx.com:interface:axis:1.0 S_AXIS_CARTESIAN TVALID";
  signal s_axis_cartesian_tdata                          : std_logic_vector(31 downto 0);
  attribute X_INTERFACE_INFO of s_axis_cartesian_tdata   : signal is "xilinx.com:interface:axis:1.0 S_AXIS_CARTESIAN TDATA";
--  attribute X_INTERFACE_INFO of m_axis_dout_tvalid       : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DOUT TVALID";
  attribute X_INTERFACE_INFO of phase_out                : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DOUT TDATA";
begin
  s_axis_cartesian_tdata <= imaginary_in & real_in;
  U0 : cordic_v6_0
    generic map (
      C_ARCHITECTURE                 => 2,
      C_CORDIC_FUNCTION              => 3,
      C_COARSE_ROTATE                => 1,
      C_DATA_FORMAT                  => 0,
      C_XDEVICEFAMILY                => "zynq",
      C_HAS_ACLKEN                   => 1,
      C_HAS_ACLK                     => 1,
      C_HAS_S_AXIS_CARTESIAN         => 1,
      C_HAS_S_AXIS_PHASE             => 0,
      C_HAS_ARESETN                  => 0,
      C_INPUT_WIDTH                  => 16,
      C_ITERATIONS                   => 0,
      C_OUTPUT_WIDTH                 => 16,
      C_PHASE_FORMAT                 => 0,
      C_PIPELINE_MODE                => -2,
      C_PRECISION                    => PRECISION,
      C_ROUND_MODE                   => 0,
      C_SCALE_COMP                   => 0,
      C_THROTTLE_SCHEME              => 3,
      C_TLAST_RESOLUTION             => 0,
      C_HAS_S_AXIS_PHASE_TUSER       => 0,
      C_HAS_S_AXIS_PHASE_TLAST       => 0,
      C_S_AXIS_PHASE_TDATA_WIDTH     => 16,
      C_S_AXIS_PHASE_TUSER_WIDTH     => 1,
      C_HAS_S_AXIS_CARTESIAN_TUSER   => 0,
      C_HAS_S_AXIS_CARTESIAN_TLAST   => 0,
      C_S_AXIS_CARTESIAN_TDATA_WIDTH => 32,
      C_S_AXIS_CARTESIAN_TUSER_WIDTH => 1,
      C_M_AXIS_DOUT_TDATA_WIDTH      => 16,
      C_M_AXIS_DOUT_TUSER_WIDTH      => 1
      )
    port map (
      aclk                    => clk,
      aclken                  => clk_en,
      aresetn                 => '1',
      s_axis_phase_tvalid     => '0',
      s_axis_phase_tuser      => std_logic_vector(to_unsigned(0, 1)),
      s_axis_phase_tlast      => '0',
      s_axis_phase_tdata      => std_logic_vector(to_unsigned(0, 16)),
      s_axis_cartesian_tvalid => '1',
      s_axis_cartesian_tuser  => std_logic_vector(to_unsigned(0, 1)),
      s_axis_cartesian_tlast  => '0',
      s_axis_cartesian_tdata  => s_axis_cartesian_tdata,
      m_axis_dout_tvalid      => open,
      m_axis_dout_tready      => '0',
      m_axis_dout_tdata       => phase_out
      );

  -- Make sure pipeline depth matches CORDIC delay
  assert VCI_DELAY = 20
    report "VCI_DELAY ("
    & natural'image(VCI_DELAY) &
    "of VCI wrapper not equal to delay of CORDIC core."
    severity error;
end cordic_atan_xil_arch;
