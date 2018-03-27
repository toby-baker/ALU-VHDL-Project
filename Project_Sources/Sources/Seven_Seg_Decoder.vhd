----------------------------------------------------------------------------------
-- Company: University of Canterbury
-- Engineer: Toby Baker and Robbie Day
-- 
-- Create Date: 03/14/2017 11:31:55 AM
-- Module Name: Seven_Seg_Decoder - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Decodes a 4-bit BCD value to control the 7-segments of the digit.
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

entity Seven_Seg_Decoder is
    Port ( num_in : in STD_LOGIC_VECTOR (3 downto 0);
           segments_out : out STD_LOGIC_VECTOR (6 downto 0));
end Seven_Seg_Decoder;

architecture Behavioral of Seven_Seg_Decoder is

begin

    my_seg_process: process(num_in)
        begin
            case num_in is   --                    "6543210"
				when "0000"	=> segments_out <= "0000001";	  -- if BCD is "0000" write a zero to display
                when "0001" => segments_out <= "1001111";      -- etc...
                when "0010" => segments_out <= "0010010";
                when "0011" => segments_out <= "0000110";
                when "0100" => segments_out <= "1001100";
                when "0101" => segments_out <= "0100100";
                when "0110" => segments_out <= "0100000";
                when "0111" => segments_out <= "0001111";
                when "1000" => segments_out <= "0000000";
                when "1001" => segments_out <= "0000100";
                when "1111" => segments_out <= "1111110"; --display minus sign for negative number
                when "1110" => segments_out <= "1111111"; --display nothing for positive number
                when others => segments_out <= "0000100";
                
            end case;
    end process my_seg_process;

end Behavioral;
