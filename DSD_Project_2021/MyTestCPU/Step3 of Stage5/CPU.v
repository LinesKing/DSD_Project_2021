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
	output [7:0]Dout,
	output reg Dval,
	output [5:0]GPO,
	output reg [7:0]IP = 0
	
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
	wire go_cmd = !Reset && (cnt == 1);

	
	// Step 2 of Stage 5:
	// 	Program Memory
	wire [34:0] instruction;
	AsyncROM Pmem(IP, instruction);

//	// Step 2 of Stage 5: Test
//	initial Dval = 1;
//	always @(*)
//		Dout = instruction[25 -:8];
	
	// Step 3 of Stage 5:
	// 	Registers
	reg [7:0] Reg [0:31];
	
	// Use these to Read the Special Registers
	wire [7:0] Rgout = Reg[29];
	wire [7:0] Rdout = Reg[30];
	wire [7:0] Rflag = Reg[31];
	
	// Use these to Write to the Flags and Din Registers
	`define RFLAG Reg[31]
	`define RDINP Reg[28]
	
	// Connect certain registers to the external world
	assign Dout = Rdout;
	assign GPO = Rgout[5:0];
	
	//TO DO: Change Later
	initial Dval = 1;
	
	// Instruction Cycle
	wire [3:0] cmd_grp = instruction[34:31];
	wire [2:0] cmd = instruction[30:28];
	wire [1:0] arg1_typ = instruction[27:26];
	wire [7:0] arg1 = instruction[25:18];
	wire [1:0] arg2_typ = instruction[17:16];
	wire [7:0] arg2 = instruction[15:8];
	wire [7:0] addr = instruction[7:0];
	
	// Step 3 of Stage 5：
	// 	Instruction Cycle - Instruction Cycle Block
	always @(posedge Clock) begin
		// Process Instruction
		if (go) begin 
			IP <= IP + 8'b1;  // Default action is to increment IP
		end
		
		if (go_cmd) begin 
			case (cmd_grp)
					`MOV: 
							Reg[arg2] <= arg1;
			// For now, we just assumed a PUR move, with arg1 a number and arg2 a register
			endcase
		end
		
		// Process Reset
		if (Reset) IP <= 8'b0;
	end
endmodule
