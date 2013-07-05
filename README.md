uart-rx
=======

Verilog module to receive data on UART.

Demo Application
----------------

- Compile the demo program for Virtex 5 FPGA on ML506 board. 
- Burn it. 
- Use a USB2TTL module and connect the ground of the USB2TTL with the FPGA ground and connect TxD pin of USB2TTL module to RxD on FPGA ( HDR1_2 pin ).
- Open a terminal program such as TeraTerm and set the baud rate to 115200
- Hit 0 and 3 leds should be off
- Hit 0-7 and observe the 3 leds (central,north and east on the ML506 board)
