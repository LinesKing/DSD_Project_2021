`timescale 1ns/1ns

module testS11;
	reg clk = 0;
	reg [9:0]SW = 0;
	reg [3:0]KEY = 0;

	wire [9:0]LEDR;
	wire [6:0]HEX0;
	wire [6:0]HEX1;
	wire [6:0]HEX2;
	wire [6:0]HEX3;
	wire [6:0]HEX4;
	wire [6:0]HEX5;
	
	MyComputer mc(clk, LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);	
	
	initial begin
		repeat (300) #10 clk = !clk;
	end
	
	initial begin
		SW[8] = 1;
	end
endmodule
