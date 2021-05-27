`timescale 1ns/1ps

module test_MyOrange;
    reg B, S0;
	 wire y;
	 
	 MyOrange MyAND(.B(B), .S0(S0), .y(y));
	 
	 initial begin
	     B = 0; S0 = 0;
		  #10 $display(B, S0,, y);
		  B = 0; S0 = 1;
		  #10 $display(B, S0,, y);
		  B = 1; S0 = 0;
		  #10 $display(B, S0,, y);
		  B = 1; S0 = 1;
		  #10 $display(B, S0,, y);
	 end
endmodule
