-- vci_configurable_lut.vhd
-- Copyright (C) 2015 VectorBlox Computing, Inc.

-------------------------------------------------------------------------------
-- This is a look-up-table (LUT) custom instruction.  The data width is
-- configurable by the DATA_WIDTH_BITS generic; if between 1 and 8 bits it
-- operates as a BYTE wide vector instruction, between 9 and 16 bits as
-- HALFWORD wide, and 17 to 31 as WORD wide.  If not 8/16/32-bits wide, the
-- unused (MSBs) will be set to 0.
-- 
-- Addressing is in two parts, BASE and OFFSET.  The BASE value is shifted to
-- be able to address the entire LUT if the LUT address range is larger than
-- the operand size, and then added to the OFFSET to form the LUT address.
-- Specifically, if ceiling(log2(LUT_DEPTH)) > (OPERAND_SIZE_BYTES*8) then BASE
-- is shifted by (ceiling(log2(LUT_DEPTH)) - (OPERAND_SIZE_BYTES*8)), else BASE
-- is shifted by 0.
--
-- This enables using multiple LUTs with the same instruction; a
-- scalar value (operand A) selects the LUT, while the vector value (operand B)
-- indexes into the LUT.  For instance, a LUT_DEPTH of 512 with
-- OPERAND_SIZE_BYTES of 8 could be used to store two 256 entry LUTs.  The BASE
-- address would be shifted by 1 (log2(512)-8), so to index the first LUT a scalar
-- value of 0x00 would give a base address of 0, while to index the second LUT
-- a scalar of 0x80 would give a base address of 256 (0x80<<1).
-- 
-- Data is read with function 0, written with function 1.  During a write, the
-- data to be written placed on operand A, and the BASE is taken from element 0
-- of the last read operation.  The OFFSET and data to be written for all lanes
-- is taken from element 0 of the input vector.  So, for example, to write
-- 0x1234 to BASE 0x100 and OFFSET 17 of a halfword (OPERAND_SIZE_BYTES=2) LUT
-- with this VCI set to VCUSTOM0, the following sequence of operations are
-- required:
-- Read BASE 0x100 (signed VCI with operand A set to the BASE) to set BASE
--   vbx(SVHS, VCUSTOM0, NULL, 0x100, NULL);
-- Move the OFFSET to be written into a temporary vector
--   vbx(SVH, VMOV, v_temp, 17, NULL);
-- Write data (unsigned VCI with operand A as write data, operand B as OFFSET)
--   vbx(SVHU, VCUSTOM0, NULL, 0x1234, v_temp);
-------------------------------------------------------------------------------


-- synthesis library vci_configurable_lut_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.vci_configurable_lut_util_pkg.all;

entity vci_configurable_lut is
  generic (
    VCI_LANES                : positive               := 2;
    OPERAND_SIZE_BYTES       : positive range 1 to 4  := 2;
    DATA_WIDTH_BITS          : positive range 1 to 32 := 16;
    LUT_DEPTH                : positive               := 2**17;
    DOUBLE_CLOCKED           : natural range 0 to 1   := 0;
    BRAM_ADDRESS_WIDTH_LIMIT : positive range 8 to 32 := 32
    );
  port (
    vci_clk_2x : in std_logic;

    vci_clk   : in std_logic;
    vci_reset : in std_logic;

    vci_valid  : in std_logic_vector(1 downto 0);
    vci_signed : in std_logic;
    vci_opsize : in std_logic_vector(1 downto 0);

    vci_vector_start : in std_logic;
    vci_vector_end   : in std_logic;
    vci_byte_valid   : in std_logic_vector((VCI_LANES*4)-1 downto 0);

    vci_data_a : in std_logic_vector((VCI_LANES*32)-1 downto 0);
    vci_flag_a : in std_logic_vector((VCI_LANES*4)-1 downto 0);
    vci_data_b : in std_logic_vector((VCI_LANES*32)-1 downto 0);
    vci_flag_b : in std_logic_vector((VCI_LANES*4)-1 downto 0);

    vci_data_out   : out std_logic_vector((VCI_LANES*32)-1 downto 0);
    vci_flag_out   : out std_logic_vector((VCI_LANES*4)-1 downto 0);
    vci_byteenable : out std_logic_vector((VCI_LANES*4)-1 downto 0)
    );
end;

architecture rtl of vci_configurable_lut is
  --All MXP custom instructions have a 3 stage pipeline
  constant VCI_STAGES : positive := 3;

  constant OPERAND_SIZE_BITS : positive := 8*OPERAND_SIZE_BYTES;
  constant VCI_ELEMENTS      : positive := (VCI_LANES*4)/OPERAND_SIZE_BYTES;

  constant PORTS_PER_RAM : positive := 2*(DOUBLE_CLOCKED+1);
  constant RAMS_NEEDED   : positive := (VCI_ELEMENTS+(PORTS_PER_RAM-1))/PORTS_PER_RAM;
  constant RAM_PORTS     : positive := PORTS_PER_RAM*RAMS_NEEDED;

  constant ADDRESS_WIDTH : positive := log2(LUT_DEPTH);
  constant BASE_SHIFT    : natural  := imax(0, ADDRESS_WIDTH-OPERAND_SIZE_BITS);

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

  component quad_read_ram
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
  end component;

  type   address_vector is array (natural range <>) of unsigned(ADDRESS_WIDTH-1 downto 0);
  signal address       : address_vector(RAM_PORTS-1 downto 0);
  signal read_address  : address_vector(RAM_PORTS-1 downto 0);
  signal offset        : address_vector(RAM_PORTS-1 downto 0);
  signal read_base     : address_vector(RAM_PORTS-1 downto 0);
  type   data_vector is array (natural range <>) of std_logic_vector(DATA_WIDTH_BITS-1 downto 0);
  signal readdata      : data_vector(RAM_PORTS-1 downto 0);
  signal readdata_flat : std_logic_vector((VCI_LANES*32)-1 downto 0);

  signal vci_read     : std_logic;
  signal vci_write    : std_logic;
  signal write_enable : std_logic;
  signal write_base   : unsigned(ADDRESS_WIDTH-1 downto 0);
  signal writedata    : std_logic_vector(DATA_WIDTH_BITS-1 downto 0);

  --Shift registers used to delay signals by the appropriate number of stages
  type   byteena_out_shifter_type is array (natural range <>) of std_logic_vector((VCI_LANES*4)-1 downto 0);
  signal byteena_out_shifter : byteena_out_shifter_type(VCI_STAGES-1 downto 0);

  signal base_in   : std_logic_vector((VCI_LANES*32)-1 downto 0);
  signal offset_in : std_logic_vector((VCI_LANES*32)-1 downto 0);
begin
  --Rename to make code more readable
  vci_read  <= vci_valid(0);
  vci_write <= vci_valid(1);

  --Pad and flatten readdata
  element_gen : for gelement in RAM_PORTS-1 downto 0 generate
    valid_port_gen : if gelement < VCI_ELEMENTS generate
      read_base(gelement) <=
        resize(unsigned(base_in(((gelement+1)*OPERAND_SIZE_BITS)-1 downto gelement*OPERAND_SIZE_BITS)), ADDRESS_WIDTH) sll BASE_SHIFT;
      offset(gelement) <=
        resize(unsigned(offset_in(((gelement+1)*OPERAND_SIZE_BITS)-1 downto gelement*OPERAND_SIZE_BITS)), ADDRESS_WIDTH);
      read_address(gelement) <= read_base(gelement) + offset(gelement);

      element_pad_gen : if OPERAND_SIZE_BITS > DATA_WIDTH_BITS generate
        readdata_flat((gelement*OPERAND_SIZE_BITS)+OPERAND_SIZE_BITS-1 downto
                      (gelement*OPERAND_SIZE_BITS)+DATA_WIDTH_BITS) <= (others => '0');
      end generate element_pad_gen;
      readdata_flat((gelement*OPERAND_SIZE_BITS)+DATA_WIDTH_BITS-1 downto gelement*OPERAND_SIZE_BITS) <=
        readdata(gelement);
    end generate valid_port_gen;
    unused_port_gen : if gelement >= VCI_ELEMENTS generate
      read_base(gelement)    <= (others => '0');
      offset(gelement)       <= (others => '0');
      read_address(gelement) <= (others => '0');
    end generate unused_port_gen;
  end generate element_gen;

  double_clock_gen : if DOUBLE_CLOCKED = 1 generate
    signal write_enable_2x     : std_logic;
    signal vci_read_2x         : std_logic;
    signal vci_write_2x        : std_logic;
    signal vci_vector_start_2x : std_logic;
    signal write_address       : unsigned(ADDRESS_WIDTH-1 downto 0);
  begin
    --Cycle 1, register inputs
    process (vci_clk_2x)
    begin  -- process
      if vci_clk_2x'event and vci_clk_2x = '1' then  -- rising clock edge
        write_enable_2x     <= write_enable;
        vci_read_2x         <= vci_read;
        vci_write_2x        <= vci_write;
        vci_vector_start_2x <= vci_vector_start;
        base_in             <= vci_data_a;
        offset_in           <= vci_data_b;
        write_enable        <= '0';

        --Only write first element
        write_address <= write_base + offset(0);
        writedata     <= base_in(writedata'range);
        if vci_write_2x = '1' and vci_vector_start_2x = '1' then
          write_enable <= '1';
        end if;

        if vci_read_2x = '1' then
          --Store base from read operation to be used in later writes
          write_base <= read_base(0);
        end if;

        if vci_reset = '1' then         -- synchronous reset (active high)
          write_enable <= '0';
        end if;
      end if;
    end process;

    address       <= (others => write_address) when write_enable = '1' else
                     read_address;

    ram_gen : for gram in RAMS_NEEDED-1 downto 0 generate
      the_ram : quad_read_ram
        generic map (
          RAM_WIDTH                => DATA_WIDTH_BITS,
          RAM_DEPTH                => LUT_DEPTH,
          BRAM_ADDRESS_WIDTH_LIMIT => BRAM_ADDRESS_WIDTH_LIMIT
          )
        port map (
          clk             => vci_clk,
          reset           => vci_reset,
          clk_2x          => vci_clk_2x,
          write_address_a => write_address,
          address_a       => address((PORTS_PER_RAM*gram)+0),
          address_b       => address((PORTS_PER_RAM*gram)+1),
          write_address_c => write_address,
          address_c       => address((PORTS_PER_RAM*gram)+2),
          address_d       => address((PORTS_PER_RAM*gram)+3),
          writedata_a     => writedata,
          writedata_c     => writedata,
          wren_a          => write_enable,
          wren_c          => '0',
          readdata_a      => readdata((PORTS_PER_RAM*gram)+0),
          readdata_b      => readdata((PORTS_PER_RAM*gram)+1),
          readdata_c      => readdata((PORTS_PER_RAM*gram)+2),
          readdata_d      => readdata((PORTS_PER_RAM*gram)+3)
          );
    end generate ram_gen;
  end generate double_clock_gen;

  single_clock_gen : if DOUBLE_CLOCKED = 0 generate
    base_in   <= vci_data_a;
    offset_in <= vci_data_b;

    --Cycle 1, register inputs
    process (vci_clk)
    begin  -- process
      if vci_clk'event and vci_clk = '1' then  -- rising clock edge
        write_enable <= '0';

        --Only write first element
        if vci_write = '1' and vci_vector_start = '1' then
          writedata    <= vci_data_a(writedata'range);
          write_enable <= '1';
          --For write operations, use base from last read, broadcast to all RAMs
          address      <= (others => (write_base + offset(0)));
        end if;

        if vci_read = '1' then
          address    <= read_address;
          --Store base from read operation to be used in later writes
          write_base <= read_base(0);
        end if;

        if vci_reset = '1' then         -- synchronous reset (active high)
          write_enable <= '0';
        end if;
      end if;
    end process;

    --Cycles 2 and 3; RAM with output registers
    ram_gen : for gram in RAMS_NEEDED-1 downto 0 generate
      the_ram : dual_read_ram
        generic map (
          RAM_WIDTH        => DATA_WIDTH_BITS,
          RAM_DEPTH        => LUT_DEPTH,
          REGISTER_OUTPUTS => true
          )
        port map (
          clk         => vci_clk,
          address_a   => address((PORTS_PER_RAM*gram)+0),
          address_b   => address((PORTS_PER_RAM*gram)+1),
          writedata_a => writedata,
          wren_a      => write_enable,
          readdata_a  => readdata((PORTS_PER_RAM*gram)+0),
          readdata_b  => readdata((PORTS_PER_RAM*gram)+1)
          );
    end generate ram_gen;
  end generate single_clock_gen;

  process (vci_clk)
  begin  -- process
    if vci_clk'event and vci_clk = '1' then  -- rising clock edge
      --Byte enable shifter; write back all valid bytes on read; nothing on write
      if vci_write = '0' then
        byteena_out_shifter(0) <= vci_byte_valid;
      else
        byteena_out_shifter(0) <= (others => '0');
      end if;
      byteena_out_shifter(byteena_out_shifter'left downto 1) <=
        byteena_out_shifter(byteena_out_shifter'left-1 downto 0);

    end if;
  end process;

  --Output signals, from the end of the pipeline shift registers
  vci_data_out   <= readdata_flat;
  vci_flag_out   <= (others => '0');
  vci_byteenable <= byteena_out_shifter(byteena_out_shifter'left);

-- ASSERTIONS to make sure generics are valid --
  assert LUT_DEPTH > 1
    report "LUT_DEPTH ("
    & positive'image(LUT_DEPTH) &
    ") must be > 1."
    severity failure;

  assert BRAM_ADDRESS_WIDTH_LIMIT >= 8
    report "BRAM_ADDRESS_WIDTH_LIMIT ("
    & positive'image(BRAM_ADDRESS_WIDTH_LIMIT) &
    ") must be greater than or equal to 8."
    severity failure;

  assert OPERAND_SIZE_BITS >= DATA_WIDTH_BITS
    report "DATA_WIDTH_BITS ("
    & positive'image(DATA_WIDTH_BITS) &
    ") is too large for specified operand size ("
    & positive'image(OPERAND_SIZE_BITS) &
    "-bits)."
    severity failure;

  assert OPERAND_SIZE_BITS*2 >= ADDRESS_WIDTH
    report "LUT_DEPTH ("
    & positive'image(LUT_DEPTH) &
    ") is too large for specified operand size.  With OPERAND_SIZE_BYTES set to "
    & positive'image(OPERAND_SIZE_BYTES) &
    " a maximum of "
    & positive'image(2**(2*OPERAND_SIZE_BYTES)) &
    " entries can be addressed."
    severity failure;

  assert DOUBLE_CLOCKED = 0 or DOUBLE_CLOCKED = 1
    report "DOUBLE_CLOCKED ("
    & natural'image(DOUBLE_CLOCKED) &
    ") must be 0 or 1."
    severity failure;

  assert OPERAND_SIZE_BYTES = 1 or OPERAND_SIZE_BYTES = 2 or OPERAND_SIZE_BYTES = 4
    report "OPERAND_SIZE_BYTES ("
    & positive'image(OPERAND_SIZE_BYTES) &
    ") must be 1 (byte), 2 (halfword), or 4 (word)."
    severity failure;
end rtl;
