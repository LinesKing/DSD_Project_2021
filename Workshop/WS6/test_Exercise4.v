`timescale 1ns/1ns

module test_Exercise4;
	reg clk;
	reg in;
	wire [9:0] LEDR;
	
	Exercise4 Exercise4_test(.CLOCK_50(clk), .KEY(in), .LEDR(LEDR));
	
	initial begin
		clk = 0;
		repeat (300000) #10 clk = !clk; //20ns 2.5s
	end
	
	initial begin
		in = 0; //reset
		#2_500_000 in=1;
		repeat (3) #100000 in = !in;
	end
endmodule
