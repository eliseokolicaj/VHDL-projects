----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Eliseo Kolicaj
-- 
-- Create Date: 12/27/2022 08:32:39 PM
-- Design Name: 
-- Module Name: LED_brightness - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This design uses a Counter to change the duty cycle of a PWM
              --The PWM are used to change the brightness of LEDs,the higher the duty 
              --cycle is the brighter the LED becomes.If duty cycle is 100% it
              --makes the LED brightest.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:If there are no RGB Leds the you can do the following:
--                      1- Put 0 on 'NUM_RGB_LEDS' generic
--                      2- Leave signals associated to RGB leds disconnected.
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

entity LED_brightness is
    Generic (   INPUT_CLK   : integer := 100000000;
                NUM_RGB_LED : integer := 4;
                NUM_LEDS    : integer := 4);
    
    Port (      Clk         : in std_logic ;
                LED_enable  : in std_logic;
                RGB_enable  : in std_logic; -- Active low
                Led_out     : out std_logic_vector (NUM_LEDS - 1 downto 0);
                RGB_R_out   : out std_logic_vector (NUM_RGB_LED - 1 downto 0);
                RGB_G_out   : out std_logic_vector (NUM_RGB_LED - 1 downto 0);
                RGB_B_out   : out std_logic_vector (NUM_RGB_LED - 1 downto 0));
end LED_brightness;

architecture Behavioral of LED_brightness is
-- Components
component Counter
Generic(
        MAX_VALUE : integer := 2**30;
        SYNCH_RESET : boolean := true);
Port (
        clk       : in std_logic;
        reset     : in std_logic;
        Max_count : out std_logic
);
end component Counter;

component PWM_design
Generic (
         BIT_DEPTH  : integer := 8;
         INPUT_CLK  : integer := 5000000; -- 50MHZ
         FREQ       : integer := 50 ); -- 50 HZ
Port (
        Clk         : in std_logic;
        Enable      : in std_logic;
        Duty_cycle  : in std_logic_vector (BIT_DEPTH - 1 downto 0);
        Pwm_Out     : out std_logic);
end component PWM_design;

-- Constants and Signals
constant LED_MAX_COUNT : integer := INPUT_CLK / 85; -- 8 bit depth means counting from 0 to 255 (the max PWM value). 255/3=85
constant RGB_MAX_COUNT : integer := INPUT_CLK / 1365;
constant SYN_RESET     : boolean := true;
constant MAX_LED_DUTY  : integer := 255;
constant MAX_RGB_DUTY  : integer := 4095;

signal led_max_cnt     : std_logic :='0';
signal rgb_max_cnt     : std_logic :='0';

signal led_pwm_reg     : std_logic :='0';
signal red_pwm_reg     : std_logic :='0';
signal grn_pwm_reg     : std_logic :='0';
signal blu_pwm_reg     : std_logic :='0';

signal rgb_counter_rst : std_logic :='0';
signal led_counter_rst : std_logic :='0';

signal led_duty_cycle  : unsigned ( 7 downto 0 ) := (others => '0');
signal rgb_duty_cycle  : unsigned ( 11 downto 0 ) := (others => '0');

begin
    --Assign outputs
    Led_out <= (others => led_pwm_reg);
    RGB_R_out <= (others => red_pwm_reg);
    RGB_G_out <= (others => grn_pwm_reg);
    RGB_B_out <= (others => blu_pwm_reg);
    
    --Invert enable signal for counter
    rgb_counter_rst <= not RGB_enable;
    led_counter_rst <= not LED_enable;
    
    --Led Counter
    led_counter : Counter 
        generic map (MAX_VALUE => LED_MAX_COUNT,SYNCH_RESET =>SYN_RESET )
        port map (clk => Clk,reset => led_counter_rst,Max_count => led_max_cnt);
    
    --RGB Counter 
    rgb_counter : Counter
        generic map (MAX_VALUE =>RGB_MAX_COUNT,SYNCH_RESET =>SYN_RESET)
        port map (clk => Clk,reset => rgb_counter_rst,Max_count => rgb_max_cnt);
     
    --Led PWM signal generator (8 bit,50 hz)
    led_pwm : PWM_design
        generic map (BIT_DEPTH => 8,INPUT_CLK => INPUT_CLK,FREQ =>50 )
        port map (Clk => Clk,Enable =>LED_enable,Duty_cycle =>std_logic_vector(led_duty_cycle),Pwm_Out =>led_pwm_reg ); 
        
     --RGB red led signal generator (4 bit,50 hz)
    red_pwm : PWM_design
        generic map (BIT_DEPTH => 4,INPUT_CLK => INPUT_CLK,FREQ =>50 )
        port map (Clk => Clk,Enable =>RGB_enable,Duty_cycle =>std_logic_vector(rgb_duty_cycle(3 downto 0)),Pwm_Out =>red_pwm_reg ); 
        
      --RGB green led signal generator (4 bit,50 hz)
    green_pwm : PWM_design
        generic map (BIT_DEPTH => 4,INPUT_CLK => INPUT_CLK,FREQ =>50 )
        port map (Clk => Clk,Enable =>RGB_enable,Duty_cycle =>std_logic_vector(rgb_duty_cycle(7 downto 4)),Pwm_Out =>grn_pwm_reg );
        
    --RGB blue led signal generator (4 bit,50 hz)
    blue_pwm : PWM_design
        generic map (BIT_DEPTH => 4,INPUT_CLK => INPUT_CLK,FREQ =>50 )
        port map (Clk => Clk,Enable =>RGB_enable,Duty_cycle =>std_logic_vector(rgb_duty_cycle(11 downto 8)),Pwm_Out =>blu_pwm_reg );
        
        --LED pwm update process
        led_count_proc : process (Clk)
        begin
            if rising_edge (Clk) then
                if (led_duty_cycle = MAX_LED_DUTY) then
                    led_duty_cycle <= (others => '0'); 
                elsif (led_max_cnt ='1') then
                    led_duty_cycle <= led_duty_cycle + 1;
                end if;
            end if;
        end process led_count_proc;    
        
        --RGB pwm update process
        rgb_count_proc : process (Clk)
        begin
            if rising_edge (Clk) then
                if (rgb_duty_cycle = MAX_RGB_DUTY) then
                    rgb_duty_cycle <= (others => '0'); 
                elsif (rgb_max_cnt ='1') then
                    rgb_duty_cycle <=rgb_duty_cycle + 1;
                end if;
            end if;
        end process rgb_count_proc;
        
end Behavioral;
