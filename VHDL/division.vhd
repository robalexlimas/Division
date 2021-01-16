--**********************************************************************************************************************
--Division Implementation
--Author: Robert Limas
--Year: 2021
--Research Group GIRA
--Universidad Pedagogica y Tecnologica de Colombia
--
--Inputs:
--    divisor, dividend
--Outputs:
--    quotient, residue
--
--Description:
--    This block corresponds to the division hardware implementation
--    Generic n: bits numbers
--**********************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity division is
generic(
	n: natural := 8
);
port(
	divisor, dividend: in std_logic_vector(n-1 downto 0);
	quotient, residue: out std_logic_vector(n-1 downto 0)
);
end entity;

architecture rtl of division is

type data is array (0 to n) of std_logic_vector(n-1 downto 0);
signal dividend_temp, residue_temp: data;

begin

--Initial assignation
dividend_temp(0) <= dividend;
residue_temp(0) <= (others=>'0');

--Steps implementation
steps_instantiation: for i in 0 to n-1 generate
	steps: entity work.step
	generic map(
		n => n
	)
	port map(
		divisor => divisor,
		quotient_before => dividend_temp(i),
		residue_before => residue_temp(i),
		residue => residue_temp(i+1),
		quotient => dividend_temp(i+1)
	);
end generate steps_instantiation;

--Output assignation
quotient <= dividend_temp(n);
residue <= residue_temp(n);

end rtl;