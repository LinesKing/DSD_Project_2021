`timescale 1ns/1ns

module test_Exercise6;
	reg clk;
	reg [2:0] in;
	wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	wire [9:0] LEDR;
	wire [3:0] num;
	wire [3:0] addr;
	
	Exercise6 Exercise6_test(.KEY(in), .CLOCK_50(clk), .LEDR(LEDR), .HEX5(HEX5), .HEX4(HEX4), 
			.HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0), .num(num), .addr(addr));
	
	initial begin
		clk = 0;
		repeat (1500000) #10 clk = !clk; //20ns 0.1s
	end
	
	initial begin
		#3_500_000 in[1:0] = 2'b00;

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

	initial begin
		in [2] = 0; //reset
		#2_500_000 in [2] = 1;
		#500_000 in[2] = !in[2];
		#1_000_000 in[2] = !in[2];
		#250_000 in[2] = !in[2];
		#250_000 in[2] = !in[2];
	end

endmodule
