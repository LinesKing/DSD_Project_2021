`include "CPU.vh"

// CPU Module

module CPU(
	input [2:0]Btns,
	input Clock,
	input [7:0]Din,
	input Reset,
	input Sample,
	input Turbo,
	output reg [3:0]Debug = 0,
	output reg [7:0]Dout = 0,
	output reg Dval = 1,
	output reg [5:0]GPO = 0,
	output reg [7:0]IP = 0
	
);	

	// Stage 4:
	// 	Clock circuitry
	reg [23:0] cnt = 1;
	localparam CntMax = 15;
	always @(posedge Clock)
		cnt <= (cnt == CntMax) ? 0 : cnt + 1;

	// Synchronise CPU operations to when cnt == 0
	wire go = !Reset && (cnt == 0);

	// 	Instruction Cycle - Instruction Cycle Block
	always @(posedge Clock) begin
		// Process Instruction
		if (go) begin
			Dout <= Dout + 8'b1;
			GPO <= GPO + 8'b1;
			IP <= IP + 8'b1;
		end
		// Process Reset
		if (Reset) begin
			Dout <= 8'b0;
			GPO <= 8'b0;
			IP <= 8'b0;
		end
	end
	
endmodule
