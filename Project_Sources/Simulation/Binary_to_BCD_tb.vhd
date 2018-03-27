----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2017 11:07:37
-- Design Name: 
-- Module Name: Binary_to_BCD_tb - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Binary_to_BCD_tb is
end Binary_to_BCD_tb;

architecture Behavioral of Binary_to_BCD_tb is

component Binary_to_BCD

    Port ( Result : in STD_LOGIC_VECTOR (31 downto 0);
           Converted_BCD : out STD_LOGIC_VECTOR (31 downto 0));
           
end component; 

signal resultIn : STD_LOGIC_VECTOR(31 downto 0);
signal converted_BCD_Out : STD_LOGIC_VECTOR(31 downto 0);

begin

        U1 : Binary_to_BCD 
        port map (resultIn, converted_BCD_Out);
    process
    begin
    
        --addition result
        resultIn <= X"fffff5ae";
        wait for 1ns;
        --subtraction result
        resultIn <= X"ffff4d46";
        wait for 1ns;
        --OR result
        resultIn <= X"ffffafd6";
        wait for 1ns;
        --AND result
        resultIn <= X"00000038";
        wait for 1ns;
        --Multiplication result
        resultIn <= X"00704e05";
        wait for 1ns;
        
    end process;
end Behavioral;







