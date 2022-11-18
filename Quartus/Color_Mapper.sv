//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module color_mapper 
( 
		input Clk, Reset, VS,
		input Character_Moving,
		input [1:0] Direction,
		input [9:0] DrawX, DrawY,
		output logic [7:0]  Red, Green, Blue 
);
    
	logic Character_Here;
	logic [23:0] Palette [23];
	
	assign Palette[0] = 24'h800080;
	assign Palette[1] = 24'h000000;
	assign Palette[2] = 24'hF83800;
	assign Palette[3] = 24'hF0D0B0;
	assign Palette[4] = 24'h503000;
	assign Palette[5] = 24'hFFE0A8;
	assign Palette[6] = 24'h0058F8;
	assign Palette[7] = 24'hFCFCFC;
	assign Palette[8] = 24'hBCBCBC;
	assign Palette[9] = 24'hA40000;
	assign Palette[10] = 24'hD82800;
	assign Palette[11] = 24'hFC7460;
	assign Palette[12] = 24'hFCBCB0;
	assign Palette[13] = 24'hF0BC3C;
	assign Palette[14] = 24'hAEACAE;
	assign Palette[15] = 24'h363301;
	assign Palette[16] = 24'h6C6C01;
	assign Palette[17] = 24'hBBBD00;
	assign Palette[18] = 24'h88D500;
	assign Palette[19] = 24'h398802;
	assign Palette[20] = 24'h65B0FF;
	assign Palette[21] = 24'h155ED8;
	assign Palette[22] = 24'h24188A;
	
	
	typedef enum logic [3:0] {upRest1, upRest2, upM1, upM2, 
									leftRest1, leftRest2, leftM1, leftM2, 
									downRest1, downRest2, downM1, downM2, 
									rightRest1, rightRest2, rightM1, rightM2} Anim_State;

	Anim_State Curr_State, Next_State;
	
	logic [16:0] read_addr, map_read_addr;
	logic [5:0] palette_color, map_palette_color;
	
	characterRAM CharacterRAM(
		.data_In(0),
		.write_address(0),
		.read_address(read_addr),
		.we(0),
		.Clk(Clk),
		.data_Out(palette_color)
	 );

	mapRAM mapRAM(
		.data_In(0),
		.write_address(0),
		.read_address(map_read_addr),
		.we(0),
		.Clk(Clk),
		.data_Out(map_palette_color)
	 );
	 
	logic [10:0] topleftX, topleftY;
	
	always_comb begin:Character_Proc
		if(DrawX >= 10'd311 && DrawX <= 10'd329 && DrawY >= 10'd340 && DrawY <= 10'd368) begin 
			Character_Here = 1'b1;
			map_read_addr = (DrawY + topleftY) / 4 * 320 + (DrawX + topleftX) / 4;
			unique case(Curr_State)
				//Draw Up Sprites
				upRest1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+133;
				end
				upM1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+114;
				end
				upRest2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+133;
				end
				upM2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+152;
				end
				
				//Draw Right Sprites
				rightRest1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+190;
				end
				rightM1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+171;
				end
				rightRest2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+190;
				end
				rightM2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+209;
				end
				
				//Draw Down Sprites
				downRest1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+19;
				end
				downM1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311);
				end
				downRest2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+19;
				end
				downM2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+38;
				end
				
				//Draw Left Sprites
				leftRest1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+76;
				end
				leftM1: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+57;
				end
				leftRest2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+76;
				end
				leftM2: begin
					read_addr = 228*(DrawY-10'd340)+(DrawX-10'd311)+95;
				end
				default;
			endcase
		end
		else begin
			Character_Here = 1'b0;
			read_addr = 0;
			map_read_addr = (DrawY + topleftY) / 4 * 320 + (DrawX + topleftX) / 4;
		end
	end 
	
	always_ff @ (posedge Clk) begin
		if(Reset) begin
			Curr_State <= upRest1;
		end
		else begin
			Curr_State <= Next_State;
		end
	end
	
	always_ff @(posedge VS) begin:Move_FSM //Need to be even slower than VS
		if(Reset) begin
			topleftX <= 11'd100;
			topleftY <= 11'd100;
		end
		unique case(Curr_State)
			//Up Check
			upRest1:
				if(Character_Moving == 0) begin
					Next_State <= upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upM1;
						topleftY <= topleftY - 1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			upM1:
				if(Character_Moving == 0) begin
					Next_State <= upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest2;
						topleftY <= topleftY - 1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			upRest2:
				if(Character_Moving == 0) begin
					Next_State <= upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upM2;
						topleftY <= topleftY - 1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			upM2:
				if(Character_Moving == 0) begin
					Next_State <= upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
						topleftY <= topleftY - 1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			//Right Check	
			rightRest1:
				if(Character_Moving == 0) begin
					Next_State <= rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightM1;
						topleftX <= topleftX + 1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			rightM1:
				if(Character_Moving == 0) begin
					Next_State <= rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest2;
						topleftX <= topleftX + 1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			rightRest2:
				if(Character_Moving == 0) begin
					Next_State <= rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightM2;
						topleftX <= topleftX + 1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			rightM2:
				if(Character_Moving == 0) begin
					Next_State <= rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
						topleftX <= topleftX + 1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			//Down Check
			downRest1:
				if(Character_Moving == 0) begin
					Next_State <= downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downM1;
						topleftY <= topleftY + 1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			downM1:
				if(Character_Moving == 0) begin
					Next_State <= downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest2;
						topleftY <= topleftY + 1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			downRest2:
				if(Character_Moving == 0) begin
					Next_State <= downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downM2;
						topleftY <= topleftY + 1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			downM2:
				if(Character_Moving == 0) begin
					Next_State <= downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
						topleftY <= topleftY + 1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
					end
				end
				
			//Left Check
			leftRest1:
				if(Character_Moving == 0) begin
					Next_State <= leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftM1;
						topleftX <= topleftX - 1;
					end
				end
				
			leftM1:
				if(Character_Moving == 0) begin
					Next_State <= leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest2;
						topleftX <= topleftX - 1;
					end
				end
				
			leftRest2:
				if(Character_Moving == 0) begin
					Next_State <= leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftM2;
						topleftX <= topleftX - 1;
					end
				end
				
			leftM2:
				if(Character_Moving == 0) begin
					Next_State <= leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State <= upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State <= rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State <= downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State <= leftRest1;
						topleftX <= topleftX - 1;
					end
				end
		
			default:
				Next_State <= upRest1;
		endcase
	end
	
	always_comb begin:RGB_Display
		if (Character_Here == 1 && palette_color != 6) begin 
			{Red, Green, Blue} = Palette[palette_color];
		end       
		else begin
			{Red, Green, Blue} = Palette[map_palette_color];
		end
	end
 
endmodule
