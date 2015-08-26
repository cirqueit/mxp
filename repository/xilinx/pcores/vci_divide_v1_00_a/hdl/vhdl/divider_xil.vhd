-- divider_xil.vhd
-- Copyright (C) 2013-2015 VectorBlox Computing, Inc.

-- synthesis library vci_divide_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

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
  -- coregen divider generated with
  -- CSET aclken=false
  -- CSET algorithm_type=Radix2
  -- CSET aresetn=false
  -- CSET clocks_per_division=1
  -- CSET component_name=div_gen_v4_0
  -- CSET divide_by_zero_detect=false
  -- CSET dividend_and_quotient_width=49
  -- CSET dividend_has_tlast=false
  -- CSET dividend_has_tuser=false
  -- CSET dividend_tuser_width=1
  -- CSET divisor_has_tlast=false
  -- CSET divisor_has_tuser=false
  -- CSET divisor_tuser_width=1
  -- CSET divisor_width=33
  -- CSET flowcontrol=NonBlocking
  -- CSET fractional_width=33
  -- CSET latency=53
  -- CSET latency_configuration=Automatic
  -- CSET operand_sign=Signed
  -- CSET optimizegoal=Performance
  -- CSET outtlastbehv=Null
  -- CSET outtready=false
  -- CSET remainder_type=Remainder

  constant COREGEN_NUMER_WIDTH : integer := 49;
  constant COREGEN_DENOM_WIDTH : integer := 33;

  -- tdata widths are multiples of 8-bits
  constant NUMER_TDATA_WIDTH : integer := 56;
  constant DENOM_TDATA_WIDTH : integer := 40;
  -- for remainder mode:
  constant DOUT_TDATA_WIDTH  : integer := NUMER_TDATA_WIDTH+DENOM_TDATA_WIDTH;

  COMPONENT div_gen_v4_0
    PORT (
      aclk : IN STD_LOGIC;
      s_axis_divisor_tvalid : IN STD_LOGIC;
      s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(DENOM_TDATA_WIDTH-1 DOWNTO 0);
      s_axis_dividend_tvalid : IN STD_LOGIC;
      s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(NUMER_TDATA_WIDTH-1 DOWNTO 0);
      m_axis_dout_tvalid : OUT STD_LOGIC;
      m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(DOUT_TDATA_WIDTH-1 DOWNTO 0)
    );
  END COMPONENT;

  signal denom_padded : std_logic_vector(DENOM_TDATA_WIDTH-1 downto 0);
  signal numer_padded : std_logic_vector(NUMER_TDATA_WIDTH-1 downto 0);
  signal dout : std_logic_vector(DOUT_TDATA_WIDTH-1 downto 0);
begin

  pad_denom_gen: if DENOM_TDATA_WIDTH > DENOM_WIDTH generate
    denom_padded(DENOM_TDATA_WIDTH-1 downto DENOM_WIDTH) <= (others => '0');
  end generate pad_denom_gen;

  denom_padded(DENOM_WIDTH-1 downto 0) <= denom;

  pad_numer_gen: if NUMER_TDATA_WIDTH > NUMER_WIDTH generate
    numer_padded(NUMER_TDATA_WIDTH-1 downto NUMER_WIDTH) <= (others => '0');
  end generate pad_numer_gen;

  numer_padded(NUMER_WIDTH-1 downto 0) <= numer;

  the_divider : div_gen_v4_0
    port map (
      aclk                   => clock,
      s_axis_divisor_tvalid  => clken,
      s_axis_divisor_tdata   => denom_padded,
      s_axis_dividend_tvalid => clken,
      s_axis_dividend_tdata  => numer_padded,
      m_axis_dout_tvalid     => open,
      m_axis_dout_tdata      => dout
      );

  -- output contains padded quotient in upper bits
  -- (DOUT_TDATA_WIDTH-1 downto DENOM_TDATA_WIDTH)
  -- and padded remainder in lower bits (DENOM_TDATA_WIDTH-1 downto 0).
  quotient <= dout(DENOM_TDATA_WIDTH + NUMER_WIDTH -1 downto DENOM_TDATA_WIDTH);

  assert DENOM_WIDTH = COREGEN_DENOM_WIDTH
    report "DENOM_WIDTH must be " & integer'image(COREGEN_DENOM_WIDTH) &
    " (got "  & integer'image(DENOM_WIDTH) & ")"
    severity failure;

  assert NUMER_WIDTH = COREGEN_NUMER_WIDTH
    report "NUMER_WIDTH must be " & integer'image(COREGEN_NUMER_WIDTH) &
    " (got "  & integer'image(NUMER_WIDTH) & ")"
    severity failure;

end rtl;
