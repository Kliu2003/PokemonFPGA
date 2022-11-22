module characterRAM
(
		input [7:0] data_In,
		input [12:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

	logic [7:0] mem [0:6612];

	initial
	begin
		 $readmemh("Sprites/Ethan_16.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end

endmodule

module mapRAM
(
		input [11:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

	logic [11:0] mem [0:76800];

	initial
	begin
		 $readmemh("Sprites/map_violet-city-medres_128.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end

endmodule 