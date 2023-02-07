----------------------------------------------------------------------------------
-- Company: 
-- Engineer:Eliseo Kolicaj 
-- 
-- Create Date: 02/07/2023 11:56:59 AM
-- Design Name: 
-- Module Name: 2_bit_comp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-bit comparator using 1-bit comparator gate-level combinational circuit
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

entity bit_comp is
Port ( x,y : in std_logic_vector (1 downto 0);
        xeqy : out std_logic );
end bit_comp;

architecture Behavioral of bit_comp is
signal e0,e1 : std_logic;

-- component declaration 
component eq_bit
Port ( a,b : in std_logic ;
        eq : out std_logic);
end component;

begin

-- instantiation of 2-bit comparator 
bit0_comp : eq_bit
port map( a => x(0), b => y(0), eq => e0 );
bit1_comp : eq_bit
port map( a => x(1), b => y(1), eq => e1 );

-- output
xeqy <= e0 and e1;
end Behavioral;
