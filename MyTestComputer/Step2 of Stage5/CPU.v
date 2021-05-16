`include "CPU.vh"

// CPU Module

module CPU(
	input [2:0]Btns,
	input Clock,
	input [7:0]Din,
	input Reset,
	input Sample,
	input Turbo,
	output [3:0]Debug,
	output reg [7:0]Dout,
	output reg Dval,
	output [5:0]GPO,
	output reg [7:0]IP
	
);	

	// Step 1 of Stage 5:
	// 	Clock circuitry (250 ms cycle)
	reg [23:0] cnt = 1;
	localparam CntMax = 12500000;
	always @(posedge Clock)
		cnt <= (cnt == CntMax) ? 0 : cnt + 1;

	// Synchronise CPU operations to when cnt == 0
	// wire go = !Reset && ((cnt == 0) || turbo_safe);
	wire go = !Reset && (cnt == 0);

	// Step 1 of Stage 5：
	// 	Instruction Cycle - Instruction Cycle Block
	always @(posedge Clock) begin
		// Process Instruction
		if (go) IP <= IP + 8'b1;
		// Process Reset
		if (Reset) IP <= 8'b0;
	end

	
	// Step 2 of Stage 5:
	// 	Program Memory
	wire [34:0] instruction;
	AsyncROM Pmem(IP, instruction);

	// Step 2 of Stage 5: Test
	initial Dval = 1;
	always @(*)
		Dout = instruction[25 -:8];
	
	initial begin
	IP = 0;
	end
endmodule
