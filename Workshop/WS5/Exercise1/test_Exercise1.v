`timescale 1ms/1ns

module test_MyFSM;
	reg clk;
	reg seq;
	wire out;
	reg [14:0] S = 15'b011010010101101;
	integer i = 13;
//	wire [3:0] state;
	wire [2:0] state;
	 
//	MyMooreFSM MyMooreFSM_test(.clk(clk), .seq(seq), .state_led(state), .out(out));
	MyMealyFSM MyMealyFSM_test(.clk(clk), .seq(seq), .state_led(state), .out(out));
	initial begin
		clk = 0;
		repeat (30) #5 clk = !clk;
	end
	
	initial begin
		seq = S[14];
		repeat (15) begin
			#10 seq = S[i];
			i = i - 1'd1;
		end
	end
	
//	always @(negedge clk) begin
//		seq = S[i];
//		i = i - 1'd1;
//	end
	
endmodule
