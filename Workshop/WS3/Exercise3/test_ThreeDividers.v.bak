`timescale 1ms/1us

module test_MyClkDivider;
	 reg clk;
	 wire Q;
	 
	 MyClkDivider MUX_test(.clk(clk), .Q(Q));
	 
	 initial begin
			clk = 0;
			repeat (20) #0.5 clk = !clk;
	 end
endmodule
