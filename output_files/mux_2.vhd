library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2 is --- declaring the inputs and outputs 
   port (
        		  pb        	: in  std_logic; -- reciveing input from pb 	
			 DIN2 		: in  std_logic_vector(7 downto 0);	-- input from the adder- 8 bit logic vector 
			 DIN1 		: in  std_logic_vector(7 downto 0); -- input from the logic processor after concatenation 
			 DOUT		: out	std_logic_vector(7 downto 0) --- output as a result of mux2 
        );
end entity mux_2;

architecture syn of mux_2 is --- initiate the entity section  

signal pb_bar1 : std_logic; -- declaration as input from the push button 

begin 

with DIN2 select

	pb_bar1 <= '0' when "11111111", --- assign '0' to p_bar1 is "11111111" is the input  else assign '1' due to any other inputs 
			NOT(pb) when others;

	DOUT <= (DIN1) WHEN (pb_bar1 = '1')	ELSE (DIN2); -- when push button is not pressed, assign logic processor value, else if it is pressed assign the adder val 


end architecture syn;
