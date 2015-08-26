-- Aaron Severance
-- fwft_fifo_reg.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.util_pkg.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

entity fwft_fifo_reg is
  generic (
    WIDTH             : integer := 32;
    DEPTH             : integer := 16;
    ALMOST_FULL_VALUE : integer := 4;
    EXTERNAL_REGISTER : boolean := false
    );
  port
    (
      clk   : in std_logic;
      reset : in std_logic;

      rdreq     : in std_logic;
      wrreq     : in std_logic;
      writedata : in std_logic_vector(WIDTH-1 downto 0);

      almost_full  : out std_logic;
      usedw        : out std_logic_vector(log2(DEPTH)-1 downto 0);
      head_invalid : out std_logic;
      empty        : out std_logic;
      full         : out std_logic;
      readdata     : out std_logic_vector(WIDTH-1 downto 0)
      );
end fwft_fifo_reg;


architecture syn of fwft_fifo_reg is
  signal head_valid        : std_logic;
  signal internal_empty    : std_logic;
  signal internal_full     : std_logic;
  signal internal_rdreq    : std_logic;
  signal internal_usedw    : std_logic_vector(log2(DEPTH)-1 downto 0);
  signal internal_one      : std_logic;
  signal internal_readdata : std_logic_vector(WIDTH-1 downto 0);
begin
  head_invalid <= not head_valid;
  usedw        <= internal_usedw;
  full         <= internal_full;

  process (clk)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if reset = '1' then
        empty      <= '1';
        head_valid <= '0';
      else
        if internal_rdreq = '1' then
          head_valid <= '1';
        elsif rdreq = '1' then
          head_valid <= '0';
          empty      <= '1';
        end if;

        if wrreq = '1' then
          empty <= '0';
        end if;
      end if;
    end if;
  end process;
  internal_rdreq <= (not internal_empty) and (rdreq or (not head_valid));

  internal_reg_gen : if EXTERNAL_REGISTER = false generate
    op_dest_fifo : scfifo
      generic map (
        add_ram_output_register => "ON",
        intended_device_family  => "Cyclone II",
        lpm_numwords            => DEPTH,
        lpm_showahead           => "OFF",
        lpm_type                => "scfifo",
        lpm_width               => WIDTH,
        lpm_widthu              => log2(DEPTH),
        overflow_checking       => "OFF",
        underflow_checking      => "OFF",
        use_eab                 => "ON"
        )
      port map (
        clock => clk,
        sclr  => reset,
        wrreq => wrreq,
        data  => writedata,
        rdreq => internal_rdreq,
        usedw => internal_usedw,
        empty => internal_empty,
        full  => internal_full,
        q     => internal_readdata
        );
    readdata <= internal_readdata;
  end generate internal_reg_gen;
  external_reg_gen : if EXTERNAL_REGISTER = true generate
    op_dest_fifo : scfifo
      generic map (
        add_ram_output_register => "ON",
        intended_device_family  => "Cyclone II",
        lpm_numwords            => DEPTH,
        lpm_showahead           => "ON",
        lpm_type                => "scfifo",
        lpm_width               => WIDTH,
        lpm_widthu              => log2(DEPTH),
        overflow_checking       => "OFF",
        underflow_checking      => "OFF",
        use_eab                 => "ON"
        )
      port map (
        clock => clk,
        sclr  => reset,
        wrreq => wrreq,
        data  => writedata,
        rdreq => internal_rdreq,
        usedw => internal_usedw,
        empty => internal_empty,
        full  => internal_full,
        q     => internal_readdata
        );
    readdata_latch : process (clk)
    begin  -- process readdata_latch
      if clk'event and clk = '1' then   -- rising clock edge
        if reset = '1' then             -- synchronous reset (active high)
          readdata <= (others => '0');
        else
          if internal_rdreq = '1' then
            readdata <= internal_readdata;
          end if;
        end if;
      end if;
    end process readdata_latch;
  end generate external_reg_gen;

  -- Conservative, could be more accurate with logic to detect read/write and
  -- deal with accordingly
  process (clk)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      if reset = '1' then
        almost_full <= '1';
      else
        if (internal_full = '1' or
            unsigned(internal_usedw) >= to_unsigned(ALMOST_FULL_VALUE-1, internal_usedw'length)) then
          almost_full <= '1';
        else
          almost_full <= '0';
        end if;
      end if;
    end if;
  end process;

end syn;
