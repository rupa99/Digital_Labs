library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
	clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  	std_logic_vector(7 downto 0); 	-- The switch inputs
	leds				: out 	std_logic_vector(7 downto 0); 	-- for displaying the switch content
	seg7_data 			: out 	std_logic_vector(6 downto 0); 	-- 7-bit outputs to a 7-segment
	seg7_char1  		: out	std_logic;				    	-- seg7 digit1 selector
	seg7_char2  		: out	std_logic				    	-- seg7 digit2 selector
	
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
	
	-- Component to concatenate, don't really need it but just made one 
	component Concatenate port (
		input_1 : in std_logic_vector(3 downto 0);				-- Input 1 that will be concatenated
		input_2 : in std_logic_vector(7 downto 4);				-- Input 2 that will be concatenated
		output_concatenate : out std_logic_vector(7 downto 0)	-- Concatenated logic vector 
	);
	end component;
	
	-- Component to add two numbers
	component Adder port(
		input_1 : in std_logic_vector(3 downto 0);			-- Input 1 and Input 2 will get added to output the sum
		input_2 : in std_logic_vector(7 downto 4);
		output_sum : out std_logic_vector(7 downto 0)		-- Sum of input 1 and input 2
	);
	end component;
	
	-- Multiplexer 1 that takes push button 3's input to send either concatenated value or added sum 
	-- If pb(3) is pressed, send the sum in 
	component mux_1 port(
	    pb        	: in  std_logic;					-- This pb is pushbutton 3
        errorCheck	: in std_logic_vector(3 downto 0);	-- This is the output of errorCheck object, which indicates whether more than one pb is pressed
		DIN2 		: in  std_logic_vector(7 downto 0);	-- Concatenated value that is sent in
		DIN1 		: in  std_logic_vector(7 downto 0); -- Sum 
        part_1      : out std_logic_vector(3 downto 0);	-- This component also splits the 8 bits value and break it into part 1 and 2
        part_2      : out std_logic_vector(3 downto 0); 

	
	);
	end component;
	 
	 -- This component takes 3 push button inputs, (2 downto 0) and based on push button pressed, it decides whether to XOR, AND, or OR
	 component Logic_Processor port(
		pb		 	: in std_logic_vector(3 downto 0);	-- All pushbuttons sent in, pb(3) is not considered
		input_1 	: in std_logic_vector(3 downto 0);	-- input 1 and 2 are the two inputs where logical operations are performed
		input_2 	: in std_logic_vector(7 downto 4);
		output		: out std_logic_vector(7 downto 0)	-- the result of operation
	 );
	 
	 end component;
	 
	 -- This multiplexer takes pushButton 3 to decide where to continue with added sum or concatenated output from logical processor
	 component mux_2 port(
		pb		 	: in std_logic;						-- push button 3
		DIN2 		: in  std_logic_vector(7 downto 0);	-- Sum
		DIN1 		: in  std_logic_vector(7 downto 0); -- Concatenated
		DOUT		: out	std_logic_vector(7 downto 0)	-- Output
	
	);
	end component;
	
	-- This component is used to trigger LED lights 
	component ledOutputs port(
	IN_1, IN_2, IN_3, IN_4, IN_5, IN_6, IN_7, IN_8: IN BIT;
	OUT_1, OUT_2, OUT_3, OUT_4, OUT_5, OUT_6, OUT_7, OUT_8 : OUT BIT 
	);
	end component;
	
	-- This component checks if more than one pushButton is pressed 
	component errorCheck port (
   		pb : in std_logic_vector(3 downto 0); -- All push buttons sent in
		output : out std_logic_vector(3 downto 0)	-- This output indicates whether to show 88 and light up all LEDs
   );
   end component;
	 
	 
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A							: std_logic_vector(6 downto 0);
	signal hex_A							: std_logic_vector(3 downto 0);
	signal seg7_B							: std_logic_vector(6 downto 0);
	signal hex_B							: std_logic_vector(7 downto 4);
	signal output_concat 					: std_logic_vector(7 downto 0); -- Output from concatenate component
	signal outputSum 						: std_logic_vector(7 downto 0);	-- Output from adder component
	signal part_1 							: std_logic_vector(3 downto 0);	-- Dissociated 4 bits value from mux 1
	signal part_2	 						: std_logic_vector(3 downto 0);	-- Dissociated 4 bits value from mux 2
	signal Logic_processor_output 			: std_logic_vector(7 downto 0);	-- Output from Logic Processor component
	signal areButtonsPressed 				: std_logic_vector(3 downto 0);	-- output of error check component

	
-- Here the circuit begins

begin

hex_B <= sw(3 downto 0);
hex_A <= sw(7 downto 4);

-- ----------------- All instances ----------------------

ERRORCHECK : errorCheck port map(pb, areButtonsPressed);	 		-- Instance of errorCheck component	

CONCATENATION : Concatenate port map(hex_A, hex_B, output_concat);

ADDED : Adder port map(hex_A, hex_B, outputSum); -- Change to Mux input

MUX1 : mux_1 port map(pb(3), areButtonsPressed, output_concat, outputSum, part_1, part_2);

SEVENSEG : SevenSegment port map(part_1, seg7_B); --creating the constructor!!!

SEVENSEG1 : SevenSegment port map(part_2, seg7_A);

SEG7MUX : segment7_mux port map(clkin_50, seg7_B, seg7_A, seg7_data, seg7_char1, seg7_char2);

LOGICPROCESSOR : Logic_Processor port map(pb, hex_A, hex_B, Logic_processor_output);
 
MUX2 : mux_2 port map(pb(3), Logic_processor_output, outputSum, leds);

end SimpleCircuit;

