library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2 is
   port (
          pb        	: in  std_logic;	
			 DIN2 		: in  std_logic_vector(7 downto 0);	-- Adder
			 DIN1 		: in  std_logic_vector(7 downto 0); -- Concatenated_2
			 DOUT			: out	std_logic_vector(7 downto 0)
        );
end entity mux_2;

architecture syn of mux_2 is

signal pb_bar1 : std_logic;

begin 

with DIN2 select

	pb_bar1 <= '0' when "11111111",
					NOT(pb) when others;


DOUT <= (DIN1) WHEN (pb_bar1 = '1')	ELSE (DIN2);


end architecture syn;
