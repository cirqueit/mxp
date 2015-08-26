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

-- VHDL created from Galaxy_dut_prim
-- VHDL created on Thu Sep 12 13:44:37 2013


-- Text written from /build/swbuild/SJ/nightly/13.0sp1/232/l64/p4/ip/aion/src/mip_common/hw_model.cpp:3107
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity Galaxy_dut_prim_atb is
end;

architecture normal of Galaxy_dut_prim_atb is

component Galaxy_dut_prim is
    port (
        valid : in std_logic_vector(0 downto 0);
        channel : in std_logic_vector(7 downto 0);
        ref_px : in std_logic_vector(31 downto 0);
        px : in std_logic_vector(31 downto 0);
        ref_py : in std_logic_vector(31 downto 0);
        py : in std_logic_vector(31 downto 0);
        ref_gm : in std_logic_vector(31 downto 0);
        m : in std_logic_vector(31 downto 0);
        start : in std_logic_vector(0 downto 0);
        vout : out std_logic_vector(0 downto 0);
        cout : out std_logic_vector(7 downto 0);
        result_x : out std_logic_vector(31 downto 0);
        result_y : out std_logic_vector(31 downto 0);
        clk : in std_logic;
        areset : in std_logic
        );
end component;

component Galaxy_dut_prim_stm is
    port (
         valid_stm : out std_logic_vector(0 downto 0);
         channel_stm : out std_logic_vector(7 downto 0);
         ref_px_stm : out std_logic_vector(31 downto 0);
         px_stm : out std_logic_vector(31 downto 0);
         ref_py_stm : out std_logic_vector(31 downto 0);
         py_stm : out std_logic_vector(31 downto 0);
         ref_gm_stm : out std_logic_vector(31 downto 0);
         m_stm : out std_logic_vector(31 downto 0);
         start_stm : out std_logic_vector(0 downto 0);
         vout_stm : out std_logic_vector(0 downto 0);
         cout_stm : out std_logic_vector(7 downto 0);
         result_x_stm : out std_logic_vector(31 downto 0);
         result_y_stm : out std_logic_vector(31 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end component;

    signal valid_stm : std_logic_vector(0 downto 0);
    signal channel_stm : std_logic_vector(7 downto 0);
    signal ref_px_stm : std_logic_vector(31 downto 0);
    signal px_stm : std_logic_vector(31 downto 0);
    signal ref_py_stm : std_logic_vector(31 downto 0);
    signal py_stm : std_logic_vector(31 downto 0);
    signal ref_gm_stm : std_logic_vector(31 downto 0);
    signal m_stm : std_logic_vector(31 downto 0);
    signal start_stm : std_logic_vector(0 downto 0);
    signal vout_stm : std_logic_vector(0 downto 0);
    signal cout_stm : std_logic_vector(7 downto 0);
    signal result_x_stm : std_logic_vector(31 downto 0);
    signal result_y_stm : std_logic_vector(31 downto 0);
    signal valid : std_logic_vector(0 downto 0);
    signal channel : std_logic_vector(7 downto 0);
    signal ref_px : std_logic_vector(31 downto 0);
    signal px : std_logic_vector(31 downto 0);
    signal ref_py : std_logic_vector(31 downto 0);
    signal py : std_logic_vector(31 downto 0);
    signal ref_gm : std_logic_vector(31 downto 0);
    signal m : std_logic_vector(31 downto 0);
    signal start : std_logic_vector(0 downto 0);
    signal vout : std_logic_vector(0 downto 0);
    signal cout : std_logic_vector(7 downto 0);
    signal result_x : std_logic_vector(31 downto 0);
    signal result_y : std_logic_vector(31 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;

begin

-- Channelized data in real output
checkChannelIn : process (clk, areset, ref_px, ref_px_stm, px, px_stm, ref_py, ref_py_stm, py, py_stm, ref_gm, ref_gm_stm, m, m_stm, start, start_stm)
begin
end process;


-- Channelized data out check
checkChannelOut : process (clk, areset, result_x, result_x_stm, result_y, result_y_stm)
    variable mismatch_vout : BOOLEAN := FALSE;
    variable mismatch_cout : BOOLEAN := FALSE;
    variable mismatch_result_x : BOOLEAN := FALSE;
    variable mismatch_result_y : BOOLEAN := FALSE;
    variable ok : BOOLEAN := TRUE;
begin
    IF (areset = '1') THEN 
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_vout := FALSE;
        mismatch_cout := FALSE;
        mismatch_result_x := FALSE;
        mismatch_result_y := FALSE;
        if (vout /= vout_stm) then
            mismatch_vout := TRUE;
            report "mismatch in vout signal" severity Failure;
        end if;
        if (vout = "1") then
            if (cout /= cout_stm) then
                mismatch_cout := TRUE;
                report "mismatch in cout signal" severity Warning;
            end if;
            if (result_x /= result_x_stm) then
                mismatch_result_x := TRUE;
                report "mismatch in result_x signal" severity Warning;
            end if;
            if (result_y /= result_y_stm) then
                mismatch_result_y := TRUE;
                report "mismatch in result_y signal" severity Warning;
            end if;
        end if;
        if (mismatch_vout = TRUE or mismatch_cout = TRUE or mismatch_result_x = TRUE or mismatch_result_y = TRUE) then
            ok := FALSE;
        end if;
        if (ok = FALSE) then
            report "Mismatch detected" severity Failure;
        end if;
    end if;
end process;


dut : Galaxy_dut_prim port map (
         valid_stm,
         channel_stm,
         ref_px_stm,
         px_stm,
         ref_py_stm,
         py_stm,
         ref_gm_stm,
         m_stm,
         start_stm,
         vout,
         cout,
         result_x,
         result_y,
        clk,
        areset
        );

sim : Galaxy_dut_prim_stm port map (
         valid_stm,
         channel_stm,
         ref_px_stm,
         px_stm,
         ref_py_stm,
         py_stm,
         ref_gm_stm,
         m_stm,
         start_stm,
         vout_stm,
         cout_stm,
         result_x_stm,
         result_y_stm,
        clk,
        areset
     );

end normal;
