module Exercise3( 
	input CLOCK_50, 
	input [2:1] KEY, 
	input reset,
	output reg [3:0] num,
	output reg [3:0] addr,
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0); 
	
	wire c = CLOCK_50; 
	wire [1:0] in; 
	Synchroniser #(2) sync(.clk(c), .in(~KEY[2:1]), .out(in)); 
	
	wire inc, nxt; 
	RisingEdgeDetector red1(.clk(c), .in(in[1]), .out(inc)); 
	RisingEdgeDetector red0(.clk(c), .in(in[0]), .out(nxt)); 
	
	wire we; 
	wire [39:0] mem_in, mem;
	wire [5:0] e; 
	wire [23:0] d; 
	
	Memory #(40) memory(.clk(c), .reset(reset), .we(we), 
		.data_in(mem_in), .data_out(mem)); 
	EditMemory em(.clk(c), .inc(inc), .nxt(nxt), .reset(reset), 
		.we(we), .mem_in(mem_in), .mem(mem), .e(e), .d(d));
		
	always @(*) addr = d[19]*4'd8 + d[18]*4'd4 + d[17]*4'd2 + d[16]*4'd1;
	always @(*) num = d[3]*4'd8 + d[2]*4'd4 + d[1]*4'd2 + d[0]*4'd1;

	SSegEn s0(.bin(d[3:0]), .en(e[0]), .segs(HEX0)); 
	SSegEn s1(.bin(d[7:4]), .en(e[1]), .segs(HEX1)); 
	SSegEn s2(.bin(d[11:8]), .en(e[2]), .segs(HEX2)); 
	SSegEn s3(.bin(d[15:12]), .en(e[3]), .segs(HEX3)); 
	SSegEn s4(.bin(d[19:16]), .en(e[4]), .segs(HEX4)); 
	SSegEn s5(.bin(d[23:20]), .en(e[5]), .segs(HEX5)); 
endmodule

module RisingEdgeDetector(input clk, in, output out); 
	reg prev; 
	always @(posedge clk) 
		prev <= in; 
	assign out = !prev && in; 
endmodule

module Memory
	#(parameter bits = 1)

	(input clk, we, reset, 
	input [bits-1:0] data_in, 
	output [bits-1:0] data_out);
	
	reg [bits-1:0] mem;
	
	always @(posedge clk)
		if (reset) mem <= 0; 
		else if (we) mem <= data_in;

	assign data_out = mem; 
endmodule

module EditMemory( 
	input clk, inc, nxt, reset,
	output reg we = 0, 
	output reg [39:0] mem_in = 0, 
	input [39:0] mem, 
	output [5:0] e, 
	output [23:0] d);
	
	reg [3:0] addr = 0, next_addr; 
	reg next_we; 
	reg [39:0] next_mem_in;

	always @(posedge clk) {addr, we, mem_in} <= reset ? {4'd0, 1'd0, 40'bx} 
		: {next_addr, next_we, next_mem_in};
		
	always @(*) begin 
		next_we = 0; 
		next_mem_in = 40'bx; 
		next_addr = addr; 
		if (inc) begin 
			next_mem_in = mem; 
			next_mem_in[addr*4 +: 4] = (mem[addr*4 +: 4] + 1'd1) % 4'd10; 
			next_we = 1; 
		end 
		else if (nxt) 
			next_addr = (addr + 1'd1) % 4'd10; 
	end

	wire [3:0] d0 = mem[addr*4 +: 4]; 
	wire [3:0] d4 = (addr + 1'd1) % 4'd10; 
	wire [3:0] d5 = (addr + 1'd1) / 4'd10; 
	assign e = 6'b11_0001; 
	assign d = {d5, d4, {3{4'bx}}, d0}; 
endmodule	
		
