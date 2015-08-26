-- Aaron Severance
-- util_pkg.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;

package util_pkg is
  --Types for general usage
  type signed32_array is array (natural range <>) of signed(31 downto 0);
  type slv32_array is array (natural range <>) of std_logic_vector(31 downto 0);

  -- Constant functions for derived constant generation
  function log2(
    constant N : integer)
    return integer;
  function log2_f(
    constant N : integer)
    return integer;
  function burst_bits(
    constant BURSTLENGTH_BYTES  : integer;
    constant MEMORY_WIDTH_LANES : integer)
    return integer;

  -- Conversion functions, not constant
  function to_onehot (
    binary_encoded : std_logic_vector)
    return std_logic_vector;

  function replicate_bit (
    input_bit              : std_logic;
    constant RETURN_LENGTH : integer
    )
    return std_logic_vector;

  function s_z_extend (
    constant SIGN_BIT      : integer;
    signal   signed_extend : std_logic;
    signal   data_in       : std_logic_vector)
    return std_logic_vector;
end package;

package body util_pkg is

  function log2_f(
    constant N : integer)
    return integer is
    variable i : integer := 0;
  begin
    while (2**i <= n) loop
      i := i + 1;
    end loop;
    return i-1;
  end log2_f;

  function log2(
    constant N : integer)
    return integer is
    variable i : integer := 0;
  begin
    while (2**i < n) loop
      i := i + 1;
    end loop;
    return i;
  end log2;

  function burst_bits(
    constant BURSTLENGTH_BYTES  : integer;
    constant MEMORY_WIDTH_LANES : integer)
    return integer is
    variable burst_bits : integer := 0;
  begin
    if memory_width_lanes*4 >= burstlength_bytes then
      return 1;
    end if;
    return log2(burstlength_bytes/(memory_width_lanes*4))+1;
  end burst_bits;

  function to_onehot (
    binary_encoded : std_logic_vector)
    return std_logic_vector is
    variable onehot : std_logic_vector((2**binary_encoded'length)-1 downto 0);
  begin
    onehot                                       := (others => '0');
    onehot(to_integer(unsigned(binary_encoded))) := '1';

    return onehot;
  end to_onehot;
  
  function replicate_bit (
    input_bit              : std_logic;
    constant RETURN_LENGTH : integer)
    return std_logic_vector is
    variable data_out : std_logic_vector(RETURN_LENGTH-1 downto 0);
  begin
    data_out := (others => input_bit);
    return data_out;
  end replicate_bit;
  
  function s_z_extend (
    constant SIGN_BIT      : integer;
    signal   signed_extend : std_logic;
    signal   data_in       : std_logic_vector)
    return std_logic_vector is
    variable data_out    : std_logic_vector(data_in'range);
    constant zero_extend : std_logic_vector(data_in'left downto SIGN_BIT+1) := (others => '0');
    constant one_extend  : std_logic_vector(data_in'left downto SIGN_BIT+1) := (others => '1');
  begin
    data_out(SIGN_BIT downto 0) := data_in(SIGN_BIT downto 0);
    if signed_extend = '1' and data_in(SIGN_BIT) = '1' then
      data_out(data_in'left downto SIGN_BIT+1) := one_extend;
    else
      data_out(data_in'left downto SIGN_BIT+1) := zero_extend;
    end if;
    return data_out;
  end s_z_extend;
  
end util_pkg;
