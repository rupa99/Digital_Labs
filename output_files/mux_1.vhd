library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_1 is --- declaring entity 
   port ( 
         		 pb        	: in  std_logic;	 ---- recieving input from pb(3)
			 DIN2 		: in  std_logic_vector(7 downto 0);---Recieving the input from concatenation of the inputs from the switches 
			 DIN1 		: in  std_logic_vector(7 downto 0); -- Recieving the input from the addition of the inputs after converting it back to an 8- bit logic vector 
			 DOUT		: out	std_logic_vector(7 downto 0)  ---- Assigning the output from the mux to this output vector                                                                                                                                                                                                                
        );
end entity mux_1;

architecture syn of mux_1 is --- initiating the architecture section 

begin 

DOUT <= (DIN1) WHEN (NOT(pb) = '1')	ELSE (DIN2); --- when push button 3 is pushed meaning- its a 0, then select DIN1 which is the addition result, if not select the concatenated input 

end architecture syn; --- end of the architeture section 
