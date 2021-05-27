module MyFSM(input clk, input [3:0]KEY, output reg [5:0] LEDR, output out);
	localparam A_off = 3'd0; 
	localparam B_off = 3'd1; 
	localparam C_off = 3'd2; 
	localparam A_on = 3'd3; 
	localparam B_on = 3'd4;
	localparam C_on = 3'd5;
	
	reg [2:0] state = A_off, next_state;
	reg [3:0] KEYA, KEYB;
	wire [3:0] IN = ~KEYB;
	wire reset = IN[0]; 
	wire invalid = (IN[1]+IN[2]+IN[3] > 1);
	
	always @(posedge clk) begin
		KEYA <= KEY;
		KEYB <= KEYA;
	end

	always @(posedge clk)
		if (reset) state <= A_off;
		else state <= next_state;
		
	always @(*) begin
		next_state = state;
		if (IN[3:1])
		case (state) 
			A_off: next_state = IN[1] ? B_off : A_off; 
			B_off: next_state = IN[2] ? C_off : (IN[1] ? B_off : A_off); 
			C_off: next_state = IN[3] ? A_on : (IN[1] ? B_off : C_off);
			A_on: next_state = IN[1] ? B_on : A_on; 
			B_on: next_state = IN[2] ? C_on : (IN[1] ? B_on : A_on); 
			C_on: next_state = IN[3] ? A_off : (IN[1] ? B_on : C_on);
			default: next_state = A_off;  
		endcase
		
		if (invalid) next_state = out ? A_on : A_off;
	end
	assign out = (state == A_on) || (state == B_on) || (state == C_on); 
	always @(*)
			case (state)
				A_off : LEDR = 6'b00_0001;
				B_off : LEDR = 6'b00_0010;
				C_off : LEDR = 6'b00_0100;
				A_on : LEDR = 6'b00_1000;
				B_on : LEDR = 6'b01_0000;
				C_on : LEDR = 6'b10_0000;
			endcase
endmodule
