module MyMooreFSM(input clk, input seq, output [3:0]state_led, output out); 
	localparam A = 4'b0001; 
	localparam B = 4'b0010; 
	localparam C = 4'b0100; 
	localparam D = 4'b1000; 
	reg [3:0] state = A, next_state; 
	always @(posedge clk) 
		state <= next_state; 
	always @(*) 
		case (state) 
			A: next_state = seq ? B : A; 
			B: next_state = seq ? B : C; 
			C: next_state = seq ? D : A; 
			D: next_state = seq ? B : A; 
			default: next_state = A;  
		endcase 
	assign out = (state == D); 
	assign state_led = state; 
endmodule


module MyMealyFSM(input clk, input seq, output [3:0]state_led, output out); 
	localparam A = 3'b001; 
	localparam B = 3'b010; 
	localparam C = 3'b100;
	reg [2:0] state = A, next_state; 
	always @(posedge clk) 
		state <= next_state; 
	always @(*) 
		case (state) 
			A: next_state = seq ? B : A; 
			B: next_state = seq ? B : C; 
			C: next_state = A;  
			default: next_state = A;  
		endcase 
	assign out = (state == C) && (seq == 1); 
	assign state_led = state; 
endmodule