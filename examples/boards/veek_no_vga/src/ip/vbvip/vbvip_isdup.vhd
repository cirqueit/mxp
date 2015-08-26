------------------------------------------------------------------------
--! @author Wing-Chi Chow
--! @copyright (c) 2012 VectorBlox Computing Inc.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library altera_mf;
use altera_mf.altera_mf_components.all;


------------------------------------------------------------------------
--! Duplicate video stream.
--
--! Create 2 video streams from 1.
------------------------------------------------------------------------
entity vbvip_isdup is
    generic (
        DEFAULT_DIN_HSIZE   : natural := 800;                           --! Horizontal video size
        DEFAULT_DIN_VSIZE   : natural := 600;                           --! Vertical video size
        DEFAULT_BPP         : natural :=  24                            --! Bits-per-pixel
    );
    port (
        iCLK        : in      std_logic;                                --! Clock
        iRST        : in      std_logic;                                --! Reset

        -- video input data and control
        oDIN_READY  : buffer  std_logic;                                --! Ready to receive source video
        iDIN_VALID  : in      std_logic;                                --! Source video valid
        iDIN_DATA   : in      std_logic_vector(DEFAULT_BPP-1 downto 0); --! Source video data
        iDIN_SOP    : in      std_logic;                                --! Source video start-of-packet
        iDIN_EOP    : in      std_logic;                                --! Source video end-of-packet

        -- video output-0 data and control
        iDOUT0_READY: in      std_logic;                                --! Sink-0 ready to receive video
        oDOUT0_VALID: out     std_logic;                                --! Sink-0 video valid
        oDOUT0_DATA : out     std_logic_vector(DEFAULT_BPP-1 downto 0); --! Sink-0 video data
        oDOUT0_SOP  : out     std_logic;                                --! Sink-0 video start-of-packet
        oDOUT0_EOP  : out     std_logic;                                --! Sink-0 video end-of-packet

        -- video output-1 data and control
        iDOUT1_READY: in      std_logic;                                --! Sink-1 ready to receive video
        oDOUT1_VALID: out     std_logic;                                --! Sink-1 video valid
        oDOUT1_DATA : out     std_logic_vector(DEFAULT_BPP-1 downto 0); --! Sink-1 video data
        oDOUT1_SOP  : out     std_logic;                                --! Sink-1 video start-of-packet
        oDOUT1_EOP  : out     std_logic                                 --! Sink-1 video end-of-packet
    );
end entity;


------------------------------------------------------------------------
--! RTL description
------------------------------------------------------------------------
architecture rtl of vbvip_isdup is
begin
    oDIN_READY   <= iDOUT0_READY and iDOUT1_READY;
    oDOUT0_VALID <= iDIN_VALID;
    oDOUT0_DATA  <= iDIN_DATA;
    oDOUT0_SOP   <= iDIN_SOP;
    oDOUT0_EOP   <= iDIN_EOP;
    oDOUT1_VALID <= iDIN_VALID;
    oDOUT1_DATA  <= iDIN_DATA;
    oDOUT1_SOP   <= iDIN_SOP;
    oDOUT1_EOP   <= iDIN_EOP;
end rtl;
