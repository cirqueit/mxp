-- divider_alt.vhd
-- Copyright (C) 2012-2015 VectorBlox Computing, Inc.

-- synthesis library vci_particle_full_lib
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library altera_mf;
use altera_mf.altera_mf_components.all;
library lpm;
use lpm.all;

entity divider is
  generic (
    DENOM_WIDTH : positive := 33;
    NUMER_WIDTH : positive := 33
    );
  port (
    clock    : in  std_logic;
    clken    : in  std_logic;
    denom    : in  std_logic_vector(DENOM_WIDTH-1 downto 0);
    numer    : in  std_logic_vector(NUMER_WIDTH-1 downto 0);
    quotient : out std_logic_vector(NUMER_WIDTH-1 downto 0)
    );
end;

architecture rtl of divider is
  component lpm_divide
    generic (
      lpm_drepresentation : string;
      lpm_hint            : string;
      lpm_nrepresentation : string;
      lpm_pipeline        : natural;
      lpm_type            : string;
      lpm_widthd          : natural;
      lpm_widthn          : natural
      );
    port (
      clock    : in  std_logic;
      clken    : in  std_logic;
      remain   : out std_logic_vector (lpm_widthd-1 downto 0);
      denom    : in  std_logic_vector (lpm_widthd-1 downto 0);
      numer    : in  std_logic_vector (lpm_widthn-1 downto 0);
      quotient : out std_logic_vector (lpm_widthn-1 downto 0)
      );
  end component;
begin

    the_divider : lpm_divide
      generic map (
        lpm_drepresentation => "SIGNED",
        lpm_hint            => "MAXIMIZE_SPEED=6,LPM_REMAINDERPOSITIVE=TRUE",
        lpm_nrepresentation => "SIGNED",
        lpm_pipeline        => NUMER_WIDTH,
        lpm_type            => "LPM_DIVIDE",
        lpm_widthd          => DENOM_WIDTH,
        lpm_widthn          => NUMER_WIDTH
        )
      port map (
        clock    => clock,
        clken    => clken,
        denom    => denom,
        numer    => numer,
        remain   => open,
        quotient => quotient
        );

end rtl;
