`timescale 1ns/1ns

module testS4;
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
		repeat (1000) #10 clk = !clk;
	end
	
	initial begin
		SW[9] = 1;
		# 5 SW[9] = 0;
	end
endmodule

//module testS4;
//	reg signed [7:0] x;
//	reg enable;
//	wire [6:0] H3,H2,H1,H0;
//	
//	Disp2cNum DUT (enable, x, H3, H2, H1, H0);
//	
//	initial begin
//		enable = 0;
//		x = 0;
//		#1
//		enable = 1;
//		#1
//		x = 5;
//		#1
//		x = -5;
//		#1
//		x = 12;
//		#1
//		x = -12;
//		#1
//		x = 123;
//		#1
//		x = -123;
//		#1
//		$stop;
//	end
//endmodule
