module characterRAM
(
		input [3:0] data_In,
		input [12:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

	logic [3:0] mem [0:6612];

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
		input [7:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

	logic [7:0] mem [0:76800];

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

module startmenuRAM
(
		input [7:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [7:0] data_Out
);

	logic [7:0] mem [0:76800];

	initial
	begin
		 $readmemh("Sprites/start-menu.txt", mem);
	end


	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end

endmodule

module collisionRAM
(
		input data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic data_Out
);

	logic mem [0:76800];

	initial
	begin
		 $readmemh("Sprites/map_violet-city-medres-collision.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 