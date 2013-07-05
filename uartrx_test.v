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
*/

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
