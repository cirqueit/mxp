-- vci_atan.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-------------------------------------------------------------------------------
-- Arctangent custom instruction.  Takes in Q2.14 magnitude inputs and outputs
-- a Q3.13 phase (in radians).
--
-- Uses a CORDIC Xilinx core for the implementation; currently only precision
-- is configurable by setting top level generics.
-------------------------------------------------------------------------------

-- synthesis library vci_atan_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.util_pkg.all;

entity vci_atan is
  generic (
    VCI_LANES : positive := 2;
    PRECISION : natural  := 0
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

architecture rtl of vci_atan is
  constant VCI_STAGES : natural := 20;

  type byteena_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*4)-1 downto 0);
  signal byteena_out_shifter : byteena_out_shifter_type((VCI_STAGES)-1 downto 0);

  signal atan : std_logic_vector((VCI_LANES*32)-1 downto 0);
  signal flag : std_logic_vector((VCI_LANES*4)-1 downto 0);

  component cordic_atan_xil is
    generic (
      VCI_DELAY : natural;
      PRECISION : natural
      );
    port (
      clk          : in  std_logic;
      clk_en       : in  std_logic;
      real_in      : in  std_logic_vector(15 downto 0);
      imaginary_in : in  std_logic_vector(15 downto 0);
      phase_out    : out std_logic_vector(15 downto 0)
      );
  end component;
begin

  -----------------------------------------------------------------------------
  -- VCI custom RTL
  -----------------------------------------------------------------------------
  lane_gen : for ghalf in (VCI_LANES*2)-1 downto 0 generate
    the_atan : cordic_atan_xil
      generic map (
        VCI_DELAY => VCI_STAGES,
        PRECISION => PRECISION
        )
      port map (
        clk          => vci_clk,
        clk_en       => '1',
        real_in      => vci_data_a(ghalf*16+15 downto ghalf*16),
        imaginary_in => vci_data_b(ghalf*16+15 downto ghalf*16),
        phase_out    => atan(ghalf*16+15 downto ghalf*16)
        );

    --Set flag to 0 for now
    flag(ghalf*2+1) <= '0';
    flag(ghalf*2+0) <= '0';
  end generate lane_gen;


  -----------------------------------------------------------------------------
  -- VCI logic
  -----------------------------------------------------------------------------
  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      --Byte enable shifter; write back valid bytes after the initial delay shifter
      byteena_out_shifter(0) <= vci_byte_valid;
      byteena_out_shifter(byteena_out_shifter'left downto 1) <=
        byteena_out_shifter(byteena_out_shifter'left-1 downto 0);
    end if;
  end process;

  --Output signals, from the end of the pipeline shift registers
  vci_data_out      <= atan;
  vci_flag_out      <= flag;
  vci_byteenable    <= byteena_out_shifter(byteena_out_shifter'left);

end rtl;
