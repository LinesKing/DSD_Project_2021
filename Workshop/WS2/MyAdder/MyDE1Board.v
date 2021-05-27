module MyDE1Board(
		input [9:0] SW,
		output [9:0] LEDR,
		output [6:0] HEX0,
		output [6:0] HEX1,
		output [6:0] HEX2,
		output [6:0] HEX4);
		
		//input
		wire [3:0] in_a = SW[9:6];
		wire [3:0] in_b = SW[3:0];
		
		//LEDs
		assign LEDR[9:6] = in_a;
		assign LEDR[3:0] = in_b;
		assign LEDR[5:4] = 2'd0;
		
		//outputs from the adder
		
		wire [3:0] result;
		wire carry_out;
		
		//The adder
		
		MyRippleCarryAdder the_adder (.a(in_a), .b(in_b), .sum(result), .carry(carry_out));
	
		//Display
		MySevenSegmentDisplay num_1 (.NUM_BINARY(in_a), .DISPLAY(HEX4));
		MySevenSegmentDisplay num_2 (.NUM_BINARY(in_b), .DISPLAY(HEX2));
		MySevenSegmentDisplay Result (.NUM_BINARY(result), .DISPLAY(HEX0));
		MySevenSegmentDisplay Carry_out (.NUM_BINARY({3'd0, carry_out}), .DISPLAY(HEX1));
	
endmodule
