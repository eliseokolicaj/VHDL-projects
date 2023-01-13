--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Wed Dec 28 18:48:02 2022
--Host        : DESKTOP-848E4O3 running 64-bit major release  (build 9200)
--Command     : generate_target UART_demo_wrapper.bd
--Design      : UART_demo_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity UART_demo_wrapper is
  port (
    Input_clk : in STD_LOGIC;
    Reset_top : in STD_LOGIC;
    UART_tx : out STD_LOGIC
  );
end UART_demo_wrapper;

architecture STRUCTURE of UART_demo_wrapper is
  component UART_demo is
  port (
    Input_clk : in STD_LOGIC;
    Reset_top : in STD_LOGIC;
    UART_tx : out STD_LOGIC
  );
  end component UART_demo;
begin
UART_demo_i: component UART_demo
     port map (
      Input_clk => Input_clk,
      Reset_top => Reset_top,
      UART_tx => UART_tx
    );
end STRUCTURE;
