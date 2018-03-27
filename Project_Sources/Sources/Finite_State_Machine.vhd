----------------------------------------------------------------------------------
-- Company: University of Canterbury    
-- Engineer: Toby Baker and Robbie Day
-- 
-- Create Date: 06.04.2017 19:13:17
-- Module Name: Finite_State_Machine - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Finite State Machine to control all essential ALU functions.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Finite_State_Machine is
    Port ( Button_Debounced : in STD_LOGIC := '0';
           reset : in STD_LOGIC := '0';
           Switches : in STD_LOGIC_VECTOR (15 downto 0);
           Display_Value : out STD_LOGIC_VECTOR(31 downto 0));
end Finite_State_Machine;

architecture Behavioral of Finite_State_Machine is

signal count : STD_LOGIC_VECTOR (1 downto 0) := "00";

begin

    process (reset, Button_Debounced, count) is 
    
        variable operand_1 : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
        variable operand_2 : STD_LOGIC_VECTOR (15 downto 0) := X"0000";
        variable operation : STD_LOGIC_VECTOR (3 downto 0) := X"0";
        variable temp1 : STD_LOGIC_VECTOR (16 downto 0) := '0' & X"0000"; -- for addition and subtraction (max result 17 bits)
        variable temp2 : STD_LOGIC_VECTOR (15 downto 0) := X"0000"; -- for OR and AND operation (max result 16 bits)
        variable mult : STD_LOGIC_VECTOR (31 downto 0) := X"00000000"; -- for multiplication (max result 32 bits)
        
        variable display : STD_LOGIC_VECTOR (31 downto 0) := X"00000000"; --variable to be sent to the eight 7seg displays
        
        begin 
            if RESET = '1' then --asynch reset, active high
                count <= "00";
            elsif (Button_Debounced'event and Button_Debounced = '1') then 
                if (count = "11") then --reset to state 0 
                    count <= "00";
                else 
                    count <= count + "01"; --move to next state
                end if;
            end if;
            
            if count = "00" then --The states have reset, ready for another operation state 0 (enter operand 1)
                    operand_1 := Switches;
                    if Switches(15) = '1' then
                        display := X"FFFF" & operand_1; --negative number to be sent to display
                    else
                        display := X"0000" & operand_1; --positive number to be sent to display
                    end if;
                    
             elsif count = "01" then--store operand 1 and move to state 1 (entering operand 2)
                    operand_2 := Switches;
                    if Switches(15) = '1' then
                        display := X"FFFF" & operand_2; --negative number to be sent to display
                    else
                        display := X"0000" & operand_2; --positive number to be sent to display
                    end if;

              elsif count = "10" then --store operand 2 and move to state 1
                    operation := Switches (3 downto 0);
                    display := X"0000000" & operation;-- State 2: Enter the Operation (zeros on all but segment 1 of 8)
                    
              else --store operation and move to state 3
                    if operation =  X"0" then --addition   
                        temp1 := (operand_1(15) & operand_1) + (operand_2(15) & operand_2);
                        if temp1(16) = '1' then   
                            display := X"FFFF" & temp1(15 downto 0); --send negative result to display
                        else
                            display := X"0000" & temp1(15 downto 0); --send positive result to display
                        end if;
                    elsif operation =  "0001" then --subtraction
                        temp1 := (operand_1(15) & operand_1) - (operand_2(15) & operand_2);
                        if temp1(16) = '1' then   
                            display := X"FFFF" & temp1(15 downto 0); --send negative result to display
                        else
                            display := X"0000" & temp1(15 downto 0); --send positive result to display
                        end if; 
                    elsif operation =  X"2" then --OR
                        temp2 :=  (operand_1 OR operand_2);
                        if temp2(15) = '1' then   
                            display := X"FFFF" & temp2(15 downto 0); --send negative result to display
                        else
                            display := X"0000" & temp2(15 downto 0); --send positive result to display
                        end if;
                    elsif operation =  X"3" then  -- AND
                        temp2 := (operand_1 AND operand_2);  
                        if temp2(15) = '1' then   
                            display := X"FFFF" & temp2(15 downto 0); --send negative result to display
                        else
                            Display_Value <= X"0000" & temp2(15 downto 0); --send positive result to display
                        end if;
                    else --Multiplication
                        mult := operand_1 * operand_2;
                        display := mult; --send the result of the multiplication to the display
                end if;
        end if;
        Display_Value <= display;

end process;
    
end Behavioral;
