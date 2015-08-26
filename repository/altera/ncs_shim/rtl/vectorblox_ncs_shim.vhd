---------------------------------------------------------------------------
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.
--
-- Nios II Custom Instruction Slave to VectorBlox MXP instruction interface.
---------------------------------------------------------------------------

-- synthesis library vbx_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vectorblox_ncs_shim is
  port(
    -- Nios II side: Qsys custom instruction slave interface.
    ncs_clk     : in  std_logic;
    ncs_clk_en  : in  std_logic;
    ncs_reset   : in  std_logic;

    ncs_start   : in  std_logic;
    ncs_done    : out std_logic;

    ncs_dataa   : in  std_logic_vector(31 downto 0);
    ncs_datab   : in  std_logic_vector(31 downto 0);
    ncs_writerc : in  std_logic;
    ncs_result  : out std_logic_vector(31 downto 0);

    -- VectorBlox MXP side: Qsys conduit interface.
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
end entity vectorblox_ncs_shim;

architecture rtl of vectorblox_ncs_shim is

    component vectorblox_ncs_shim_internal
      port (
        ncs_clk     : in  std_logic;
        ncs_clk_en  : in  std_logic;
        ncs_reset   : in  std_logic;
        ncs_start   : in  std_logic;
        ncs_done    : out std_logic;
        ncs_dataa   : in  std_logic_vector(31 downto 0);
        ncs_datab   : in  std_logic_vector(31 downto 0);
        ncs_writerc : in  std_logic;
        ncs_result  : out std_logic_vector(31 downto 0);

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
    end component;

begin

    vectorblox_ncs_shim_internal_0 : component vectorblox_ncs_shim_internal
      port map (
        ncs_clk     => ncs_clk,
        ncs_clk_en  => ncs_clk_en,
        ncs_reset   => ncs_reset,
        ncs_start   => ncs_start,
        ncs_done    => ncs_done,
        ncs_dataa   => ncs_dataa,
        ncs_datab   => ncs_datab,
        ncs_writerc => ncs_writerc,
        ncs_result  => ncs_result,

        coe_clk     => coe_clk,
        coe_clk_en  => coe_clk_en,
        coe_reset   => coe_reset,
        coe_start   => coe_start,
        coe_done    => coe_done,
        coe_dataa   => coe_dataa,
        coe_datab   => coe_datab,
        coe_writerc => coe_writerc,
        coe_result  => coe_result
      );

end architecture rtl;
