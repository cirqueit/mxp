-- divider_vivado.vhd
-- Copyright (C) 2013-2015 VectorBlox Computing, Inc.

-- synthesis library vci_divide_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library div_gen_v5_1;
use div_gen_v5_1.div_gen_v5_1;

entity divider is
  generic (
    DENOM_WIDTH : positive := 33;
    NUMER_WIDTH : positive := 49
    );
  port (
    clock    : in  std_logic;
    clken    : in  std_logic;
    denom    : in  std_logic_vector(DENOM_WIDTH-1 downto 0);
    numer    : in  std_logic_vector(NUMER_WIDTH-1 downto 0);
    quotient : out std_logic_vector(NUMER_WIDTH-1 downto 0)
    );
end;

architecture rtl of divider is
  constant DENOM_WIDTH_BYTES  : positive := (DENOM_WIDTH+7)/8;
  constant NUMER_WIDTH_BYTES  : positive := (NUMER_WIDTH+7)/8;
  constant DENOM_WIDTH_PADDED : positive := DENOM_WIDTH_BYTES*8;
  constant NUMER_WIDTH_PADDED : positive := NUMER_WIDTH_BYTES*8;
  constant DOUT_WIDTH         : positive := NUMER_WIDTH_PADDED+DENOM_WIDTH_PADDED;

  component div_gen_v5_1 is
    generic (
      C_XDEVICEFAMILY               : string;
      C_HAS_ARESETN                 : integer;
      C_HAS_ACLKEN                  : integer;
      C_LATENCY                     : integer;
      ALGORITHM_TYPE                : integer;
      DIVISOR_WIDTH                 : integer;
      DIVIDEND_WIDTH                : integer;
      SIGNED_B                      : integer;
      DIVCLK_SEL                    : integer;
      FRACTIONAL_B                  : integer;
      FRACTIONAL_WIDTH              : integer;
      C_HAS_DIV_BY_ZERO             : integer;
      C_THROTTLE_SCHEME             : integer;
      C_TLAST_RESOLUTION            : integer;
      C_HAS_S_AXIS_DIVISOR_TUSER    : integer;
      C_HAS_S_AXIS_DIVISOR_TLAST    : integer;
      C_S_AXIS_DIVISOR_TDATA_WIDTH  : integer;
      C_S_AXIS_DIVISOR_TUSER_WIDTH  : integer;
      C_HAS_S_AXIS_DIVIDEND_TUSER   : integer;
      C_HAS_S_AXIS_DIVIDEND_TLAST   : integer;
      C_S_AXIS_DIVIDEND_TDATA_WIDTH : integer;
      C_S_AXIS_DIVIDEND_TUSER_WIDTH : integer;
      C_M_AXIS_DOUT_TDATA_WIDTH     : integer;
      C_M_AXIS_DOUT_TUSER_WIDTH     : integer
      );
    port (
      aclk                   : in  std_logic;
      aclken                 : in  std_logic;
      aresetn                : in  std_logic;
      s_axis_divisor_tvalid  : in  std_logic;
      s_axis_divisor_tready  : out std_logic;
      s_axis_divisor_tuser   : in  std_logic_vector(0 downto 0);
      s_axis_divisor_tlast   : in  std_logic;
      s_axis_divisor_tdata   : in  std_logic_vector(DENOM_WIDTH_PADDED-1 downto 0);
      s_axis_dividend_tvalid : in  std_logic;
      s_axis_dividend_tready : out std_logic;
      s_axis_dividend_tuser  : in  std_logic_vector(0 downto 0);
      s_axis_dividend_tlast  : in  std_logic;
      s_axis_dividend_tdata  : in  std_logic_vector(NUMER_WIDTH_PADDED-1 downto 0);
      m_axis_dout_tvalid     : out std_logic;
      m_axis_dout_tready     : in  std_logic;
      m_axis_dout_tuser      : out std_logic_vector(0 downto 0);
      m_axis_dout_tlast      : out std_logic;
      m_axis_dout_tdata      : out std_logic_vector(DOUT_WIDTH-1 downto 0)
      );
  end component div_gen_v5_1;

  signal denom_padded : std_logic_vector(DENOM_WIDTH_PADDED-1 downto 0);
  signal numer_padded : std_logic_vector(NUMER_WIDTH_PADDED-1 downto 0);
  signal dout         : std_logic_vector(DOUT_WIDTH-1 downto 0);
begin

  pad_denom_gen : if DENOM_WIDTH_PADDED > DENOM_WIDTH generate
    denom_padded(DENOM_WIDTH_PADDED-1 downto DENOM_WIDTH) <= (others => '0');
  end generate pad_denom_gen;

  denom_padded(DENOM_WIDTH-1 downto 0) <= denom;

  pad_numer_gen : if NUMER_WIDTH_PADDED > NUMER_WIDTH generate
    numer_padded(NUMER_WIDTH_PADDED-1 downto NUMER_WIDTH) <= (others => '0');
  end generate pad_numer_gen;

  numer_padded(NUMER_WIDTH-1 downto 0) <= numer;

  the_divider : div_gen_v5_1
    generic map (
      C_XDEVICEFAMILY               => "zynq",
      C_HAS_ARESETN                 => 0,
      C_HAS_ACLKEN                  => 1,
      C_LATENCY                     => NUMER_WIDTH+4,
      ALGORITHM_TYPE                => 1,
      DIVISOR_WIDTH                 => DENOM_WIDTH,
      DIVIDEND_WIDTH                => NUMER_WIDTH,
      SIGNED_B                      => 1,
      DIVCLK_SEL                    => 1,
      FRACTIONAL_B                  => 0,
      FRACTIONAL_WIDTH              => DENOM_WIDTH,
      C_HAS_DIV_BY_ZERO             => 0,
      C_THROTTLE_SCHEME             => 3,
      C_TLAST_RESOLUTION            => 0,
      C_HAS_S_AXIS_DIVISOR_TUSER    => 0,
      C_HAS_S_AXIS_DIVISOR_TLAST    => 0,
      C_S_AXIS_DIVISOR_TDATA_WIDTH  => DENOM_WIDTH_PADDED,
      C_S_AXIS_DIVISOR_TUSER_WIDTH  => 1,
      C_HAS_S_AXIS_DIVIDEND_TUSER   => 0,
      C_HAS_S_AXIS_DIVIDEND_TLAST   => 0,
      C_S_AXIS_DIVIDEND_TDATA_WIDTH => NUMER_WIDTH_PADDED,
      C_S_AXIS_DIVIDEND_TUSER_WIDTH => 1,
      C_M_AXIS_DOUT_TDATA_WIDTH     => DOUT_WIDTH,
      C_M_AXIS_DOUT_TUSER_WIDTH     => 1
      )
    port map (
      aclk                   => clock,
      aclken                 => clken,
      aresetn                => '1',
      s_axis_divisor_tvalid  => '1',
      s_axis_divisor_tuser   => std_logic_vector(TO_UNSIGNED(0, 1)),
      s_axis_divisor_tlast   => '0',
      s_axis_divisor_tdata   => denom_padded,
      s_axis_dividend_tvalid => '1',
      s_axis_dividend_tuser  => std_logic_vector(TO_UNSIGNED(0, 1)),
      s_axis_dividend_tlast  => '0',
      s_axis_dividend_tdata  => numer_padded,
      m_axis_dout_tvalid     => open,
      m_axis_dout_tready     => '0',
      m_axis_dout_tdata      => dout
      );

  -- output contains padded quotient in upper bits
  -- (DOUT_WIDTH-1 downto DENOM_WIDTH_PADDED)
  -- and padded remainder in lower bits (DENOM_WIDTH_PADDED-1 downto 0).
  quotient <= dout(DENOM_WIDTH_PADDED+NUMER_WIDTH-1 downto DENOM_WIDTH_PADDED);
  
end rtl;
