----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2023 11:59:36 AM
-- Design Name: 
-- Module Name: bit_eq - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit_eq is
Port ( a,b : in std_logic ;
        eq : out std_logic);
end bit_eq;

architecture Behavioral of bit_eq is
signal eq1 , eq2 : std_logic;

begin

-- sum of two product terms
eq <= eq1 or eq2 ;
--product terms
eq1<= (not a) and (not b);
eq2<= a and b;

end Behavioral;
