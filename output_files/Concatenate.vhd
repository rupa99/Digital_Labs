library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concatenate is port (
input_1 : in std_logic_vector(3 downto 0);
input_2 : in std_logic_vector(7 downto 4);
output_concatenate : out std_logic_vector(7 downto 0)
);

end concatenate;

architecture Behavioral of concatenate is


begin

output_concatenate <= input_1 & input_2;

end architecture Behavioral;
