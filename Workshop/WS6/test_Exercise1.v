`timescale 1ns/1ns

module test_Exercise1;
	reg clk;
	reg in;
	wire [7:0] cnt, cnt_raw;
	wire [6:0] HEX5, HEX4, HEX1, HEX0;
	
	Exercise1 Exercise1_test(.SW(in), .CLOCK_50(clk), .cnt(cnt), .cnt_raw(cnt_raw), 
							.HEX5(HEX5), .HEX4(HEX4), .HEX1(HEX1), .HEX0(HEX0));
	
	initial begin
		clk = 0;
		repeat (10000000) #10 clk = !clk; //20ns 0.1s
	end
	
	initial begin
		in = 0;
		repeat (10)
			#10000000 in = !in; //20ms
	end
endmodule
