`timescale 1ns/1ps

module MyMult1(input [3:0]x, output [19:0]y);
	 wire [4:0] x1 = 2 * x;
	 wire [9:0] x2 = x1 * x1; 
	 wire [14:0] x3 = x2 * x1;
	 assign y = x3 * x1; 
endmodule

module MyMult2(input [3:0]x, output [19:0]y);
	 wire [4:0] x1 = 2 * x;
	 wire [9:0] x2 = x1 * x1; 
	 assign y = x2 * x2;
endmodule

module MyPipeline(
	 input clk,
	 input [3:0] x,
	 output reg [19:0] y);
	 
	 reg [3:0] xx;
	 wire [19:0] yy;
	 
	 MyMult1 mult (.x(xx), .y(yy));
	 always @(posedge clk) begin
		 xx <= x;
		 y <= yy;
	 end
endmodule
	 
module MyPipeline2(
	 input clk,
	 input [3:0] x,
	 output reg [19:0] y);
	 
	 reg [3:0] x1;
	 wire [9:0] y1;
	 reg [9:0] x2;
	 wire [19:0] y2;
	 
	 assign y1 = (2 * x1) * (2 * x1);
	 assign y2 = x2 * x2;
	 always @(posedge clk) begin
		 x1 <= x;
		 x2 <= y1;
		 y <= y2;
	 end
endmodule
