module MyFruitBasket (input A, input B, input S0, output z);
	 wire x, y;
	 MyApple  an_apple_chip(.A(A), .S0(S0), .x(x));
	 MyOrange an_orange_chip(.y(y), .B(B), .S0(S0));
	 MyLemon  a_lemon_chip(.y(y), .z(z), .x(x));
endmodule

module MyApple (input A, input S0, output x);
    assign x = A & ~S0;
endmodule

module MyOrange (input B, input S0, output y);
    assign y = B & S0;
endmodule

module MyLemon (input x, input y, output z);
    assign z = x | y;
endmodule

