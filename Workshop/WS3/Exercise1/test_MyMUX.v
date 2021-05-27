`timescale 1ns/1ps

module test_MyMUX;
    reg x, y, s;
	 wire m;
	 MyMUX MUX_test(.x(x), .y(y), .s(s), .m(m));
	 
	 initial begin
		  s = 0;
		  repeat (8) #5 s = !s;
	 end
	 initial begin
		  x = 0;
		  repeat (4) #10 x = !x;
	 end
	 initial begin
		  y = 0;
		  repeat (2) #20 y = !y;
	 end
endmodule
