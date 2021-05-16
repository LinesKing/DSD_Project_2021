`include "CPU.vh"

// Stage 10:
// 	Asynchronous ROM (Program Memory)
module AsyncROM(input [7:0] addr, output reg [34:0] data);
	always @(addr)
		case (addr)
			0: data = set(`DOUT, 1);
			2: data = set_bit(`FLAG, `DVAL);
//			4: data = acc(`SMT, `DOUT, -2);
//			8: data = atc(`OFLW, 16);
			4: data = {`MOV, `SHL, `REG, `DOUT, `REG, `DOUT, `N8};
			8: data = atc(`SHFT, 16);
			12: data = jmp(4);
			16: data = set(`DOUT, 250);
			20: data = acc(`UAD, `DOUT, 1);
			24: data = atc(`OFLW, 8);
			28: data = jmp(20);
			default: data = 35'b0; // NOP
			1, 5, 9, 13, 17, 21, 25: data = mov(`FLAG, `GOUT);
		endcase
		
	function [34:0] set;
		input [7:0] reg_num;
		input [7:0] value;
		set = {`MOV, `PUR, `NUM, value, `REG, reg_num, `N8};
	endfunction
	
	function [34:0] mov;
		input [7:0] src_reg;
		input [7:0] dst_reg;
		mov = {`MOV, `PUR, `REG, src_reg, `REG, dst_reg, `N8};
	endfunction
	
	function [34:0] jmp;
		input [7:0] addr;
		jmp = {`JMP, `UNC, `N10, `N10, addr};
	endfunction
	
	function [34:0] atc;
		input [2:0] bit;
		input [7:0] addr;
		atc = {`ATC, bit, `N10, `N10, addr};
	endfunction
	
	function [34:0] acc;
		input [2:0] op;
		input [7:0] reg_num;
		input [7:0] value;
		acc = {`ACC, op, `REG, reg_num, `NUM, value, `N8};
	endfunction
	
	// Stage 11
	function [34:0] set_bit;
		input [7:0] reg_num;
		input [2:0] bit;
		set_bit = {`ACC, `OR, `REG, reg_num, `NUM, 8'b1 << bit, `N8};
	endfunction
	
	function [34:0] clr_bit;
		input [7:0] reg_num;
		input [2:0] bit;
		clr_bit = {`ACC, `AND, `REG, reg_num, `NUM, ~(8'b1 << bit), `N8};
	endfunction
endmodule
