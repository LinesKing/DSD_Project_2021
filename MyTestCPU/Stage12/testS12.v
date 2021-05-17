//`timescale 1ns/1ns
//
//module testS12;
//	reg clk = 0;
//	reg [9:0]SW = 10'b0000001110;
//	reg [3:0]KEY = 4'b0000;
//
//	wire [9:0]LEDR;
//	wire [6:0]HEX0;
//	wire [6:0]HEX1;
//	wire [6:0]HEX2;
//	wire [6:0]HEX3;
//	wire [6:0]HEX4;
//	wire [6:0]HEX5;
//	
//	MyComputer mc(clk, LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);	
//	
//	initial begin
//		repeat (50) #10 clk = !clk;
//	end
//	
//	initial begin
//		#23 KEY[3] = !KEY[3];
//		#45 KEY[3] = !KEY[3];
//	end
//	
//	initial begin
//		SW[8] = 1;
//	end
//endmodule

`timescale 1ms/1ns

module testS12;
reg [9:0] SW = 10'b0000000000;
reg [3:0] KEY = 4'b0;
reg clk = 0;
wire [6:0] HEX5 , HEX4 , HEX3 , HEX2 , HEX1 , HEX0;
wire [9:0] LEDR;


MyComputer s5(.SW(SW), .KEY(KEY), .Clock(clk), .HEX5(HEX5), .HEX4(HEX4) , .HEX3(HEX3) , .HEX2(HEX2) , .HEX1(HEX1) , .HEX0(HEX0), .LEDR(LEDR));

initial forever begin
#0.00001 clk = !clk;
end


initial forever begin
#650 SW = SW+1;
end


initial forever begin
#350 KEY = 4'b1000;
#350 KEY = 4'b0000;
end


initial #10_000 SW[9] = 1;
endmodule
