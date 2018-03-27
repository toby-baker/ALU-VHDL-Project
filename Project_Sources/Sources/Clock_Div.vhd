----------------------------------------------------------------------------------
-- Company: University of Canterbury
-- Engineers: Toby Baker and Robbie Day
-- 
-- Create Date: 03/14/2017 11:31:55 AM
-- Module Name: Clock_Div - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Clock Divider to control Multiplexing. Divides the clock to give
-- an output signal of 1000Hz.
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

entity Clock_Div is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end Clock_Div;

architecture Behavioral of Clock_Div is

        constant clk_limit : STD_LOGIC_VECTOR  (15 downto 0) := X"C350"; --50,000
        signal clk_ctr : STD_LOGIC_VECTOR(15 downto 0);
        signal temp_clk : std_logic;       
        
begin
    --clock divider 100MHz to 1000Hz
    clock: process(clk_in)
        begin
        if clk_in = '1' and clk_in'Event then
            if clk_ctr = clk_limit then -- if counter == (50000)
                temp_clk <= not temp_clk;   -- toggle clock
                clk_ctr <= X"0000";      -- reset counter
            else
                clk_ctr <= clk_ctr + X"0001"; -- counter = counter + 1
            end if;
        end if;
    end process clock;
    clk_out <= temp_clk;     -- continuosly update clock output 
    
end Behavioral;
