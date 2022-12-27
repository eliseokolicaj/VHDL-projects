----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/27/2022 02:04:50 PM
-- Design Name: 
-- Module Name: test_counter - Behavioral
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

entity test_counter is
end test_counter;

architecture Behavioral of test_counter is

component Counter 
Generic(
        MAX_VALUE : integer := 2**30;
        SYNCH_RESET : boolean := true);
Port (
    clk       : in std_logic;
    reset     : in std_logic;
    Max_count : out std_logic);
end component Counter;

signal clk : std_logic := '0';
signal reset :  std_logic := '0';
signal Max_count : std_logic;

begin

dev_to_test : Counter 
generic map (MAX_VALUE =>1000000,SYNCH_RESET => true)
port map (clk => clk, reset => reset, Max_count => Max_count);

Clk_stimulus : process 
begin 
      wait for 10 ns;
      clk <= not clk;
end process clk_stimulus;

Reset_stimulus : process
begin
    wait for 50 ns;
    reset <= not reset;
    wait for 150 ns; 
end process Reset_stimulus;

end Behavioral;
