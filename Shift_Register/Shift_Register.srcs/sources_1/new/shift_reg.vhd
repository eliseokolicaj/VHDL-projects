----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2022 04:04:16 PM
-- Design Name: 
-- Module Name: shift_reg - Behavioral
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

entity shift_reg is
 Port (data_in : in std_logic;
       clk     : in std_logic;
       reset   : in std_logic;
       A       : out std_logic;
       B       : out std_logic;
       C       : out std_logic;
       D       : out std_logic);
end shift_reg;

architecture Behavioral of shift_reg is

--Define Signals
signal A_reg,B_reg : std_logic := '0';
signal C_reg,D_reg : std_logic := '0';

--Begin Architecture
begin

--Signal Assignments
A <= A_reg;
B <= B_reg;
C <= C_reg;
D <= D_reg;

reg_process : process (clk)
begin
if (rising_edge (clk))then
   if (reset = '1') then
       A_reg <= '0';
       B_reg <= '0';
       C_reg <= '0';
       D_reg <= '0';
   else
       A_reg <= data_in;
       B_reg <= A_reg;
       C_reg <= B_reg;
       D_reg <= C_reg;
   end if;
end if;
end process reg_process;
end Behavioral;
