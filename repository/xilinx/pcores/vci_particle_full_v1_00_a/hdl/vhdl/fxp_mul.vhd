-- fxp_mul.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.util_pkg.all;

entity fxp_mul is
  generic (
    WIDTH    : positive := 32;
    DELAY    : natural  := 0;
    FXP_BITS : natural  := 16
    );
  port (
    a : in signed(WIDTH-1 downto 0);
    b : in signed(WIDTH-1 downto 0);

    clk    : in std_logic;
    clk_en : in std_logic;

    result : out signed(WIDTH-1 downto 0);
    oflow  : out std_logic
    );
end;

--Mimic the fixed point multiply of MXP for use in custom instructions

architecture rtl of fxp_mul is
  signal product     : signed((WIDTH*2)-1 downto 0);
  signal mul_full    : signed((WIDTH*2)-1 downto 0);
  signal unused_msbs : std_logic_vector(WIDTH-FXP_BITS-1 downto 0);

  type pipe_stage_type is array (DELAY-1 downto 0) of
    signed(2*WIDTH-1 downto 0);

begin

  --May need to check/correct overflow conditions depending on MXP
  product <= a * b;

  ----------------------------------------------------------------------
  delay_0: if DELAY = 0 generate
    mul_full <= product;
  end generate delay_0;

  ----------------------------------------------------------------------
  delay_1: if DELAY = 1 generate
    signal stage : pipe_stage_type;
  begin
    process (clk)
    begin
      if clk'event and clk = '1' then
        if clk_en = '1' then
          stage(0) <= product;
        end if;
      end if;
    end process;

    mul_full <= stage(0);
  end generate delay_1;

  ----------------------------------------------------------------------
  delay_gt_1: if DELAY > 1 generate
    signal stage : pipe_stage_type;
  begin
    process (clk)
    begin
      if clk'event and clk = '1' then
        if clk_en = '1' then
          stage <= stage(DELAY-2 downto 0) & product;
        end if;
      end if;
    end process;

    mul_full <= stage(DELAY-1);
  end generate delay_gt_1;

  ----------------------------------------------------------------------

  result      <= mul_full(FXP_BITS+WIDTH-1 downto FXP_BITS);
  unused_msbs <= std_logic_vector(mul_full((WIDTH*2)-2 downto FXP_BITS+WIDTH-1));
  oflow       <= '1' when unused_msbs /= replicate_bit(mul_full((WIDTH*2)-1), WIDTH-FXP_BITS)
                 else '0';

end rtl;
