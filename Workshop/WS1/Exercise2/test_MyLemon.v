`timescale 1ns/1ps

module test_MyLemon;
    reg x, y;
	 wire z;
	 
	 MyLemon MyOr(.x(x), .y(y), .z(z));
	 
	 initial begin
	     x = 0; y = 0;
		  #10 $display(x, y,, z);
		  x = 0; y = 1;
		  #10 $display(x, y,, z);
		  x = 1; y = 0;
		  #10 $display(x, y,, z);
		  x = 1; y = 1;
		  #10 $display(x, y,, z);
	 end
endmodule
