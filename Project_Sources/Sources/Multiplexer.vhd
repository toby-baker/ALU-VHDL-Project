----------------------------------------------------------------------------------
-- Company: University of Canterbury
-- Engineer: Toby Baker and Robbie Day
-- 
-- Create Date: 19.03.2017 21:16:30
-- Module Name: Multiplexer - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Multiplexes the 8-digit display and controls which value is 
-- displayed on each digit at one time.
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

entity Multiplexer is
    Port ( count : in STD_LOGIC_VECTOR (2 downto 0);
           bcd : in STD_LOGIC_VECTOR (31 downto 0);
           z : out STD_LOGIC_VECTOR (3 downto 0); --the bcd for one light
           AN : out STD_LOGIC_VECTOR (7 downto 0)); --controls which lights are on
end Multiplexer;

architecture Behavioral of Multiplexer is

begin

    p1: process(count, bcd)
    begin
        --case statement to multiplex each 7seg display
        case count is 
            when "000"  =>
                 z <= bcd(3 downto 0); --ones column
                 AN <= "11111110"; --digit 1 on
            when "001"  =>
                z <= bcd(7 downto 4); --tens
                AN  <= "11111101"; --digit 2 on
            when "010" =>
                z <= bcd(11 downto 8); --hundreds
                AN <= "11111011"; --digit 3 on
            when "011" => 
                z <= bcd(15 downto 12); --thousand
                AN <= "11110111"; --digit 4 on
            when "100" =>
                z <= bcd(19 downto 16); --tens of thousands
                AN <= "11101111"; --digit 5 on
            when "101" =>
                z <= bcd(23 downto 20); -- hundreds of thousands
                AN <= "11011111"; --digit 6 on
            when "110" =>
                z <= bcd(27 downto 24); --millions
                AN <= "10111111"; --digit 7 on
            when "111" =>
                z <= "111" & bcd(31); --sign
                AN <= "01111111"; --digit 8 on
        end case;
    end process;

end Behavioral;
