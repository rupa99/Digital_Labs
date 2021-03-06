library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Logic_Processor is port (
	pb		 : in std_logic_vector(3 downto 0);
	input_1 : in std_logic_vector(3 downto 0);
	input_2 : in std_logic_vector(3 downto 0);
	output: out std_logic_vector(3 downto 0)
);
end Logic_Processor;



architecture Behavioral of Logic_Processor is

begin 

with pb select
	
	output 		<= 		(input_1 AND input_2) when "1110",
								(input_1 OR input_2) when "1101",  
								(input_1 XOR input_2) when "1011",
								"0110" when "0111",
								"0000" when "1111",
								"1111" when others;
							 										
end architecture Behavioral; 