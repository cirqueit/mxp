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
use std.TextIO.all;
USE work.Galaxy_dut_safe_path.all;

-- Text written from /build/swbuild/SJ/nightly/13.0sp1/232/l64/p4/ip/aion/src/mip_common/hw_model.cpp:3299
entity Galaxy_dut_stm is
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
end;

architecture normal of Galaxy_dut_stm is

-- Text written from /build/swbuild/SJ/nightly/13.0sp1/232/l64/p4/ip/aion/src/mip_common/hw_model.cpp:3308
    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal clk_c_auto_stm_sig_stop : std_logic := '0';
    signal clk_cout_auto_stm_sig_stop : std_logic := '0';
    signal clk_m_auto_stm_sig_stop : std_logic := '0';
    signal clk_px_auto_stm_sig_stop : std_logic := '0';
    signal clk_py_auto_stm_sig_stop : std_logic := '0';
    signal clk_ref_gm_auto_stm_sig_stop : std_logic := '0';
    signal clk_ref_px_auto_stm_sig_stop : std_logic := '0';
    signal clk_ref_py_auto_stm_sig_stop : std_logic := '0';
    signal clk_result_x_auto_stm_sig_stop : std_logic := '0';
    signal clk_result_y_auto_stm_sig_stop : std_logic := '0';
    signal clk_start_auto_stm_sig_stop : std_logic := '0';
    signal clk_v_auto_stm_sig_stop : std_logic := '0';
    signal clk_vout_auto_stm_sig_stop : std_logic := '0';

    function str_to_stdvec(inp: string) return std_logic_vector is
        variable temp: std_logic_vector(inp'range) := (others => 'X');
    begin
        for i in inp'range loop
            if (inp(i) = '1') then
                temp(i) := '1';
            elsif (inp(i) = '0') then
                temp(i) := '0';
            end if;
        end loop;
        return temp;
    end function str_to_stdvec;

begin
    clk <= clk_stm_sig;
    clk_process: process 
    begin
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 2300 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 2300 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            wait;
        end if;
    end process;

    areset <= areset_stm_sig;
    areset_process: process begin
        areset_stm_sig <= '1';
        wait for 3750 ps;
        areset_stm_sig <= '0';
        wait;
    end process;

    --Generating stimulus for c_auto
    c_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable channel_int_0 : Integer;
        variable channel_temp : std_logic_vector(7 downto 0);

    begin
        -- initialize all outputs to 0
        c_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to c_auto)
            if endfile(data_file_ChannelIn) then
                clk_c_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, channel_int_0);
                channel_temp(7 downto 0) := std_logic_vector(to_unsigned(channel_int_0, 8));
                c_stm <= channel_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for cout_auto
    cout_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelOut : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelOut.stm");
        variable cout_int_0 : Integer;
        variable cout_temp : std_logic_vector(7 downto 0);

    begin
        -- initialize all outputs to 0
        cout_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to cout_auto)
            if endfile(data_file_ChannelOut) then
                clk_cout_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelOut, L);

                read(L, dummy_int);
                read(L, cout_int_0);
                cout_temp(7 downto 0) := std_logic_vector(to_unsigned(cout_int_0, 8));
                cout_stm <= cout_temp;
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for m_auto
    m_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable m_int_0 : Integer;
        variable m_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        m_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to m_auto)
            if endfile(data_file_ChannelIn) then
                clk_m_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, m_int_0);
                m_temp(31 downto 0) := std_logic_vector(to_signed(m_int_0, 32));
                m_stm <= m_temp;
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for px_auto
    px_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable px_int_0 : Integer;
        variable px_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        px_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to px_auto)
            if endfile(data_file_ChannelIn) then
                clk_px_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, px_int_0);
                px_temp(31 downto 0) := std_logic_vector(to_signed(px_int_0, 32));
                px_stm <= px_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for py_auto
    py_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable py_int_0 : Integer;
        variable py_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        py_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to py_auto)
            if endfile(data_file_ChannelIn) then
                clk_py_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, py_int_0);
                py_temp(31 downto 0) := std_logic_vector(to_signed(py_int_0, 32));
                py_stm <= py_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for ref_gm_auto
    ref_gm_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable ref_gm_int_0 : Integer;
        variable ref_gm_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        ref_gm_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to ref_gm_auto)
            if endfile(data_file_ChannelIn) then
                clk_ref_gm_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, ref_gm_int_0);
                ref_gm_temp(31 downto 0) := std_logic_vector(to_signed(ref_gm_int_0, 32));
                ref_gm_stm <= ref_gm_temp;
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for ref_px_auto
    ref_px_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable ref_px_int_0 : Integer;
        variable ref_px_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        ref_px_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to ref_px_auto)
            if endfile(data_file_ChannelIn) then
                clk_ref_px_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, ref_px_int_0);
                ref_px_temp(31 downto 0) := std_logic_vector(to_signed(ref_px_int_0, 32));
                ref_px_stm <= ref_px_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for ref_py_auto
    ref_py_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable ref_py_int_0 : Integer;
        variable ref_py_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        ref_py_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to ref_py_auto)
            if endfile(data_file_ChannelIn) then
                clk_ref_py_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, ref_py_int_0);
                ref_py_temp(31 downto 0) := std_logic_vector(to_signed(ref_py_int_0, 32));
                ref_py_stm <= ref_py_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for result_x_auto
    result_x_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelOut : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelOut.stm");
        variable result_x_int_0 : Integer;
        variable result_x_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        result_x_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to result_x_auto)
            if endfile(data_file_ChannelOut) then
                clk_result_x_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelOut, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, result_x_int_0);
                result_x_temp(31 downto 0) := std_logic_vector(to_signed(result_x_int_0, 32));
                result_x_stm <= result_x_temp;
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for result_y_auto
    result_y_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelOut : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelOut.stm");
        variable result_y_int_0 : Integer;
        variable result_y_temp : std_logic_vector(31 downto 0);

    begin
        -- initialize all outputs to 0
        result_y_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to result_y_auto)
            if endfile(data_file_ChannelOut) then
                clk_result_y_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelOut, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, result_y_int_0);
                result_y_temp(31 downto 0) := std_logic_vector(to_signed(result_y_int_0, 32));
                result_y_stm <= result_y_temp;

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for start_auto
    start_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable start_int_0 : Integer;
        variable start_temp : std_logic_vector(0 downto 0);

    begin
        -- initialize all outputs to 0
        start_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to start_auto)
            if endfile(data_file_ChannelIn) then
                clk_start_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, start_int_0);
                start_temp(0 downto 0) := std_logic_vector(to_unsigned(start_int_0, 1));
                start_stm <= start_temp;

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for v_auto
    v_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelIn : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelIn.stm");
        variable valid_int_0 : Integer;
        variable valid_temp : std_logic_vector(0 downto 0);

    begin
        -- initialize all outputs to 0
        v_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to v_auto)
            if endfile(data_file_ChannelIn) then
                clk_v_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelIn, L);

                read(L, valid_int_0);
                valid_temp(0 downto 0) := std_logic_vector(to_unsigned(valid_int_0, 1));
                v_stm <= valid_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;

    --Generating stimulus for vout_auto
    vout_auto_stm_init_p: process

        variable L : line;
        variable dummy_int : Integer;

        file data_file_ChannelOut : text open read_mode is safe_path("Galaxy/dut/prim/Galaxy_dut_prim_ChannelOut.stm");
        variable vout_int_0 : Integer;
        variable vout_temp : std_logic_vector(0 downto 0);

    begin
        -- initialize all outputs to 0
        vout_stm <= (others => '0');

        wait for 201 ps; -- wait delay

        while true loop

            --(ports connected to vout_auto)
            if endfile(data_file_ChannelOut) then
                clk_vout_auto_stm_sig_stop <= '1';
                wait;
            else
                readline(data_file_ChannelOut, L);

                read(L, vout_int_0);
                vout_temp(0 downto 0) := std_logic_vector(to_unsigned(vout_int_0, 1));
                vout_stm <= vout_temp;
                read(L, dummy_int);
                read(L, dummy_int);
                read(L, dummy_int);

                deallocate(L);
            end if;

            -- wait for rising edge to pass (assert signals just after rising edge)
            wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
            wait for 1 ps; -- wait delay

        end loop;

        wait;
    end process;


    clk_stm_sig_stop <= clk_c_auto_stm_sig_stop OR clk_cout_auto_stm_sig_stop OR clk_m_auto_stm_sig_stop OR clk_px_auto_stm_sig_stop OR clk_py_auto_stm_sig_stop OR clk_ref_gm_auto_stm_sig_stop OR clk_ref_px_auto_stm_sig_stop OR clk_ref_py_auto_stm_sig_stop OR clk_result_x_auto_stm_sig_stop OR clk_result_y_auto_stm_sig_stop OR clk_start_auto_stm_sig_stop OR clk_v_auto_stm_sig_stop OR clk_vout_auto_stm_sig_stop OR '0';

end;
