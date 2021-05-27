//module MyPipeline(
//	 input clk,
//	 input [3:0] x,
//	 output reg [19:0] y);
//	 
//	 wire [4:0] x1 = 2*x;
//	 reg [9:0] x2;
//	 
//	 always @(posedge clk) begin
//		 x2 <= x1 * x1;
//		 y <= x2 * x2;
//	 end
//endmodule

module MyPipeline (input clk, input [3:0]x, output reg[19:0]y);
	 reg [3:0] x0; 
	 wire [4:0] x1 = 2 * x0; 
	 reg [9:0] x2;
	 always @(posedge clk) begin 
		 x0 <= x; 
		 x2 <= x1 * x1; 
		 y <= x2 * x2; 
end endmodule

module Syn(input clk, ext_in, output sync_out);
	 reg a, b;
	 always @(posedge clk) begin
			a <= ext_in;
			b <= a;
	 end
	 assign sync_out = b;
endmodule

module EdgeDetector(input clk, input IN, output OUT);
	 reg prev = 1'b1;
	 reg curr = 1'b1;
	 
	 always @(posedge clk)
			{prev, curr} <= {curr, IN};
	 assign OUT = prev & ! curr;
endmodule

module MySevenSegmentDisplay (input [3:0] NUM_BINARY, output reg [6:0] DISPLAY);
    always @(*)
			case(NUM_BINARY)
				4'b0000: DISPLAY = ~7'b0111111;
				4'b0001: DISPLAY = ~7'b0000110;
				4'b0010: DISPLAY = ~7'b1011011;
				4'b0011: DISPLAY = ~7'b1001111;
				4'b0100: DISPLAY = ~7'b1100110;
				4'b0101: DISPLAY = ~7'b1101101;
				4'b0110: DISPLAY = ~7'b1111101;
				4'b0111: DISPLAY = ~7'b0000111;
				4'b1000: DISPLAY = ~7'b1111111;
				4'b1001: DISPLAY = ~7'b1101111;
				4'b1010: DISPLAY = ~7'b1110111;
				4'b1011: DISPLAY = ~7'b1111100;
				4'b1100: DISPLAY = ~7'b0111001;
				4'b1101: DISPLAY = ~7'b1011110;
				4'b1110: DISPLAY = ~7'b1111001;
				4'b1111: DISPLAY = ~7'b1110001;
			endcase
endmodule


module Pipeline (
	 input [3:0] x,
	 input clk,
	 input [0:0] PB,
	 output [6:0] D4,
	 output [6:0] D3,
	 output [6:0] D2,
	 output [6:0] D1,
	 output [6:0] D0,
	 output [19:0] yy);
	 
	 reg [3:0] xx = 4'd0;
//	 wire [19:0] yy;
	 wire en, pb_synced;
	 
	 Syn sync (.clk(clk), .ext_in(PB), .sync_out(pb_synced));
	 EdgeDetector enable (.clk(clk), .IN(pb_synced), .OUT(en));
	 MyPipeline ppl (.clk(clk), .x(xx), .y(yy));
	 
	 always @(posedge clk)
		 if (en) xx <= x;
	 
	 MySevenSegmentDisplay Display4(.NUM_BINARY(yy[19:16]), .DISPLAY(D4[6:0]));
	 MySevenSegmentDisplay Display3(.NUM_BINARY(yy[15:12]), .DISPLAY(D3[6:0]));
	 MySevenSegmentDisplay Display2(.NUM_BINARY(yy[11:8]), .DISPLAY(D2[6:0]));
	 MySevenSegmentDisplay Display1(.NUM_BINARY(yy[7:4]), .DISPLAY(D1[6:0]));
	 MySevenSegmentDisplay Display0(.NUM_BINARY(yy[3:0]), .DISPLAY(D0[6:0]));
	 
endmodule
