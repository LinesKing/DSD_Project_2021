module Synchroniser(clk, in, out);
	parameter n = 1;
	input clk;
	input [n-1:0] in;
	output reg [n-1:0] out;
	reg [n-1:0] buff;
	always @(posedge clk) begin
		buff <= in;
		out <= buff;
	end
endmodule

module EdgeDetector(input clk, in, output out); 
	reg prev; 
	always @(posedge clk) prev <= in; 
	assign out = (prev && !in); 
endmodule

module EdgeDetectors(clk, in, out);
	parameter n = 1;
	input clk;
	input [n-1 :0] in;
	output [n-1:0] out;
	genvar i;
	generate
		for(i=0; i<n; i=i+1) begin :EdgeD
			EdgeDetector ED(.clk(clk), .in(in[i]), .out(out[i]));
		end
	endgenerate
endmodule

//module MyFSM(input clk, input reset, input [2:0]IN, output out);
//	localparam A_off = 3'd0; 
//	localparam B_off = 3'd1; 
//	localparam C_off = 3'd2; 
//	localparam A_on = 3'd3; 
//	localparam B_on = 3'd4;
//	localparam C_on = 3'd5;
//	
//	reg [2:0] state = A_off, next_state;	
//	always @(posedge clk)
//		if (reset) state <= A_off;
//		else state <= next_state;
//	assign out = (state == A_on) || (state == B_on) || (state == C_on); 	
//	wire invalid = (IN[0]+IN[1]+IN[2] > 1) || (state > 5);
//	
//	always @(*) begin
//		next_state = state;
//		if (IN[2:0])
//		case (state) 
//			A_off: next_state = IN[0] ? B_off : A_off; 
//			B_off: next_state = IN[1] ? C_off : (IN[0] ? B_off : A_off); 
//			C_off: next_state = IN[2] ? A_on : (IN[0] ? B_off : C_off);
//			A_on: next_state = IN[0] ? B_on : A_on; 
//			B_on: next_state = IN[1] ? C_on : (IN[0] ? B_on : A_on); 
//			C_on: next_state = IN[2] ? A_off : (IN[0] ? B_on : C_on);
//			default: next_state = A_off;  
//		endcase
//		
//		if (invalid) next_state = out ? A_on : A_off;
//	end
//endmodule

module MyFSM(input clk, reset, input [2:0] IN, output out);
	localparam A_off = 3'd0, B_off = 3'd1, C_off = 3'd2; 
	localparam A_on = 3'd3, B_on = 3'd4, C_on = 3'd5; 
	reg [2:0] state = A_off, next_state; 
	always @(posedge clk) 
		if (reset) state <= A_off; 
		else state <= next_state; 
	assign out = (state == A_on) || (state == B_on) || (state == C_on); 
	wire invalid = (IN[0] + IN[1] + IN[2] > 1) || (state > 5); 
	wire advance = (((state == B_off) || (state == B_on)) && IN[1]) || (((state == C_off) || (state == C_on)) && IN[2]); 
	wire back_to_A = out ? A_on : A_off; 
	wire back_to_B = out ? B_on : B_off; 
	always @(*) begin 
		next_state = state; 
		if (IN) begin 
			if (advance) next_state = (state + 1'b1) % 3'd6; 
			else next_state = IN[0] ? back_to_B : back_to_A; 
		end 
		if (invalid) next_state = back_to_A; 
	end 
endmodule

//module MyFSM(input clk, reset, input [2:0] IN, output reg out = 0); 
//	reg [1:0] nkeys = 0, next_nkeys;
//	reg next_out;
//	always @(posedge clk) 
//		{nkeys, out} <= reset ? 3'b000 : {next_nkeys, next_out}; 
//	wire invalid = (IN[0] + IN[1] + IN[2] > 1) || (nkeys > 2);
//	wire advance = ((nkeys == 2'd1) && IN[1]) || ((nkeys == 2'd2) && IN[2]); 
//	always @(*) begin 
//		{next_nkeys, next_out} = {nkeys, out}; 
//		if (IN) begin 
//			if (advance) begin 
//				next_nkeys = (nkeys + 1'b1) % 3'd3; 
//				if (next_nkeys == 0) next_out = !out; 
//			end 
//			else next_nkeys = IN[0]; 
//		end 
//		if (invalid) {next_nkeys, next_out} = {2'd0, out}; 
//	end 
//endmodule

module MyLock(input clk, input [3:0] KEY, output out);
	wire [3:0] key_sync;
	wire reset = !key_sync[0];
	wire [2:0] key_pressed;
	
	Synchroniser #(4) s(.clk(clk), .in(KEY), .out(key_sync));
	EdgeDetectors #(3) e(.clk(clk), .in(key_sync[3:1]), .out(key_pressed));
	MyFSM FSM (.clk(clk), .reset(reset), .IN(key_pressed), .out(out));
endmodule


