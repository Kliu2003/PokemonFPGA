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

module gymRAM
(
		input [5:0] data_In,
		input [15:0] write_address, read_address,
		input we, Clk,
		output logic [5:0] data_Out
);

	logic [5:0] mem [0:35840];

	initial
	begin
		 $readmemh("Sprites/Violet_Gym_HGSS_64.txt", mem);
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
		output logic [4:0] data_Out
);

	logic [4:0] mem [0:20000];

	initial
	begin
		 $readmemh("Sprites/start-menu_200x100_32.txt", mem);
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
		input [15:0] write_address, read_address,
		input we, Clk,
		output logic [3:0] data_Out
);

	logic [3:0] mem [0:76800];

	initial
	begin
		 $readmemb("Sprites/mem__map_violet-city-medres-collision.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module collisionGymRAM
(
		input data_In,
		input [18:0] write_address, read_address,
		input we, Clk,
		output logic [3:0] data_Out
);

	logic [3:0] mem [0:20000];

	initial
	begin
		 $readmemb("Sprites/mem__Violet_Gym_HGSS-collision_2.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 