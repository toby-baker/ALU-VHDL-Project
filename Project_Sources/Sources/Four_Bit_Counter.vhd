----------------------------------------------------------------------------------
-- Company: University of Canterbury    
-- Engineers: Toby Baker and Robbie Day
--
-- Create Date: 03/14/2017 11:31:55 AM
-- Module Name: Four_Bit_Counter - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Three bit counter incremented by the divided clock signal. Counting
-- the full 3-bit range.
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

entity Three_Bit_Counter is
    Port ( clk, reset : in STD_LOGIC;
           q_out : out STD_LOGIC_VECTOR (2 downto 0));
end Three_Bit_Counter;

architecture Behavioral of Three_Bit_Counter is

signal count : std_logic_vector (2 downto 0);

begin

    process (reset, clk) is 
        begin 
            if RESET = '1' then --asynch reset, active high
                count <= "000";
            elsif (clk'event and clk = '1') then 
                if (count = "111") then -- reset counter after max count reached
                    count <= "000";
                else 
                    count <= count + "001"; --increment counter
                end if;
            end if;
            
     end process;
     
     q_out <= count; --continuously update the count

end Behavioral;
