-- Aaron Severance
-- adder_tree.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.util_pkg.all;

entity adder_tree is
  generic (
    LEAVES : integer := 8
    );
  port(
    data_in  : in  signed32_array((LEAVES)-1 downto 0);
    data_out : out signed(31 downto 0)
    );
end entity adder_tree;

architecture rtl of adder_tree is
  constant LEVELS        : integer := log2(LEAVES);
  constant PADDED_LEAVES : integer := 2**LEVELS;
  signal   tree          : signed32_array((2*PADDED_LEAVES)-1 downto 1);
begin
  tree(PADDED_LEAVES+LEAVES-1 downto PADDED_LEAVES) <= data_in;

  --In case not power of 2 leaves; can't use a normal assignment in case there
  --are power of 2 leaves
  empty_leaves_gen : for gleaf in PADDED_LEAVES-1 downto LEAVES generate
    tree(gleaf+PADDED_LEAVES) <= (others => '0');
  end generate empty_leaves_gen;

  tree_level_gen : for glevel in LEVELS-1 downto 0 generate
    branch_gen : for gbranch in (2**glevel)-1 downto 0 generate
      tree((2**glevel)+gbranch) <= tree((2**(glevel+1))+(2*gbranch)) + tree((2**(glevel+1))+(2*gbranch+1));
    end generate branch_gen;
  end generate tree_level_gen;

  data_out <= tree(1);
  
end architecture rtl;
