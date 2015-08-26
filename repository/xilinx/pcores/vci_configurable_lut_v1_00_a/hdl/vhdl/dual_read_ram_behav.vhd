-- dual_read_ram_behav.vhd
-- Copyright (C) 2015 VectorBlox Computing, Inc.
--
-- Behavioural implementation of 2 read 1 write RAM

-- synthesis library vci_configurable_lut_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.vci_configurable_lut_util_pkg.all;

entity dual_read_ram is
  generic (
    RAM_WIDTH        : positive := 16;
    RAM_DEPTH        : positive := 1024;
    REGISTER_OUTPUTS : boolean  := false
    );
  port (
    clk         : in  std_logic;
    address_a   : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    address_b   : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    writedata_a : in  std_logic_vector(RAM_WIDTH-1 downto 0);
    wren_a      : in  std_logic;
    readdata_a  : out std_logic_vector(RAM_WIDTH-1 downto 0);
    readdata_b  : out std_logic_vector(RAM_WIDTH-1 downto 0)
    );
end dual_read_ram;


architecture rtl of dual_read_ram is
  type   ram_type is array (RAM_DEPTH-1 downto 0) of std_logic_vector(RAM_WIDTH-1 downto 0);
  signal ram : ram_type;

  signal out_a : std_logic_vector(RAM_WIDTH-1 downto 0);
  signal out_b : std_logic_vector(RAM_WIDTH-1 downto 0);
begin

  output_reg_gen : if REGISTER_OUTPUTS = true generate
    --Dual read, single write RAM with output registers
    process (clk)
    begin
      if clk'event and clk = '1' then
        out_a      <= ram(to_integer(address_a));
        out_b      <= ram(to_integer(address_b));
        readdata_a <= out_a;
        readdata_b <= out_b;
        if wren_a = '1' then
          ram(to_integer(address_a)) <= writedata_a;
        end if;
      end if;
    end process;
  end generate output_reg_gen;

  no_output_reg_gen : if REGISTER_OUTPUTS = false generate
    --Dual read, single write RAM
    process (clk)
    begin
      if clk'event and clk = '1' then
        readdata_a <= ram(to_integer(address_a));
        readdata_b <= ram(to_integer(address_b));
        if wren_a = '1' then
          ram(to_integer(address_a)) <= writedata_a;
        end if;
      end if;
    end process;
  end generate no_output_reg_gen;

end rtl;
