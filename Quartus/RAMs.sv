//Sprite and collision text files generated by custom script

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
		input [18:0] write_address, read_address,
		input we, Clk,
		output logic [3:0] data_Out
);

	logic [3:0] mem [0:76800];

	initial
	begin
		 $readmemb("Sprites/mem__map_violet-city-medres-collision_2_3.txt", mem);
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
		input [15:0] write_address, read_address,
		input we, Clk,
		output logic [3:0] data_Out
);

	logic [3:0] mem [0:35840];

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

module dialogue_1_right
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc_right.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_1_wrong
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc_wrong.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_3_right
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc3_right.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_3_wrong
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc3_wrong.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_1_1
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc1_dialogue1.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_1_2
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc1_dialogue2.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_1_3
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc1_dialogue3.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_2_1
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc2_dialogue1.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_2_2
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc2_dialogue2.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_3_1
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc3_dialogue1.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_3_2
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc3_dialogue2.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 

module dialogue_3_3
(		
		input data_In,
		input [12:0] write_address, read_address,
		input we, Clk,
		output logic data_Out
);

	logic mem [0:5440];

	initial
	begin
		 $readmemb("Sprites/npc3_dialogue3.txt", mem);
	end
	always_ff @ (posedge Clk) begin
		if (we)
			mem[write_address] <= data_In;
		data_Out<= mem[read_address];
	end
	
endmodule 


//Text file generated using Zayd's waveform generator

module warp_rom (
	input clk,
	input [13:0] addr,
	output logic [7:0] q
);

	logic [7:0] rom [15174];
	always_ff @(posedge clk) begin
		q <= rom[addr];
	end
	initial begin 
		$readmemh("Music/warp.txt", rom); 
	end
endmodule
