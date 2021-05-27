`timescale 1ns/1ps

module test_MySyncMUX;
	 reg x, y, s, clk;
	 wire m_sync;
	 
	 MySyncMUX MUX_test(.x(x), .y(y), .s(s), .clk(clk), .m_sync(m_sync));
	 
	 initial begin
			clk = 0;
			repeat (16) #2.5 clk = !clk;
	 end
	 
	 initial begin s = 0; repeat (8) #5 s = !s; end
	 initial begin x = 0; repeat (4) #10 x = !x; end
	 initial begin y = 0; repeat (2) #20 y = !y; end
endmodule
