-- quad_read_ram_behav.vhd
-- Copyright (C) 2015 VectorBlox Computing, Inc.
--
-- Behavioural implementation of 4 read 2 write RAM by double clocking a 2 read
-- 1 write RAM.  Data comes out after 2 clock cycles of the 1x clock.
--
-- Note for timing that inputs are registered after only one 2x clock cycle

-- synthesis library vci_configurable_lut_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.vci_configurable_lut_util_pkg.all;

entity quad_read_ram is
  generic (
    RAM_WIDTH                : positive := 16;
    RAM_DEPTH                : positive := 1024;
    BRAM_ADDRESS_WIDTH_LIMIT : positive := 32
    );
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    clk_2x          : in  std_logic;
    write_address_a : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    address_a       : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    address_b       : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    write_address_c : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    address_c       : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    address_d       : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
    writedata_a     : in  std_logic_vector(RAM_WIDTH-1 downto 0);
    writedata_c     : in  std_logic_vector(RAM_WIDTH-1 downto 0);
    wren_a          : in  std_logic;
    wren_c          : in  std_logic;
    readdata_a      : out std_logic_vector(RAM_WIDTH-1 downto 0);
    readdata_b      : out std_logic_vector(RAM_WIDTH-1 downto 0);
    readdata_c      : out std_logic_vector(RAM_WIDTH-1 downto 0);
    readdata_d      : out std_logic_vector(RAM_WIDTH-1 downto 0)
    );
end quad_read_ram;


architecture rtl of quad_read_ram is
  component dual_read_ram
    generic (
      RAM_WIDTH        : positive := 16;
      RAM_DEPTH        : positive := 1024;
      REGISTER_OUTPUTS : boolean  := false
      );
    port (
      clk         : in  std_logic;
      address_a   : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
      address_b   : in  unsigned(log2(RAM_DEPTH)-1 downto 0);
      writedata_a : in  std_logic_vector(RAM_WIDTH-1 downto 0);
      wren_a      : in  std_logic;
      readdata_a  : out std_logic_vector(RAM_WIDTH-1 downto 0);
      readdata_b  : out std_logic_vector(RAM_WIDTH-1 downto 0)
      );
  end component;

  function imin(
    constant M : integer;
    constant N : integer)
    return integer is
  begin
    if M < N then
      return M;
    end if;
    return N;
  end imin;

  constant ADDRESS_BITS : positive := log2(RAM_DEPTH);

  --Manually create and mux BRAMs of this depth
  constant BRAM_DEPTH_BITS  : positive := imin(ADDRESS_BITS, BRAM_ADDRESS_WIDTH_LIMIT);
  constant BRAM_DEPTH       : positive := imin(RAM_DEPTH, 2**BRAM_DEPTH_BITS);
  constant BRAMS            : positive := (RAM_DEPTH+(BRAM_DEPTH-1))/BRAM_DEPTH;
  constant BRAM_SELECT_BITS : natural  := ADDRESS_BITS-BRAM_DEPTH_BITS;

  signal address_a_2x : unsigned(BRAM_DEPTH_BITS-1 downto 0);
  signal address_b_2x : unsigned(BRAM_DEPTH_BITS-1 downto 0);
  signal writedata_2x : std_logic_vector(RAM_WIDTH-1 downto 0);
  signal wren_2x      : std_logic_vector(BRAMS-1 downto 0);

  type   ram_data_array is array (natural range <>) of std_logic_vector(RAM_WIDTH-1 downto 0);
  signal out_a_2x_d1 : ram_data_array(BRAMS-1 downto 0);
  signal out_b_2x_d1 : ram_data_array(BRAMS-1 downto 0);
  signal out_a_2x_d2 : ram_data_array(BRAMS-1 downto 0);
  signal out_b_2x_d2 : ram_data_array(BRAMS-1 downto 0);

  signal readdata_a_array : ram_data_array(BRAMS-1 downto 0);
  signal readdata_b_array : ram_data_array(BRAMS-1 downto 0);
  signal readdata_c_array : ram_data_array(BRAMS-1 downto 0);
  signal readdata_d_array : ram_data_array(BRAMS-1 downto 0);

  signal toggler        : std_logic;
  signal toggler_d2x    : std_logic;
  signal firstcycle     : std_logic;
  signal secondcycle    : std_logic;
  signal firstcycle_dn1 : std_logic;
begin

  --Signals to find first, second cycle of 2x clock
  process (clk)
  begin  -- process
    if clk'event and clk = '1' then        -- rising clock edge
      toggler <= not toggler;
      if reset = '1' then                  -- synchronous reset (active high)
        toggler <= '0';
      end if;
    end if;
  end process;
  process (clk_2x)
  begin  -- process
    if clk_2x'event and clk_2x = '1' then  -- rising clock edge
      toggler_d2x    <= toggler;
      firstcycle_dn1 <= not (toggler_d2x xor toggler);
      secondcycle    <= firstcycle_dn1;
      firstcycle     <= secondcycle;
      if reset = '1' then
        firstcycle_dn1 <= '0';
        secondcycle    <= '0';
        firstcycle     <= '0';
      end if;
    end if;
  end process;


  --Register the inputs on the 2x clock
  process (clk_2x)
  begin  -- process
    if clk_2x'event and clk_2x = '1' then  -- rising clock edge
      if firstcycle = '0' then
        address_a_2x <= address_a(BRAM_DEPTH_BITS-1 downto 0);
        writedata_2x <= writedata_a;
        address_b_2x <= address_b(BRAM_DEPTH_BITS-1 downto 0);
      else
        address_a_2x <= address_c(BRAM_DEPTH_BITS-1 downto 0);
        writedata_2x <= writedata_c;
        address_b_2x <= address_d(BRAM_DEPTH_BITS-1 downto 0);
      end if;
    end if;
  end process;

  --Extra delay stage for retiming data onto 1x clock
  process (clk_2x)
  begin
    if clk_2x'event and clk_2x = '1' then
      out_a_2x_d2 <= out_a_2x_d1;
      out_b_2x_d2 <= out_b_2x_d1;
    end if;
  end process;

  --If inputs aren't registered, data a/b are valid on the 2nd 2x cycle and
  --data c/d are valid on the 3rd 2x cycle.  We need to latch the data at the
  --end of the 4th 2x cycle, so grab c/d delayed by 1 2x cycle and grab a/b
  --delayed by 2 2x cycles.
  process (clk)
  begin  -- process
    if clk'event and clk = '1' then     -- rising clock edge
      readdata_a_array <= out_a_2x_d2;
      readdata_b_array <= out_b_2x_d2;
      readdata_c_array <= out_a_2x_d1;
      readdata_d_array <= out_b_2x_d1;
    end if;
  end process;

  single_bram_gen : if BRAMS = 1 generate
    --Only one BRAM, write enable always applies
    process (clk_2x)
    begin  -- process
      if clk_2x'event and clk_2x = '1' then  -- rising clock edge
        if firstcycle = '0' then
          wren_2x(0) <= wren_a;
        else
          wren_2x(0) <= wren_c;
        end if;
      end if;
    end process;

    --Ram output directly
    readdata_a <= readdata_a_array(0);
    readdata_b <= readdata_b_array(0);
    readdata_c <= readdata_c_array(0);
    readdata_d <= readdata_d_array(0);
  end generate single_bram_gen;

  multiple_brams_gen : if BRAMS > 1 generate
    signal bram_a_sel_2x_dn1 : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_b_sel_2x_dn1 : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_a_sel_2x     : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_b_sel_2x     : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_a_sel_2x_d1  : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_b_sel_2x_d1  : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_a_sel_2x_d2  : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_b_sel_2x_d2  : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_a_sel     : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_b_sel     : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_c_sel     : unsigned(BRAM_SELECT_BITS-1 downto 0);
    signal bram_d_sel     : unsigned(BRAM_SELECT_BITS-1 downto 0);
  begin
    --Register signals to mux between BRAMs
    process (clk_2x)
    begin  -- process
      if clk_2x'event and clk_2x = '1' then  -- rising clock edge
        if firstcycle = '0' then
          bram_a_sel_2x_dn1 <= address_a(ADDRESS_BITS-1 downto BRAM_DEPTH_BITS);
          bram_b_sel_2x_dn1 <= address_b(ADDRESS_BITS-1 downto BRAM_DEPTH_BITS);
        else
          bram_a_sel_2x_dn1 <= address_c(ADDRESS_BITS-1 downto BRAM_DEPTH_BITS);
          bram_b_sel_2x_dn1 <= address_d(ADDRESS_BITS-1 downto BRAM_DEPTH_BITS);
        end if;

        bram_a_sel_2x    <= bram_a_sel_2x_dn1;
        bram_b_sel_2x    <= bram_b_sel_2x_dn1;
        bram_a_sel_2x_d1 <= bram_a_sel_2x;
        bram_b_sel_2x_d1 <= bram_b_sel_2x;
        bram_a_sel_2x_d2 <= bram_a_sel_2x_d1;
        bram_b_sel_2x_d2 <= bram_b_sel_2x_d1;
      end if;
    end process;

    process (clk)
    begin  -- process
      if clk'event and clk = '1' then   -- rising clock edge
        bram_a_sel <= bram_a_sel_2x_d2;
        bram_b_sel <= bram_b_sel_2x_d2;
        bram_c_sel <= bram_a_sel_2x_d1;
        bram_d_sel <= bram_b_sel_2x_d1;
      end if;
    end process;

    bram_control_gen : for gram in BRAMS-1 downto 0 generate
      --For each BRAM decode write enable
      process (clk_2x)
      begin  -- process
        if clk_2x'event and clk_2x = '1' then  -- rising clock edge
          if firstcycle = '0' then
            if write_address_a(ADDRESS_BITS-1 downto BRAM_DEPTH_BITS) = to_unsigned(gram, BRAM_SELECT_BITS) then
              wren_2x(gram) <= wren_a;
            else
              wren_2x(gram) <= '0';
            end if;
          else
            if write_address_c(ADDRESS_BITS-1 downto BRAM_DEPTH_BITS) = to_unsigned(gram, BRAM_SELECT_BITS) then
              wren_2x(gram) <= wren_c;
            else
              wren_2x(gram) <= '0';
            end if;
          end if;
        end if;
      end process;
    end generate bram_control_gen;

    --Ram output MUX'ed
    readdata_a <= readdata_a_array(to_integer(bram_a_sel));
    readdata_b <= readdata_b_array(to_integer(bram_b_sel));
    readdata_c <= readdata_c_array(to_integer(bram_c_sel));
    readdata_d <= readdata_d_array(to_integer(bram_d_sel));
  end generate multiple_brams_gen;


  bram_gen : for gram in BRAMS-1 downto 0 generate
    the_ram : dual_read_ram
      generic map (
        RAM_WIDTH        => RAM_WIDTH,
        RAM_DEPTH        => BRAM_DEPTH,
        REGISTER_OUTPUTS => true
        )
      port map (
        clk         => clk_2x,
        address_a   => address_a_2x,
        address_b   => address_b_2x,
        writedata_a => writedata_2x,
        wren_a      => wren_2x(gram),
        readdata_a  => out_a_2x_d1(gram),
        readdata_b  => out_b_2x_d1(gram)
        );
  end generate bram_gen;

end rtl;
