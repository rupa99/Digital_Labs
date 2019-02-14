library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity declaration for inputs and outputs 
entity concatenate is port (
	input_1 : in std_logic_vector(3 downto 0); -- declaring 4- bit input vector 
	input_2 : in std_logic_vector(7 downto 4); -- declaring 4- bit input vector
	output_concatenate : out std_logic_vector(7 downto 0) -- declaring 8- bit output vector
);

end concatenate; -- ending entity declaration 

--initiating the architecture section 
architecture Behavioral of concatenate is

begin

	output_concatenate <= input_1 & input_2; -- concatenating the 4 bit inputs and assigning the resultant to the 8-bit output vector 

end architecture Behavioral;
--ending the declaration of the architecture section 
