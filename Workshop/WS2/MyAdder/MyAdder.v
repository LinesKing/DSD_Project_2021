module MyHalfAdder(input a, b, output sum, carry);
	 assign sum = a ^ b;
	 assign carry = a & b;
endmodule

module MyFullAdder(input a, b, c_in, output sum, carry);
	 assign sum = (a ^ b) ^ c_in;
	 assign carry = (a & b) | (c_in & (a ^ b));
endmodule
