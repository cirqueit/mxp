-- vci_sqrt.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-------------------------------------------------------------------------------
-- Fixed-point square root instruction.  Takes the number of fractional bits as
-- a generic (FXP_BITS).
--
-- This implementation uses an integer square root operator from a vendor
-- library.  Using an integer square root on a fixed point number of the form
-- Qm.f gives an output in the form Q(m/2).(f/2).  To get a full precision
-- result, we first change the input to the format Qm.(2f) by left-shifting the
-- input by f.  We then perform the square root and get an output in the form
-- Q(m/2).f and fill in the m/2 MSBs with 0's to get our final answer.
--
-- Because this instruction has a pipeline that is VCI_DELAY stages deep (longer
-- than the 3 stages that are allowed by the MXP pipeline) it has to delay
-- writeback for the first VCI_DELAY cycles.  It uses the vci_delay_count
-- signal to count down until the pipeline has valid data.  During the
-- countdown the output byte enable signals are all set to 0.  This also means
-- that during the laste VCI_DELAY cycles of the instruction, input data that
-- is loaded will be stranded in the pipeline.  Software using this instruction
-- must increase the vector length during this instruction:
-- vl <= vl + VCI_LANES*VCI_DELAY.
-------------------------------------------------------------------------------

-- synthesis library vci_sqrt_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.util_pkg.all;

entity vci_sqrt is
  generic (
    VCI_LANES       : positive             := 2;
    FXP_BITS        : natural              := 0;
    PIPELINE_STAGES : natural              := 8;
    LATENCY_MODE    : integer range 0 to 1 := 0
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

    vci_data_a : in std_logic_vector(VCI_LANES*32-1 downto 0);
    vci_flag_a : in std_logic_vector(VCI_LANES*4-1 downto 0);
    vci_data_b : in std_logic_vector(VCI_LANES*32-1 downto 0);
    vci_flag_b : in std_logic_vector(VCI_LANES*4-1 downto 0);

    vci_data_out      : out std_logic_vector(VCI_LANES*32-1 downto 0);
    vci_flag_out      : out std_logic_vector(VCI_LANES*4-1 downto 0);
    vci_byteenable    : out std_logic_vector(VCI_LANES*4-1 downto 0)
    );
end;

architecture rtl of vci_sqrt is
  constant RAD_WIDTH      : positive := 32+FXP_BITS;
  constant FXP_BITS_DIV_2 : natural  := FXP_BITS/2;
  constant Q_WIDTH        : positive := 16+FXP_BITS_DIV_2;

  -- Latency of Altera altsqrt is configurable with PIPELINE=PIPELINE_STAGES
  -- but latency of Xilinx LogiCORE CORDIC square root is equal to the
  -- bit width of the core's output (floor(INPUT_WIDTH/2)+1).
  type     sel_t is array (0 to 1) of positive;
  constant DELAY_SEL : sel_t    := (0 => PIPELINE_STAGES, 1 => Q_WIDTH+1);
  constant VCI_STAGES : positive := DELAY_SEL(LATENCY_MODE);

  type byteena_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*4)-1 downto 0);
  signal byteena_out_shifter : byteena_out_shifter_type((VCI_STAGES)-1 downto 0);

  signal radical  : std_logic_vector(VCI_LANES*RAD_WIDTH-1 downto 0);
  signal quotient : std_logic_vector(VCI_LANES*32-1 downto 0);
  signal flag     : std_logic_vector(VCI_LANES*4-1 downto 0);

  component sqrt is
    generic (
      PIPELINE_STAGES : natural  := 8;
      OUTPUT_WIDTH    : positive := 24;
      INPUT_WIDTH     : positive := 48
      );
    port (
      clk     : in  std_logic;
      ena     : in  std_logic;
      q       : out std_logic_vector (OUTPUT_WIDTH-1 downto 0);
      radical : in  std_logic_vector (INPUT_WIDTH-1 downto 0)
      );
  end component;

begin

  -----------------------------------------------------------------------------
  -- VCI custom RTL
  -----------------------------------------------------------------------------
  sqrt_gen : for gword in VCI_LANES-1 downto 0 generate

    radical(gword*RAD_WIDTH+RAD_WIDTH-1 downto gword*RAD_WIDTH+RAD_WIDTH-32) <= vci_data_a(gword*32+31 downto gword*32);
    extend_gen : if FXP_BITS > 0 generate
      radical(gword*RAD_WIDTH+RAD_WIDTH-33 downto gword*RAD_WIDTH) <= (others => '0');
    end generate extend_gen;

    the_sqrtr : sqrt
      generic map (
        PIPELINE_STAGES => VCI_STAGES,
        OUTPUT_WIDTH    => Q_WIDTH,
        INPUT_WIDTH     => RAD_WIDTH
        )
      port map (
        clk     => vci_clk,
        ena     => '1',
        radical => radical(gword*RAD_WIDTH+RAD_WIDTH-1 downto gword*RAD_WIDTH),
        q       => quotient(gword*32+Q_WIDTH-1 downto gword*32)
        );

    quot_extend_gen : if Q_WIDTH < 32 generate
      quotient(gword*32+31 downto gword*32+Q_WIDTH) <= (others => '0');
    end generate quot_extend_gen;

    --Set flag to 0 for now
    flag(gword*4+0) <= '0';
    flag(gword*4+1) <= '0';
    flag(gword*4+2) <= '0';
    flag(gword*4+3) <= '0';
  end generate sqrt_gen;


  -----------------------------------------------------------------------------
  -- VCI logic
  -----------------------------------------------------------------------------
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      --Byte enable shifter; write back any valid inputs
      byteena_out_shifter(0) <=
        vci_byte_valid;
      byteena_out_shifter(byteena_out_shifter'left downto 1) <=
        byteena_out_shifter(byteena_out_shifter'left-1 downto 0);
    end if;
  end process;

  --Output signals, from the end of the pipeline shift registers
  vci_data_out      <= quotient;
  vci_flag_out      <= flag;
  vci_byteenable    <= byteena_out_shifter(byteena_out_shifter'left);

  -- Quirk of our implementation means that if FXP_BITS the result would be off by sqrt(2).
  assert FXP_BITS_DIV_2*2 = FXP_BITS and FXP_BITS < 33
    report "FXP_BITS ("
    & integer'image(FXP_BITS) &
    ") must be a multiple of 2 between 0 and 32"
    severity error;
end rtl;
