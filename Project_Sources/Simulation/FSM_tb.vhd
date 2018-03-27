----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2017 10:29:34
-- Design Name: 
-- Module Name: FSM_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_tb is
end FSM_tb;

architecture Behavioral of FSM_tb is

component Finite_State_Machine

    Port ( Button_Debounced : in STD_LOGIC;
           Switches : in STD_LOGIC_VECTOR (15 downto 0);
           Display_Value : out STD_LOGIC_VECTOR (31 downto 0));
           
end component; 
    
signal ButtonIn : STD_LOGIC;
signal SwitchesIn : STD_LOGIC_VECTOR(15 downto 0);
signal Display_ValueOut : STD_LOGIC_VECTOR(31 downto 0);
    
begin
    
    U1 : Finite_State_Machine 
        port map (ButtonIn, SwitchesIn, Display_ValueOut);
    process
    begin
    
        --Addition
        ButtonIn <= '0';
        SwitchesIn <= X"0067"; -- operand 1
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; 
        SwitchesIn <= X"F547"; -- operand 2       
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;

        ButtonIn <= '0';
        SwitchesIn <= X"0000"; --opcode
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; -- display result
        wait for 1ns;
        
        --Subtraction
        ButtonIn <= '1';
        wait for 0.1ns;

        ButtonIn <= '0';
        SwitchesIn <= X"B519"; -- operand 1
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;

        ButtonIn <= '0';  
        SwitchesIn <= X"67D3"; -- operand 2
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"0001"; -- opcode
        wait for 1ns;
    
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; -- display result
        wait for 1ns;
        
        -- OR
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"8754"; -- operand 1
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"2986"; -- operand 2  
        wait for 1ns;
        
        ButtonIn <= '1'; 
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"0002"; -- opcode
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; -- display result
        wait for 1ns;
        
        -- AND
        ButtonIn <= '1';       
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"00FE"; -- operand 1 
        wait for 1ns;
          
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; 
        SwitchesIn <= X"0738"; -- operand 2 
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"0003"; -- opcode
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; -- display result
        wait for 1ns;
        
        -- Multiplication
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"0805"; -- operand 1
        wait for 1ns;
          
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"0E01"; -- operand 2 
        wait for 1ns;
               
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0';
        SwitchesIn <= X"000F"; -- opcode 
        wait for 1ns;
        
        ButtonIn <= '1';
        wait for 0.1ns;
        
        ButtonIn <= '0'; -- display result
        wait for 1ns;
        
    end process;
    
end Behavioral;
