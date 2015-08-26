-- vci_particle_full.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.component_pkg.all;
use work.util_pkg.all;

entity vci_particle_full is
  generic (
    VCI_LANES       : positive             := 2;
    FXP_BITS        : natural              := 16;
    OCT_DIST_APPROX : natural range 0 to 1 := 0;
    DSPBA_FLOATING  : natural range 0 to 1 := 0;
    LATENCY_MODE    : natural range 0 to 1 := 0
    );
  port (
    vci_clk   : in std_logic;
    vci_reset : in std_logic;

    vci_valid  : in std_logic;
    vci_signed : in std_logic;
    vci_opsize : in std_logic_vector(1 downto 0);

    vci_vector_start : in std_logic;
    vci_vector_end   : in std_logic;
    vci_byte_valid   : in std_logic_vector(VCI_LANES*4-1 downto 0);
    vci_dest_addr_in : in std_logic_vector(31 downto 0);

    vci_data_a : in std_logic_vector(VCI_LANES*32-1 downto 0);
    vci_flag_a : in std_logic_vector(VCI_LANES*4-1 downto 0);
    vci_data_b : in std_logic_vector(VCI_LANES*32-1 downto 0);
    vci_flag_b : in std_logic_vector(VCI_LANES*4-1 downto 0);

    vci_data_out      : out std_logic_vector(VCI_LANES*32-1 downto 0);
    vci_flag_out      : out std_logic_vector(VCI_LANES*4-1 downto 0);
    vci_byteenable    : out std_logic_vector(VCI_LANES*4-1 downto 0);
    vci_dest_addr_out : out std_logic_vector(31 downto 0)
    );
end;

architecture rtl of vci_particle_full is
  type sel_t is array (0 to 1) of positive;
  type nat_sel_t is array (0 to 1) of natural;

  constant FREE_RUNNING : natural := DSPBA_FLOATING;

  constant SQRT_RAD_WIDTH : positive := 32+FXP_BITS;
  constant FXP_BITS_DIV_2 : natural  := FXP_BITS/2;
  constant SQRT_Q_WIDTH   : positive := 16+FXP_BITS_DIV_2;

  -- Latency of Altera altsqrt is configurable with PIPELINE=desired number of
  -- stages, but latency of Xilinx LogiCORE CORDIC square root is equal to the
  -- bit width of the core's output (floor(INPUT_WIDTH/2)+1).
  -- Delay of Altera altsqrt also should be adjusted for FXP_BITS.
  constant SQRT_DELAY_SEL : sel_t    := (0 => 16, 1 => SQRT_Q_WIDTH+1);
  constant SQRT_DELAY     : positive := SQRT_DELAY_SEL(LATENCY_MODE);

  constant DX_SQUARED_STAGES_SEL : sel_t    := (0 => 1, 1 => 2);
  constant DX_SQUARED_STAGES     : positive := DX_SQUARED_STAGES_SEL(LATENCY_MODE);

  -- Add an additional pipeline stage at output of SQRT or not.
  -- (Output of Xilinx LogiCORE CORDIC sqrt is already registered.)
  constant SQRT_DIST_OUTPUT_STAGE_SEL : nat_sel_t := (0 => 1, 1 => 0);
  constant SQRT_DIST_OUTPUT_STAGE     : natural   := SQRT_DIST_OUTPUT_STAGE_SEL(LATENCY_MODE);

  constant SQRT_DIST_DELAY : positive := DX_SQUARED_STAGES + SQRT_DELAY + SQRT_DIST_OUTPUT_STAGE;

  constant DIST_DELAY_SEL : sel_t    := (0 => SQRT_DIST_DELAY, 1 => 2);
  constant DIST_DELAY     : positive := DIST_DELAY_SEL(OCT_DIST_APPROX);

  -- Latency of Altera lpm_divide configured with LPM_PIPELINE=NUMER_WIDTH
  -- is NUMER_WIDTH, but latency of Xilinx LogiCORE divider
  -- (algorithm_type=Radix2, signed=true, fractional=false,
  -- clocks_per_division=1, flowcontrol=NonBlocking) is NUMER_WIDTH+4.
  constant DIV_NUMER_WIDTH : positive := 32 + FXP_BITS;

  -- Add an additional pipeline stage at output of divider or not.
  -- (Output of Xilinx LogiCORE divider is already registered.)
  constant DIV_OUTPUT_STAGE_SEL : nat_sel_t := (0 => 1, 1 => 0);
  constant DIV_OUTPUT_STAGE     : natural   := DIV_OUTPUT_STAGE_SEL(LATENCY_MODE);

  constant DIV_DELAY_SEL : sel_t    := (0 => DIV_NUMER_WIDTH, 1 => DIV_NUMER_WIDTH + 4);
  constant DIV_DELAY     : positive := DIV_DELAY_SEL(LATENCY_MODE) + DIV_OUTPUT_STAGE;

  constant GMM_MUL_STAGES_SEL    : sel_t := (0 => 1, 1 => 2);
  -- Note: two for Altera as well.
  constant GMM_D_MUL_STAGES_SEL  : sel_t := (0 => 2, 1 => 2);
  constant GMM_D2_MUL_STAGES_SEL : sel_t := (0 => 1, 1 => 2);
  constant GMM_D3_MUL_STAGES_SEL : sel_t := (0 => 2, 1 => 2);

  constant GMM_MUL_STAGES    : positive := GMM_MUL_STAGES_SEL(LATENCY_MODE);
  constant GMM_D_MUL_STAGES  : positive := GMM_D_MUL_STAGES_SEL(LATENCY_MODE);
  constant GMM_D2_MUL_STAGES : positive := GMM_D2_MUL_STAGES_SEL(LATENCY_MODE);
  constant GMM_D3_MUL_STAGES : positive := GMM_D3_MUL_STAGES_SEL(LATENCY_MODE);

  constant DFX_MUL_STAGES_SEL : sel_t    := (0 => 1, 1 => 2);
  constant DFX_MUL_STAGES     : positive := DFX_MUL_STAGES_SEL(LATENCY_MODE);

  constant INPUT_STAGE : positive := 1;
  constant ACCUM_STAGE : positive := 1;

  constant BASE_FIXED_DELAY : positive := INPUT_STAGE + DIST_DELAY + DIV_DELAY +
                                              GMM_D_MUL_STAGES + GMM_D2_MUL_STAGES + GMM_D3_MUL_STAGES +
                                              DFX_MUL_STAGES + ACCUM_STAGE;
  -- The total pipeline delay must be an even number of cycles to
  -- support the sharing of a single pipeline over two vector lanes.
  -- A pipeline stage can be conditionally added (or removed) to satisfy
  -- this requirement.
  -- If base delay is odd (delay mod 2 = 1), need an extra stage.
  constant EXTRA_FIXED_STAGE    : natural  := (BASE_FIXED_DELAY mod 2);
  constant HAND_FIXED_DELAY     : positive := BASE_FIXED_DELAY + EXTRA_FIXED_STAGE;
  constant DSPBA_FLOATING_DELAY : positive := 78;

  constant FP_DELAY_SEL : sel_t    := (0 => HAND_FIXED_DELAY, 1 => DSPBA_FLOATING_DELAY);
  constant FP_DELAY     : positive := FP_DELAY_SEL(DSPBA_FLOATING);

  constant DATA_FIFO_DELAY : natural   := 4;  --Max cycles from input to valid FIFO
  constant FIFO_DELAY_SEL  : nat_sel_t := (0 => 0, 1 => DATA_FIFO_DELAY);
  constant FIFO_DELAY      : natural   := FIFO_DELAY_SEL(FREE_RUNNING);

  constant VCI_DELAY  : positive := 2 + FP_DELAY + FIFO_DELAY + 2;
  constant HALF_LANES : positive := VCI_LANES/2;

  type data_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*32)-1 downto 0);
  type byteena_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*4)-1 downto 0);
  type dest_addr_shifter_type is array (natural range <>) of std_logic_vector(31 downto 0);

  constant VCI_STAGES : positive := 2;

  signal data_out_shifter    : data_out_shifter_type(VCI_STAGES-1 downto 0);
  signal flag_out_shifter    : byteena_out_shifter_type(VCI_STAGES-1 downto 0);
  signal byteena_out_shifter : byteena_out_shifter_type(VCI_STAGES-1 downto 0);
  signal dest_addr_shifter   : dest_addr_shifter_type(VCI_STAGES-1 downto 0);

  signal vci_delay_count       : unsigned(log2(VCI_DELAY+1-VCI_STAGES+1)-1 downto 0);
  signal byteena_delay_shifter : byteena_out_shifter_type(VCI_DELAY-1 downto 0);
  signal dest_delay_shifter    : dest_addr_shifter_type(VCI_DELAY-1 downto 0);

  signal vci_data_a_2d : signed32_array(VCI_LANES-1 downto 0);
  signal vci_data_b_2d : signed32_array(VCI_LANES-1 downto 0);

  signal clk_en     : std_logic;
  signal start_d1   : std_logic;
  signal start_d2   : std_logic;
  signal fp_start   : std_logic;
  signal input_is_p : std_logic;
  signal instr_load : std_logic;
  signal load_p     : std_logic;
  signal ref_px     : signed(31 downto 0);
  signal next_px    : signed32_array(VCI_LANES-1 downto 0);
  signal px         : signed32_array(VCI_LANES-1 downto 0);
  signal px_valid   : signed32_array(HALF_LANES-1 downto 0);
  signal ref_py     : signed(31 downto 0);
  signal next_py    : signed32_array(VCI_LANES-1 downto 0);
  signal py         : signed32_array(VCI_LANES-1 downto 0);
  signal py_valid   : signed32_array(HALF_LANES-1 downto 0);
  signal ref_gm     : signed(31 downto 0);
  signal m          : signed32_array(VCI_LANES-1 downto 0);

  signal fp_result_x      : signed32_array(HALF_LANES-1 downto 0);
  signal result_x         : signed32_array(HALF_LANES-1 downto 0);
  signal result_x_flat    : std_logic_vector((HALF_LANES*32)-1 downto 0);
  signal result_x_flat_d1 : std_logic_vector((HALF_LANES*32)-1 downto 0);
  signal result_x_flat_d2 : std_logic_vector((HALF_LANES*32)-1 downto 0);
  signal fp_result_y      : signed32_array(HALF_LANES-1 downto 0);
  signal result_y         : signed32_array(HALF_LANES-1 downto 0);
  signal result_y_flat    : std_logic_vector((HALF_LANES*32)-1 downto 0);
  signal result_y_flat_d1 : std_logic_vector((HALF_LANES*32)-1 downto 0);
  signal result_y_flat_d2 : std_logic_vector((HALF_LANES*32)-1 downto 0);

  signal output_is_x            : std_logic;
  signal next_data_out_shifter0 : std_logic_vector((VCI_LANES*32)-1 downto 0);

  signal vci_valid_d  : std_logic_vector(FP_DELAY downto 1);
  signal vci_reset_d1 : std_logic;

  signal data_fifo_rdreq     : std_logic;
  signal data_fifo_wrreq     : std_logic;
  signal data_fifo_writedata : std_logic_vector((2*HALF_LANES*32)-1 downto 0);

  signal data_fifo_almost_full  : std_logic;
  signal data_fifo_usedw        : std_logic_vector(log2(FP_DELAY+DATA_FIFO_DELAY+1)-1 downto 0);
  signal data_fifo_head_invalid : std_logic;
  signal data_fifo_empty        : std_logic;
  signal data_fifo_full         : std_logic;
  signal data_fifo_readdata     : std_logic_vector((2*HALF_LANES*32)-1 downto 0);

  signal data_fifo_init       : std_logic;
  signal data_fifo_init_count : unsigned(log2(FP_DELAY+DATA_FIFO_DELAY+1)-1 downto 0);
begin

  --Put reference values into registers
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      if vci_valid = '1' then
        start_d1 <= vci_vector_start;
        start_d2 <= start_d1;
        if vci_vector_start = '1' then
          if instr_load = '1' then
            ref_px     <= signed(vci_data_a(31 downto 0));
            ref_py     <= signed(vci_data_b(31 downto 0));
            load_p     <= '0';
            instr_load <= '0';
          else
            instr_load <= '1';
            load_p     <= '1';
          end if;
        else
          if load_p = '0' then
            ref_gm <= signed(vci_data_b(31 downto 0));
            load_p <= '1';
          end if;
        end if;
      end if;

      if vci_reset = '1' then           -- synchronous reset (active high)
        instr_load <= '1';
        load_p     <= '1';
      end if;
    end if;
  end process;

  --Put inputs into registers
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      if vci_valid = '1' then
        input_is_p <= not input_is_p;
        if input_is_p = '1' then
          next_px                   <= vci_data_a_2d;
          next_py                   <= vci_data_b_2d;
          px(HALF_LANES-1 downto 0) <= px(VCI_LANES-1 downto HALF_LANES);
          py(HALF_LANES-1 downto 0) <= py(VCI_LANES-1 downto HALF_LANES);
          m(HALF_LANES-1 downto 0)  <= m(VCI_LANES-1 downto HALF_LANES);
        else
          px <= next_px;
          py <= next_py;
          m  <= vci_data_a_2d;
        end if;
      end if;

      if vci_reset = '1' then           -- synchronous reset (active high)
        input_is_p <= '1';
      end if;
    end if;
  end process;

  --Convert to/from packed formats
  lane_gen : for glane in VCI_LANES-1 downto 0 generate
    vci_data_a_2d(glane) <= signed(vci_data_a(((glane+1)*32)-1 downto glane*32));
    vci_data_b_2d(glane) <= signed(vci_data_b(((glane+1)*32)-1 downto glane*32));
  end generate lane_gen;
  half_lane_gen : for glane in HALF_LANES-1 downto 0 generate
    result_x_flat(((glane+1)*32)-1 downto glane*32) <= std_logic_vector(result_x(glane));
    result_y_flat(((glane+1)*32)-1 downto glane*32) <= std_logic_vector(result_y(glane));
  end generate half_lane_gen;

  hand_fixed_gen : if DSPBA_FLOATING = 0 generate
    full_pipeline : full_particle
      generic map (
        VCI_LANES              => HALF_LANES,
        FXP_BITS               => FXP_BITS,
        OCT_DIST_APPROX        => OCT_DIST_APPROX,
        INPUT_STAGE            => INPUT_STAGE,
        DIST_DELAY             => DIST_DELAY,
        DIV_DELAY              => DIV_DELAY,
        SQRT_DIST_OUTPUT_STAGE => SQRT_DIST_OUTPUT_STAGE,
        DIV_OUTPUT_STAGE       => DIV_OUTPUT_STAGE,
        DX_SQUARED_STAGES      => DX_SQUARED_STAGES,
        GMM_MUL_STAGES         => GMM_MUL_STAGES,
        GMM_D_MUL_STAGES       => GMM_D_MUL_STAGES,
        GMM_D2_MUL_STAGES      => GMM_D2_MUL_STAGES,
        GMM_D3_MUL_STAGES      => GMM_D3_MUL_STAGES,
        DFX_MUL_STAGES         => DFX_MUL_STAGES,
        EXTRA_STAGE            => EXTRA_FIXED_STAGE,
        ACCUM_STAGE            => ACCUM_STAGE
        )
      port map (
        clk    => vci_clk,
        clk_en => clk_en,
        start  => fp_start,
        reset  => vci_reset,

        ref_px => ref_px,
        px     => px_valid,
        ref_py => ref_py,
        py     => py_valid,
        ref_gm => ref_gm,
        m      => m(HALF_LANES-1 downto 0),

        result_x => fp_result_x,
        result_y => fp_result_y
        );
  end generate hand_fixed_gen;

  dspa_floating_gen : if DSPBA_FLOATING /= 0 generate
    full_pipeline : dspba_full_particle
      generic map (
        VCI_LANES => HALF_LANES
        )
      port map (
        clk   => vci_clk,
        start => fp_start,
        reset => vci_reset,

        ref_px => ref_px,
        px     => px_valid,
        ref_py => ref_py,
        py     => py_valid,
        ref_gm => ref_gm,
        m      => m(HALF_LANES-1 downto 0),

        result_x => fp_result_x,
        result_y => fp_result_y
        );
  end generate dspa_floating_gen;

  free_gen : if FREE_RUNNING /= 0 generate
    clk_en <= '1';

    data_fifo : fwft_fifo_reg
      generic map (
        WIDTH             => 2*HALF_LANES*32,
        DEPTH             => FP_DELAY+DATA_FIFO_DELAY+1,
        ALMOST_FULL_VALUE => FP_DELAY+DATA_FIFO_DELAY,
        EXTERNAL_REGISTER => false
        )
      port map (
        clk   => vci_clk,
        reset => vci_reset,

        rdreq     => data_fifo_rdreq,
        wrreq     => data_fifo_wrreq,
        writedata => data_fifo_writedata,

        almost_full  => data_fifo_almost_full,
        usedw        => data_fifo_usedw,
        head_invalid => data_fifo_head_invalid,
        empty        => data_fifo_empty,
        full         => data_fifo_full,
        readdata     => data_fifo_readdata
        );
    data_fifo_rdreq <= vci_valid;
    data_fifo_wrreq <= vci_valid_d(vci_valid_d'left) or data_fifo_init;
    data_fifo_flatten_gen : for glane in HALF_LANES-1 downto 0 generate
      data_fifo_writedata(((glane+1)*32)-1 downto glane*32) <=
        std_logic_vector(fp_result_x(glane));
      data_fifo_writedata(((HALF_LANES+glane+1)*32)-1 downto (HALF_LANES+glane)*32) <=
        std_logic_vector(fp_result_y(glane));
      result_x(glane) <= signed(data_fifo_readdata(((glane+1)*32)-1 downto glane*32));
      result_y(glane) <= signed(data_fifo_readdata(((HALF_LANES+glane+1)*32)-1 downto (HALF_LANES+glane)*32));
    end generate data_fifo_flatten_gen;

    data_fifo_init_proc : process (vci_clk)
    begin  -- process data_fifo_init_proc
      if vci_clk'event and vci_clk = '1' then  -- rising clock edge
        vci_valid_d(1)                         <= vci_valid;
        vci_valid_d(vci_valid_d'left downto 2) <= vci_valid_d(vci_valid_d'left-1 downto 1);
        vci_reset_d1                           <= vci_reset;

        --Why doesn't the SCFIFO work if you write immediately after reset?
        --Not mine to ask why...
        if data_fifo_init_count /= to_unsigned(0, data_fifo_init_count'length) and vci_reset_d1 /= '1' then
          data_fifo_init       <= '1';
          data_fifo_init_count <= data_fifo_init_count - to_unsigned(1, data_fifo_init_count'length);
        else
          data_fifo_init <= '0';
        end if;

        if vci_reset = '1' then         -- synchronous reset (active high)
          data_fifo_init_count <= to_unsigned(FP_DELAY+DATA_FIFO_DELAY, data_fifo_init_count'length);
        end if;
      end if;
    end process data_fifo_init_proc;

    px_valid <= px(HALF_LANES-1 downto 0) when vci_valid = '1' else (others => ref_px);
    py_valid <= py(HALF_LANES-1 downto 0) when vci_valid = '1' else (others => ref_py);
    fp_start <= start_d2 and vci_valid;
  end generate free_gen;

  nonfree_gen : if FREE_RUNNING = 0 generate
    clk_en   <= vci_valid;
    fp_start <= start_d2;
    result_x <= fp_result_x;
    result_y <= fp_result_y;
    px_valid <= px(HALF_LANES-1 downto 0);
    py_valid <= py(HALF_LANES-1 downto 0);
  end generate nonfree_gen;

  --Demux and register
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      if vci_valid = '1' then                -- synchronous reset (active high)
        result_x_flat_d1 <= result_x_flat;
        result_y_flat_d1 <= result_y_flat;
        result_x_flat_d2 <= result_x_flat_d1;
        result_y_flat_d2 <= result_y_flat_d1;
      end if;
    end if;
  end process;

  --Normal 3 stage shifter for data/byteenables (always active)
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      byteena_out_shifter(0) <=
        byteena_delay_shifter(byteena_delay_shifter'left);
      byteena_out_shifter(byteena_out_shifter'left downto 1) <=
        byteena_out_shifter(byteena_out_shifter'left-1 downto 0);

      dest_addr_shifter(0) <=
        dest_delay_shifter(dest_delay_shifter'left);
      dest_addr_shifter(dest_addr_shifter'left downto 1) <=
        dest_addr_shifter(dest_addr_shifter'left-1 downto 0);

      if vci_valid = '1' then
        output_is_x            <= not output_is_x;
        next_data_out_shifter0 <= result_y_flat_d2 & result_y_flat_d1;
      end if;
      if output_is_x = '1' then
        data_out_shifter(0) <= result_x_flat_d2 & result_x_flat_d1;
      else
        data_out_shifter(0) <= next_data_out_shifter0;
      end if;
      data_out_shifter(1)                              <= data_out_shifter(0);
      data_out_shifter(data_out_shifter'left downto 2) <=
        data_out_shifter(data_out_shifter'left-1 downto 1);

      flag_out_shifter(0)                              <= (others => '0');
      flag_out_shifter(1)                              <= flag_out_shifter(0);
      flag_out_shifter(flag_out_shifter'left downto 2) <=
        flag_out_shifter(flag_out_shifter'left-1 downto 1);

      if vci_vector_start = '1' then
        byteena_out_shifter(0) <= (others => '0');
      end if;

      if vci_reset = '1' then
        --Resets to avoid being put into a shift register (for timing)
        data_out_shifter(0) <= (others => '0');
        output_is_x         <= '1';
      end if;
    end if;
  end process;

  --Clock enabled shifter for long pipeline delay signals
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      if vci_valid = '1' then
        byteena_delay_shifter(0)                                   <= vci_byte_valid;
        byteena_delay_shifter(byteena_delay_shifter'left downto 1) <=
          byteena_delay_shifter(byteena_delay_shifter'left-1 downto 0);

        dest_delay_shifter(0)                                <= vci_dest_addr_in;
        dest_delay_shifter(dest_delay_shifter'left downto 1) <=
          dest_delay_shifter(dest_delay_shifter'left-1 downto 0);

        if vci_vector_start = '1' then
          vci_delay_count                                   <= to_unsigned(VCI_DELAY+1-VCI_STAGES, vci_delay_count'length);
          byteena_delay_shifter(byteena_delay_shifter'left) <= (others => '0');
        elsif vci_delay_count /= 0 then
          vci_delay_count <= vci_delay_count - 1;
        end if;

        if vci_delay_count /= 0 then
          byteena_delay_shifter(byteena_delay_shifter'left) <= (others => '0');
        end if;
      end if;
    end if;
  end process;

  vci_data_out               <= data_out_shifter(data_out_shifter'left);
  vci_flag_out               <= flag_out_shifter(flag_out_shifter'left);
  vci_byteenable(3 downto 0) <= byteena_out_shifter(byteena_out_shifter'left)(3 downto 0);
  multilane_gen : if VCI_LANES > 1 generate
    vci_byteenable(vci_byteenable'left downto 4) <= (others => '0');
  end generate multilane_gen;
  vci_dest_addr_out <= dest_addr_shifter(dest_addr_shifter'left);

-- ASSERTIONS to make sure CONSTANTS are valid --
  assert OCT_DIST_APPROX = 0 or OCT_DIST_APPROX = 1
    report "OCT_DIST_APPROX ("
    & integer'image(OCT_DIST_APPROX) &
    ") out of range.  Must be 0 (false) or 1 (true)"
    severity failure;

  assert DSPBA_FLOATING = 0 or DSPBA_FLOATING = 1
    report "DSPBA_FLOATING ("
    & integer'image(DSPBA_FLOATING) &
    ") out of range.  Must be 0 (false) or 1 (true)"
    severity failure;

  assert HALF_LANES*2 = VCI_LANES
    report "VCI_LANES ("
    & integer'image(VCI_LANES) &
    ") out of range.  Must be evenly divisible by 2"
    severity failure;

end rtl;
