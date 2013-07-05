`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:01:13 07/05/2013
// Design Name:   uartrx
// Module Name:   K:/fpga_projs/uart_rx/tb.v
// Project Name:  uart_rx
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uartrx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg clk;
	reg rst;
	reg rxd;
	reg ack;

	// Outputs
	wire [7:0] data;
	wire req;

	// Instantiate the Unit Under Test (UUT)
	uartrx #(.div(100)) uut (
		.clk(clk), 
		.rst(rst), 
		.rxd(rxd), 
		.data(data), 
		.req(req), 
		.ack(ack)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		rxd = 1;
		ack = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
		// Add stimulus here
		
		#1000;
		
		// sending 0x55
		rxd = 0;
		#1000; // sending start bit
		rxd = 1;
		#1000; // sending lsb (whats above this)
		rxd = 0;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending msb
		rxd = 1;
		#1000; // sending stop
		
		// sending 0x12
		rxd = 0;
		#1000; // sending start bit
		rxd = 0;
		#1000; // sending lsb (whats above this)
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending msb
		rxd = 1;
		#1000; // sending stop
		 
		#3535;
		// sending 0xB3
		rxd = 0;
		#1000; // sending start bit
		rxd = 1;
		#1000; // sending lsb (whats above this)
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending next bit
		rxd = 0;
		#1000; // sending next bit
		rxd = 1;
		#1000; // sending msb
		rxd = 1;
		#1000; // sending stop
		
		#2000;

	end
	
	always begin
		#5 clk = ~clk;
	end
      
endmodule

