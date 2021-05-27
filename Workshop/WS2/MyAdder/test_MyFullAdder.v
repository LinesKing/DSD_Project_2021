`timescale 1ns/1ns

module test_MyFullAdder;
    reg a, b, c_in;
	 wire sum, carry;
	 
	 MyFullAdder HA(.a(a), .b(b), .c_in(c_in), .sum(sum), .carry(carry));
	 
	 initial begin
		  c_in = 0; a = 0; b = 0;
		  #10 $display(carry,,sum);
		  c_in = 0; a = 0; b = 1;
		  #10 $display(carry,,sum);
		  c_in = 0; a = 1; b = 0;
		  #10 $display(carry,,sum);
		  c_in = 0; a = 1; b = 1;
		  #10 $display(carry,,sum);
		  c_in = 1; a = 0; b = 0;
		  #10 $display(carry,,sum);
		  c_in = 1; a = 0; b = 1;
		  #10 $display(carry,,sum);
		  c_in = 1; a = 1; b = 0;
		  #10 $display(carry,,sum);
		  c_in = 1; a = 1; b = 1;
		  #10 $display(carry,,sum);
	 end
endmodule
