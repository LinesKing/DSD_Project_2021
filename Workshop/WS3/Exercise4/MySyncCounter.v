module MySyncCounter (
	 input PB0,
	 output [6:0] HEX0,
	 output [3:0] LEDR);
	 reg [3:0] count = 0;
	 
	 MySevenSegmentDisplay BIT0 (.NUM_BINARY(count),
			.DISPLAY (HEX0));
	 always @( posedge PB0 )
			count <= count + 1;
	 assign LEDR = count ;
endmodule
