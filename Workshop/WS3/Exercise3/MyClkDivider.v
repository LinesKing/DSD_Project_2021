module MyClkDivider (input clk , output reg Q);
	 initial Q = 1'b0;
	 wire D = !Q;
	 always @(negedge clk)
			Q <= D;
endmodule
