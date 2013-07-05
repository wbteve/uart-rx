`timescale 1ns / 1ps
/*
    uartrx receives data on coded in UART
    Copyright (C) 2013  Sagar G V
    E-mail : sagar.writeme@gmail.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*///////////////////////////////////////////////////////////////

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

