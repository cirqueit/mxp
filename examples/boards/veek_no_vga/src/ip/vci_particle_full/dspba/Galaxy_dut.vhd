----------------------------------------------------------------------------- 
-- Altera DSP Builder Advanced Flow Tools Release Version 13.0sp1
-- Quartus II development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2013 Altera Corporation.  All rights reserved.    
-- Your use of  Altera  Corporation's design tools,  logic functions and other 
-- software and tools,  and its AMPP  partner logic functions, and  any output 
-- files  any of the  foregoing  device programming or simulation files),  and 
-- any associated  documentation or information are expressly subject  to  the 
-- terms and conditions  of the Altera Program License Subscription Agreement, 
-- Altera  MegaCore  Function  License  Agreement, or other applicable license 
-- agreement,  including,  without limitation,  that your use  is for the sole 
-- purpose of  programming  logic  devices  manufactured by Altera and sold by 
-- Altera or its authorized  distributors.  Please  refer  to  the  applicable 
-- agreement for further details.
----------------------------------------------------------------------------- 

-- VHDL created from Galaxy_dut
-- VHDL created on Thu Sep 12 13:44:37 2013


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;
USE work.Galaxy_dut_safe_path.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY lpm;
USE lpm.lpm_components.all;

-- Text written from /build/swbuild/SJ/nightly/13.0sp1/232/l64/p4/ip/aion/src/mip_common/hw_model.cpp:1303
entity Galaxy_dut is
    port (
        c : in std_logic_vector(7 downto 0);
        cout : out std_logic_vector(7 downto 0);
        m : in std_logic_vector(31 downto 0);
        px : in std_logic_vector(31 downto 0);
        py : in std_logic_vector(31 downto 0);
        ref_gm : in std_logic_vector(31 downto 0);
        ref_px : in std_logic_vector(31 downto 0);
        ref_py : in std_logic_vector(31 downto 0);
        result_x : out std_logic_vector(31 downto 0);
        result_y : out std_logic_vector(31 downto 0);
        start : in std_logic_vector(0 downto 0);
        v : in std_logic_vector(0 downto 0);
        vout : out std_logic_vector(0 downto 0);
        clk : in std_logic;
        areset : in std_logic
        );
end;

architecture normal of Galaxy_dut is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name NOT_GATE_PUSH_BACK OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410";

-- Galaxy_dut_prim component declaration
-- inputs
--  N/C
--  N/C
--  N/C
--  N/C
--  ref_px <= ref_px, width=32, real=0
--  valid <= v, width=1, real=0
--  channel <= c, width=8, real=0
--  px <= px, width=32, real=0
--  ref_py <= ref_py, width=32, real=0
--  py <= py, width=32, real=0
--  ref_gm <= ref_gm, width=32, real=0
--  m <= m, width=32, real=0
--  start <= start, width=1, real=0
-- outputs
--  N/C
--  N/C
--  result_x => Galaxy_dut_prim_result_x, width=32, real=0
--  vout => Galaxy_dut_prim_vout, width=1, real=0
--  cout => Galaxy_dut_prim_cout, width=8, real=0
--  result_y => Galaxy_dut_prim_result_y, width=32, real=0
    component Galaxy_dut_prim is
        port (
        ref_px : in std_logic_vector(31 downto 0);
        valid : in std_logic_vector(0 downto 0);
        channel : in std_logic_vector(7 downto 0);
        px : in std_logic_vector(31 downto 0);
        ref_py : in std_logic_vector(31 downto 0);
        py : in std_logic_vector(31 downto 0);
        ref_gm : in std_logic_vector(31 downto 0);
        m : in std_logic_vector(31 downto 0);
        start : in std_logic_vector(0 downto 0);
        result_x : out std_logic_vector(31 downto 0);
        vout : out std_logic_vector(0 downto 0);
        cout : out std_logic_vector(7 downto 0);
        result_y : out std_logic_vector(31 downto 0);
        clk : in std_logic;
        areset : in std_logic        );
    end component;


    signal Galaxy_dut_prim_ref_px : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_valid : std_logic_vector (0 downto 0);
    signal Galaxy_dut_prim_channel : std_logic_vector (7 downto 0);
    signal Galaxy_dut_prim_px : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_ref_py : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_py : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_ref_gm : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_m : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_start : std_logic_vector (0 downto 0);
    signal Galaxy_dut_prim_result_x : std_logic_vector (31 downto 0);
    signal Galaxy_dut_prim_vout : std_logic_vector (0 downto 0);
    signal Galaxy_dut_prim_cout : std_logic_vector (7 downto 0);
    signal Galaxy_dut_prim_result_y : std_logic_vector (31 downto 0);
begin


	--GND(CONSTANT,0)

	--VCC(CONSTANT,1)

	--start_auto(GPIN,13)

	--m_auto(GPIN,4)

	--ref_gm_auto(GPIN,8)

	--py_auto(GPIN,7)

	--ref_py_auto(GPIN,10)

	--px_auto(GPIN,6)

	--c_auto(GPIN,2)

	--v_auto(GPIN,14)

	--ref_px_auto(GPIN,9)

	--Galaxy_dut_prim(BLACKBOX,5)
        Galaxy_dut_prim_ref_px <= ref_px;
        Galaxy_dut_prim_valid <= v;
        Galaxy_dut_prim_channel <= c;
        Galaxy_dut_prim_px <= px;
        Galaxy_dut_prim_ref_py <= ref_py;
        Galaxy_dut_prim_py <= py;
        Galaxy_dut_prim_ref_gm <= ref_gm;
        Galaxy_dut_prim_m <= m;
        Galaxy_dut_prim_start <= start;
    theGalaxy_dut_prim : Galaxy_dut_prim port map (
        ref_px => Galaxy_dut_prim_ref_px,
        valid => Galaxy_dut_prim_valid,
        channel => Galaxy_dut_prim_channel,
        px => Galaxy_dut_prim_px,
        ref_py => Galaxy_dut_prim_ref_py,
        py => Galaxy_dut_prim_py,
        ref_gm => Galaxy_dut_prim_ref_gm,
        m => Galaxy_dut_prim_m,
        start => Galaxy_dut_prim_start,
        result_x => Galaxy_dut_prim_result_x,
        vout => Galaxy_dut_prim_vout,
        cout => Galaxy_dut_prim_cout,
        result_y => Galaxy_dut_prim_result_y,
        clk => clk,
        areset => areset        );

	--cout_auto(GPOUT,3)
    cout <= Galaxy_dut_prim_cout;


	--result_x_auto(GPOUT,11)
    result_x <= Galaxy_dut_prim_result_x;


	--result_y_auto(GPOUT,12)
    result_y <= Galaxy_dut_prim_result_y;


	--vout_auto(GPOUT,15)
    vout <= Galaxy_dut_prim_vout;


end normal;
