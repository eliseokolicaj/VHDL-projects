----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Eliseo Kolicaj
-- 
-- Create Date: 12/23/2022 04:57:50 PM
-- Design Name: 
-- Module Name: blinky_LED - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity blinky_LED is

Generic (
          NUM_LEDS : integer := 4;
          CLK_RATE : integer := 100000000;
          BLINK_RATE : integer := 2
          );
Port (
          Clk : in std_logic;
          Reset : in std_logic;
          Led_out : out std_logic_vector (NUM_LEDS - 1 downto 0) );
end blinky_LED;

architecture Behavioral of blinky_LED is

--Calculate count value to determine Blink rate

constant MAX_VALUE : integer := CLK_RATE / BLINK_RATE;
constant BIT_DEPTH : integer := integer (ceil(log2(real(MAX_VALUE))));  -- how many bits to count to MAX_VALUE

signal count_reg : unsigned ( BIT_DEPTH - 1 downto 0 ) := (others => '0');  --holds count value 
signal led_reg : std_logic_vector (NUM_LEDS - 1 downto 0) := "0000";-- holds valueto be  outputed to leds

begin

--Assign output Led value
Led_out <= led_reg;

--Process that increments the counter every rising edge clock
count_proc: process(Clk)
begin
    if (rising_edge (Clk)) then
        if (Reset = '0') or (count_reg = MAX_VALUE) then
            count_reg <= (others => '0');
        else
            count_reg <= count_reg + 1;
        end if;
    end if;

end process count_proc;

--Process that will toggle led output every time thst counter reaches 'MAX_VALUE'
output_proc: process (Clk)
begin
    if (rising_edge (Clk)) then
        if (count_reg = MAX_VALUE) then
            led_reg <= not led_reg;
        end if;
    end if;

end process output_proc;
end Behavioral;
