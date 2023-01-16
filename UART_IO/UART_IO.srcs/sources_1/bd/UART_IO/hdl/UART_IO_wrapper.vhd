--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Mon Jan  9 19:03:04 2023
--Host        : DESKTOP-848E4O3 running 64-bit major release  (build 9200)
--Command     : generate_target UART_IO_wrapper.bd
--Design      : UART_IO_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity UART_IO_wrapper is
  port (
    Input_clk : in STD_LOGIC;
    Reset_Top : in STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    UART_Tx : out STD_LOGIC;
    btn : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end UART_IO_wrapper;

architecture STRUCTURE of UART_IO_wrapper is
  component UART_IO is
  port (
    Input_clk : in STD_LOGIC;
    Reset_Top : in STD_LOGIC;
    UART_Tx : out STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    btn : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sw : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component UART_IO;
begin
UART_IO_i: component UART_IO
     port map (
      Input_clk => Input_clk,
      Reset_Top => Reset_Top,
      UART_Rx => UART_Rx,
      UART_Tx => UART_Tx,
      btn(3 downto 0) => btn(3 downto 0),
      led(3 downto 0) => led(3 downto 0),
      sw(2 downto 0) => sw(2 downto 0)
    );
end STRUCTURE;
