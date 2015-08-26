------------------------------------------------------------------------
-- Author: Wing-Chi Chow
-- Copyright (c) 2012 VectorBlox Computing Inc.
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


------------------------------------------------------------------------
-- Convert raw CCD input to 24-bit RGB.
------------------------------------------------------------------------
entity CCD2RGB is
    port (
        iPIX_CLK        : in     std_logic;
        iDLY_RSTn_1     : in     std_logic;
        iDLY_RSTn_2     : in     std_logic;

        iAUTO_START     : in     std_logic;
        iD              : in     std_logic_vector(11 downto 0);
        iLVAL           : in     std_logic;
        iFVAL           : in     std_logic;

        oPIX_PLLCLK     : out    std_logic;
        osCCD_R         : out    std_logic_vector(11 downto 0);
        osCCD_G         : out    std_logic_vector(11 downto 0);
        osCCD_B         : out    std_logic_vector(11 downto 0);
        osCCD_DVAL      : out    std_logic;
        osCCD_LVAL      : out    std_logic;
        osCCD_FVAL      : out    std_logic;
        oFrame_Cont     : buffer std_logic_vector(31 downto 0)
    );
end entity;


------------------------------------------------------------------------
------------------------------------------------------------------------
architecture rtl of CCD2RGB is

    component pixclk_pll
        port (
            inclk0  : in  std_logic;
            c0      : out std_logic 
        );
    end component;

    component CCD_Capture is
        port (
            iCLK        : in  std_logic;
            iRST        : in  std_logic;
            iDATA       : in  std_logic_vector(11 downto 0);
            iLVAL       : in  std_logic;
            iFVAL       : in  std_logic;
            iSTART      : in  std_logic;
            iEND        : in  std_logic;
            oDATA       : out std_logic_vector(11 downto 0);
            oDVAL       : out std_logic;
            oX_Cont     : out std_logic_vector(15 downto 0);
            oY_Cont     : out std_logic_vector(15 downto 0);
            oFrame_Cont : out std_logic_vector(31 downto 0)
        );
    end component CCD_Capture;

    component RAW2RGB is
        port (
            iCLK    : in  std_logic;
            iRST_n  : in  std_logic;
            iData   : in  std_logic_vector(11 downto 0);
            iDval   : in  std_logic;
            iMIRROR : in  std_logic;
            iX_Cont : in  std_logic_vector(15 downto 0);
            iY_Cont : in  std_logic_vector(15 downto 0);
            oRed    : out std_logic_vector(11 downto 0);
            oGreen  : out std_logic_vector(11 downto 0);
            oBlue   : out std_logic_vector(11 downto 0);
            oDval   : out std_logic
        );
    end component RAW2RGB;


    signal PIX_PLLCLK   : std_logic;

    -- inputs re-flopped with iPIX_CLK
    signal D_d1         : std_logic_vector(11 downto 0);
    signal LVAL_d1      : std_logic;
    signal FVAL_d1      : std_logic;

    -- inputs re-flopped with PIX_PLLCLK
    signal rCCD_DATA    : std_logic_vector(11 downto 0);
    signal rCCD_LVAL    : std_logic;
    signal rCCD_FVAL    : std_logic;
    signal rCCD_LVAL_d1 : std_logic;
    signal rCCD_FVAL_d1 : std_logic;

    signal mCCD_DATA    : std_logic_vector(11 downto 0);
    signal mCCD_DVAL    : std_logic;

    signal X_Cont       : std_logic_vector(15 downto 0);
    signal Y_Cont       : std_logic_vector(15 downto 0);

begin

    -- re-flop inputs to iPIX_CLK
    process (iPIX_CLK)
    begin
        if rising_edge(iPIX_CLK) then
            D_d1    <= iD;
            LVAL_d1 <= iLVAL;
            FVAL_d1 <= iFVAL;
        end if;
    end process;


    -- re-flop inputs again, this time to PIX_PLLCLK
    process (PIX_PLLCLK)
    begin
        if rising_edge(PIX_PLLCLK) then
            rCCD_DATA <= D_d1;
            rCCD_LVAL <= LVAL_d1;
            rCCD_FVAL <= FVAL_d1;
        end if;
    end process;


    -- clean-up iPIX_CLK with PLL
    upixclk_pll: component pixclk_pll
        port map (
            inclk0  => iPIX_CLK,
            c0      => PIX_PLLCLK
        );
    oPIX_PLLCLK <= PIX_PLLCLK;


    -- CMOS/CCD sensor capture
    uCCD_Capture : component CCD_Capture
        port map (
            iCLK        => PIX_PLLCLK,
            iRST        => iDLY_RSTn_2,
            iDATA       => rCCD_DATA,
            iLVAL       => rCCD_LVAL,
            iFVAL       => rCCD_FVAL,
            iSTART      => iAUTO_START,
            iEND        => '0',
            oDATA       => mCCD_DATA,
            oDVAL       => mCCD_DVAL,
            oX_Cont     => X_Cont,
            oY_Cont     => Y_Cont,
            oFrame_Cont => oFrame_Cont
        );


    -- raw data to RGB conversion
    uRAW2RGB : component RAW2RGB
        port map (
            iCLK    => PIX_PLLCLK,
            iRST_n  => iDLY_RSTn_1,
            iData   => mCCD_DATA,
            iDval   => mCCD_DVAL,
            iMIRROR => '0',
            iX_Cont => X_Cont,
            iY_Cont => Y_Cont,
            oRed    => osCCD_R,
            oGreen  => osCCD_G,
            oBlue   => osCCD_B,
            oDval   => osCCD_DVAL
        );


    -- LVAL and FVAL delays to match pixel processing delays
    process (PIX_PLLCLK)
    begin
        if rising_edge(PIX_PLLCLK) then
            osCCD_LVAL <= rCCD_LVAL_d1;
            osCCD_FVAL <= rCCD_FVAL_d1;

            rCCD_LVAL_d1 <= rCCD_LVAL;
            rCCD_FVAL_d1 <= rCCD_FVAL;
        end if;
    end process;

end rtl;
