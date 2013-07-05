`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:16 07/05/2013 
// Design Name: 
// Module Name:    uartrx_test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uartrx_test(
    input clk,
    input rst,
    input rxd,
    output [2:0] led
    );
	
	wire [7:0] data;
	wire req;
	
	assign led = data[2:0];
	
	uartrx #(.div(234)) UARTRX0(.clk(clk),.rst(rst),.rxd(rxd),.data(data),.req(req)); // div = 234 for 27Mhz at 115200 baud
endmodule
