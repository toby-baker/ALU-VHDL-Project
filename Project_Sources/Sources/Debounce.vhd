--------------------------------------------------------------------------------
-- Company: University of Canterbury
-- Engineers: Toby Baker and Robbie Day
-- 
-- Create Date: 03/14/2017 11:31:55 AM
-- Module Name: Seven_Seg_Decoder - Behavioral
-- Project Name: 16-bit ALU
-- Target Devices: Nexys4 DDR
-- Tool Versions: Vivado 2016.4
-- Description: Module for debouncing the buttons. A push is registered as high
-- after 10.5ms (enough timr for bouncing to stop).
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Debounce is
  generic(
    counter_size  :  INTEGER := 20); --gives 10.5ms for the 100MHz clock
  Port(
    clk     : in  STD_LOGIC;  --input clock
    button  : in  STD_LOGIC;  --input signal to be debounced
    button_debounced  : out STD_LOGIC); --debounced signal
    
end Debounce;

Architecture Behavioral OF Debounce IS
  SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0); --input flip flops
  SIGNAL counter_set : STD_LOGIC;                    --sync reset to zero
  SIGNAL counter_out : STD_LOGIC_VECTOR(counter_size downto 0) := (others => '0'); --counter output
BEGIN

  counter_set <= flipflops(0) xor flipflops(1);   --determine when to start/reset counter
  
  process(clk)
  begin
    if (clk'EVENT and clk = '1') then
      flipflops(0) <= button;
      flipflops(1) <= flipflops(0);
      if (counter_set = '1') then                  --reset counter because input is changing
        counter_out <= (others => '0');
      elsif(counter_out(counter_size) = '0') then --stable input time is not yet met
        counter_out <= counter_out + 1;
      else                                        --stable input time is met
        button_debounced <= flipflops(1);
      end if;    
    end if;
  end process;
end Behavioral;
