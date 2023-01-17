--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Tue Jan 17 17:58:07 2023
--Host        : DESKTOP-848E4O3 running 64-bit major release  (build 9200)
--Command     : generate_target temp_sensor_wrapper.bd
--Design      : temp_sensor_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity temp_sensor_wrapper is
  port (
    adc_enable : in STD_LOGIC;
    ck_an_n : in STD_LOGIC;
    ck_an_p : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    temp_mode_select : in STD_LOGIC;
    uart_rx : in STD_LOGIC;
    uart_tx : out STD_LOGIC
  );
end temp_sensor_wrapper;

architecture STRUCTURE of temp_sensor_wrapper is
  component temp_sensor is
  port (
    adc_enable : in STD_LOGIC;
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    ck_an_n : in STD_LOGIC;
    ck_an_p : in STD_LOGIC;
    uart_rx : in STD_LOGIC;
    uart_tx : out STD_LOGIC;
    temp_mode_select : in STD_LOGIC
  );
  end component temp_sensor;
begin
temp_sensor_i: component temp_sensor
     port map (
      adc_enable => adc_enable,
      ck_an_n => ck_an_n,
      ck_an_p => ck_an_p,
      clk => clk,
      reset => reset,
      temp_mode_select => temp_mode_select,
      uart_rx => uart_rx,
      uart_tx => uart_tx
    );
end STRUCTURE;
