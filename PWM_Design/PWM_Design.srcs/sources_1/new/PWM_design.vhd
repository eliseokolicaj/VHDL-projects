----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2022 10:00:33 PM
-- Design Name: 
-- Module Name: PWM_design - Behavioral
-- Project Name: PWM
-- Target Devices: 
-- Tool Versions: 
-- Description: Produces a pulse width modulated (PWM)signal 
--              based on value input on the input 'Duty_Cycle' 
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

entity PWM_design is
Generic (
         BIT_DEPTH  : integer := 8;
         INPUT_CLK  : integer := 5000000; -- 50MHZ
         FREQ       : integer := 50 ); -- 50 HZ
Port (
        Clk         : in std_logic;
        Enable      : in std_logic;
        Duty_cycle  : in std_logic_vector (BIT_DEPTH - 1 downto 0);
        Pwm_Out     : out std_logic);
end PWM_design;

architecture Behavioral of PWM_design is
-- Constants
constant max_freq_count : integer := INPUT_CLK /FREQ;
constant pwm_step       : integer := max_freq_count / (2**BIT_DEPTH);

--Signals
signal pwm_value        : std_logic := '0';
signal freq_count       : integer range  0 to max_freq_count := 0;
signal pwm_count        : integer range  0 to 2**BIT_DEPTH   := 0;
signal max_pwm_count    : integer range  0 to 2**BIT_DEPTH   := 0;
signal pwm_step_count   : integer range  0 to max_freq_count := 0;

begin
-- Convert Duty Cycle to max_pwm_count 
max_pwm_count <= to_integer (unsigned(Duty_cycle));
Pwm_Out <= pwm_value;

--Process that runs signal out at a correct frequency
freq_counter : process (Clk)
begin
    if(rising_edge(Clk)) then
        if (Enable = '0') then
            if(freq_count < max_freq_count) then
                freq_count <= freq_count + 1;
                if (pwm_count < max_pwm_count) then
                    pwm_value <= '1';
                    if (pwm_step_count < pwm_step) then
                        pwm_step_count <= pwm_step_count +1;
                    else
                        pwm_step_count <= 0;
                        pwm_count <= 0;
                    end if;
                else
                    pwm_value <= '0';
                end if;
            else
                freq_count <= 0;
                pwm_count <= 0;
            end if;
        else
            pwm_value <= '0';
        end if;
    end if;
 end process freq_counter;

end Behavioral;
