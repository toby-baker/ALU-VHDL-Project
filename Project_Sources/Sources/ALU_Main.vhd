----------------------------------------------------------------------------------
-- ENCE373 - ALU_Prject
-- Engineers: Toby Baker and Robbie Day
-- 07/04/2017
-- 
-- Create Date: 19.03.2017 20:33:45
-- Module Name: ALU_Main - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: NexysDDR-4
-- Description: VHDL Implementation of an ALU.
----------------------------------------------------------------------------------
-- INCLUIDES

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
----------------------------------------------------------------------------------
-- Main Entity

entity ALU_Main is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0); 
       CLK100MHZ : in STD_LOGIC;
       BTNR : in STD_LOGIC;
       CA : out STD_LOGIC;
       CB : out STD_LOGIC;
       CC : out STD_LOGIC;
       CD : out STD_LOGIC;
       CE : out STD_LOGIC;
       CF : out STD_LOGIC;
       CG : out STD_LOGIC;
       AN : out STD_LOGIC_VECTOR (7 downto 0));
end ALU_Main;
----------------------------------------------------------------------------------
 
architecture Behavioral of ALU_Main is

component Clock_Div

    Port( clk_in : in STD_LOGIC;
          clk_out : out STD_LOGIC );
          
end component;

component Three_Bit_Counter
    Port ( clk : in STD_LOGIC;
           q_out : out STD_LOGIC_VECTOR (2 downto 0));
        
end component;
component debounce

    Port ( clk : in STD_LOGIC;
           Button : in STD_LOGIC;
           Button_Debounced : out STD_LOGIC);
           
end component;

component Finite_State_Machine

    Port ( Button_Debounced : in STD_LOGIC;
           Switches : in STD_LOGIC_VECTOR (15 downto 0);
           Display_Value : out STD_LOGIC_VECTOR (31 downto 0));
           
end component; 

component Binary_to_BCD
    Port ( Result : in STD_LOGIC_VECTOR (31 downto 0);
           Converted_BCD : out STD_LOGIC_VECTOR (31 downto 0) );

end component;

component Multiplexer
    Port ( count : in STD_LOGIC_VECTOR (2 downto 0);
       bcd : in STD_LOGIC_VECTOR (31 downto 0);
       z : out STD_LOGIC_VECTOR (3 downto 0); --the bcd for one light
       AN : out STD_LOGIC_VECTOR (7 downto 0));
end component;
     

component Seven_Seg_Decoder

    Port ( num_in: in STD_LOGIC_VECTOR (3 downto 0);
           segments_out : out STD_LOGIC_VECTOR (6 downto 0));
           
end component;

signal my_clock : STD_LOGIC;
signal three_bit : STD_LOGIC_VECTOR (2 downto 0);
signal display_num : STD_LOGIC_VECTOR (3 downto 0);
signal result : STD_LOGIC_VECTOR(31 downto 0);
signal converted_display : STD_LOGIC_VECTOR (31 downto 0);
signal debounced : STD_LOGIC;

begin

    U1 : Clock_Div
        port map (clk_out => my_clock, clk_in => CLK100MHZ);

    U2 : Three_Bit_Counter
       port map ( clk => my_clock, q_out => three_bit);
    
    U3 : Debounce
        port map ( clk => CLK100MHZ, Button => BTNR, Button_Debounced => debounced);
    
    U4 : Finite_State_Machine
        port map ( Button_Debounced => debounced, Switches => SW, Display_Value => result);
    
    U5 : Binary_to_BCD
        port map (Result => result, Converted_BCD => converted_display);
    
    U6 : Multiplexer
        port map ( count => three_bit, bcd => converted_display, z => display_num, AN => AN);
    
    U7 : Seven_Seg_Decoder
        port map ( num_in => display_num, segments_out(6) => CA, segments_out(5) => CB, segments_out(4) => CC,
                  segments_out(3) => CD, segments_out(2) => CE, segments_out(1) => CF, segments_out(0) => CG);

end Behavioral;
