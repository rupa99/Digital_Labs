library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_1 is
   port (
          pb        	: in  std_logic;	
			 DIN2 		: in  std_logic_vector(7 downto 0);	-- Concatenated
			 DIN1 		: in  std_logic_vector(7 downto 0); -- Sum
			 DOUT			: out	std_logic_vector(7 downto 0)                                                                                                                                                                                                                                
        );
end entity mux_1;

architecture syn of mux_1 is

begin 

DOUT <= (DIN1) WHEN (NOT(pb) = '1')	ELSE (DIN2);

end architecture syn;
