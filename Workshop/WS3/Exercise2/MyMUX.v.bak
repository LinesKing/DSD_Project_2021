`timescale 1ns/1ps

module MyMUX (input x, input y, input s, output m);
	 wire N1, N2, N3;
	 assign #1 N1 = ~s;
	 assign #1 N2 = x & N1;
	 assign #1 N3 = s & y;
	 assign #1 m = N2 | N3;
endmodule
