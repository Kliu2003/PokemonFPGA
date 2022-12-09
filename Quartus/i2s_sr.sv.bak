module i2s_sr #(parameter SIZE) (
	output reg sd,
	input clk, // inverted clk (aka want to act on negedge of outside clk)
	input data, // just 0 for this purpose
	input [SIZE-1:0] data_pl, // either left or right input data
	input pl // synchronous parallel load
);
	
	logic [SIZE-1:0] data_sr;
	always @(negedge clk) begin:sr_main
		if (pl == 1'b1) begin
			data_sr <= data_pl;
		end
		sd <= data_sr[SIZE-1]; // want to shift out MSB first
		data_sr <= {data_sr[SIZE-2:0], 0};
	end
	
endmodule 