--**********************************************************************************************************************
--Division Implementation
--Author: Robert Limas
--Year: 2021
--Research Group GIRA
--Universidad Pedagogica y Tecnologica de Colombia
--
--Test bench file
--
--Description:
--This file is to verify the correct operation of the implementation.
--**********************************************************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity tb is
generic(
	n: natural := 8
);
end entity;

architecture rtl of tb is

signal divisor: std_logic_vector(n-1 downto 0);
signal dividend: std_logic_vector(n-1 downto 0) := (n-1=>'0', others=>'1');
signal quotient, residue: std_logic_vector(n-1 downto 0);

signal divisor_temp: signed(n-1 downto 0) := (others=>'0');

begin

divisor <= std_logic_vector(divisor_temp);

--Design instantiation
division0: entity work.division
generic map(
	n =>  n
)
port map(
	divisor => divisor,
	dividend => dividend,
	quotient => quotient,
	residue => residue
);

--Counter for divisor test
process
begin
divisor_temp <= divisor_temp + 1;
wait for 150 ns;
end process;

end rtl;