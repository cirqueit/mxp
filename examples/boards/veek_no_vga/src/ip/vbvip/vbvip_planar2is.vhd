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
--! Convert planar video to Avalon.
--
--! Convert 24-bit planar video stream to Avalon streaming video.
------------------------------------------------------------------------
entity vbvip_planar2is is
  generic (
--      USE_FIXED_SIZES         : bit     := '1';
--      HSYNCS_ARE_NEG          : bit     := '1';
--      VSYNCS_ARE_NEG          : bit     := '1';
    DEFAULT_HSIZE           : natural := 800;  --! Horizontal video size
    DEFAULT_VSIZE           : natural := 600;  --! Vertical video size
    DEFAULT_BPP             : natural := 24;   --! Bits-per-pixel
    DEFAULT_FIFO_DEPTH_POW2 : natural := 10  --! FIFO-depth = 2^DEFAULT_FIFO_DEPTH_POW2
    );
  port (
    iRST : in std_logic;                --! Reset

    -- planar video input
    iVID_CLK       : in std_logic;      --! Source video clock
    iVID_DATAVALID : in std_logic;      --! Source video valid
    iVID_LOCKED    : in std_logic;      --! Source video locked
    iVID_H_SYNC    : in std_logic;      --! Source video horizontal sync
    iVID_V_SYNC    : in std_logic;      --! Source video vertical sync
    iVID_F         : in std_logic;      --! Source video field
    iVID_DATA      : in std_logic_vector(DEFAULT_BPP-1 downto 0);  --! Source video data

    -- avalon video stream output
    iIS_CLK   : in     std_logic;       --! Sink clock
    iIS_READY : in     std_logic;       --! Sink ready to receive data
    oIS_VALID : buffer std_logic;       --! Sink data valid
    oIS_SOP   : buffer std_logic;       --! Sink start-of-packet
    oIS_EOP   : buffer std_logic;       --! Sink end-of-packet
    oIS_DATA  : buffer std_logic_vector(DEFAULT_BPP-1 downto 0);  --! Sink data

    -- error output
    oOVERFLOW : out std_logic           --! FIFO overflow
    );
end entity;


------------------------------------------------------------------------
--! RTL description
------------------------------------------------------------------------
architecture rtl of vbvip_planar2is is
  constant RESET_SYNC_STAGES : positive := 2;

-- bit constants (Quartus bug work-around)
  constant USE_FIXED_SIZES : bit := '1';
  constant HSYNCS_ARE_NEG  : bit := '1';
  constant VSYNCS_ARE_NEG  : bit := '1';

-- re-flopped video inputs
  signal VID_DATAVALID_reflopped : std_logic;
  signal VID_LOCKED_reflopped    : std_logic;
  signal VID_H_SYNC_reflopped    : std_logic;
  signal VID_V_SYNC_reflopped    : std_logic;
  signal VID_F_reflopped         : std_logic;
  signal VID_DATA_reflopped      : std_logic_vector(DEFAULT_BPP-1 downto 0);

-- internal video inputs
  signal VID_DATAVALID : std_logic;
  signal VID_LOCKED    : std_logic;
  signal VID_H_SYNC    : std_logic;
  signal VID_V_SYNC    : std_logic;
  signal VID_F         : std_logic;
  signal VID_DATA      : std_logic_vector(DEFAULT_BPP-1 downto 0);

-- video reset signal
  signal VID_RST : std_logic_vector(RESET_SYNC_STAGES downto 0);

-- FIFO write control and data
  signal WR_REQ  : std_logic;
  signal WR_FULL : std_logic;
  signal WR_DATA : std_logic_vector(DEFAULT_BPP-1 downto 0);
  signal WR_SOP  : std_logic;
  signal WR_EOP  : std_logic;

-- FIFO read control and data
  signal RD_CLK   : std_logic;
  signal RD_RST   : std_logic;
  signal RD_RDY   : std_logic;
  signal RD_EMPTY : std_logic;
  signal RD_REQ   : std_logic;
  signal RD_ACK   : std_logic;
  signal RD_DATA  : std_logic_vector(DEFAULT_BPP-1 downto 0);
  signal RD_SOP   : std_logic;
  signal RD_EOP   : std_logic;

  signal WR_OVFLW  : std_logic;
  signal FIFO_CLR  : std_logic;
  signal FIFO_DATA : std_logic_vector(DEFAULT_BPP+1 downto 0);
  signal FIFO_Q    : std_logic_vector(DEFAULT_BPP+1 downto 0);
  signal EARLY_EOP : std_logic;

  signal HSIZE     : unsigned(15 downto 0);
  signal VSIZE     : unsigned(15 downto 0);
  signal PIX_TOTAL : unsigned(HSIZE'length+VSIZE'length-1 downto 0);
  signal PIX_COUNT : unsigned(HSIZE'length+VSIZE'length-1 downto 0);

  signal VID_V_SYNC_falling : std_logic;

--type STATE_t is (
--    IDLE,
--    CONTROL_HEADER, CONTROL_1, CONTROL_2, CONTROL_3,
--    SPACER,
--    VIDEO_HEADER, VIDEO_DATA, VIDEO_EOP
--);
--signal STATE, STATE_nxt:      STATE_t;


begin

  --------------------------------------------------------------------
  -- sizes
  --------------------------------------------------------------------
  HSIZE     <= to_unsigned(DEFAULT_HSIZE, HSIZE'length);
  VSIZE     <= to_unsigned(DEFAULT_VSIZE, VSIZE'length);
  PIX_TOTAL <= HSIZE * VSIZE;


  --------------------------------------------------------------------
  -- create VID_RST (iVID_CLK reset)
  --------------------------------------------------------------------
  VID_RST(0) <= iRST;
  vid_rst_reflop : process (iVID_CLK)
  begin  -- process vid_rst_reflop
    if rising_edge(iVID_CLK) then       -- rising clock edge
      VID_RST(RESET_SYNC_STAGES downto 1) <= VID_RST(RESET_SYNC_STAGES-1 downto 0);
    end if;
  end process vid_rst_reflop;


  --------------------------------------------------------------------
  -- re-flop video inputs
  --------------------------------------------------------------------
  proc_reflop_vidin : process (iVID_CLK)
  begin
    if rising_edge(iVID_CLK) then
      if (VID_RST(RESET_SYNC_STAGES) = '1') then
        VID_DATAVALID_reflopped <= '0';
        VID_LOCKED_reflopped    <= '0';
        VID_H_SYNC_reflopped    <= '0';
        VID_V_SYNC_reflopped    <= '0';
        VID_F_reflopped         <= '0';
      else
        VID_DATAVALID_reflopped <= iVID_DATAVALID;
        VID_LOCKED_reflopped    <= iVID_LOCKED;
        VID_H_SYNC_reflopped    <= iVID_H_SYNC xor to_stdulogic(HSYNCS_ARE_NEG);
        VID_V_SYNC_reflopped    <= iVID_V_SYNC xor to_stdulogic(VSYNCS_ARE_NEG);
        VID_F_reflopped         <= iVID_F;
      end if;
    end if;
  end process proc_reflop_vidin;


  proc_reflop_viddata : process (iVID_CLK)
  begin
    if rising_edge(iVID_CLK) then
      VID_DATA_reflopped <= iVID_DATA;
    end if;
  end process proc_reflop_viddata;


  --------------------------------------------------------------------
  -- re-flop video inputs again (no need to apply reset)
  --------------------------------------------------------------------
  proc_reflop_vidin2 : process (iVID_CLK)
  begin
    if rising_edge(iVID_CLK) then
      VID_DATAVALID <= VID_DATAVALID_reflopped;
      VID_LOCKED    <= VID_LOCKED_reflopped;
      VID_H_SYNC    <= VID_H_SYNC_reflopped;
      VID_V_SYNC    <= VID_V_SYNC_reflopped;
      VID_F         <= VID_F_reflopped;
      VID_DATA      <= VID_DATA_reflopped;
    end if;
  end process proc_reflop_vidin2;


  -- falling vsync edge
  VID_V_SYNC_falling <= not VID_V_SYNC_reflopped and VID_V_SYNC;


  --------------------------------------------------------------------
  -- internal read inputs
  --------------------------------------------------------------------
  RD_CLK <= iIS_CLK;
  RD_RST <= iRST;
  RD_RDY <= iIS_READY;


  --------------------------------------------------------------------
  -- dual clock FIFO
  --------------------------------------------------------------------
  uFIFO : dcfifo
    generic map (
--          add_ram_output_register     => ,
--          add_usedw_msb_bit           => ,
      clocks_are_synchronized => "FALSE",
--          delay_rdusedw               => ,
--          delay_wrusedw               => ,
--          intended_device_family      => ,
      lpm_numwords            => 2**DEFAULT_FIFO_DEPTH_POW2,
      lpm_showahead           => "OFF",
      lpm_width               => WR_DATA'length+2,
      lpm_widthu              => DEFAULT_FIFO_DEPTH_POW2,
      overflow_checking       => "OFF",
      rdsync_delaypipe        => 5,
      read_aclr_synch         => "ON",
      underflow_checking      => "OFF",
      use_eab                 => "ON",
--      write_aclr_synch        => "ON",
      wrsync_delaypipe        => 5,
      lpm_hint                => "MAXIMIZE_SPEED=7",
      lpm_type                => "dcfifo"
      )
    port map (
      aclr    => FIFO_CLR,
      data    => FIFO_DATA,
      q       => FIFO_Q,
      rdclk   => RD_CLK,
      rdempty => RD_EMPTY,
      rdfull  => open,
      rdreq   => RD_REQ,
      rdusedw => open,
      wrclk   => iVID_CLK,
      wrempty => open,
      wrfull  => WR_FULL,
      wrreq   => WR_REQ,
      wrusedw => open
      );
  FIFO_DATA(DEFAULT_BPP+1)          <= WR_SOP;
  FIFO_DATA(DEFAULT_BPP)            <= WR_EOP;
  FIFO_DATA(DEFAULT_BPP-1 downto 0) <= WR_DATA;
  RD_SOP                            <= FIFO_Q(DEFAULT_BPP+1);
  RD_EOP                            <= FIFO_Q(DEFAULT_BPP);
  RD_DATA                           <= FIFO_Q(DEFAULT_BPP-1 downto 0);


  --------------------------------------------------------------------
  -- Create start of packets and end of packets
  --------------------------------------------------------------------
  proc_create_sop_eop : process (iVID_CLK)
  begin
    if rising_edge(iVID_CLK) then
      if (VID_RST(RESET_SYNC_STAGES) = '1') then
        WR_SOP <= '0';
        WR_EOP <= '0';
      else
        WR_SOP <= VID_LOCKED and VID_V_SYNC_falling;

        if ((PIX_COUNT = 1) and ((VID_DATAVALID and VID_LOCKED) = '1')) or (EARLY_EOP = '1') then
          WR_EOP <= '1';
        else
          WR_EOP <= '0';
        end if;
      end if;
    end if;
  end process proc_create_sop_eop;

  EARLY_EOP <= '1' when ((VID_LOCKED = '0') or (VID_V_SYNC = '1')) and (PIX_COUNT /= 0) else
               '0';


  --------------------------------------------------------------------
  -- FIFO write control
  --------------------------------------------------------------------
  proc_fifo_write : process (iVID_CLK)
  begin
    if rising_edge(iVID_CLK) then
      if (VID_RST(RESET_SYNC_STAGES) = '1') then
        WR_REQ   <= '0';
        WR_OVFLW <= '0';
        WR_DATA  <= (others => '0');
      else
        if (VID_V_SYNC = '1') then
          WR_OVFLW <= '0';
        end if;

        if ((VID_LOCKED and VID_V_SYNC_falling) = '1') then  -- sop
          WR_REQ  <= '1';
          WR_DATA <= (others => '0');
        elsif (((VID_DATAVALID and VID_LOCKED) = '1') or (EARLY_EOP = '1'))
          and (WR_OVFLW = '0')
          and (PIX_COUNT /= 0) then
          if (WR_FULL = '1') then
            WR_REQ   <= '0';
            WR_OVFLW <= '1';
          else
            WR_REQ  <= '1';
            WR_DATA <= VID_DATA;
          end if;
        else
          WR_REQ <= '0';
        end if;
      end if;
    end if;
  end process proc_fifo_write;

  oOVERFLOW <= WR_OVFLW;


  --------------------------------------------------------------------
  -- FIFO clear
  --------------------------------------------------------------------
--  proc_fifo_clear: process (iVID_CLK)
--  begin
--      if rising_edge(iVID_CLK) then
  FIFO_CLR <= VID_RST(RESET_SYNC_STAGES) or WR_OVFLW;
--      end if;
--  end process proc_fifo_clear;


  --------------------------------------------------------------------
  -- write counters
  --------------------------------------------------------------------
  proc_counters : process (iVID_CLK)
  begin
    if rising_edge(iVID_CLK) then
      if (VID_RST(RESET_SYNC_STAGES) = '1') then
        PIX_COUNT <= (others => '0');
      else
        
        if (VID_V_SYNC_falling = '1') then
          PIX_COUNT <= PIX_TOTAL;
        elsif (EARLY_EOP = '1') then
          PIX_COUNT <= (others => '0');
        elsif ((VID_DATAVALID and VID_LOCKED) = '1') and (PIX_COUNT /= 0) then
          PIX_COUNT <= PIX_COUNT - 1;
        end if;
      end if;
    end if;
  end process proc_counters;


  --------------------------------------------------------------------
  -- FIFO read request
  --------------------------------------------------------------------
  RD_REQ <= (not RD_EMPTY) and RD_RDY;

  --------------------------------------------------------------------
  -- Streaming data output and control
  --------------------------------------------------------------------
  oIS_SOP  <= RD_SOP;
  oIS_EOP  <= RD_EOP;
  oIS_DATA <= RD_DATA;

  proc_stoutput : process (RD_CLK)
  begin
    if rising_edge(RD_CLK) then
      if (RD_RST = '1') then
        oIS_VALID <= '0';
      else
        oIS_VALID <= RD_REQ;
      end if;
    end if;
  end process proc_stoutput;

end rtl;
