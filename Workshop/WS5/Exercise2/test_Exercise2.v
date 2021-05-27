`timescale 1ns/1ps

module test_MyFSM;
	reg clk;
	reg [3:0] KEY;
	wire [5:0] LEDR;
	wire out;
	
	MyFSM MyFSM_test(.clk(clk), .KEY(KEY), .LEDR(LEDR), .out(out));
	
	initial begin
		clk = 0;
		repeat (20) #10 clk = !clk;
	end
	
	initial begin
		KEY[3:0] = 4'b1111;
		#20 KEY[3:0] = 4'b1101;
		repeat (9) begin
			#20 KEY[3:1] = {KEY[2:1],KEY[3]};
		end
	end
	
endmodule
