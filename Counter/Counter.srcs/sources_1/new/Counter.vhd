----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Eliseo Kolicaj
-- 
-- Create Date: 12/26/2022 04:10:14 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
-- Project Name: Counter
-- Target Devices: 
-- Tool Versions: 
-- Description: Up Counter with either a synchronous reset or asynchronous reset
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
Generic(
        MAX_VALUE : integer := 2**30;
        SYNCH_RESET : boolean := true);
Port (
        clk       : in std_logic;
        reset     : in std_logic;
        Max_count : out std_logic);
end Counter;

architecture Behavioral of Counter is

constant bit_depth : integer :=integer (ceil(log2(real(MAX_VALUE))));
signal   count_reg : unsigned( bit_depth - 1 to 0) := (others => '0');

begin

Synch_rst : if SYNCH_RESET = true generate
    count_proc : process (clk)
    begin
        if rising_edge (clk) then
            if(reset = '0') or (count_reg=MAX_VALUE) then
                count_reg <= (others => '0');
            else
                count_reg <= count_reg + 1;
            end if;
        end if;
    end process count_proc;
end generate;

Asynch_rst : if SYNCH_RESET = false generate
    count_proc : process (reset,clk)
    begin
        if (reset = '0') then
            count_reg <= (others => '0');
        elsif rising_edge (clk) then
            if (count_reg = MAX_VALUE) then
                count_reg <= (others => '0');
            else
                count_reg <= count_reg + 1;
            end if;
        end if;
    end process count_proc;
end generate;

output_proc : process (count_reg)
begin
    Max_count <= '0';
    if (count_reg = MAX_VALUE)then
        Max_count <= '1';
    end if;
end process output_proc;

end Behavioral;
