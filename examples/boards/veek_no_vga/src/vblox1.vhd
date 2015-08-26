-- Aaron Severance
-- vblox1.vhd
-- Copyright 2012

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity veek is
  port(

-- CLOCK --
    CLOCK_50  : in std_logic;
    CLOCK2_50 : in std_logic;
    CLOCK3_50 : in std_logic;

-- KEY --
    KEY : in std_logic_vector(3 downto 0);

-- SW --
    SW : in std_logic_vector(17 downto 0);

-- LED --
    LEDG : out std_logic_vector(7 downto 0);
    LEDR : out std_logic_vector(17 downto 0);

-- SEG7 --
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0);
    HEX6 : out std_logic_vector(6 downto 0);
    HEX7 : out std_logic_vector(6 downto 0);

-- Audio --
    AUD_ADCDAT  : in    std_logic;
    AUD_ADCLRCK : inout std_logic;
    AUD_BCLK    : inout std_logic;
    AUD_DACDAT  : out   std_logic;
    AUD_DACLRCK : inout std_logic;
    AUD_XCK     : out   std_logic;

-- I2C for Audio and Tv-Decode  --
    I2C_SCLK : out   std_logic;
    I2C_SDAT : inout std_logic;

-- TV Decoder --
    TD_CLK27   : in  std_logic;
    TD_DATA    : in  std_logic_vector(7 downto 0);
    TD_HS      : in  std_logic;
    TD_RESET_N : out std_logic;
    TD_VS      : in  std_logic;

-- SDRAM --
    DRAM_ADDR  : out   std_logic_vector(12 downto 0);
    DRAM_BA    : out   std_logic_vector(1 downto 0);
    DRAM_CAS_N : out   std_logic;
    DRAM_CKE   : out   std_logic;
    DRAM_CLK   : out   std_logic;
    DRAM_CS_N  : out   std_logic;
    DRAM_DQ    : inout std_logic_vector(31 downto 0);
    DRAM_DQM   : out   std_logic_vector(3 downto 0);
    DRAM_RAS_N : out   std_logic;
    DRAM_WE_N  : out   std_logic;

-- SRAM --
    SRAM_ADDR : out   std_logic_vector(19 downto 0);
    SRAM_CE_N : out   std_logic;
    SRAM_DQ   : inout std_logic_vector(15 downto 0);
    SRAM_LB_N : out   std_logic;
    SRAM_OE_N : out   std_logic;
    SRAM_UB_N : out   std_logic;
    SRAM_WE_N : out   std_logic;

-- Flash --
    FL_ADDR  : out   std_logic_vector(22 downto 0);
    FL_CE_N  : out   std_logic;
    FL_DQ    : inout std_logic_vector(7 downto 0);
    FL_OE_N  : out   std_logic;
    FL_RST_N : out   std_logic;
    FL_RY    : in    std_logic;
    FL_WE_N  : out   std_logic;
    FL_WP_N  : out   std_logic;

-- GPIO --
    LTM_ADC_PENIRQ_n : in    std_logic;
    LTM_ADC_BUSY     : in    std_logic;
    LTM_ADC_DCLK     : out   std_logic;
    LTM_ADC_DIN      : out   std_logic;
    LTM_ADC_DOUT     : in    std_logic;
    LTM_B            : out   std_logic_vector(7 downto 0);
    LTM_DEN          : out   std_logic;
    LTM_G            : out   std_logic_vector(7 downto 0);
    LTM_GREST        : out   std_logic;
    LTM_HD           : out   std_logic;
    LTM_NCLK         : out   std_logic;
    LTM_R            : out   std_logic_vector(7 downto 0);
    LTM_SCEN         : out   std_logic;
    LTM_SDA          : inout std_logic;
    LTM_VD           : out   std_logic;

    LCD_B         : out   std_logic_vector(7 downto 0);
    LCD_DCLK      : out   std_logic;
    LCD_G         : out   std_logic_vector(7 downto 0);
    LCD_HSD       : out   std_logic;
    TOUCH_I2C_SCL : out   std_logic;
    TOUCH_I2C_SDA : inout std_logic;
    TOUCH_INT_n   : in    std_logic;
    LCD_R         : out   std_logic_vector(7 downto 0);
    LCD_VSD       : out   std_logic;

    LCD_DITH      : out std_logic;
    LCD_MODE      : out std_logic;
    LCD_POWER_CTL : out std_logic;
    LCD_UPDN      : out std_logic;
    LCD_RSTB      : out std_logic;
    LCD_DE        : out std_logic;
    LCD_SHLR      : out std_logic;
    LCD_DIM       : out std_logic;

--D5M
    CAMERA_LVAL    : in    std_logic;
    CAMERA_PIXCLK  : in    std_logic;
    CAMERA_RESET_N : out   std_logic;
    CAMERA_SCLK    : out   std_logic;
    CAMERA_SDATA   : inout std_logic;
    CAMERA_STROBE  : in    std_logic;
    CAMERA_TRIGGER : out   std_logic;
    CAMERA_XCLKIN  : out   std_logic;
    CAMERA_D       : in    std_logic_vector(11 downto 0);
    CAMERA_FVAL    : in    std_logic;

-- LIGHT SENSOR --
    LSENSOR_ADDR_SEL : out   std_logic;
    LSENSOR_SCL      : out   std_logic;
    LSENSOR_SDA      : inout std_logic;
    LSENSOR_INT      : in    std_logic;

-- G_Sensor --
    GSENSOR_CS_n         : out   std_logic;
    GSENSOR_INT1         : in    std_logic;
    GSENSOR_INT2         : in    std_logic;
    GSENSOR_ALT_ADDR     : out   std_logic;
    GSENSOR_SDA_SDI_SDIO : inout std_logic;
    GSENSOR_SCL_SCLK     : out   std_logic
    );

end entity;

architecture rtl of veek is
  component vblox1 is
    port (
      clk_50           : in  std_logic := 'X';  -- clk
      clk_sdram_clk    : out std_logic;         -- clk
      clk_40_clk       : out std_logic;         -- clk
      clk_25_clk       : out std_logic;         -- clk
      reset_n          : in  std_logic := 'X';  -- reset_n
      reset_25_reset_n : out std_logic;         -- reset_n
      reset_40_reset_n : out std_logic;         -- reset_n

      altpll_0_locked_conduit_export    : out std_logic;         -- export
      altpll_0_areset_conduit_export    : in  std_logic := 'X';  -- export
      altpll_0_phasedone_conduit_export : out std_logic;         -- export

      altpll_xclk_locked_conduit_export    : out std_logic;         -- export
      altpll_xclk_areset_conduit_export    : in  std_logic := 'X';  -- export
      altpll_xclk_phasedone_conduit_export : out std_logic;         -- export

      in_port_to_the_switch_pio : in  std_logic_vector(17 downto 0) := (others => 'X');  -- export
      out_port_from_the_led_pio : out std_logic_vector(7 downto 0);  -- export

      multi_touch_conduit_end_I2C_SCL : out   std_logic;         -- I2C_SCL
      multi_touch_conduit_end_I2C_SDA : inout std_logic := 'X';  -- I2C_SDA
      multi_touch_conduit_end_INT_n   : in    std_logic := 'X';  -- INT_n

      bidir_port_to_and_from_the_av_i2c_data_pio : inout std_logic := 'X';  -- export
      out_port_from_the_av_i2c_clk_pio           : out   std_logic;  -- export

      vid_clk_to_the_alt_vip_cti_0       : in  std_logic                     := 'X';  -- vid_clk
      vid_data_to_the_alt_vip_cti_0      : in  std_logic_vector(23 downto 0) := (others => 'X');  -- vid_data
      vid_datavalid_to_the_alt_vip_cti_0 : in  std_logic                     := 'X';  -- vid_datavalid
      vid_f_to_the_alt_vip_cti_0         : in  std_logic                     := 'X';  -- vid_f
      vid_h_sync_to_the_alt_vip_cti_0    : in  std_logic                     := 'X';  -- vid_h_sync
      vid_locked_to_the_alt_vip_cti_0    : in  std_logic                     := 'X';  -- vid_locked
      vid_v_sync_to_the_alt_vip_cti_0    : in  std_logic                     := 'X';  -- vid_v_sync
      overflow_from_the_alt_vip_cti_0    : out std_logic;  -- overflow

      vid_clk_to_the_alt_vip_itc_1         : in  std_logic := 'X';  -- vid_clk
      vid_data_from_the_alt_vip_itc_1      : out std_logic_vector(23 downto 0);  -- vid_data
      vid_datavalid_from_the_alt_vip_itc_1 : out std_logic;  -- vid_datavalid
      vid_h_sync_from_the_alt_vip_itc_1    : out std_logic;  -- vid_h_sync
      vid_v_sync_from_the_alt_vip_itc_1    : out std_logic;  -- vid_v_sync
      vid_f_from_the_alt_vip_itc_1         : out std_logic;  -- vid_f
      vid_h_from_the_alt_vip_itc_1         : out std_logic;  -- vid_h
      vid_v_from_the_alt_vip_itc_1         : out std_logic;  -- vid_v
      underflow_from_the_alt_vip_itc_1     : out std_logic;  -- underflow

      zs_addr_from_the_sdram      : out   std_logic_vector(12 downto 0);  -- addr
      zs_ba_from_the_sdram        : out   std_logic_vector(1 downto 0);  -- ba
      zs_cas_n_from_the_sdram     : out   std_logic;  -- cas_n
      zs_cke_from_the_sdram       : out   std_logic;  -- cke
      zs_cs_n_from_the_sdram      : out   std_logic;  -- cs_n
      zs_dq_to_and_from_the_sdram : inout std_logic_vector(31 downto 0) := (others => 'X');  -- dq
      zs_dqm_from_the_sdram       : out   std_logic_vector(3 downto 0);  -- dqm
      zs_ras_n_from_the_sdram     : out   std_logic;  -- ras_n
      zs_we_n_from_the_sdram      : out   std_logic;  -- we_n

      address_to_the_cfi_flash    : out   std_logic_vector(22 downto 0);  -- address_to_the_cfi_flash
      read_n_to_the_cfi_flash     : out   std_logic_vector(0 downto 0);  -- read_n_to_the_cfi_flash
      select_n_to_the_cfi_flash   : out   std_logic_vector(0 downto 0);  -- select_n_to_the_cfi_flash
      tri_state_bridge_flash_data : inout std_logic_vector(7 downto 0) := (others => 'X');  -- tri_state_bridge_flash_data
      write_n_to_the_cfi_flash    : out   std_logic_vector(0 downto 0);  -- write_n_to_the_cfi_flash

      out_port_from_the_td_reset_pio : out std_logic;  -- export

      audio_avalon_controller_conduit_end_CLK    : out std_logic;  -- CLK
      audio_avalon_controller_conduit_end_LRCIN  : out std_logic;  -- LRCIN
      audio_avalon_controller_conduit_end_DIN    : out std_logic;  -- DIN
      audio_avalon_controller_conduit_end_LRCOUT : out std_logic;  -- LRCOUT
      audio_avalon_controller_conduit_end_DOUT   : in  std_logic := 'X';  -- DOUT
      audio_avalon_controller_conduit_end_BCLK   : out std_logic   -- BCLK
      );
  end component vblox1;

  component Reset_Delay is
    port (
      iCLK   : in  std_logic;
      iRST   : in  std_logic;
      oRST_0 : out std_logic;
      oRST_1 : out std_logic;
      oRST_2 : out std_logic;
      oRST_3 : out std_logic;
      oRST_4 : out std_logic
      );
  end component Reset_Delay;

  component CCD2RGB is
    port (
      iPIX_CLK    : in std_logic;
      iDLY_RSTn_1 : in std_logic;
      iDLY_RSTn_2 : in std_logic;

      iAUTO_START : in std_logic;
      iD          : in std_logic_vector(11 downto 0);
      iLVAL       : in std_logic;
      iFVAL       : in std_logic;

      oPIX_PLLCLK : out    std_logic;
      osCCD_R     : out    std_logic_vector(11 downto 0);
      osCCD_G     : out    std_logic_vector(11 downto 0);
      osCCD_B     : out    std_logic_vector(11 downto 0);
      osCCD_DVAL  : out    std_logic;
      osCCD_LVAL  : out    std_logic;
      osCCD_FVAL  : out    std_logic;
      oFrame_Cont : buffer std_logic_vector(31 downto 0)
      );
  end component;

  component SEG7_LUT_8 is
    port (
      iDIG  : in  std_logic_vector(31 downto 0);
      oSEG0 : out std_logic_vector(6 downto 0);
      oSEG1 : out std_logic_vector(6 downto 0);
      oSEG2 : out std_logic_vector(6 downto 0);
      oSEG3 : out std_logic_vector(6 downto 0);
      oSEG4 : out std_logic_vector(6 downto 0);
      oSEG5 : out std_logic_vector(6 downto 0);
      oSEG6 : out std_logic_vector(6 downto 0);
      oSEG7 : out std_logic_vector(6 downto 0)
      );
  end component SEG7_LUT_8;

  component I2C_CCD_Config is
    port (
      iCLK            : in    std_logic;
      iRST_N          : in    std_logic;
      iEXPOSURE_ADJ   : in    std_logic;
      iEXPOSURE_DEC_p : in    std_logic;
      iMIRROR_SW      : in    std_logic;
      I2C_SCLK        : out   std_logic;
      I2C_SDAT        : inout std_logic
      );
  end component I2C_CCD_Config;

  signal clk_25 : std_logic;
  signal clk_40 : std_logic;

  signal LCD_DATA : std_logic_vector(23 downto 0);
  signal LCD_HS   : std_logic;
  signal LCD_VS   : std_logic;

  signal locked : std_logic;

  signal mCCD_DATA  : std_logic_vector(11 downto 0);
  signal mCCD_DVAL  : std_logic;
  signal X_Cont     : std_logic_vector(15 downto 0);
  signal Y_Cont     : std_logic_vector(15 downto 0);
  signal Frame_Cont : std_logic_vector(31 downto 0);
  signal DLY_RST_0  : std_logic;
  signal DLY_RST_1  : std_logic;
  signal DLY_RST_2  : std_logic;
  signal DLY_RST_3  : std_logic;
  signal DLY_RST_4  : std_logic;

  signal sCCD_R    : std_logic_vector(11 downto 0);
  signal sCCD_G    : std_logic_vector(11 downto 0);
  signal sCCD_B    : std_logic_vector(11 downto 0);
  signal sCCD_LVAL : std_logic;
  signal sCCD_FVAL : std_logic;
  signal sCCD_DVAL : std_logic;

  signal auto_start : std_logic;

  signal PIXPLLCLK : std_logic;

begin
  TD_RESET_N <= '0';

  LEDR <= SW;

  FL_RST_N <= '1';
  FL_WP_N  <= '1';

  CAMERA_XCLKIN <= clk_25;

  LCD_MODE      <= '0';
  LCD_DIM       <= '1';
  LCD_POWER_CTL <= '1';
  LCD_SHLR      <= '1';
  LCD_UPDN      <= '0';
  lcd_out_proc : process (clk_40)
  begin
    if rising_edge(clk_40) then
      LCD_RSTB <= locked and KEY(3);

      LCD_HSD <= not LCD_HS;
      LCD_VSD <= not LCD_VS;

      LCD_R <= LCD_DATA(23 downto 16);
      LCD_G <= LCD_DATA(15 downto 8);
      LCD_B <= LCD_DATA(7 downto 0);
    end if;
  end process lcd_out_proc;

  LCD_DCLK       <= clk_40;
  CAMERA_TRIGGER <= '1';
  CAMERA_RESET_N <= DLY_RST_1;

  --auto start when power on
  auto_start <= KEY(0) and (DLY_RST_3) and (not DLY_RST_4);


  qsys_system : component vblox1
    port map (
      clk_50           => CLOCK_50,
      clk_sdram_clk    => DRAM_CLK,
      clk_40_clk       => clk_40,
      clk_25_clk       => clk_25,
      reset_n          => '1',
      reset_25_reset_n => open,
      reset_40_reset_n => open,

      altpll_0_locked_conduit_export    => locked,
      altpll_0_areset_conduit_export    => '0',
      altpll_0_phasedone_conduit_export => open,

      altpll_xclk_locked_conduit_export    => open,
      altpll_xclk_areset_conduit_export    => '0',
      altpll_xclk_phasedone_conduit_export => open,

      -- Basic I/O
      in_port_to_the_switch_pio => SW,
      out_port_from_the_led_pio => LEDG,

      -- the_multi_touch
      multi_touch_conduit_end_I2C_SCL => TOUCH_I2C_SCL,
      multi_touch_conduit_end_I2C_SDA => TOUCH_I2C_SDA,
      multi_touch_conduit_end_INT_n   => TOUCH_INT_n,

      -- TV and Audio I2C
      bidir_port_to_and_from_the_av_i2c_data_pio => I2C_SDAT,
      out_port_from_the_av_i2c_clk_pio           => I2C_SCLK,

      -- Camera
      vid_clk_to_the_alt_vip_cti_0       => PIXPLLCLK,
      vid_data_to_the_alt_vip_cti_0      => sCCD_R(11 downto 4) & sCCD_G(11 downto 4) & sCCD_B(11 downto 4),
      vid_datavalid_to_the_alt_vip_cti_0 => sCCD_LVAL,
      vid_f_to_the_alt_vip_cti_0         => '0',
      vid_h_sync_to_the_alt_vip_cti_0    => sCCD_LVAL,
      vid_locked_to_the_alt_vip_cti_0    => DLY_RST_3,
      vid_v_sync_to_the_alt_vip_cti_0    => sCCD_FVAL,
      overflow_from_the_alt_vip_cti_0    => open,

      -- veek LCD
      vid_clk_to_the_alt_vip_itc_1         => clk_40,
      vid_data_from_the_alt_vip_itc_1      => LCD_DATA,
      vid_datavalid_from_the_alt_vip_itc_1 => open,
      vid_h_sync_from_the_alt_vip_itc_1    => LCD_HS,
      vid_v_sync_from_the_alt_vip_itc_1    => LCD_VS,
      vid_f_from_the_alt_vip_itc_1         => open,
      vid_h_from_the_alt_vip_itc_1         => open,
      vid_v_from_the_alt_vip_itc_1         => open,
      underflow_from_the_alt_vip_itc_1     => open,

      -- SDRAM
      zs_addr_from_the_sdram      => DRAM_ADDR,
      zs_ba_from_the_sdram        => DRAM_BA,
      zs_cas_n_from_the_sdram     => DRAM_CAS_N,
      zs_cke_from_the_sdram       => DRAM_CKE,
      zs_cs_n_from_the_sdram      => DRAM_CS_N,
      zs_dq_to_and_from_the_sdram => DRAM_DQ,
      zs_dqm_from_the_sdram       => DRAM_DQM,
      zs_ras_n_from_the_sdram     => DRAM_RAS_N,
      zs_we_n_from_the_sdram      => DRAM_WE_N,

      address_to_the_cfi_flash     => FL_ADDR,
      read_n_to_the_cfi_flash(0)   => FL_OE_N,
      select_n_to_the_cfi_flash(0) => FL_CE_N,
      tri_state_bridge_flash_data  => FL_DQ,
      write_n_to_the_cfi_flash(0)  => FL_WE_N,

      out_port_from_the_td_reset_pio => open,  --Don't need currently?

      audio_avalon_controller_conduit_end_CLK    => AUD_XCK,
      audio_avalon_controller_conduit_end_LRCIN  => AUD_DACLRCK,
      audio_avalon_controller_conduit_end_DIN    => AUD_DACDAT,
      audio_avalon_controller_conduit_end_LRCOUT => AUD_ADCLRCK,
      audio_avalon_controller_conduit_end_DOUT   => AUD_ADCDAT,
      audio_avalon_controller_conduit_end_BCLK   => AUD_BCLK
      );

  --reset signals
  u2 : component Reset_Delay
    port map (
      iCLK   => CLOCK2_50,
      iRST   => KEY(0),
      oRST_0 => DLY_RST_0,
      oRST_1 => DLY_RST_1,
      oRST_2 => DLY_RST_2,
      oRST_3 => DLY_RST_3,              --auto-start start point
      oRST_4 => DLY_RST_4               --auto-start end point
      );

  uCCD2RGB : component CCD2RGB
    port map (
      iPIX_CLK    => CAMERA_PIXCLK,
      iDLY_RSTn_1 => DLY_RST_1,
      iDLY_RSTn_2 => DLY_RST_2,

      iAUTO_START => auto_start,
      iD          => CAMERA_D,
      iLVAL       => CAMERA_LVAL,
      iFVAL       => CAMERA_FVAL,

      oPIX_PLLCLK => PIXPLLCLK,
      osCCD_R     => sCCD_R,
      osCCD_G     => sCCD_G,
      osCCD_B     => sCCD_B,
      osCCD_DVAL  => sCCD_DVAL,
      osCCD_LVAL  => sCCD_LVAL,
      osCCD_FVAL  => sCCD_FVAL,
      oFrame_Cont => Frame_Cont
      );

  --frame data display
  u5 : component SEG7_LUT_8
    port map (
      oSEG0 => HEX0,
      oSEG1 => HEX1,
      oSEG2 => HEX2,
      oSEG3 => HEX3,
      oSEG4 => HEX4,
      oSEG5 => HEX5,
      oSEG6 => HEX6,
      oSEG7 => HEX7,
      iDIG  => Frame_Cont(31 downto 0)
      );

  --cmos sensor configuration
  u8 : component I2C_CCD_Config
    port map (
      --      Host Side
      iCLK            => CLOCK2_50,
      iRST_N          => DLY_RST_2,
      iEXPOSURE_ADJ   => KEY(2) and KEY(3),
      iEXPOSURE_DEC_p => KEY(3),
      iMIRROR_SW      => '0',
      --      I2C Side
      I2C_SCLK        => CAMERA_SCLK,
      I2C_SDAT        => CAMERA_SDATA
      );

end rtl;
