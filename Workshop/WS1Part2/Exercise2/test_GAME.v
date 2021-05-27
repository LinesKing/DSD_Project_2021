`timescale 1ns/1ps

module test_GAME;
    reg gen_A, gen_B, gen_C, gen_D;
	 wire out_w, out_x, out_y, out_z;

	 Exercise2 LED(.A(gen_A), .B(gen_B), .C(gen_C), .D(gen_D), .w(out_w), .x(out_x), .y(out_y), .z(out_z));
	 
	 initial begin
	     gen_A = 0; gen_B = 0; gen_C = 0; gen_D = 0;
		  # 10 $display(out_w, out_x, out_y ,out_z);
		  gen_A = 0; gen_B = 1; gen_C = 0; gen_D = 0;
		  # 10 $display(out_w, out_x, out_y ,out_z);
		  gen_A = 0; gen_B = 1; gen_C = 1; gen_D = 0;
		  # 10 $display(out_w, out_x, out_y ,out_z);
		  gen_A = 0; gen_B = 1; gen_C = 1; gen_D = 1;
		  # 10 $display(out_w, out_x, out_y ,out_z);
		  gen_A = 1; gen_B = 1; gen_C = 1; gen_D = 1;
		  # 10 $display(out_w, out_x, out_y ,out_z);
	 end
endmodule
