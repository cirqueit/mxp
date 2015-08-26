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
--! Clip video stream.
--
--! Actual behaviour is a simple pass-through.
------------------------------------------------------------------------
entity vbvip_clip is
    generic (
        DEFAULT_DIN_HSIZE   : natural := 800;                           --! Horizontal video size
        DEFAULT_DIN_VSIZE   : natural := 600;                           --! Vertical video size
        DEFAULT_BPP         : natural :=  24                            --! Bits-per-pixel
    );
    port (
        iCLK        : in      std_logic;                                --! Clock
        iRST        : in      std_logic;                                --! Reset

        -- video input data and control
        oDIN_READY  : out     std_logic;                                --! Ready to receive source video
        iDIN_VALID  : in      std_logic;                                --! Source video valid
        iDIN_DATA   : in      std_logic_vector(DEFAULT_BPP-1 downto 0); --! Source video data
        iDIN_SOP    : in      std_logic;                                --! Source video start-of-packet
        iDIN_EOP    : in      std_logic;                                --! Source video end-of-packet

        -- video output data and control
        iDOUT_READY : in      std_logic;                                --! Sink ready to receive video
        oDOUT_VALID : out     std_logic;                                --! Sink video valid
        oDOUT_DATA  : out     std_logic_vector(DEFAULT_BPP-1 downto 0); --! Sink video data
        oDOUT_SOP   : out     std_logic;                                --! Sink video start-of-packet
        oDOUT_EOP   : out     std_logic                                 --! Sink video end-of-packet
    );
end entity;


------------------------------------------------------------------------
--! RTL description
------------------------------------------------------------------------
architecture rtl of vbvip_clip is
begin
    oDIN_READY  <= iDOUT_READY;
    oDOUT_VALID <= iDIN_VALID;
    oDOUT_SOP   <= iDIN_SOP;
    oDOUT_EOP   <= iDIN_EOP;
    oDOUT_DATA  <= iDIN_DATA;
end rtl;
