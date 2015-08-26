-- vci_divide.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_divide_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.util_pkg.all;

entity vci_divide is
  generic (
    VCI_LANES : positive := 2;
    FXP_BITS  : natural  := 0;
    LATENCY_MODE : integer range 0 to 1 := 0
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

architecture rtl of vci_divide is
  constant N_BITS     : positive := 1+32+FXP_BITS;
  -- Latency of Altera lpm_divide configured with LPM_PIPELINE=N_BITS
  -- (width of numerator) is N_BITS, but latency of Xilinx LogiCORE divider
  -- (algorithm_type=Radix2, signed=true, fractional=false,
  -- clocks_per_division=1, flowcontrol=NonBlocking) is N_BITS+4.
  -- One extra clock is needed before the saturation logic
  type sel_t is array (0 to 1) of positive;
  constant DELAY_SEL : sel_t := (0 => N_BITS+1, 1 => N_BITS+4+1);
  constant VCI_STAGES  : positive := DELAY_SEL(LATENCY_MODE);

  type byteena_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*4)-1 downto 0);
  signal byteena_out_shifter : byteena_out_shifter_type((VCI_STAGES)-1 downto 0);

  signal numerator             : std_logic_vector(VCI_LANES*N_BITS-1 downto 0);
  signal denominator           : std_logic_vector(VCI_LANES*33-1 downto 0);
  signal quotient              : std_logic_vector(VCI_LANES*N_BITS-1 downto 0);
  signal quotient_d1           : std_logic_vector(VCI_LANES*N_BITS-1 downto 0);
  signal truncated_quotient_d1 : std_logic_vector(VCI_LANES*32-1 downto 0);
  signal flag_d1               : std_logic_vector(VCI_LANES*4-1 downto 0);

  signal unsigned_oflow_d1   : std_logic_vector(VCI_LANES-1 downto 0);
  signal signed_pos_oflow_d1 : std_logic_vector(VCI_LANES-1 downto 0);
  signal signed_neg_oflow_d1 : std_logic_vector(VCI_LANES-1 downto 0);

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
begin
  div_gen : for gword in VCI_LANES-1 downto 0 generate

    --Sign extend or not depending on op sign
    numerator(gword*N_BITS+N_BITS-1) <=
      vci_data_b(gword*32+31) when vci_signed = '1' else '0';
    denominator(gword*33+32) <=
      vci_data_a(gword*32+31) when vci_signed = '1' else '0';

    --Numerator data is shifted up by the number of fixed point bits
    numerator(gword*N_BITS+N_BITS-2 downto gword*N_BITS+N_BITS-33) <= vci_data_b(gword*32+31 downto gword*32);
    extend_gen : if FXP_BITS > 0 generate
      numerator(gword*N_BITS+N_BITS-34 downto gword*N_BITS) <= (others => '0');
    end generate extend_gen;

    --Denominator data is just copied
    denominator(gword*33+31 downto gword*33) <= vci_data_a(gword*32+31 downto gword*32);

    the_divider : divider
      generic map (
        DENOM_WIDTH => 33,
        NUMER_WIDTH => N_BITS
        )
      port map (
        clock    => vci_clk,
        clken    => '1',
        denom    => denominator(gword*33+32 downto gword*33),
        numer    => numerator(gword*N_BITS+N_BITS-1 downto gword*N_BITS),
        quotient => quotient(gword*N_BITS+N_BITS-1 downto gword*N_BITS)
        );

    --Register quotient for timing
    process (vci_clk)
    begin  -- process
      if vci_clk'event and vci_clk = '1' then  -- rising clock edge
        quotient_d1(gword*N_BITS+N_BITS-1 downto gword*N_BITS) <= quotient(gword*N_BITS+N_BITS-1 downto gword*N_BITS);
      end if;
    end process;

    unsigned_oflow_d1(gword) <=
      '1' when (quotient_d1(gword*N_BITS+N_BITS-1 downto gword*N_BITS+32) /=
                std_logic_vector(to_unsigned(0, N_BITS-32)))
      else '0';

    --Could reuse unsigned oflow for the signed oflow 0's check (need to check
    --one more bit when signed) but for now use simpler replicated logic
    signed_pos_oflow_d1(gword) <=
      '1' when (quotient_d1(gword*N_BITS+N_BITS-1) = '0' and
                (quotient_d1(gword*N_BITS+N_BITS-2 downto gword*N_BITS+31) /=
                 std_logic_vector(to_signed(0, N_BITS-32)))) else
      '0';
    signed_neg_oflow_d1(gword) <=
      '1' when (quotient_d1(gword*N_BITS+N_BITS-1) = '1' and
                (quotient_d1(gword*N_BITS+N_BITS-2 downto gword*N_BITS+31) /=
                 std_logic_vector(to_signed(-1, N_BITS-32)))) else
      '0';

    saturate_proc : process (vci_signed,
                             unsigned_oflow_d1(gword),
                             signed_pos_oflow_d1(gword),
                             signed_neg_oflow_d1(gword),
                             quotient_d1(gword*N_BITS+31 downto gword*N_BITS))
    begin  -- process saturate_proc
      truncated_quotient_d1(gword*32+31 downto gword*32) <= quotient_d1(gword*N_BITS+31 downto gword*N_BITS);

      if vci_signed = '1' then
        if signed_pos_oflow_d1(gword) = '1' then
          truncated_quotient_d1(gword*32+31)                 <= '0';
          truncated_quotient_d1(gword*32+30 downto gword*32) <= (others => '1');
        elsif signed_neg_oflow_d1(gword) = '1' then
          truncated_quotient_d1(gword*32+31)                 <= '1';
          truncated_quotient_d1(gword*32+30 downto gword*32) <= (others => '0');
        end if;
      else
        if unsigned_oflow_d1(gword) = '1' then
          truncated_quotient_d1(gword*32+31 downto gword*32) <= (others => '1');
        end if;
      end if;
    end process saturate_proc;

    --Set flag to overflow
    flag_d1(gword*4+0) <= signed_pos_oflow_d1(gword) or signed_neg_oflow_d1(gword) when vci_signed = '1' else
                          unsigned_oflow_d1(gword);
    flag_d1(gword*4+1) <= flag_d1(gword*4+0);
    flag_d1(gword*4+2) <= flag_d1(gword*4+0);
    flag_d1(gword*4+3) <= flag_d1(gword*4+0);
  end generate div_gen;

  --Shifter for byteenables
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      byteena_out_shifter(0) <=
        vci_byte_valid;
      byteena_out_shifter(byteena_out_shifter'left downto 1) <=
        byteena_out_shifter(byteena_out_shifter'left-1 downto 0);
    end if;
  end process;

  vci_data_out      <= truncated_quotient_d1;
  vci_flag_out      <= flag_d1;
  vci_byteenable    <= byteena_out_shifter(byteena_out_shifter'left);

end rtl;
