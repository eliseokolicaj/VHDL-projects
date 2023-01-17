/*
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 */

/*
 * 
 *
 * This file is a generated sample test application.
 *
 * This application is intended to test and/or illustrate some 
 * functionality of your system.  The contents of this file may
 * vary depending on the IP in your system and may use existing
 * IP driver functions.  These drivers will be generated in your
 * SDK application project when you run the "Generate Libraries" menu item.
 *
 */

#include <stdio.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xiomodule.h"
#include "iomodule_header.h"
int main () 
{
  u32 data, adc_reading, selected_degree;
  float voltage_mV,temperature_C, temperature_F;
  float temperature_out;
  int delay_count,temperature_whole,temperature_hundreds;

  XIOModule gpi;

  //Initialize GPIO's
  data = XIOModule_Initialize(&gpi,XPAR_IOMODULE_0_DEVICE_ID);
  data =XIOModule_Start (&gpi);

  while (1)
  {
	  adc_reading = XIOModule_DiscreteRead(&gpi,1); //perform adc reading
	  adc_reading = adc_reading >> 4;  // shift 4 lsb's

	  selected_degree = XIOModule_DiscreteRead(&gpi,2); // read slide switch to determine C or F
	  voltage_mV= (float) (3.3/4095) *  (float)adc_reading * 1000; // determine voltage reading
	  temperature_C = (voltage_mV - 500) / 10; //calculate temp in C

	  temperature_out = temperature_C;

	  if (selected_degree == 1)
	  {
		  // calculate temp in farenheight
		  temperature_F = (temperature_C * 1.8) + 32;
		  temperature_out = temperature_F;
	  }

	  // Output Temperature
	  temperature_whole = temperature_out;
	  temperature_hundreds = (temperature_out - temperature_whole) * 100;

	  if (selected_degree == 0)
		  xil_printf("Temperature : %d.%d C\n\r",temperature_whole,temperature_hundreds);
	  else
          xil_printf("Temperature : %d.%d F\n\r",temperature_whole,temperature_hundreds);

	  // delay
	  delay_count = 0 ;
	  while (delay_count < 50000000)
		  delay_count++;
  }
  return 0;
}
