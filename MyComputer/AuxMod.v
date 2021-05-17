//=======================================================
//  Synchronise the input signal
//=======================================================
module Synchroniser(clk, x, y);
	parameter n = 1;
	input clk;
	input [n-1:0] x;
	output reg [n-1:0] y = 0;
	
	reg [n-1:0] buff;
	always @(posedge clk) begin
		buff <= x;
		y <= buff;
	end
endmodule

//=======================================================
//  Debounce the input signal
//=======================================================
module Debounce(input clk, x, output reg y = 0);
	localparam millisecond = 50000; //  1ms/(1/50M)
	localparam period = 30*millisecond-1;
	localparam size = $clog2(period);
	
	reg [size-1:0] cnt = 0;
	wire x_syn;
	Synchroniser sync(.clk(clk), .x(x), .y(x_syn));

	// State memory
	always @(posedge clk) begin
		cnt = ((y == x_syn)|(cnt == period)) ? 1'b0 : cnt + 1'b1;
	end
	
	// Transition and output logic
	always @(posedge clk) begin
		if (cnt == period) y <= !y;
	end
endmodule

//=======================================================
//  Display an 8-bit signed number in 2's complement
//=======================================================
module Disp2cNum(input enable, input signed [7:0]x, output [6:0]H0, H1, H2, H3);
	wire neg = (x < 0);
	wire [7:0] ux = neg ? -x : x;
	wire [7:0] xo0, xo1, xo2, xo3;
	wire eno0, eno1, eno2, eno3;
	
	// Create four instances of DispDec.
    DispDec dd0(.x(ux), .neg(neg), .enable(enable), .xo(xo0), .eno(eno0), .segs(H0));
    DispDec dd1(.x(xo0), .neg(neg), .enable(eno0), .xo(xo1), .eno(eno1), .segs(H1));
    DispDec dd2(.x(xo1), .neg(neg), .enable(eno1), .xo(xo2), .eno(eno2), .segs(H2));
    DispDec dd3(.x(xo2), .neg(neg), .enable(eno2), .xo(xo3), .eno(eno3), .segs(H3));
endmodule

//=======================================================
//  Display an 8-bit number in decimal
//=======================================================
module DispDec(input [7:0] x, input neg, enable, output reg [7:0] xo, output reg eno, 
					output [6:0] segs);
	wire [3:0] digit = x % 10;  // the remainder after dividing by 10
	wire n = (neg) && (x == 0);  // if display a negative sign
	SSeg converter(digit, n, enable, segs);
	always @(*) begin
		xo = x / 10;
		eno = (enable != 0) & ((xo != 0) | ((neg)&&(x != 0)));  // digit or neg sign
	end
endmodule

//=======================================================
//  Display an 8-bit number in hexadecimal
//=======================================================
module DispHex(input [7:0]x, output [6:0]H0, H1);
	SSeg disp0(.bin(x[3:0]), .neg(1'b0), .enable(1'b1), .segs(H0));
   SSeg disp1(.bin(x[7:4]), .neg(1'b0), .enable(1'b1), .segs(H1));
endmodule

//=======================================================
//  Display on a 7-segment Display
//======================================================= 
module SSeg(input [3:0] bin, input neg, input enable, output reg [6:0] segs);
	always @(*)
		if (enable) begin
			if (neg) segs = 7'b011_1111;
			else begin
				case (bin)
					0: segs = 7'b100_0000;
					1: segs = 7'b111_1001;
					2: segs = 7'b010_0100;
					3: segs = 7'b011_0000;
					4: segs = 7'b001_1001;
					5: segs = 7'b001_0010;
					6: segs = 7'b000_0010;
					7: segs = 7'b111_1000;
					8: segs = 7'b000_0000;
					9: segs = 7'b001_1000;
					10: segs = 7'b000_1000;
					11: segs = 7'b000_0011;
					12: segs = 7'b100_0110;
					13: segs = 7'b010_0001;
					14: segs = 7'b000_0110;
					15: segs = 7'b000_1110;
				endcase
			end
		end
		else segs = 7'b111_1111;
endmodule

/////////////////// Step 2 of Stage 12 //////////////////
//=======================================================
//  Detect a falling edge
//=======================================================
module DetectFallingEdge(input clk, x, output y);
    reg buff;
	 
    always @(posedge clk) begin
        buff <= x;
    end
	 
	 assign y = buff && ~x; 
endmodule
