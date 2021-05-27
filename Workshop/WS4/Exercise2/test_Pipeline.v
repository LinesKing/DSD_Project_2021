`timescale 1ns/1ps

module test_Syn;
	 reg clk = 0;
	 reg in = 1;
	 wire out;
	 
	 Syn syn(.clk(clk), .ext_in(in), .sync_out(out));
	 initial begin
	 	 fork
			begin
				#65 in = !in;
				#10 in = !in;
				#65 in = !in;
			end
			
			begin
				repeat (30) #10 clk = !clk;
			end
		 join

	 end
endmodule

module test_ED;
	 reg clk = 0;
	 reg in = 0;
	 wire out;

	 EdgeDetector ena (.clk(clk), .IN(in), .OUT(out));
	 
	 initial begin
	 	 fork
			begin
				#35 in = !in;
				#60 in = !in;
				#20 in = !in;
				#60 in = !in;
			end
			
			begin
				repeat (30) #10 clk = !clk;
			end
		 join

	 end
endmodule

module test_Pipeline;
	 reg clk;
	 reg [3:0] x;
	 reg ENA;
	 wire [6:0] D4;
	 wire [6:0] D3;
	 wire [6:0] D2;
	 wire [6:0] D1;
	 wire [6:0] D0;
	 wire [19:0] yy;
	 
	 Pipeline Pipeline_test(.x(x), .clk(clk), .PB(ENA),
		  .D4(D4), .D3(D3), .D2(D2), .D1(D1), .D0(D0), .yy(yy));
	 initial begin
		 clk = 0;
		 x = 4'b0000;
		 ENA = 1;

		 fork
			begin
				#65 ENA = !ENA;
				#10 ENA = !ENA;
				#65 ENA = !ENA;
			end
			
			begin
				repeat (30) #10 clk = !clk;
			end
			
			begin
				#50 x = 4'b1010;
				repeat (4) #50 x = x - 4'b0010;
			end
		 join

	 end
endmodule
