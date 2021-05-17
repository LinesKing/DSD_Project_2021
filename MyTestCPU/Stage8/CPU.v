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
	output reg [7:0]IP_OUT = 0
	
);	

	// Stage 6:
	// 	 Synchronise the turbo signal
	wire turbo_safe;
	Synchroniser tbo(Clock, Turbo, turbo_safe);
	reg [7:0]IP = 0;
		
	// Step 1 of Stage 5:
	// 	Clock circuitry (250 ms cycle)
	reg [23:0] cnt = 0;
	localparam CntMax = 12500000 - 1;
	always @(posedge Clock)
		cnt <= (cnt == CntMax) ? 0 : cnt + 1;

	// Synchronise CPU operations to when cnt == 0
	wire go = !Reset && ((cnt == 0) || turbo_safe);


	
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
	
	// Stage 8
	// Introduce several more temporary variables that do not get synthesised
	reg [7:0] cnum, cnum1, cnum2;  // current numbers in ncmd
	reg [5:0] cloc;  // current location in cmd
	reg cond;  // jump or overflow condition
	reg [15:0] word, s_word;  // num for ACC
	
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
			case (cmd_grp)
					`MOV: begin  // Move
							cnum = get_number(arg1_typ, arg1);
							case (cmd)
								`SHL: begin  // Shift Left, multiplied by 2
									`RFLAG[`SHFT] <= cnum[7];
									cnum = {cnum[6:0], 1'b0};
								end
								`SHR: begin  // Shift Right, divided by 2 with floor
									`RFLAG[`SHFT] <= cnum[0];
									cnum = {1'b0, cnum[7:1]};
								end
							endcase
							Reg[get_location(arg2_typ, arg2)] <= cnum;
					end
					
					// Stage 8
					`ACC: begin  // Accumulate
						cnum = get_number(arg2_typ, arg2);
						cloc = get_location(arg1_typ, arg1);
						case (cmd)
							`UAD: word = Reg[cloc] + cnum;  // Unsigned Addition
							`SAD: s_word = $signed(Reg[cloc]) + $signed(cnum);  // Signed Addition
							`UMT: word = Reg[cloc] * cnum;  // Unsigned Multiplication
							`SMT: s_word = $signed(Reg[cloc] ) * $signed(cnum);  // Signed Multiplication
							`AND: cnum = Reg[cloc] & cnum;  // Bitwise And
							`OR: cnum = Reg[cloc] | cnum;  // Bitwise Or
							`XOR: cnum = Reg[cloc] ^ cnum;  // Bitwise XOR
						endcase
					
						if (cmd[2] == 0)
							if (cmd[0] == 0) begin // Unsigned addition or multiplication
								cnum = word[7:0];
								`RFLAG[`OFLW] <= (word > 255);
							end
							else begin // Signed addition or multiplication
								cnum = s_word[7:0];
								`RFLAG[`OFLW] <= (s_word > 127 || s_word < -128);
							end
						Reg[cloc] <= cnum; // Fill this in
					end
					
					// Stage 9
					`JMP: begin  // Jump
					cnum1 = get_number(arg1_typ, arg1);
					cnum2 = get_number(arg2_typ, arg2);
						case (cmd)
							`UNC: cond = 1;  // Unconditional Jump
							`EQ : cond = cnum1 == cnum2;  // Jump on Equality
							`ULT: cond = cnum1 < cnum2;  // Jump on Unsigned Less Than
							`SLT: cond = $signed(cnum1) < $signed(cnum2);  // Jump on Signed Less Than
							`ULE: cond = cnum1 <= cnum2;  // Jump on Unsigned Less Than or Equals
							`SLE: cond = $signed(cnum1) <= $signed(cnum2);  // Jump on Signed Less Than or Equals
							default: cond = 0;
						endcase
							if (cond) IP <= addr;
					end
					
			endcase
		end
		
		// Process Reset
		if (Reset) IP <= 8'b0;
	end
	
	// Stage 6:
	always @(posedge Clock) begin
		IP_OUT <= IP;
	end
	
	// Stage 7
	function [7:0] get_number;
		input [1:0] arg_type;
		input [7:0] arg;
		begin
			case (arg_type)
				`REG: get_number = Reg[arg[4:0]];
				`IND: get_number = Reg[ Reg[arg[4:0]][4:0] ];
				default: get_number = arg;
			endcase
		end
	endfunction
	function [5:0] get_location;
		input [1:0] arg_type;
		input [7:0] arg;
		begin
			case (arg_type)
				`REG: get_location = arg[4:0];
				`IND: get_location = Reg[arg[4:0]][4:0];
				default: get_location = 0;
			endcase
		end
	endfunction
endmodule
