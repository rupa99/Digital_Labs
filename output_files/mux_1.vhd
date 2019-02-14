library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- This multiplexer is used to determine whether to let go 
-- concatenated value of hex_A and hex_B or the sum of hex_A and hex_B

entity mux_1 is
   port (
                        pb        	: in  std_logic;	                -- In this multiplexer only one push button is checked
                        errorCheck	: in std_logic_vector(3 downto 0);      -- This lets us know if more than one pb is pressed
			DIN2 		: in  std_logic_vector(7 downto 0);	-- Concatenated value
                        DIN1 		: in  std_logic_vector(7 downto 0);     -- Sum value

                        -- half of the 8 digits value is broken down into two parts, this is one of those two parts
                        part_1          : out std_logic_vector(3 downto 0);     
                        part_2          : out std_logic_vector(3 downto 0);

        );
end entity mux_1;

architecture syn of mux_1 is
        signal muxOutput : std_logic_vector(7 downto 0);        -- This signal stores the output value of this multiplexer
begin 
        -- Sum is sent through when pb(3) is pressed and if not pressed concatenated value is sent through
        muxOutput <= (DIN1)      WHEN (NOT(pb) = '1')	        ELSE (DIN2);    


        -- Now, this is where error is taken into consideration
        -- If the value of errorCheck input is 1000, that indicates an error
        -- When errorCheck input is 0001 then it just means pushButton 3 is pressed. Hence, the digits are broken down into two pieces
with errorCheck select

part_1            <=      "1000"  when "1000",                          -- Error, show 88
                        muxOutput(7 downto 4) when "0001",              -- Normal
			"0000" when others;

			
with areButtonsPressed select

part_2            <=     "1000" when "1000",                            -- Error, show 88
                        muxOutput(3 downto 0) when "0001",              
			"0000" when others;

end architecture syn;
