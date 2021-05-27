`timescale 1ns/1ps

module test_MyMult1;
    reg [3:0] x;
	 wire [19:0] y;
	 MyMult1 MyMult1_test(.x(x), .y(y));
	 initial begin
		 x = 4'b0000;
		 #20 x = 4'b1010;
	 end
endmodule

module test_MyMult2;
    reg [3:0] x;
	 wire [19:0] y;
	 MyMult2 MyMult2_test(.x(x), .y(y));
	 initial begin
		 x = 4'b0000;
		 #20 x = 4'b1010;
	 end
endmodule

module test_MyPipeline;
    reg clk;
	 reg [3:0] x;
	 wire [19:0] y;
	 
	 MyPipeline MyPipeline_test(.clk(clk), .x(x), .y(y));
	 initial begin
		 clk = 0;
		 x = 4'b0000;

		 fork
			begin
				repeat (16) #10 clk = !clk;
			end
			
			begin
				#20 x = 4'b1010;
				repeat (4) #20 x = x - 4'b0010;
			end
		 join

	 end
endmodule

module test_MyPipeline2;
    reg clk;
	 reg [3:0] x;
	 wire [19:0] y;
	 
	 MyPipeline2 MyPipeline2_test(.clk(clk), .x(x), .y(y));
	 initial begin
		 clk = 0;
		 x = 4'b0000;

		 fork
			begin
				repeat (16) #2.5 clk = !clk;
			end
			
			begin
				#5 x = 4'b1010;
				repeat (4) #5 x = x - 4'b0010;
			end
		 join

	 end
endmodule
