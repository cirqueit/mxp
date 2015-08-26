-- distance_calc.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.component_pkg.all;
use work.util_pkg.all;

entity distance_calc is
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
end;

--ORIGINAL C CODE this replaces
--//get absolute distances of particles from px,py
--vbx(SVW, VABSDIFF, v_abs_dx, 0, v_dx);
--vbx(SVW, VABSDIFF, v_abs_dy, 0, v_dy);

--//use octagonal approx to get distance
--vbx_fix16_sub( v_t_sub, v_abs_dy, v_abs_dx);

--//Put max in v_y, min in v_x
--vbx( VVW, VCMV_GTZ, v_y, v_abs_dy, v_t_sub);
--vbx( VVW, VCMV_GTZ, v_x, v_abs_dx, v_t_sub);
--vbx( VVW, VCMV_LEZ, v_y, v_abs_dx, v_t_sub);
--vbx( VVW, VCMV_LEZ, v_x, v_abs_dy, v_t_sub);

--vbx_fix16_mul_s( v_y, F16(0.941246), v_y);
--vbx_fix16_mul_s( v_x, F16(0.41), v_x);
--vbx_fix16_add( v_dist, v_y, v_x);
--END ORIGINAL C CODE this replaces

architecture oct_approx of distance_calc is
  --FIXME: Only work for 16-bit format currently
  constant MAX_MUL_AMT : signed(31 downto 0) := x"0000F0F5";  --F16(0.941246)
  constant MIN_MUL_AMT : signed(31 downto 0) := x"000068F6";  --F16(0.41)

  --Keep everything in signed format to match C code
  signal abs_dx           : signed(31 downto 0);
  signal abs_dy           : signed(31 downto 0);
  signal abs_dx_gt_abs_dy : std_logic;
  signal abs_max          : signed(31 downto 0);
  signal abs_min          : signed(31 downto 0);
  signal abs_max_mul      : signed(31 downto 0);
  signal abs_min_mul      : signed(31 downto 0);
  signal abs_max_mul_d1   : signed(31 downto 0);
  signal abs_min_mul_d1   : signed(31 downto 0);

  signal oct_dist         : signed(31 downto 0);
begin

  --Line for line recreate the DAG of the C code

  --ABS based on MSB
  abs_dx <= dx when dx(dx'left) = '0' else to_signed(0, dx'length) - dx;
  abs_dy <= dy when dy(dy'left) = '0' else to_signed(0, dy'length) - dy;

  --Comparison factored out so it can be used for both min & max
  abs_dx_gt_abs_dy <= '1' when abs_dx > abs_dy else '0';

  abs_max <= abs_dx when abs_dx_gt_abs_dy = '1' else abs_dy;
  abs_min <= abs_dy when abs_dx_gt_abs_dy = '1' else abs_dx;

  --Multiply by magic constants for octagonal approximation
  abs_max_mul_unit : fxp_mul
    generic map (
      WIDTH    => 32,
      DELAY    => 0,
      FXP_BITS => FXP_BITS
      )
    port map (
      a      => abs_max,
      b      => MAX_MUL_AMT,
      clk    => clk,
      clk_en => clk_en,
      result => abs_max_mul,
      oflow  => open
      );

  abs_min_mul_unit : fxp_mul
    generic map (
      WIDTH    => 32,
      DELAY    => 0,
      FXP_BITS => FXP_BITS
      )
    port map (
      a      => abs_min,
      b      => MIN_MUL_AMT,
      clk    => clk,
      clk_en => clk_en,
      result => abs_min_mul,
      oflow  => open
      );


  oct_dist       <= abs_max_mul_d1 + abs_min_mul_d1;
  distance_oflow <= '0';                --Technically possible, but not with
                                        --current distances so just use 0

  --Pipeline Registers
  process (clk)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if clk_en = '1' then
        abs_min_mul_d1 <= abs_min_mul;
        abs_max_mul_d1 <= abs_max_mul;
      end if;
    end if;
  end process;

  gen_output_stage: if OUTPUT_STAGE = 1 generate
    process (clk)
    begin
      if clk'event and clk = '1' then
        if clk_en = '1' then
          distance <= oct_dist;
        end if;
      end if;
    end process;
  end generate gen_output_stage;

  gen_no_output_stage: if OUTPUT_STAGE = 0 generate
    distance <= oct_dist;
  end generate gen_no_output_stage;

end oct_approx;

--ORIGINAL C CODE this replaces
--//use sqrt(abs_dx**2 + abs_dy**2) to get distance
--vbx_fix16_mul( v_y, v_dy, v_dy);
--vbx_fix16_mul( v_x, v_dx, v_dx);
--vbx_fix16_add( v_dist2, v_x, v_y);
--vbx_fix16_sqrt(v_rdist0, v_dist2);
--END ORIGINAL C CODE this replaces

architecture sqrt_based of distance_calc is
  constant RAD_WIDTH      : positive := 32+FXP_BITS;
  constant FXP_BITS_DIV_2 : natural  := FXP_BITS/2;
  constant Q_WIDTH        : positive := 16+FXP_BITS_DIV_2;

  --Keep everything in signed format to match C code
  signal dx2_d1    : signed(31 downto 0);
  signal dy2_d1    : signed(31 downto 0);
  signal distance2 : signed(31 downto 0);

  signal radical  : std_logic_vector(RAD_WIDTH-1 downto 0);
  signal quotient : std_logic_vector(Q_WIDTH-1 downto 0);
  signal signed_quotient : signed(31 downto 0);

  signal dx2_oflow_d1      : std_logic;
  signal dy2_oflow_d1      : std_logic;
  signal distance2_oflow   : std_logic;
  signal distance2_oflow_d : std_logic_vector(DIST_DELAY-DX_SQUARED_STAGES downto 1);

  component sqrt is
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
  end component;

begin

  --Square dx, dy
  dx_square_unit : fxp_mul
    generic map (
      WIDTH    => 32,
      DELAY    => DX_SQUARED_STAGES,
      FXP_BITS => FXP_BITS
      )
    port map (
      a      => dx,
      b      => dx,
      clk    => clk,
      clk_en => clk_en,
      result => dx2_d1,
      oflow  => dx2_oflow_d1
      );

  dy_square_unit : fxp_mul
    generic map (
      WIDTH    => 32,
      DELAY    => DX_SQUARED_STAGES,
      FXP_BITS => FXP_BITS
      )
    port map (
      a      => dy,
      b      => dy,
      clk    => clk,
      clk_en => clk_en,
      result => dy2_d1,
      oflow  => dy2_oflow_d1
      );

  distance2       <= dx2_d1 + dy2_d1;
  distance2_oflow <= dx2_oflow_d1 or dy2_oflow_d1;

  radical(RAD_WIDTH-1 downto RAD_WIDTH-32) <= std_logic_vector(distance2);
  extend_gen : if FXP_BITS > 0 generate
    radical(RAD_WIDTH-33 downto 0) <= (others => '0');
  end generate extend_gen;

  the_sqrt : sqrt
    generic map (
      PIPELINE_STAGES => DIST_DELAY-DX_SQUARED_STAGES-OUTPUT_STAGE,
      OUTPUT_WIDTH    => Q_WIDTH,
      INPUT_WIDTH     => RAD_WIDTH
      )
    port map (
      clk       => clk,
      ena       => clk_en,
      radical   => radical,
      q         => quotient
      );

  signed_quotient <= signed(resize(unsigned(quotient), 32));

  --pipeline registers
  process (clk)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if clk_en = '1' then              -- synchronous reset (active high)
        distance2_oflow_d(1)                               <= distance2_oflow;
        distance2_oflow_d(distance2_oflow_d'left downto 2) <= distance2_oflow_d(distance2_oflow_d'left-1 downto 1);
      end if;
    end if;
  end process;
  distance_oflow <= distance2_oflow_d(distance2_oflow_d'left);

  gen_output_stage: if OUTPUT_STAGE = 1 generate
    process (clk)
    begin
      if clk'event and clk = '1' then
        if clk_en = '1' then
          distance <= signed_quotient;
        end if;
      end if;
    end process;
  end generate gen_output_stage;

  gen_no_output_stage: if OUTPUT_STAGE = 0 generate
    distance <= signed_quotient;
  end generate gen_no_output_stage;

end sqrt_based;
