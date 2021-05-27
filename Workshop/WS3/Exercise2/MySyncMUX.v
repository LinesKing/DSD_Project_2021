module MySyncMUX (input x, y, s, clk , output reg m_sync); 
	 MyMUX MUX (.x(x), .y(y), .s(s), .m(m));
	 always @(posedge clk) begin
	 m_sync <= m;
	 end
endmodule
