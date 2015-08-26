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


-- Text written from /build/swbuild/SJ/nightly/13.0sp1/232/l64/p4/ip/aion/src/mip_common/hw_model.cpp:3107
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity Galaxy_dut_atb is
end;

architecture normal of Galaxy_dut_atb is

component Galaxy_dut is
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
end component;

component Galaxy_dut_stm is
    port (
         c_stm : out std_logic_vector(7 downto 0);
         cout_stm : out std_logic_vector(7 downto 0);
         m_stm : out std_logic_vector(31 downto 0);
         px_stm : out std_logic_vector(31 downto 0);
         py_stm : out std_logic_vector(31 downto 0);
         ref_gm_stm : out std_logic_vector(31 downto 0);
         ref_px_stm : out std_logic_vector(31 downto 0);
         ref_py_stm : out std_logic_vector(31 downto 0);
         result_x_stm : out std_logic_vector(31 downto 0);
         result_y_stm : out std_logic_vector(31 downto 0);
         start_stm : out std_logic_vector(0 downto 0);
         v_stm : out std_logic_vector(0 downto 0);
         vout_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end component;

    signal c_stm : std_logic_vector(7 downto 0);
    signal cout_stm : std_logic_vector(7 downto 0);
    signal m_stm : std_logic_vector(31 downto 0);
    signal px_stm : std_logic_vector(31 downto 0);
    signal py_stm : std_logic_vector(31 downto 0);
    signal ref_gm_stm : std_logic_vector(31 downto 0);
    signal ref_px_stm : std_logic_vector(31 downto 0);
    signal ref_py_stm : std_logic_vector(31 downto 0);
    signal result_x_stm : std_logic_vector(31 downto 0);
    signal result_y_stm : std_logic_vector(31 downto 0);
    signal start_stm : std_logic_vector(0 downto 0);
    signal v_stm : std_logic_vector(0 downto 0);
    signal vout_stm : std_logic_vector(0 downto 0);
    signal c : std_logic_vector(7 downto 0);
    signal cout : std_logic_vector(7 downto 0);
    signal m : std_logic_vector(31 downto 0);
    signal px : std_logic_vector(31 downto 0);
    signal py : std_logic_vector(31 downto 0);
    signal ref_gm : std_logic_vector(31 downto 0);
    signal ref_px : std_logic_vector(31 downto 0);
    signal ref_py : std_logic_vector(31 downto 0);
    signal result_x : std_logic_vector(31 downto 0);
    signal result_y : std_logic_vector(31 downto 0);
    signal start : std_logic_vector(0 downto 0);
    signal v : std_logic_vector(0 downto 0);
    signal vout : std_logic_vector(0 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;

begin

-- General Purpose data in real output
checkc_auto : process (clk, areset, c, c_stm)
begin
end process;


-- General Purpose data out check
checkcout_auto : process (clk, areset)
    variable mismatch_cout : BOOLEAN := FALSE;
    variable ok : BOOLEAN := TRUE;
begin
    IF (areset = '1') THEN 
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_cout := FALSE;
        if (cout /= cout_stm) and vout = "1" then
            mismatch_cout := TRUE;
            report "Mismatch on device output pin cout" severity Warning;
        end if;
        if mismatch_cout then
            ok := FALSE;
        end if;
        assert (ok)
        report "mismatch in device level signal." severity Failure;
    end if;
end process;


-- General Purpose data in real output
checkm_auto : process (clk, areset, m, m_stm)
begin
end process;


-- General Purpose data in real output
checkpx_auto : process (clk, areset, px, px_stm)
begin
end process;


-- General Purpose data in real output
checkpy_auto : process (clk, areset, py, py_stm)
begin
end process;


-- General Purpose data in real output
checkref_gm_auto : process (clk, areset, ref_gm, ref_gm_stm)
begin
end process;


-- General Purpose data in real output
checkref_px_auto : process (clk, areset, ref_px, ref_px_stm)
begin
end process;


-- General Purpose data in real output
checkref_py_auto : process (clk, areset, ref_py, ref_py_stm)
begin
end process;


-- General Purpose data out check
checkresult_x_auto : process (clk, areset)
    variable mismatch_result_x : BOOLEAN := FALSE;
    variable ok : BOOLEAN := TRUE;
begin
    IF (areset = '1') THEN 
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_result_x := FALSE;
        if (result_x /= result_x_stm) and vout = "1" then
            mismatch_result_x := TRUE;
            report "Mismatch on device output pin result_x" severity Warning;
        end if;
        if mismatch_result_x then
            ok := FALSE;
        end if;
        assert (ok)
        report "mismatch in device level signal." severity Failure;
    end if;
end process;


-- General Purpose data out check
checkresult_y_auto : process (clk, areset)
    variable mismatch_result_y : BOOLEAN := FALSE;
    variable ok : BOOLEAN := TRUE;
begin
    IF (areset = '1') THEN 
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_result_y := FALSE;
        if (result_y /= result_y_stm) and vout = "1" then
            mismatch_result_y := TRUE;
            report "Mismatch on device output pin result_y" severity Warning;
        end if;
        if mismatch_result_y then
            ok := FALSE;
        end if;
        assert (ok)
        report "mismatch in device level signal." severity Failure;
    end if;
end process;


-- General Purpose data in real output
checkstart_auto : process (clk, areset, start, start_stm)
begin
end process;


-- General Purpose data in real output
checkv_auto : process (clk, areset, v, v_stm)
begin
end process;


-- General Purpose data out check
checkvout_auto : process (clk, areset)
    variable mismatch_vout : BOOLEAN := FALSE;
    variable ok : BOOLEAN := TRUE;
begin
    IF (areset = '1') THEN 
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_vout := FALSE;
        if (vout /= vout_stm) then
            mismatch_vout := TRUE;
            report "Mismatch on device output pin vout" severity Warning;
        end if;
        if mismatch_vout then
            ok := FALSE;
        end if;
        assert (ok)
        report "mismatch in device level signal." severity Failure;
    end if;
end process;


dut : Galaxy_dut port map (
         c_stm,
         cout,
         m_stm,
         px_stm,
         py_stm,
         ref_gm_stm,
         ref_px_stm,
         ref_py_stm,
         result_x,
         result_y,
         start_stm,
         v_stm,
         vout,
        clk,
        areset
        );

sim : Galaxy_dut_stm port map (
         c_stm,
         cout_stm,
         m_stm,
         px_stm,
         py_stm,
         ref_gm_stm,
         ref_px_stm,
         ref_py_stm,
         result_x_stm,
         result_y_stm,
         start_stm,
         v_stm,
         vout_stm,
        clk,
        areset
     );

end normal;
