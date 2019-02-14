library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is port (
input_1 : in std_logic_vector(3 downto 0);
input_2 : in std_logic_vector(7 downto 4);
output_sum : out std_logic_vector(7 downto 0)
);
end Adder;


architecture Behavioral of Adder is

signal in1_concat          : std_logic_vector(7 downto 0);
signal in2_concat          : std_logic_vector(7 downto 0);

-- 
--
begin

---- concat 
in1_concat <= "0000" & input_1;
in2_concat <= "0000" & input_2; 

output_sum (7 downto 0)<= std_logic_vector(unsigned(in1_concat)+unsigned(in2_concat));

end architecture Behavioral;

