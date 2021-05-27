`timescale 1ns/1ps

module test_MyFruitBasket;
    reg A, B, S0;
	 wire z;
	 integer i;
	 
	 MyFruitBasket MyMUX(.A(A), .B(B), .S0(S0), .z(z));
	 
	 initial begin
		  A = 0; B = 0; S0 = 0;
		  for(i = 1; i <= 8; i = i + 1) begin
				#10 $display(A, B,, S0,, z);
				S0 = !S0;
				B = (i % 2 == 0)? !B: B;
				A = (i % 4 == 0)? !A: A;
		  end
	 end
endmodule
