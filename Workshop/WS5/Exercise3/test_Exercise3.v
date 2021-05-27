`timescale 1ns/1ps

module test_MyLock;
	reg clk;
	reg [3:0] KEY;
	wire out;
	
	MyLock MyLock_test(.clk(clk), .KEY(KEY), .out(out));
	
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
