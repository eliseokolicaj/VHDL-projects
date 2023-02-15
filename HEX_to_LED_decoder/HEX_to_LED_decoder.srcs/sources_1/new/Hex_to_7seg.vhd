----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Eliseo Kolicaj 
-- 
-- Create Date: 02/09/2023 12:22:14 PM
-- Design Name: 
-- Module Name: Hex_to_7seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Convert 4 bit hexadecimal input to 7 segment display Led
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

entity Hex_to_7seg is
Port (  hex : in std_logic_vector (3 downto 0);
        dp : in std_logic;
        sseg : out std_logic_vector (7 downto 0) );
end Hex_to_7seg;

architecture Behavioral of Hex_to_7seg is

begin

bits_to_7seg : process (hex)
begin
    case hex is 
        when "0000" =>
        sseg (6 downto 0) <="1000000";
        when "0001" =>
        sseg (6 downto 0) <="1111001";
        when "0010" =>
        sseg (6 downto 0) <="0100100";
        when "0011" =>
        sseg (6 downto 0) <="0110000";
        when "0100" =>
        sseg (6 downto 0) <="0011001";
        when "0101" =>
        sseg (6 downto 0) <="0010010";
        when "0110" =>
        sseg (6 downto 0) <="0000010";
        when "0111" =>
        sseg (6 downto 0) <="1111000";
        when "1000" =>
        sseg (6 downto 0) <="0000000";
        when "1001" =>
        sseg (6 downto 0) <="0010000";
        when "1010" =>
        sseg (6 downto 0) <="0001000"; --a
        when "1011" =>
        sseg (6 downto 0) <="0000011"; --b
        when "1100" =>
        sseg (6 downto 0) <="1000110"; --c
        when "1101" =>
        sseg (6 downto 0) <="0100001"; --d
        when "1110" =>
        sseg (6 downto 0) <="0000110"; --e
        when others => 
        sseg (6 downto 0) <="0001110"; --f
    end case;
    sseg(7) <= dp;
end process bits_to_7seg;

end Behavioral;
