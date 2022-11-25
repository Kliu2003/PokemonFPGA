module color_mapper 
( 
		input Clk, Reset, VS, blank, pixel_clk,
		input Character_Moving,
		input [1:0] Direction,
		input [9:0] DrawX, DrawY,
		output logic [7:0]  Red, Green, Blue 
);
    
	logic Character_Here;
	
	logic [23:0] Palette [16];
	assign Palette[0] = 24'h0080ff;
	assign Palette[1] = 24'h050507;
	assign Palette[2] = 24'h565656;
	assign Palette[3] = 24'h384040;
	assign Palette[4] = 24'hf7af20;
	assign Palette[5] = 24'hd8a078;
	assign Palette[6] = 24'hb66f20;
	assign Palette[7] = 24'hf8d0b8;
	assign Palette[8] = 24'hb8b0d0;
	assign Palette[9] = 24'h968fae;
	assign Palette[10] = 24'he7e7f7;
	assign Palette[11] = 24'hc03838;
	assign Palette[12] = 24'hed6747;
	assign Palette[13] = 24'h0b6ed1;
	assign Palette[14] = 24'h5e3233;
	assign Palette[15] = 24'h2e3340;
	
	logic [23:0] Map_Palette [128];
	assign Map_Palette[0] = 24'h6159a0;
	assign Map_Palette[1] = 24'h60a7d3;
	assign Map_Palette[2] = 24'h925e29;
	assign Map_Palette[3] = 24'hd4d8dc;
	assign Map_Palette[4] = 24'hd49f68;
	assign Map_Palette[5] = 24'h339ada;
	assign Map_Palette[6] = 24'haa9667;
	assign Map_Palette[7] = 24'h68c6da;
	assign Map_Palette[8] = 24'h2a68a3;
	assign Map_Palette[9] = 24'h6497a5;
	assign Map_Palette[10] = 24'h63945d;
	assign Map_Palette[11] = 24'h375c5d;
	assign Map_Palette[12] = 24'ha1a798;
	assign Map_Palette[13] = 24'h55292e;
	assign Map_Palette[14] = 24'h36256f;
	assign Map_Palette[15] = 24'h8ecea9;
	assign Map_Palette[16] = 24'h6c4d74;
	assign Map_Palette[17] = 24'ha0b0d1;
	assign Map_Palette[18] = 24'ha8cad5;
	assign Map_Palette[19] = 24'h593492;
	assign Map_Palette[20] = 24'h4f3355;
	assign Map_Palette[21] = 24'h65c3a1;
	assign Map_Palette[22] = 24'h949435;
	assign Map_Palette[23] = 24'h3c9377;
	assign Map_Palette[24] = 24'hd06e2a;
	assign Map_Palette[25] = 24'hdfb99d;
	assign Map_Palette[26] = 24'h393a8c;
	assign Map_Palette[27] = 24'h706317;
	assign Map_Palette[28] = 24'h6666c4;
	assign Map_Palette[29] = 24'h368fb6;
	assign Map_Palette[30] = 24'h394335;
	assign Map_Palette[31] = 24'h1870d0;
	assign Map_Palette[32] = 24'h906a69;
	assign Map_Palette[33] = 24'h886496;
	assign Map_Palette[34] = 24'hf4c59f;
	assign Map_Palette[35] = 24'h5d802a;
	assign Map_Palette[36] = 24'hc77d47;
	assign Map_Palette[37] = 24'he5833d;
	assign Map_Palette[38] = 24'hc9bbca;
	assign Map_Palette[39] = 24'ha6a9af;
	assign Map_Palette[40] = 24'h79d4b2;
	assign Map_Palette[41] = 24'h39bdee;
	assign Map_Palette[42] = 24'ha08060;
	assign Map_Palette[43] = 24'h53672c;
	assign Map_Palette[44] = 24'h4a5632;
	assign Map_Palette[45] = 24'h979aa4;
	assign Map_Palette[46] = 24'h957858;
	assign Map_Palette[47] = 24'h5c7825;
	assign Map_Palette[48] = 24'h6f9722;
	assign Map_Palette[49] = 24'h9da4a6;
	assign Map_Palette[50] = 24'h484a33;
	assign Map_Palette[51] = 24'h3cc2ee;
	assign Map_Palette[52] = 24'hafb0b7;
	assign Map_Palette[53] = 24'h9b836d;
	assign Map_Palette[54] = 24'h74c8a8;
	assign Map_Palette[55] = 24'h939499;
	assign Map_Palette[56] = 24'h78664f;
	assign Map_Palette[57] = 24'h658726;
	assign Map_Palette[58] = 24'h77a527;
	assign Map_Palette[59] = 24'h856a4f;
	assign Map_Palette[60] = 24'h70b698;
	assign Map_Palette[61] = 24'h468769;
	assign Map_Palette[62] = 24'h6ea88c;
	assign Map_Palette[63] = 24'h676789;
	assign Map_Palette[64] = 24'h737692;
	assign Map_Palette[65] = 24'h928b89;
	assign Map_Palette[66] = 24'h4f674e;
	assign Map_Palette[67] = 24'h43c8ee;
	assign Map_Palette[68] = 24'h545973;
	assign Map_Palette[69] = 24'h72796b;
	assign Map_Palette[70] = 24'h627c2a;
	assign Map_Palette[71] = 24'h522a99;
	assign Map_Palette[72] = 24'h4b584c;
	assign Map_Palette[73] = 24'h6f5946;
	assign Map_Palette[74] = 24'h6d5637;
	assign Map_Palette[75] = 24'h526373;
	assign Map_Palette[76] = 24'h844950;
	assign Map_Palette[77] = 24'h50a788;
	assign Map_Palette[78] = 24'h6d9579;
	assign Map_Palette[79] = 24'h84b42e;
	assign Map_Palette[80] = 24'h7a464c;
	assign Map_Palette[81] = 24'h70886f;
	assign Map_Palette[82] = 24'h5a32a2;
	assign Map_Palette[83] = 24'h4b494c;
	assign Map_Palette[84] = 24'h363532;
	assign Map_Palette[85] = 24'h997d62;
	assign Map_Palette[86] = 24'h3a6551;
	assign Map_Palette[87] = 24'h4b9878;
	assign Map_Palette[88] = 24'h2f2a23;
	assign Map_Palette[89] = 24'h43bbe7;
	assign Map_Palette[90] = 24'h507554;
	assign Map_Palette[91] = 24'h59b795;
	assign Map_Palette[92] = 24'h38876d;
	assign Map_Palette[93] = 24'h709b83;
	assign Map_Palette[94] = 24'h384863;
	assign Map_Palette[95] = 24'h633bab;
	assign Map_Palette[96] = 24'h69666d;
	assign Map_Palette[97] = 24'h525691;
	assign Map_Palette[98] = 24'h737355;
	assign Map_Palette[99] = 24'h6b4a35;
	assign Map_Palette[100] = 24'h34394b;
	assign Map_Palette[101] = 24'h7bbab5;
	assign Map_Palette[102] = 24'h357a66;
	assign Map_Palette[103] = 24'h39434d;
	assign Map_Palette[104] = 24'h4b382f;
	assign Map_Palette[105] = 24'h6b3743;
	assign Map_Palette[106] = 24'h5556b2;
	assign Map_Palette[107] = 24'h99815a;
	assign Map_Palette[108] = 24'h6b3775;
	assign Map_Palette[109] = 24'h845b93;
	assign Map_Palette[110] = 24'h462874;
	assign Map_Palette[111] = 24'h8485a3;
	assign Map_Palette[112] = 24'h517966;
	assign Map_Palette[113] = 24'h74868e;
	assign Map_Palette[114] = 24'h312955;
	assign Map_Palette[115] = 24'h37a8ea;
	assign Map_Palette[116] = 24'habc298;
	assign Map_Palette[117] = 24'h2e688e;
	assign Map_Palette[118] = 24'ha57b57;
	assign Map_Palette[119] = 24'h47486b;
	assign Map_Palette[120] = 24'h716633;
	assign Map_Palette[121] = 24'h54688a;
	assign Map_Palette[122] = 24'h4b86b3;
	assign Map_Palette[123] = 24'h4f3967;
	assign Map_Palette[124] = 24'h424889;
	assign Map_Palette[125] = 24'ha39894;
	assign Map_Palette[126] = 24'h38735b;
	assign Map_Palette[127] = 24'h855750;
	
	
	typedef enum logic [3:0] {upRest1, upRest2, upM1, upM2, 
									leftRest1, leftRest2, leftM1, leftM2, 
									downRest1, downRest2, downM1, downM2, 
									rightRest1, rightRest2, rightM1, rightM2} Anim_State;

	Anim_State Curr_State, Next_State;
	
	logic [16:0] read_addr, map_read_addr;
	logic [3:0] palette_color;
	logic [7:0] map_palette_color;
	
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
	logic [2:0] movementDelay;
	
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
						if(movementDelay == 0) begin
							Next_State <= upM1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= upRest2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= upM2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= upRest1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= rightM1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= rightRest2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= rightM2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= rightRest1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= downM1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= downRest2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= downM2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= downRest1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= leftM1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= leftRest2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= leftM2;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
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
						if(movementDelay == 0) begin
							Next_State <= leftRest1;
						end
						if(movementDelay == 4'd7) begin
							movementDelay <= 4'd0;
						end
						else begin
							movementDelay <= movementDelay + 1;
						end
						topleftX <= topleftX - 1;
					end
				end
		
			default:
				Next_State <= upRest1;
		endcase
	end
	
	always_ff @(posedge pixel_clk) begin:RGB_Display
		if(!blank) begin
			{Red, Green, Blue} <= 24'h000000;
		end
		else if (Character_Here == 1 && palette_color != 0) begin 
			{Red, Green, Blue} <= Palette[palette_color];
		end       
		else begin
			{Red, Green, Blue} = Map_Palette[map_palette_color];
		end
	end
 
endmodule
