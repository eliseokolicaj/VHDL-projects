/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include <string.h>
#include "xparameters.h"
#include "xil_cache.h"
#include "xiomodule.h"


int main()
{
    int done = 0;
    int byte_count = 0;
    int execute_cmd;
    char command [6];
    char led_cmd [3];
    char led_num [2];
    u8 tmp_rx_buf;
    u8 rx_buf[40];
    u32 button_data = 0;
    u32 switch_data = 0;
    u32 led_data = 0;
    u32 data;
    XIOModule iomodule;

	Xil_ICacheEnable ();
	Xil_DCacheEnable ();

	// Initialize module
	data = XIOModule_Initialize(&iomodule,XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start (&iomodule);
	data = XIOModule_CfgInitialize (&iomodule,NULL,1);
	xil_printf("CFInitialization returned (0=success) %d \n\r",data);

	print("---- ENTER COMMAND -----\n\r");

	//While loop until user enters "finish" command

	while(done==0)
	{
		execute_cmd = 0;
		memset(rx_buf,0,sizeof(rx_buf));
		byte_count = 0 ;

		//Build up message from UART Terminal
		while (execute_cmd == 0)
		{
			// Read UART data
			while ((data = XIOModule_Recv,(&iomodule,&tmp_rx_buf,1))==0);

			rx_buf[byte_count] = tmp_rx_buf;

			if(rx_buf[byte_count]== '\n')
				execute_cmd = 1;
			byte_count++;
		}

	// Build command arrays
	memcpy(command,&rx_buf[0],6);
	memcpy(led_cmd,&rx_buf[0],3);
	memcpy(led_num,&rx_buf[4],2);

	// Read the button and switch status
	button_data = XIOModule_DiscreteRead(&iomodule,1);
	switch_data = XIOModule_DiscreteRead(&iomodule,2);

	// Execute the recieved command

	if (strcmp(command,"led")==0)
	{
		led_data = led_num[1] - 48;

		if ((led_num[0]-48) == 1)
			led_data +=10;

		XIOModule_DiscreteWrite(&iomodule,1,led_data);
	}
	else if (strcmp(command,"button")==0)
		xil_printf ("Button status = %d\n\r",button_data);
	else if (strcmp(command,"switch")==0)
			xil_printf ("Switch status = %d\n\r",button_data);
	else if (strcmp(command,"finish")==0)
			done=1;
    else
    	print("Command Invalid ,please re-enter below: \n\r");
	}

print ("----- Exiting Main -----");
Xil_ICacheDisable ();
Xil_DCacheDisable ();
return 0;

}
