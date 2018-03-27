----------------------------------------------------------------------------------
-- Company: University of Canterbury    
-- Engineer: Toby Baker and Robbie Day
-- 
-- Create Date: 26.04.2017 10:59:01
-- Module Name: Binary_to_BCD - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Converts a 32-bit binary number to its 32-bit BCD equivalent.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Binary_to_BCD is
    Port ( Result : in STD_LOGIC_VECTOR (31 downto 0);
           Converted_BCD : out STD_LOGIC_VECTOR (31 downto 0));
end Binary_to_BCD;

architecture Behavioral of Binary_to_BCD is

begin

process(Result)
  
    variable shift : std_logic_vector (63 downto 0) := X"0000000000000000";
    
    alias num is shift(31 downto 0);
    alias one is shift(35 downto 32);
    alias two is shift(39 downto 36);
    alias three is shift(43 downto 40);
    alias four is shift(47 downto 44);
    alias five is shift(51 downto 48);
    alias six is shift(55 downto 52);
    alias seven is shift(59 downto 56);
    
    begin
        if Result(31) = '1' then
            num := NOT Result(31 downto 0) + X"00000001";
        else
            num := Result(31 downto 0);
        end if;
        
        one := X"0";
        two := X"0";
        three := X"0";
        four := X"0";
        five := X"0";
        six := X"0";
        seven := X"0";
        
        --BCD algorithm
        for i in 1 to 32 loop
	     -- Check if any digit is greater than or equal to 5
        if one >= "0101" then
           one := one + "0011"; 
        end if;
        
        if two >= "0101" then
            two := two + "0011";
        end if;
        
        if three >= "0101" then
            three := three + "0011";
        end if;

        if four >= "0101" then
            four := four + "0011";
        end if;

        if five >= "0101" then
            five := five + "0011";
        end if;

        if six >= "0101" then
            six := six + "0011";
        end if;

        if seven >= "0101" then
            seven := seven + "0011";
        end if;
        
        -- Shift left
        shift := shift(62 downto 0) & '0';
     end loop;
    
    --set each bcd value
    --digit 8 is reserved for sign only, displauys a - or nothing
    Converted_BCD <= Result(31 downto 28) & seven & six & five & four & three & two & one;
    
end process;

end Behavioral;
