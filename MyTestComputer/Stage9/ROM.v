`include "CPU.vh"

// Step 2 of Stage 5:
// 	Asynchronous ROM (Program Memory)
module AsyncROM(input [7:0] addr, output reg [34:0] data);
	always @(addr)
		case (addr)
			0: data = {`MOV, `PUR, `NUM, 8'd 1, `REG, `DOUT, `N8};
			4: data = {`ACC, `SMT, `REG, `DOUT, `NUM, -8'd 2, `N8};
			7: data = {`JMP, `SLT, `REG, `DOUT, `NUM, 8'd 64, 8'd 4};
			10: data = {`MOV, `PUR, `NUM, 8'd 100, `REG, `DOUT, `N8};
			13: data = {`ACC, `SAD, `REG, `DOUT, `NUM, -8'd 7, `N8};
			16: data = {`JMP, `SLE, `NUM, 8'd 0, `REG, `DOUT, 8'd 13};
			20: data = {`JMP, `UNC, `N10, `N10, 8'd 0};
			default: data = 35'b0; // Default instruction is a NOP
		endcase
endmodule
