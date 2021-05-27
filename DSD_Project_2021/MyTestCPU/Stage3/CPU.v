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
	output reg Dval = 0,
	output reg [5:0]GPO = 0,
	output reg [7:0]IP = 0
	
);	

	// Step 3：
	always @(posedge Clock) begin
		// Process Instruction
		if (Reset) begin
			Debug = 4'b0;
			Dout = 8'b0;
			Dval = 0;
			GPO = 6'b0;
			IP = 8'b0;
		end
		// Process Reset
		if (!Reset) GPO = 6'b111111;
	end

endmodule
