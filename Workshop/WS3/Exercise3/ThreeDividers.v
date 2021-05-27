module ThreeDividers (input clk, output [2:0] Q);
	 wire [2:0] Q_FF;
	 MyClkDivider Clk1 (.clk(clk), .Q(Q_FF[0]));
	 MyClkDivider Clk2 (.clk(Q_FF[0]), .Q(Q_FF[1]));
	 MyClkDivider Clk3 (.clk(Q_FF[1]), .Q(Q_FF[2]));
	 assign Q[2:0] = Q_FF[2:0];
endmodule
