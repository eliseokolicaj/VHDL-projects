----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Eliseo Kolicaj
-- 
-- Create Date: 02/18/2023 03:09:41 PM
-- Design Name: 
-- Module Name: bit_shifter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8 bit barrel shifter that rotates an arbitrary number of bits to the right.
--              
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

entity bit_shifter is
 Port ( a : in std_logic_vector ( 7 downto 0);
        amt : in std_logic_vector (2 downto 0);
        y : out std_logic_vector ( 7 downto 0) );
end bit_shifter;

architecture Behavioral of bit_shifter is

signal s0,s1 : std_logic_vector ( 7 downto 0);

begin

    -- stage 0, shifts 1 bit or 0                                           -- since  amt is 3 bit input  m2 m1 m0 then use this formula 
    s0 <= a(0) & a (7 downto 1) when amt (0) <= '1' else a;                 -- to shifts bits m2*2^2 + m1*2^1 + m0*2^0
    -- stage 1 , shifts 2 bits or 0
    s1 <= s0(1 downto 0) & s0(7 downto 2) when amt(1) <= '1' else s0;
    -- stage 2 , shift 4 bits or 0
    y <= s1(3 downto 0) & s1(7 downto 4) when amt(2) <= '1' else s1;
    
end Behavioral;  







