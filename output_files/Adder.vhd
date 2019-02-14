library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is port ( -- declaring entity and classifying inputs/outputs 
input_1 : in std_logic_vector(3 downto 0); -- recieving a 4 bit input from the switches (0-3)
input_2 : in std_logic_vector(7 downto 4); -- recieving a 4 bit input from the switches (7-4)
output_sum : out std_logic_vector(7 downto 0) -- output of the arithmetic sum is calculated at the end, and assigned to an 8 bit logic vector 
);
end Adder;


architecture Behavioral of Adder is -- declaring architectural section 

signal in1_concat          : std_logic_vector(7 downto 0); -- declaring 8 bit vectors to assign for the concatenated inputs 
signal in2_concat          : std_logic_vector(7 downto 0); --' ' 

-- 
--
begin 

---- concat 
in1_concat <= "0000" & input_1; -- concatenating 0000's using '&' operator to add leading zeros to make it 8 bit vectors  
in2_concat <= "0000" & input_2; -- ' ' 

output_sum (7 downto 0)<= std_logic_vector(unsigned(in1_concat)+unsigned(in2_concat)); -- adding the inputs as an unsigned variable then recasting it back to a logic vector 

end architecture Behavioral; -- ending arch section 

