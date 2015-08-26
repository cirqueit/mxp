-- full_particle.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.component_pkg.all;
use work.util_pkg.all;

entity full_particle is
  generic (
    VCI_LANES       : positive := 2;
    FXP_BITS        : natural  := 16;
    INPUT_STAGE     : natural range 0 to 1 := 1;
    OCT_DIST_APPROX : natural  := 0;
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
end;

--ORIGINAL C CODE this replaces
--vbx_fix16_sub_s(v_dx, px, v_particles.v_Px);
--vbx_fix16_sub_s(v_dy, py, v_particles.v_Py);
--vbx( VVW, VCUSTOM1, v_dist, v_dx, v_dy);

--// reciprocal of distance used later on
--vbx(SVW, VMOV, v_1, F16(1), 0); //generate vector of '1's
--vbx_fix16_div( v_rdist, v_1, v_dist, v_tmp, length );// 1/dist

--//get repulsion
--vbx_fix16_mul_s(v_mm, v_gm[j], v_particles.v_size); //our particle* vector of particle sizes

--//(particle*v_particles**2) / distance**2
--vbx_fix16_mul(v_mm, v_mm,    v_rdist);
--vbx_fix16_mul(v_mm, v_mm,    v_rdist);
--vbx_fix16_mul(v_mm, v_mm,    v_rdist);

--vbx_acc(VVW, VMULFXP, v_fx+j, v_mm, v_dx);

--vbx_acc(VVW, VMULFXP, v_fy+j, v_mm, v_dy);
--END ORIGINAL C CODE this replaces


architecture rtl of full_particle is
  type     signed32_array_shifter is array (natural range <>) of signed32_array(VCI_LANES-1 downto 0);
  type     control_shifter is array (natural range <>) of std_logic_vector(VCI_LANES-1 downto 0);
  constant FXP_ONE : signed(31 downto 0) := to_signed(1, 32) sll FXP_BITS;

  signal gmm_shifter : signed32_array_shifter(INPUT_STAGE+DIST_DELAY+DIV_DELAY
                                              downto GMM_MUL_STAGES);
  signal start_d : std_logic_vector(INPUT_STAGE+DIST_DELAY+DIV_DELAY+
                                    GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES+GMM_D3_MUL_STAGES+
                                    DFX_MUL_STAGES+EXTRA_STAGE downto 1);
  signal dx      : signed32_array(VCI_LANES-1 downto 0);
  signal dx_d    : signed32_array_shifter(INPUT_STAGE+DIST_DELAY+DIV_DELAY+
                                          GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES+GMM_D3_MUL_STAGES
                                          downto 1);
  signal dy      : signed32_array(VCI_LANES-1 downto 0);
  signal dy_d    : signed32_array_shifter(INPUT_STAGE+DIST_DELAY+DIV_DELAY+
                                          GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES+GMM_D3_MUL_STAGES
                                          downto 1);

  signal distance_d1            : signed32_array(VCI_LANES-1 downto 0);
  signal distance_oflow_d1      : std_logic_vector(VCI_LANES-1 downto 0);

  signal distance_invalid_d     : control_shifter(INPUT_STAGE+DIST_DELAY+DIV_DELAY+
                                                  GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES+
                                                  GMM_D3_MUL_STAGES+
                                                  DFX_MUL_STAGES+EXTRA_STAGE downto
                                                  INPUT_STAGE+DIST_DELAY);

  signal reciprocal_distance_d : signed32_array_shifter(INPUT_STAGE+DIST_DELAY+DIV_DELAY+
                                                        GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES downto
                                                        INPUT_STAGE+DIST_DELAY+DIV_DELAY);

  signal gmm_over_distance_d1   : signed32_array(VCI_LANES-1 downto 0);
  signal gmm_over_distance2_d1  : signed32_array(VCI_LANES-1 downto 0);
  signal gmm_over_distance3_d1  : signed32_array(VCI_LANES-1 downto 0);

  signal dfx_unvalidated : signed32_array(VCI_LANES-1 downto 0);
  signal dfx_validated : signed32_array(VCI_LANES-1 downto 0);
  signal dfx_accum     : signed32_array(VCI_LANES-1 downto 0);

  signal dfy_unvalidated : signed32_array(VCI_LANES-1 downto 0);
  signal dfy_validated : signed32_array(VCI_LANES-1 downto 0);
  signal dfy_accum     : signed32_array(VCI_LANES-1 downto 0);
begin

  lane_gen : for glane in VCI_LANES-1 downto 0 generate
    --Gmm, calculated initially, then delayed for later use: d0
    -- This is assumed to overlap entirely with the input, dist, and div
    -- stages, i.e. GMM_MUL_STAGES < INPUT_STAGE + DIST_DELAY + DIV_DELAY.
    gmm_mul_unit : fxp_mul
      generic map (
        WIDTH    => 32,
        DELAY    => GMM_MUL_STAGES,
        FXP_BITS => FXP_BITS
        )
      port map (
        a      => ref_gm,
        b      => m(glane),
        clk    => clk,
        clk_en => clk_en,
        result => gmm_shifter(GMM_MUL_STAGES)(glane),
        oflow  => open
        );

    --get x and y distances from our current particle to every other
    dx(glane) <= ref_px - px(glane);
    dy(glane) <= ref_py - py(glane);

    oct_dist_gen : if OCT_DIST_APPROX = 1 generate
      --Octagonal distance approximation: INPUT_STAGE -> INPUT_STAGE+DIST_DELAY
      distance_approximator : entity work.distance_calc(oct_approx)
        generic map (
          FXP_BITS   => FXP_BITS,
          DIST_DELAY => DIST_DELAY,
          OUTPUT_STAGE => 1
          )
        port map (
          clk    => clk,
          clk_en => clk_en,

          dx => dx_d(1)(glane),
          dy => dy_d(1)(glane),

          distance       => distance_d1(glane),
          distance_oflow => distance_oflow_d1(glane)
          );
    end generate oct_dist_gen;

    sqrt_dist_gen : if OCT_DIST_APPROX = 0 generate
      --SQRT distance calculation: INPUT_STAGE -> INPUT_STAGE+DIST_DELAY
      distance_calculator : entity work.distance_calc(sqrt_based)
        generic map (
          FXP_BITS   => FXP_BITS,
          DIST_DELAY => DIST_DELAY,
          DX_SQUARED_STAGES => DX_SQUARED_STAGES,
          OUTPUT_STAGE => SQRT_DIST_OUTPUT_STAGE
          )
        port map (
          clk    => clk,
          clk_en => clk_en,

          dx => dx_d(1)(glane),
          dy => dy_d(1)(glane),

          distance       => distance_d1(glane),
          distance_oflow => distance_oflow_d1(glane)
          );
    end generate sqrt_dist_gen;

    --Too small distance calculation: INPUT_STAGE+DIST_DELAY
    distance_invalid_d(INPUT_STAGE+DIST_DELAY)(glane)
      <= '1' when distance_d1(glane) < FXP_ONE else distance_oflow_d1(glane);

    --Reciprocal distance calculation: INPUT_STAGE+DIST_DELAY -> INPUT_STAGE+DIST_DELAY+DIV_DELAY
    reciprocal : fxp_div
      generic map (
        WIDTH    => 32,
        FXP_BITS => FXP_BITS,
        OUTPUT_STAGE => DIV_OUTPUT_STAGE
        )
      port map (
        clk    => clk,
        clk_en => clk_en,

        numerator   => FXP_ONE,
        denominator => distance_d1(glane),

        quotient => reciprocal_distance_d(INPUT_STAGE+DIST_DELAY+DIV_DELAY)(glane)
        );

    --Gmm/d: INPUT_STAGE+DIST_DELAY+DIV_DELAY
    gmm_d_mul : fxp_mul
      generic map (
        WIDTH    => 32,
        DELAY    => GMM_D_MUL_STAGES,
        FXP_BITS => FXP_BITS
        )
      port map (
        a      => reciprocal_distance_d(INPUT_STAGE+DIST_DELAY+DIV_DELAY)(glane),
        b      => gmm_shifter(gmm_shifter'left)(glane),
        clk    => clk,
        clk_en => clk_en,
        result => gmm_over_distance_d1(glane),
        oflow  => open
        );

    --Gmm/d^2: INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES
    gmm_d2_mul : fxp_mul
      generic map (
        WIDTH    => 32,
        DELAY    => GMM_D2_MUL_STAGES,
        FXP_BITS => FXP_BITS
        )
      port map (
        a      => reciprocal_distance_d(INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES)(glane),
        b      => gmm_over_distance_d1(glane),
        clk    => clk,
        clk_en => clk_en,
        result => gmm_over_distance2_d1(glane),
        oflow  => open
        );

    --Gmm/d^3: INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES
    gmm_d3_mul : fxp_mul
      generic map (
        WIDTH    => 32,
        DELAY    => GMM_D3_MUL_STAGES,
        FXP_BITS => FXP_BITS
        )
      port map (
        a      => reciprocal_distance_d(INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES)(glane),
        b      => gmm_over_distance2_d1(glane),
        clk    => clk,
        clk_en => clk_en,
        result => gmm_over_distance3_d1(glane),
        oflow  => open
        );

    -- dfx, dfy: Note optional extra pipeline stage (EXTRA_STAGE generic)
    -- to make total pipeline delay an even number of cycles (if necessary).

    --dfx, dfy: INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES+GMM_D2_MUL_STAGES+GMM_D3_MUL_STAGES
    dfx_mul_unit : fxp_mul
      generic map (
        WIDTH    => 32,
        DELAY    => DFX_MUL_STAGES+EXTRA_STAGE,
        FXP_BITS => FXP_BITS
        )
      port map (
        a      => gmm_over_distance3_d1(glane),
        b      => dx_d(dx_d'left)(glane),
        clk    => clk,
        clk_en => clk_en,
        result => dfx_unvalidated(glane),
        oflow  => open
        );

    dfy_mul_unit : fxp_mul
      generic map (
        WIDTH    => 32,
        DELAY    => DFX_MUL_STAGES+EXTRA_STAGE,
        FXP_BITS => FXP_BITS
        )
      port map (
        a      => gmm_over_distance3_d1(glane),
        b      => dy_d(dy_d'left)(glane),
        clk    => clk,
        clk_en => clk_en,
        result => dfy_unvalidated(glane),
        oflow  => open
        );

    --Check for not too small distance:
    --INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES+GMM_D2_STAGES+GMM_D3_STAGES+
    --  DFX_MUL_STAGES+EXTRA_STAGE
    dfx_validated(glane) <= dfx_unvalidated(glane) when distance_invalid_d(distance_invalid_d'left)(glane) = '0'
                            else (others => '0');
    dfy_validated(glane) <= dfy_unvalidated(glane) when distance_invalid_d(distance_invalid_d'left)(glane) = '0'
                            else (others => '0');

    --Accum: INPUT_STAGE+DIST_DELAY+DIV_DELAY+GMM_D_MUL_STAGES+GMM_D2_STAGES+GMM_D3_STAGES+
    --  DFX_MUL_STAGES+EXTRA_STAGE+ACCUM_STAGE
    accum_proc : process (clk)
    begin  -- process accum_proc
      if clk'event and clk = '1' then   -- rising clock edge
        if clk_en = '1' then
          if start_d(start_d'left) = '1' then
            dfx_accum(glane) <= dfx_validated(glane);
            dfy_accum(glane) <= dfy_validated(glane);
          else
            dfx_accum(glane) <= dfx_accum(glane) + dfx_validated(glane);
            dfy_accum(glane) <= dfy_accum(glane) + dfy_validated(glane);
          end if;
        end if;
      end if;
    end process accum_proc;

  end generate lane_gen;

  --Pipeline registers
  process (clk)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if clk_en = '1' then
        start_d(1)                                           <= start;
        start_d(start_d'left downto 2)                       <= start_d(start_d'left-1 downto 1);
        dx_d(1)                                              <= dx;
        dx_d(dx_d'left downto 2)                             <= dx_d(dx_d'left-1 downto 1);
        dy_d(1)                                              <= dy;
        dy_d(dy_d'left downto 2)                             <= dy_d(dy_d'left-1 downto 1);

        gmm_shifter(gmm_shifter'left downto gmm_shifter'right+1)
          <= gmm_shifter(gmm_shifter'left-1 downto gmm_shifter'right);

        distance_invalid_d(distance_invalid_d'left downto distance_invalid_d'right+1)
          <= distance_invalid_d(distance_invalid_d'left-1 downto distance_invalid_d'right);

        reciprocal_distance_d(reciprocal_distance_d'left downto reciprocal_distance_d'right+1)
          <= reciprocal_distance_d(reciprocal_distance_d'left-1 downto reciprocal_distance_d'right);
      end if;

      if reset = '1' then
        start_d(1) <= '0';
      end if;
    end if;
  end process;


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
