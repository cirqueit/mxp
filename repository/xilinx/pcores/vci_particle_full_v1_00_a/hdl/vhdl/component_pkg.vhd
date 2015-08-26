-- component_pkg.vhd
-- Copyright (C) 2013-2015 VectorBlox Computing, Inc.

-- Component declarations

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.util_pkg.all;

package component_pkg is

  component fwft_fifo_reg
    generic (
      WIDTH             : integer := 32;
      DEPTH             : integer := 16;
      ALMOST_FULL_VALUE : integer := 4;
      EXTERNAL_REGISTER : boolean := false
      );
    port
      (
        clk   : in std_logic;
        reset : in std_logic;

        rdreq     : in std_logic;
        wrreq     : in std_logic;
        writedata : in std_logic_vector(WIDTH-1 downto 0);

        almost_full  : out std_logic;
        usedw        : out std_logic_vector(log2(DEPTH)-1 downto 0);
        head_invalid : out std_logic;
        empty        : out std_logic;
        full         : out std_logic;
        readdata     : out std_logic_vector(WIDTH-1 downto 0)
        );
  end component;

  component adder_tree
    generic (
      LEAVES : integer := 8
      );
    port(
      data_in  : in  signed32_array((LEAVES)-1 downto 0);
      data_out : out signed(31 downto 0)
      );
  end component;

  component fxp_mul
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
  end component;

  component fxp_div
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
  end component;

  component distance_calc
    generic (
      FXP_BITS   : natural := 16;
      DIST_DELAY : natural := 1;
      DX_SQUARED_STAGES : natural := 1;
      OUTPUT_STAGE : natural range 0 to 1 := 1
      );
    port (
      clk    : in std_logic;
      clk_en : in std_logic;

      dx : in signed(31 downto 0);
      dy : in signed(31 downto 0);

      distance       : out signed(31 downto 0);
      distance_oflow : out std_logic
      );
  end component;

  component full_particle
    generic (
      VCI_LANES       : positive := 2;
      FXP_BITS        : natural  := 16;
      OCT_DIST_APPROX : natural  := 0;
      INPUT_STAGE     : natural range 0 to 1 := 1;
      DIST_DELAY      : natural  := 1;
      DIV_DELAY       : natural  := 1;
      SQRT_DIST_OUTPUT_STAGE : natural range 0 to 1 := 1;
      DIV_OUTPUT_STAGE       : natural range 0 to 1 := 1;
      DX_SQUARED_STAGES : natural := 1;
      GMM_MUL_STAGES    : natural := 1;
      GMM_D_MUL_STAGES  : natural := 2;
      GMM_D2_MUL_STAGES : natural := 1;
      GMM_D3_MUL_STAGES : natural := 1;
      DFX_MUL_STAGES    : natural := 1;
      EXTRA_STAGE       : natural range 0 to 1 := 0;
      ACCUM_STAGE       : natural range 0 to 1 := 1
      );
    port (
      clk    : in std_logic;
      clk_en : in std_logic;
      start  : in std_logic;
      reset  : in std_logic;

      ref_px : in signed(31 downto 0);
      px     : in signed32_array(VCI_LANES-1 downto 0);
      ref_py : in signed(31 downto 0);
      py     : in signed32_array(VCI_LANES-1 downto 0);
      ref_gm : in signed(31 downto 0);
      m      : in signed32_array(VCI_LANES-1 downto 0);

      result_x : out signed32_array(VCI_LANES-1 downto 0);
      result_y : out signed32_array(VCI_LANES-1 downto 0)
      );
  end component;

  component Galaxy_dut
    port (
      c        : in  std_logic_vector(7 downto 0);
      cout     : out std_logic_vector(7 downto 0);
      m        : in  std_logic_vector(31 downto 0);
      px       : in  std_logic_vector(31 downto 0);
      py       : in  std_logic_vector(31 downto 0);
      ref_gm   : in  std_logic_vector(31 downto 0);
      ref_px   : in  std_logic_vector(31 downto 0);
      ref_py   : in  std_logic_vector(31 downto 0);
      result_x : out std_logic_vector(31 downto 0);
      result_y : out std_logic_vector(31 downto 0);
      start    : in  std_logic_vector(0 downto 0);
      v        : in  std_logic_vector(0 downto 0);
      vout     : out std_logic_vector(0 downto 0);
      clk      : in  std_logic;
      areset   : in  std_logic
      );
  end component;

  component dspba_full_particle
    generic (
      VCI_LANES       : positive := 2
      );
    port (
      clk    : in std_logic;
      start  : in std_logic;
      reset  : in std_logic;

      ref_px : in signed(31 downto 0);
      px     : in signed32_array(VCI_LANES-1 downto 0);
      ref_py : in signed(31 downto 0);
      py     : in signed32_array(VCI_LANES-1 downto 0);
      ref_gm : in signed(31 downto 0);
      m      : in signed32_array(VCI_LANES-1 downto 0);

      result_x : out signed32_array(VCI_LANES-1 downto 0);
      result_y : out signed32_array(VCI_LANES-1 downto 0)
      );
  end component;

end package;

package body component_pkg is
end component_pkg;
