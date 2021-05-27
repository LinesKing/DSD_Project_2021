module Exercise2(input A, input B, input C, input D, output w, output x, output y, output z);
    assign x = !B | (A & B & C & D);
	 assign y = (!C & B) | (A & B & C & D);
	 assign z = (!D & C & B) | (A & B & C & D);
	 assign w = (!A & D & C & B) | (A & B & C & D);
endmodule
