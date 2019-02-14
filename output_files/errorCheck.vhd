library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This is where we are checking if more than one push button is pressed

entity errorCheck is port (
	pb : in std_logic_vector(3 downto 0);			-- All three push buttons are taken in to check if only one or more than one is pressed
	output: out std_logic_vector(3 downto 0)		-- This outputs 2 different outputs: It depends on push buttons
													-- When pb is "0001" --> indicates only one is pressed
);													-- When pb is "1000" --> More than one is pressed 
end errorCheck;

architecture Behavioral of errorCheck is
begin 

with pb select -- Analyzing pushButton inputs, pb is a std_logic_vector of (3 downto 0)
	
-- When 1110, 1101, 1011, 0111, 1111 is not the value of pb, it is an error meaning more than one push button is pressed
output 								<= 			"0001" when "1110",
												"0001" when "1101",  
												"0001" when "1011",
												"0001" when "1111",	
												"0001" when "0111",
												"1000" when others;
												
end architecture Behavioral; 