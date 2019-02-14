library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity declaration for inputs and outputs 
entity Adder is port (
input_1 : in std_logic_vector(3 downto 0); --declaring the input as a 4-bit logic vector assigned from switches 3-0
input_2 : in std_logic_vector(7 downto 4); --declaring the input as a 4-bit logic vector assigned from switches 7-4
output_sum : out std_logic_vector(7 downto 0) --declaring the output as an 8-bit logic vector 
);
end Adder; -- ending entity 

--creating/declaring the architecture section
architecture Behavioral of Adder is

signal in1_concat          : std_logic_vector(7 downto 0); --creating an 8-bit logic vector that can store 8 values 
signal in2_concat          : std_logic_vector(7 downto 0);  --creating an 8-bit logic vector that can store 8 values 

-- 
--
begin

in1_concat <= "0000" & input_1; -- concatenating the 1st set of inputs from the switches with "0000"
in2_concat <= "0000" & input_2; -- concatenating the 2nd set of inputs from the switches with "0000"

--adding the results from the concatenation using unsigned ints--- performing arithmetic addtion, then converting back to logic vector 
output_sum (7 downto 0)<= std_logic_vector(unsigned(in1_concat)+unsigned(in2_concat)); 

end architecture Behavioral; 
  -- ending architectural declaration 

