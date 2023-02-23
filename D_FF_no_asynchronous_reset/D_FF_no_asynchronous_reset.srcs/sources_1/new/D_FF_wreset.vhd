----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Eliseo Kolicaj
-- 
-- Create Date: 02/23/2023 07:56:37 PM
-- Design Name: 
-- Module Name: D_FF_wreset - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: D FF without asynchronous reset
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

entity D_FF_wreset is
Port ( clk : in std_logic;
        d : in std_logic;
        q : out std_logic );
end D_FF_wreset;

architecture Behavioral of D_FF_wreset is

begin
clk_proc : process (clk)
begin
     if (rising_edge (clk)) then 
         q <= d;
     end if;
end process clk_proc;
end Behavioral;
