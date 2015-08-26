-- vci_lut.vhd
-- Copyright (C) 2014 VectorBlox Computing, Inc.

-- synthesis library vci_lut_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.lut_pkg.all;

entity vci_lut is
  generic (
    VCI_LANES : positive := 2
    );
  port (
    vci_clk   : in std_logic;
    vci_reset : in std_logic;

    vci_valid  : in std_logic;
    vci_select : in std_logic_vector(1 downto 0);
    vci_signed : in std_logic;
    vci_opsize : in std_logic_vector(1 downto 0);

    vci_vector_start : in std_logic;
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

architecture rtl of vci_lut is
  constant VCI_STAGES : positive := 3;

  type   data_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*32)-1 downto 0);
  signal data_out_shifter : data_out_shifter_type(VCI_STAGES-1 downto 0);

  type   byteena_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*4)-1 downto 0);
  signal flag_out_shifter    : byteena_out_shifter_type(VCI_STAGES-1 downto 0);
  signal byteena_out_shifter : byteena_out_shifter_type(VCI_STAGES-1 downto 0);

  type   dest_addr_shifter_type is array (natural range <>) of std_logic_vector(31 downto 0);
  signal dest_addr_shifter : dest_addr_shifter_type(VCI_STAGES-1 downto 0);

  --Intermediate 
  signal data_lbp : std_logic_vector(VCI_LANES*32-1 downto 0);
  signal data_lut : std_logic_vector(255 downto 0);
  signal data_pass : std_logic_vector(7 downto 0);
  signal data_fail : std_logic_vector(7 downto 0);

  --Outputs from the logic function
  signal data_out : std_logic_vector(VCI_LANES*32-1 downto 0);
  signal flag_out : std_logic_vector(VCI_LANES*4-1 downto 0);

  --Unpacked lbp and output
  type   byte_array is array (natural range <>) of std_logic_vector(7 downto 0);
  signal data_lbp_unpacked     : byte_array(VCI_LANES*4-1 downto 0);
  signal data_out_unpacked     : byte_array(VCI_LANES*4-1 downto 0);

  --Unpacked LUT
  type   word_array is array (natural range <>) of std_logic_vector(31 downto 0);
  signal data_lut_unpacked     : word_array(7 downto 0);

begin

  --Change data interally to arrays of words for ease of use
  pack_unpack_gen : for gbyte in VCI_LANES*4-1 downto 0 generate
    data_lbp_unpacked(gbyte) <= data_lbp(((gbyte+1)*8)-1 downto gbyte*8);
    data_out(((gbyte+1)*8)-1 downto gbyte*8) <= std_logic_vector(data_out_unpacked(gbyte));
  end generate pack_unpack_gen;

  unpack_lut_gen : for gword in 7 downto 0 generate
    data_lut_unpacked(gword) <= data_lut(((gword+1)*32)-1 downto gword*32);
  end generate unpack_lut_gen;

  -- cycle +0
  process (vci_clk)
      variable idx : integer;
      begin  -- process
        if vci_clk'event and vci_clk = '1' then  -- rising clock edge
          idx := to_integer(unsigned(vci_data_a(7 downto 0)));
          data_lut <= lut(idx);
          data_pass <= plut(idx);
          data_fail <= flut(idx);
          data_lbp <= vci_data_b;
        end if;
  end process;

  -- cycle +1
  value_gen : for gbyte in VCI_LANES*4-1 downto 0 generate
      process (vci_clk)
          variable grp : integer;
          variable idx : integer;
          variable val : std_logic;
          begin
          if vci_clk'event and vci_clk = '1' then  -- rising clock edge
              grp := to_integer(unsigned(data_lbp_unpacked(gbyte)(7 downto 5)));
              idx := to_integer(unsigned(data_lbp_unpacked(gbyte)(4 downto 0)));
              val := data_lut_unpacked(grp)(idx);
              if val = '0' then
                  data_out_unpacked(gbyte) <= data_pass;
              else
                  data_out_unpacked(gbyte) <= data_fail;
              end if;
              flag_out(gbyte) <= val;
          end if;
      end process;
  end generate value_gen;

  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge

      -- cycle +2
      data_out_shifter((0+2))                              <= data_out;
      --Data out shifter; delay the data result by VCI_STAGES - 1
      -- data_out_shifter(0)                              <= data_out;
      -- data_out_shifter(data_out_shifter'left downto 1) <=
      --   data_out_shifter(data_out_shifter'left-1 downto 0);

      flag_out_shifter((0+2))                              <= flag_out;
      --Data out shifter; delay the flag result by VCI_STAGES - 1
      -- flag_out_shifter(0)                              <= flag_out;
      -- flag_out_shifter(flag_out_shifter'left downto 1) <=
      --   flag_out_shifter(flag_out_shifter'left-1 downto 0);

      --Byte enable shifter; write back all valid bytes
      byteena_out_shifter(0)                                 <= vci_byte_valid;
      byteena_out_shifter(byteena_out_shifter'left downto 1) <=
        byteena_out_shifter(byteena_out_shifter'left-1 downto 0);

      --Destination address shifter; this instruction does not modify the destination address
      dest_addr_shifter(0)                               <= vci_dest_addr_in;
      dest_addr_shifter(dest_addr_shifter'left downto 1) <=
        dest_addr_shifter(dest_addr_shifter'left-1 downto 0);
    end if;
  end process;

  --Output signals, from the end of the pipeline shift registers
  vci_data_out      <= data_out_shifter(data_out_shifter'left);
  vci_flag_out      <= flag_out_shifter(flag_out_shifter'left);
  vci_byteenable    <= byteena_out_shifter(byteena_out_shifter'left);
  vci_dest_addr_out <= dest_addr_shifter(dest_addr_shifter'left);
  
end rtl;
