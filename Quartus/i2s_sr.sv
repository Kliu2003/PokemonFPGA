module i2s_sr(
	input SClk, // inverted clk (aka want to act on negedge of outside clk)
	input LRClk,
	input [7:0] sample, // just 0 for this purpose
	output [31:0] q
);
	always @(posedge SClk) begin
		if(LRClk == 1) begin
			q <= {1'b0, sample, 23'b0};
		end
		else begin
			q <= {q[30:0], 1'b0};
		end
	end
endmodule 