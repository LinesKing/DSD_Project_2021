`timescale 1ns/1ns

module test_MyHalfAdder;
    reg a, b;
	 wire sum, carry;
	 
	 MyHalfAdder HA(.a(a), .b(b), .sum(sum), .carry(carry));
	 
	 initial begin
		  a = 0; b = 0;
		  #10 $display(carry,,sum);
		  a = 0; b = 1;
		  #10 $display(carry,,sum);
		  a = 1; b = 0;
		  #10 $display(carry,,sum);
		  a = 1; b = 1;
		  #10 $display(carry,,sum);
	 end
endmodule
