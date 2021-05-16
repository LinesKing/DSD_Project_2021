`timescale 1ns/1ns

module testS12;
	reg clk = 0;
	reg [9:0]SW = 10'b0000001110;
	reg [3:0]KEY = 4'b0000;

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
		#23 KEY[3] = !KEY[3];
		#45 KEY[3] = !KEY[3];
		#67 KEY[3] = !KEY[3];
		#123 KEY[3] = !KEY[3];
	end
	
	initial begin
		SW[8] = 1;
	end
endmodule
