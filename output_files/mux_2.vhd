library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2 is
   port (
          pb        : in  std_logic;	
			 DIN2 		: in  std_logic_vector(7 downto 0);	-- Adder
			 DIN1 		: in  std_logic_vector(7 downto 0); -- Concatenated_2
			 DOUT			: out	std_logic_vector(7 downto 0)
        );
end entity mux_2;

architecture syn of mux_2 is

--signal pb_bar : std_logic;

begin 

--pb_bar <= NOT(pb);


DOUT <= (DIN1) WHEN (NOT(pb) = '1')	ELSE (DIN2);


end architecture syn;
