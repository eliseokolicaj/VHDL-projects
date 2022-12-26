----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2022 04:39:18 PM
-- Design Name: 
-- Module Name: test_shift_reg - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_shift_reg is
end test_shift_reg;

architecture Behavioral of test_shift_reg is

component Shift_reg 
 Port (data_in : in std_logic;
       clk     : in std_logic;
       reset   : in std_logic;
       A       : out std_logic;
       B       : out std_logic;
       C       : out std_logic;
       D       : out std_logic);
end component;

signal data_in :  std_logic := '0';
signal reset :  std_logic := '0';
signal clk :  std_logic := '1';
signal A,B,C,D :  std_logic;

begin

dev_to_test : Shift_reg
port map (A => A,B => B ,C => C ,D => D,data_in => data_in,clk => clk,reset => reset);

clk_stimulus : process 
begin 
      wait for 10 ns;
      clk <= not clk;
end process clk_stimulus;

data_stimulus : process
begin 
     wait for 40 ns;
     data_in <= not data_in;
     wait for 120 ns;
end process data_stimulus;

end Behavioral;
