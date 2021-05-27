`timescale 1ns/1ps

module test_inverter;
    reg gen_input;
	 wire out_x, out_y;
	 
	 Exercise1 Hello(.A(gen_input), .x(out_x), .y(out_y));
	 
	 initial begin
	     gen_input = 0;
		  #10 $display(gen_input,, out_x, out_y);
		  gen_input = 1;
		  #10 $display(gen_input,, out_x, out_y);
	 end
endmodule
