module MyMUX(input A, input B, input S0, output reg z);
	 always @(*) begin
		  casex({A, B, S0})
				3'b0x0: z = 0;
				3'b1x0: z = 1;
				3'bx01: z = 0;
				3'bx11: z = 1;
			endcase
	  end
endmodule
