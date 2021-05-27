`timescale 1ns/1ns

module test_Exercise2;
	reg clk;
	reg in;
	wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	Exercise2 Exercise2_test(.SW(in), .CLOCK_50(clk), .HEX5(HEX5), .HEX4(HEX4), 
					.HEX3(HEX3), .HEX2(HEX2),.HEX1(HEX1), .HEX0(HEX0));
	
	initial begin
		clk = 0;
		repeat (10000000) #10 clk = !clk; //20ns 0.1s
	end
	
	initial begin
		in = 0;
	end
endmodule
