--**********************************************************************************************************************
--Division Implementation
--Author: Robert Limas
--Year: 2021
--Research Group GIRA
--Universidad Pedagogica y Tecnologica de Colombia
--
--Inputs:
--    divisor, quotient_before, residue_before
--Outputs:
--    residue, quotient
--
--Description:
--    This block corresponds to one step of the division algorithm
--    Generic n: bits numbers
--**********************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity step is
generic(
	n: natural := 8
);
port(
	divisor, quotient_before, residue_before: in std_logic_vector(n-1 downto 0);
	residue, quotient: out std_logic_vector(n-1 downto 0)
);
end entity;

architecture rtl of step is

signal quotient_temp, residue_temp, subtract: std_logic_vector(n-1 downto 0);
signal aux: std_logic_vector((2*n)-1 downto 0);

begin

--Shif left between residue and quotient
aux <= residue_before(n-2 downto 0) & quotient_before & '0';

--Reassignment of names
quotient_temp <= aux(n-1 downto 0);
residue_temp <= aux((2*n)-1 downto n);

--Instantation of subtractor
add_sub: entity work.adder_subtractor
generic map(
	n => n
)
port map(
	add_sub => '1',
	a => residue_temp,
	b => divisor,
	y => subtract
);

--Restoration multiplexer
residue <= subtract when subtract(n-1) = '0' else residue_temp;

--Quotient(0) assignation 0 if subtractor < 0 else 1
quotient <= quotient_temp(n-1 downto 1) & (not subtract(n-1));

end rtl;