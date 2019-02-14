library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concatenate is port ( --- creating an entity and declaring inputs and outputs 
	input_1 : in std_logic_vector(3 downto 0); -- recieving a 4 bit input from a logic vector from selecting (3-0) bits   
	input_2 : in std_logic_vector(7 downto 4); -- '                                         ' from seleting (7-4) bits 
	output_concatenate : out std_logic_vector(7 downto 0) --- assigning output from concatenation to an 8 bit vector 
);

end concatenate; -- ending the entity declaration  

architecture Behavioral of concatenate is   --- declaring the architectural section 

begin

	output_concatenate <= input_1 & input_2; -- concatenating the inputs and assigning it to an 8 bit logic vector 

end architecture Behavioral; ---- ending the architectural sectioon 
