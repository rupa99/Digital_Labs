library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port(
		clk : in std_logic := '0';
		DIN2: in std_logic_vector(6 downto 0);
		DIN1: in std_logic_vector(6 downto 0);
		DOUT: out std_logic_vector(6 downto 0);
		DIG2 : OUT std_logic;
		DIG1 : out std_logic
	);
	end component;
	
	component Concatenate port (
		input_1 : in std_logic_vector(3 downto 0);
		input_2 : in std_logic_vector(7 downto 4);
		output_concatenate : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component Adder port(
		input_1 : in std_logic_vector(3 downto 0);
		input_2 : in std_logic_vector(7 downto 4);
		output_sum : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component mux_1 port(
		
		pb  		: in std_logic;
		DIN2 		: in  std_logic_vector(7 downto 0);	-- Concatenated
		DIN1 		: in  std_logic_vector(7 downto 0); -- Sum
		DOUT			: out	std_logic_vector(7 downto 0)
	
	);
	end component;
	 
	 
	 component Logic_Processor port(
		pb		 	: in std_logic_vector(3 downto 0);
		input_1 	: in std_logic_vector(3 downto 0);
		input_2 	: in std_logic_vector(7 downto 4);
		output	: out std_logic_vector(3 downto 0)
	 );
	 
	 end component;
	 
	 component mux_2 port(
		
		pb		 	: in std_logic;
		DIN2 		: in  std_logic_vector(7 downto 0);	-- Added
		DIN1 		: in  std_logic_vector(7 downto 0); -- Concatenated
		DOUT		: out	std_logic_vector(7 downto 0)
	
	);
	end component;
	
	
	component ledOutputs port(
	IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7, IN_8: IN BIT;
	OUT_1, OUT_2, OUT_3, OUT_4, OUT_5, OUT_6, OUT_7, OUT_8 : OUT BIT 
	);
	end component;
	
	component errorCheck port (
   pb : in std_logic_vector(3 downto 0);
	output : out std_logic_vector(3 downto 0)
   );
	
   end component;
	 
	 
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A							: std_logic_vector(6 downto 0);
	signal hex_A							: std_logic_vector(3 downto 0);
	signal seg7_B							: std_logic_vector(6 downto 0);
	signal error_A							: std_logic_vector(6 downto 0);
	signal error_B							: std_logic_vector(6 downto 0);
	signal hex_B							: std_logic_vector(7 downto 4);
	signal output_concat 				: std_logic_vector(7 downto 0);
	signal outputSum 						: std_logic_vector(7 downto 0);
	signal digit_out 						: std_logic_vector(7 downto 0);
	signal part_1 							: std_logic_vector(3 downto 0);
	signal part_2 							: std_logic_vector(3 downto 0);
	signal Logic_processor_output 	: std_logic_vector(3 downto 0);
	signal mux_2_input1 					: std_logic_vector(7 downto 0);
	signal areButtonsPressed 			: std_logic_vector(3 downto 0);

	
-- Here the circuit begins

begin

hex_B <= sw(3 downto 0);
hex_A <= sw(7 downto 4);

INST1 : errorCheck port map(pb, areButtonsPressed);




--if areButtonsPressed = '1' then

	--INST2 :  SevenSegment port map("1000", seg7_A);
	
--end if;

INST3 : Concatenate port map(hex_A, hex_B, output_concat);

INST4 : Adder port map(hex_A, hex_B, outputSum); -- Change to Mux input

INST5 : mux_1 port map(pb(3), output_concat, outputSum, digit_out);


-- Opposite of Concatenation

--part_1 <= digit_out(7 downto 4);
--part_2 <= digit_out(3 downto 0);

-- Uncomment this:
-- Starts here:

--if areButtonsPressed = "1000" then
with areButtonsPressed select

part_1 <= "1000" when "1000",
			digit_out(7 downto 4) when "0001",
			"0000" when others;

			
with areButtonsPressed select

part_2 <=  "1000" when "1000",
			digit_out(3 downto 0) when "0001",
			"0000" when others;
	   
-- Ends here

--end if;

INST6 : SevenSegment port map(part_1, seg7_B); --creating the constructor!!!

INST7 : SevenSegment port map(part_2, seg7_A);

INST8 : segment7_mux port map(clkin_50, seg7_B, seg7_A, seg7_data, seg7_char1, seg7_char2);

 
 
 ------------------------------------
 
 INST9 : Logic_Processor port map(pb, hex_A, hex_B, Logic_processor_output);
 
 with Logic_processor_output select
  mux_2_input1 <= "11111111" when "1111",
						outputSum when "0110",
						("0000" & Logic_processor_output) when others;
 
 
 INST10 : mux_2 port map(pb(3), mux_2_input1, outputSum, leds);
 
 

 

end SimpleCircuit;

