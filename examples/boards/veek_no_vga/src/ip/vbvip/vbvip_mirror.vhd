------------------------------------------------------------------------
--! @author Wing-Chi Chow
--! @copyright (c) 2013 VectorBlox Computing Inc.
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

library altera_mf;
use altera_mf.altera_mf_components.all;


------------------------------------------------------------------------
--! Mirror video stream.
------------------------------------------------------------------------
entity vbvip_mirror is
  generic (
    DEFAULT_BPP       : natural := 24;   --! Bits-per-pixel
    DEFAULT_FIFO_SIZE : natural := 2048  --! FIFO size (should be power of 2)
    );
  port (
    iCLK : in std_logic;                 --! Clock
    iRST : in std_logic;                 --! Reset

    -- register control bit(s)
    iREG_MIRROR : in std_logic;         --! Mirror control register bit

    -- video input data and control
    iVIN_DVALID : in std_logic;         --! Video input valid
    iVIN_LOCKED : in std_logic;         --! Video input locked
    iVIN_HSYNC  : in std_logic;         --! Video input hsync
    iVIN_VSYNC  : in std_logic;         --! Video input vsync
    iVIN_FIELD  : in std_logic;  --! Video input interlaced field (unused for progressive inputs)
    iVIN_DATA   : in std_logic_vector(DEFAULT_BPP-1 downto 0);  --! Video input data

    -- video input data and control
    oVOUT_DVALID : buffer std_logic;    --! Video input valid
    oVOUT_LOCKED : buffer std_logic;    --! Video input locked
    oVOUT_HSYNC  : buffer std_logic;    --! Video input hsync
    oVOUT_VSYNC  : buffer std_logic;    --! Video input vsync
    oVOUT_FIELD  : buffer std_logic;  --! Video input interlaced field (unused for progressive inputs)
    oVOUT_DATA   : buffer std_logic_vector(DEFAULT_BPP-1 downto 0)  --! Video input data
    );
end entity;


------------------------------------------------------------------------
--! RTL description
------------------------------------------------------------------------
architecture rtl of vbvip_mirror is

  component vbvip_mirror_ram
    port
      (
        aclr      : in  std_logic := '0';
        clock     : in  std_logic := '1';
        data      : in  std_logic_vector (23 downto 0);
        rdaddress : in  std_logic_vector (10 downto 0);
        wraddress : in  std_logic_vector (10 downto 0);
        wren      : in  std_logic := '0';
        q         : out std_logic_vector (23 downto 0)
        );
  end component;

  signal REG_MIRROR_d1 : std_logic;
  signal REG_MIRROR_d2 : std_logic;
  signal REG_MIRROR_VS : std_logic;

  signal VIN_DVALID_d1 : std_logic;
  signal VIN_LOCKED_d1 : std_logic;
  signal VIN_HSYNC_d1  : std_logic;
  signal VIN_VSYNC_d1  : std_logic;
  signal VIN_FIELD_d1  : std_logic;
  signal VIN_DATA_d1   : std_logic_vector(DEFAULT_BPP-1 downto 0);

  signal VIN_HSYNC_d2 : std_logic;
  signal VIN_VSYNC_d2 : std_logic;

  signal FIRST_LINE : boolean;
  signal BLANKING   : boolean;
  signal DECR_ADDR  : boolean;
  signal ADDR       : std_logic_vector(10 downto 0);
  signal VMIR_DATA  : std_logic_vector(DEFAULT_BPP-1 downto 0);
  signal VMIR_WREN  : std_logic;

begin

  proc_reflop_vin : process(iCLK)
  begin
    if rising_edge(iCLK) then
      if (iRST = '1') then
        VIN_HSYNC_d2 <= '0';
        VIN_VSYNC_d2 <= '0';

        VIN_DVALID_d1 <= '0';
        VIN_LOCKED_d1 <= '0';
        VIN_HSYNC_d1  <= '0';
        VIN_VSYNC_d1  <= '0';
        VIN_FIELD_d1  <= '0';
        VIN_DATA_d1   <= (others => '0');
      else
        VIN_HSYNC_d2 <= VIN_HSYNC_d1;
        VIN_VSYNC_d2 <= VIN_VSYNC_d1;

        VIN_DVALID_d1 <= iVIN_DVALID;
        VIN_LOCKED_d1 <= iVIN_LOCKED;
        VIN_HSYNC_d1  <= iVIN_HSYNC;
        VIN_VSYNC_d1  <= iVIN_VSYNC;
        VIN_FIELD_d1  <= iVIN_FIELD;
        VIN_DATA_d1   <= iVIN_DATA;
      end if;
    end if;
  end process proc_reflop_vin;


  proc_debounce_reg_mirror : process(iCLK)
  begin
    if rising_edge(iCLK) then
      if (iRST = '1') then
        REG_MIRROR_d2 <= '0';
        REG_MIRROR_d1 <= '0';
        REG_MIRROR_VS <= '0';
      else
        REG_MIRROR_d2 <= REG_MIRROR_d1;
        REG_MIRROR_d1 <= iREG_MIRROR;

        if (VIN_VSYNC_d1 = '1') then
          REG_MIRROR_VS <= REG_MIRROR_d2;
        end if;
      end if;
    end if;
  end process proc_debounce_reg_mirror;



  proc_output : process(iCLK)
  begin
    if rising_edge(iCLK) then
      if (iRST = '1') then
        oVOUT_DVALID <= '0';
        oVOUT_LOCKED <= '0';
        oVOUT_HSYNC  <= '0';
        oVOUT_VSYNC  <= '0';
        oVOUT_FIELD  <= '0';
        oVOUT_DATA   <= (others => '0');
      else
        oVOUT_DVALID <= VIN_DVALID_d1;
        oVOUT_LOCKED <= VIN_LOCKED_d1;
        oVOUT_HSYNC  <= VIN_HSYNC_d1;
        oVOUT_VSYNC  <= VIN_VSYNC_d1;
        oVOUT_FIELD  <= VIN_FIELD_d1;

        if (REG_MIRROR_VS = '1') then
          if (FIRST_LINE) then
            oVOUT_DATA <= (others => '0');
          else
            oVOUT_DATA <= VMIR_DATA;
          end if;
        else
          oVOUT_DATA <= VIN_DATA_d1;
        end if;
      end if;
    end if;
  end process proc_output;


  proc_addr : process(iCLK)
  begin
    if rising_edge(iCLK) then
      if (iRST = '1') then
        FIRST_LINE <= true;
        BLANKING   <= true;
        DECR_ADDR  <= false;
        ADDR       <= (others => '0');
      else
        if (VIN_VSYNC_d1 = '1') and (VIN_VSYNC_d2 = '0') then  -- rising vsync edge
          FIRST_LINE <= true;
          BLANKING   <= true;
        else
          if (VIN_DVALID_d1 = '1') then
            BLANKING <= false;
          end if;

          if (VIN_HSYNC_d1 = '1') and (VIN_HSYNC_d2 = '0') and (not BLANKING) then  -- rising hsync edge after valid data
            FIRST_LINE <= false;
          end if;
        end if;

        if (VIN_HSYNC_d1 = '1') and (VIN_HSYNC_d2 = '0') then  -- rising hsync edge
          DECR_ADDR <= not DECR_ADDR;
        end if;

        if (VIN_DVALID_d1 = '1') and (iVIN_DVALID = '1') then
          if (DECR_ADDR) then
            ADDR <= unsigned(ADDR) - 1;
          else
            ADDR <= unsigned(ADDR) + 1;
          end if;
        end if;
      end if;
    end if;
  end process proc_addr;


  VMIR_WREN <= VIN_DVALID_d1 and VIN_LOCKED_d1;
  vbvip_mirror_ram_inst : vbvip_mirror_ram
    port map (
      clock => iCLK,
      aclr  => iRST,

      wraddress => ADDR,
      wren      => VMIR_WREN,
      data      => VIN_DATA_d1,

      rdaddress => ADDR,
      q         => VMIR_DATA
      );

end rtl;
