library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This takes three push button inputs and performs logic operations
entity Logic_Processor is port (
	pb			 : in std_logic_vector (3 downto 0);	-- Takes in push buttons	
	input_1 	 : in std_logic_vector (3 downto 0);	-- One of the two operands	
	input_2 	 : in std_logic_vector (3 downto 0);	-- Second input which will be used for logical operations
	output		 : out std_logic_vector(7 downto 0)		-- Result of the logical operations
);
end Logic_Processor;



architecture Behavioral of Logic_Processor is

begin 
with pb select
		-- This is where the logical operations are done,
		-- when pushbutton results are:
			-- 0000 ---> Nothing happens 
			-- 1110 ---> Logical AND of operands
			-- 1101 ---> Logical OR of operands
			-- 1011 ---> Logical XOR of operands 


		-- Concatenation is done in here as well, which is why we are performing AND operation with 0000
	output 		<= 		("0000" & (input_1 AND input_2)) when "1110", 
						("0000" & (input_1 OR input_2)) when "1101",  
						("0000" & (input_1 XOR input_2)) when "1011",
								"00000000" when "1111",
								"11111111" when others;			-- This is done to light up the leds when more than one pb is pressed
		-- This returns 8 digits std_logic_vector(7 downto 0)								
end architecture Behavioral; 