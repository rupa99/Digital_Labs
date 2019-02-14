library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity errorCheck is port (
	pb : in std_logic_vector(3 downto 0);
	output: out std_logic_vector(3 downto 0)
);
end errorCheck;



architecture Behavioral of errorCheck is


begin 

with pb select
	
output 								<= 	"0001" when "1110",
												"0001" when "1101",  
												"0001" when "1011",
												"0001" when "1111",
												
												"0001" when "0111",
												
												"1000" when others;
												
end architecture Behavioral; 