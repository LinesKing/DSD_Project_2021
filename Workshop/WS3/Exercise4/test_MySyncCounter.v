`timescale 1ms/1us

module test_MySyncCounter;
	 reg clk;
	 wire [6:0] HEX0;
	 wire [3:0] LEDR;
	 
	 MySyncCounter freq_div (.PB0(clk), .HEX0(HEX0), .LEDR(LEDR));
	 initial begin
		clk = 0;
		repeat (20) #0.5 clk = !clk ;
	 end
endmodule
