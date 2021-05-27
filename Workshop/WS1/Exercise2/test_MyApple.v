`timescale 1ns/1ps

module test_MyApple;
    reg A, S0;
	 wire x;
	 
	 MyApple MyAND(.A(A), .S0(S0), .x(x));
	 
	 initial begin
	     A = 0; S0 = 0;
		  #10 $display(A, S0,, x);
		  A = 0; S0 = 1;
		  #10 $display(A, S0,, x);
		  A = 1; S0 = 0;
		  #10 $display(A, S0,, x);
		  A = 1; S0 = 1;
		  #10 $display(A, S0,, x);
	 end
endmodule
