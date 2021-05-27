module Exercise1(input A, input B, output x, output y, output z);
    assign x = A & B;
	 assign y = A | B;
	 assign z = A ^ B;
endmodule
