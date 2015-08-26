-- fxp_div.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fxp_div is
  generic (
    WIDTH    : positive := 32;
    FXP_BITS : natural  := 16;
    OUTPUT_STAGE : natural range 0 to 1 := 1
    );
  port (
    clk    : in std_logic;
    clk_en : in std_logic;

    numerator   : in signed(WIDTH-1 downto 0);
    denominator : in signed(WIDTH-1 downto 0);

    quotient : out signed(WIDTH-1 downto 0)
    );
end;

--Mimic the fixed point divide of MXP for use in custom instructions

architecture rtl of fxp_div is
  component divider
    generic (
      DENOM_WIDTH : positive := 33;
      NUMER_WIDTH : positive := 33
      );
    port (
      clock    : in  std_logic;
      clken    : in  std_logic;
      denom    : in  std_logic_vector(DENOM_WIDTH-1 downto 0);
      numer    : in  std_logic_vector(NUMER_WIDTH-1 downto 0);
      quotient : out std_logic_vector(NUMER_WIDTH-1 downto 0)
      );
  end component;

  signal numerator_extended : signed(WIDTH+FXP_BITS-1 downto 0);
  signal quotient_extended  : std_logic_vector(WIDTH+FXP_BITS-1 downto 0);

  signal quotient_signed : signed(WIDTH-1 downto 0);

begin

  --Numerator data is shifted up by the number of fixed point bits
  numerator_extended(WIDTH+FXP_BITS-1 downto FXP_BITS) <= numerator;
  extend_gen : if FXP_BITS > 0 generate
    numerator_extended(FXP_BITS-1 downto 0) <= (others => '0');
  end generate extend_gen;

  the_divider : divider
    generic map (
      DENOM_WIDTH => WIDTH,
      NUMER_WIDTH => WIDTH+FXP_BITS
      )
    port map (
      clock    => clk,
      clken    => clk_en,
      denom    => std_logic_vector(denominator),
      numer    => std_logic_vector(numerator_extended),
      quotient => quotient_extended
      );

  quotient_signed <= signed(quotient_extended(WIDTH-1 downto 0));

  gen_output_stage: if OUTPUT_STAGE = 1 generate
    process (clk)
    begin
      if clk'event and clk = '1' then
        if clk_en = '1' then
          quotient <= quotient_signed;
        end if;
      end if;
    end process;
  end generate gen_output_stage;

  gen_no_output_stage: if OUTPUT_STAGE = 0 generate
    quotient <= quotient_signed;
  end generate gen_no_output_stage;

end rtl;
