-- sqrt_alt.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_sqrt_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

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
  component altsqrt
    generic (
      pipeline     : natural;
      q_port_width : natural;
      r_port_width : natural;
      width        : natural;
      lpm_type     : string
      );
    port (
      clk       : in  std_logic;
      ena       : in  std_logic;
      q         : out std_logic_vector (q_port_width-1 downto 0);
      radical   : in  std_logic_vector (width-1 downto 0);
      remainder : out std_logic_vector (r_port_width-1 downto 0)
      );
  end component;
begin

  the_sqrtr : altsqrt
    generic map (
      pipeline     => PIPELINE_STAGES,
      q_port_width => OUTPUT_WIDTH,
      r_port_width => OUTPUT_WIDTH+1,
      width        => INPUT_WIDTH,
      lpm_type     => "ALTSQRT"
      )
    port map (
      clk       => clk,
      ena       => ena,
      radical   => radical,
      q         => q,
      remainder => open
      );

end rtl;
