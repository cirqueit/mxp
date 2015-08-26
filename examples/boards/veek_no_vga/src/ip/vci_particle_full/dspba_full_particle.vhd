-- dspba_full_particle.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.component_pkg.all;
use work.util_pkg.all;

entity dspba_full_particle is
  generic (
    VCI_LANES : positive := 2
    );
  port (
    clk   : in std_logic;
    start : in std_logic;
    reset : in std_logic;

    ref_px : in signed(31 downto 0);
    px     : in signed32_array(VCI_LANES-1 downto 0);
    ref_py : in signed(31 downto 0);
    py     : in signed32_array(VCI_LANES-1 downto 0);
    ref_gm : in signed(31 downto 0);
    m      : in signed32_array(VCI_LANES-1 downto 0);

    result_x : out signed32_array(VCI_LANES-1 downto 0);
    result_y : out signed32_array(VCI_LANES-1 downto 0)
    );
end;

architecture rtl of dspba_full_particle is
  signal start_slv     : std_logic_vector(0 downto 0);
  signal dfx_accum     : signed32_array(VCI_LANES-1 downto 0);
  signal dfx_accum_slv : slv32_array(VCI_LANES-1 downto 0);
  signal dfy_accum     : signed32_array(VCI_LANES-1 downto 0);
  signal dfy_accum_slv : slv32_array(VCI_LANES-1 downto 0);
begin
  start_slv(0) <= start;

  lane_gen : for glane in VCI_LANES-1 downto 0 generate
    dspba_pipeline : Galaxy_dut
      port map (
        c        => (others => '0'),
        cout     => open,
        m        => std_logic_vector(m(glane)),
        px       => std_logic_vector(px(glane)),
        py       => std_logic_vector(py(glane)),
        ref_gm   => std_logic_vector(ref_gm),
        ref_px   => std_logic_vector(ref_px),
        ref_py   => std_logic_vector(ref_py),
        result_x => dfx_accum_slv(glane),
        result_y => dfy_accum_slv(glane),
        start    => start_slv,
        v        => "1",
        vout     => open,
        clk      => clk,
        areset   => reset
        );
    dfx_accum(glane) <= signed(dfx_accum_slv(glane));
    dfy_accum(glane) <= signed(dfy_accum_slv(glane));
  end generate lane_gen;

  --FIXME: Accumulating first is wasteful, but it works for now
  reduction_sum_x : adder_tree
    generic map (
      LEAVES => VCI_LANES
      )
    port map (
      data_in  => dfx_accum,
      data_out => result_x(0)
      );

  reduction_sum_y : adder_tree
    generic map (
      LEAVES => VCI_LANES
      )
    port map (
      data_in  => dfy_accum,
      data_out => result_y(0)
      );

  --Only produce sum for one lane
  multilane_gen : if VCI_LANES > 1 generate
    result_x(VCI_LANES-1 downto 1) <= (others => (others => '0'));
    result_y(VCI_LANES-1 downto 1) <= (others => (others => '0'));
  end generate multilane_gen;

end rtl;
