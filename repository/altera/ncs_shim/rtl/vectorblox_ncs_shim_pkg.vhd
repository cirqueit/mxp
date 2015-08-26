-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vbx_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package vectorblox_ncs_shim_pkg is

    component vectorblox_ncs_shim is
      port(
        ncs_clk     : in  std_logic;
        ncs_clk_en  : in  std_logic;
        ncs_reset   : in  std_logic;

        ncs_start   : in  std_logic;
        ncs_done    : out std_logic;

        ncs_dataa   : in  std_logic_vector(31 downto 0);
        ncs_datab   : in  std_logic_vector(31 downto 0);
        ncs_writerc : in  std_logic;
        ncs_result  : out std_logic_vector(31 downto 0);

        --
        coe_clk     : out std_logic;
        coe_clk_en  : out std_logic;
        coe_reset   : out std_logic;

        coe_start   : out std_logic;
        coe_done    : in  std_logic;

        coe_dataa   : out std_logic_vector(31 downto 0);
        coe_datab   : out std_logic_vector(31 downto 0);
        coe_writerc : out std_logic;
        coe_result  : in  std_logic_vector(31 downto 0)
      );
    end component vectorblox_ncs_shim;

end package;

package body vectorblox_ncs_shim_pkg is
end vectorblox_ncs_shim_pkg;
