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
module uartrx #(parameter div=234)(
    input clk,
	 input rst,
	 input rxd,
    output reg [7:0] data,
    output req,
	 input ack
    );
	 
	reg startbit;
	reg [3:0] state,nextstate;
	wire uartbit;
	wire nextbit;
	reg [7:0] tempdata;
	wire shift;
	
	////////////////////////////////got data////////////////////////////////////////////////////
	assign req = (nextstate == 0 & state == 10);
	always @(posedge clk or posedge rst) begin
		if(rst) data <= 0;
		else if(req) data <= tempdata;
	end
	
	///////////////////////////////data shifter////////////////////////////////////////////////
	always @(posedge clk or posedge rst) begin
		if(rst) tempdata <= 0;
		else if(shift) tempdata <= { uartbit , tempdata[7:1] };
	end
	
	////////////////////////////////input synchronizer//////////////////////////////////////////
	reg [3:0] inreg;
	wire [2:0] insum;
	always @(posedge clk or posedge rst) begin
		if(rst) inreg <= 4'hF;
		else inreg <= { inreg[2:0] , rxd };
	end
	assign insum = ( { 2'b00 , inreg[3] } + { 2'b00 , inreg[2] } + { 2'b00 , inreg[1] } + { 2'b00 , inreg[0] });
	assign uartbit = insum > 1;//inreg[3] | inreg[2] | inreg[1];

	
	//////////////////////////////////next bit generator////////////////////////////////////////
	reg [31:0] regcount;
	always @(posedge clk or posedge rst) begin
		if(rst) begin
						startbit <= 0;
						regcount <= 0;
				  end
		else begin
					startbit <= 0;
					if(~uartbit & (state == 0) & (startbit == 0)) begin
															regcount <= div/2;
															startbit <= 1;
														 end
					else if(regcount == (div-1)) regcount <= 0;
					else regcount <= regcount + 1;
			  end
	end
	assign nextbit = (regcount == 0);

	///////////////////////////////////state machine////////////////////////////////////////////
	always @(posedge clk or posedge rst) begin
		if(rst) state <= 0;
		else state <= nextstate;
	end
	
	always @(*) begin
		nextstate <= state;
		case(state)
			4'h0: begin
						if(startbit) nextstate <= 1;
					end
			4'h1: if(nextbit) nextstate <=2;
			4'h2: if(nextbit) nextstate <=3;
			4'h3: if(nextbit) nextstate <=4;
			4'h4: if(nextbit) nextstate <=5;
			4'h5: if(nextbit) nextstate <=6;
			4'h6: if(nextbit) nextstate <=7;
			4'h7: if(nextbit) nextstate <=8;
			4'h8: if(nextbit) nextstate <=9;
			4'h9: if(nextbit) nextstate <=10;
			4'hA: if(nextbit) nextstate <= 0;
		endcase 
	end
	assign shift = nextbit & (state >= 2 && state <= 9);
	///////////////////////////////////////////////////////////////////////////////////////////////////////
	
endmodule
