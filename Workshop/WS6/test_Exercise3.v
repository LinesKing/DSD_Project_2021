`timescale 1ns/1ns

module test_Exercise3;
	reg clk;
	reg [1:0] in; //1 num, 0 pos
	reg reset;
	wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [3:0] num;
	wire [3:0] addr;
	
	Exercise3 Exercise3_test(.KEY(in), .CLOCK_50(clk), .reset(reset), .num(num), .addr(addr), .HEX5(HEX5), .HEX4(HEX4), 
					.HEX3(HEX3), .HEX2(HEX2),.HEX1(HEX1), .HEX0(HEX0));
	
	initial begin
		clk = 0;
		repeat (150) #10 clk = !clk; //20ns 0.1s
	end
	
		
	initial begin
		reset = 1;
		#20 reset = !reset; //reset

		in = 2'b00;
		repeat (4)
			#20 in[1] = !in[1]; //pos 0, num 2

		repeat (2)
			#40 in[0] = !in[0]; //pos 1, num 0

		repeat (8)
			#20 in[1] = !in[1]; //pos 1, num 4
		
		repeat (2)
			#40 in[0] = !in[0]; //pos 2, num 0
			
		repeat (4)
			#40 in[0] = !in[0]; //pos 3, num 0

		repeat (10)
			#20 in[1] = !in[1]; //pos 3, num 5

		repeat (2)
			#40 in[0] = !in[0]; //pos 4, num 0

		repeat (4)
			#20 in[1] = !in[1]; //pos 4, num 2

		repeat (2)
			#40 in[0] = !in[0]; //pos 5, num 0
			
		repeat (2)
			#40 in[0] = !in[0]; //pos 6, num 0

		repeat (4)
			#20 in[1] = !in[1]; //pos 6, num 2
			
		repeat (2)
			#40 in[0] = !in[0]; //pos 2, num 0
	end
endmodule
