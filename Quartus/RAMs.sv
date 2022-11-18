module characterRAM
(
		input [7:0] data_In,
		input [12:0] write_address, read_address,
		input we, Clk,

		output logic [4:0] data_Out
);

	// mem has width of 3 bits and a total of 400 addresses
	logic [7:0] mem [0:6612];

	initial
	begin
		 $readmemh("Sprites/Ethan.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end

endmodule
