`timescale 1ms/1us

module test_ThreeDividers;
	 reg clk ;
	 wire Q;
	 
	 ThreeDividers freq_div (.clk(clk), .Q(Q));
	 initial begin
		clk = 0;
		repeat (20) #0.5 clk = !clk ;
	 end
endmodule
