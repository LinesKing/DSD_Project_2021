module Exercise5( 
	input CLOCK_50, 
	input [3:1] KEY, 
	output [9:0] LEDR,
	output reg [3:0] num,
	output reg [3:0] addr,	
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0); 
	
	wire c = CLOCK_50; 
	assign LEDR[9:4] = 0; 
	wire [2:0] in; 
	Synchroniser #(3) sync(.clk(c), .in(~KEY[3:1]), .out(in)); 
	
	wire [1:0] mode; 
	ModeSelector ms(.clk(c), .in(in[2]), .mode(mode)); 
	
	wire reset = (mode == 2'd3); 
	genvar i; 
	generate for(i=0; i<=3; i=i+1) begin :leds 
			assign LEDR[i] = (mode == i); 
		end 
	endgenerate 
	
	wire inc, nxt; 
	RisingEdgeDetector red1(.clk(c), .in(in[1]), .out(inc)); 
	RisingEdgeDetector red0(.clk(c), .in(in[0]), .out(nxt)); 
	
	wire we; 
	wire [39:0] mem_in, mem; 
	wire [5:0] e; 
	wire [23:0] d; 
	
	Memory #(40) memory(.clk(c), .reset(reset), .we(we), .data_in(mem_in), .data_out(mem)); 
	EditMemory em(.clk(c), .inc(inc), .nxt(nxt), .reset(reset), .we(we), .mem_in(mem_in), .mem(mem), .e(e), .d(d)); 
	
	always @(*) addr = d[19]*4'd8 + d[18]*4'd4 + d[17]*4'd2 + d[16]*4'd1;
	always @(*) num = d[3]*4'd8 + d[2]*4'd4 + d[1]*4'd2 + d[0]*4'd1;
	
	SSegEn s0(.bin(d[3:0]), .en(e[0]), .segs(HEX0)); 
	SSegEn s1(.bin(d[7:4]), .en(e[1]), .segs(HEX1)); 
	SSegEn s2(.bin(d[11:8]), .en(e[2]), .segs(HEX2)); 
	SSegEn s3(.bin(d[15:12]), .en(e[3]), .segs(HEX3)); 
	SSegEn s4(.bin(d[19:16]), .en(e[4]), .segs(HEX4));
	SSegEn s5(.bin(d[23:20]), .en(e[5]), .segs(HEX5)); 
endmodule


