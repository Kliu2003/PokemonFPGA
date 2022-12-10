module color_mapper 
( 
		input Clk, Reset, VS, blank, pixel_clk,
		input [7:0] keycode,
		input Character_Moving,
		input [1:0] Direction,
		input [10:0] DrawX, DrawY,
		output logic [7:0]  Red, Green, Blue 
);
   
	logic Character_Here;
	
	typedef enum logic [3:0] {upRest1, upRest2, upM1, upM2, 
									leftRest1, leftRest2, leftM1, leftM2, 
									downRest1, downRest2, downM1, downM2, 
									rightRest1, rightRest2, rightM1, rightM2} Anim_State;
	
	typedef enum logic [2:0] {START = 3'b000, OVERWORLD = 3'b001, BATTLE = 3'b010, GYM = 3'b011, 
										GYM_PAUSE = 3'b111, OVERWORLD_PAUSE = 3'b101} Game_State;
	
	Anim_State Curr_State, Next_State;
	Game_State Curr_Game_State, Next_Game_State;
	
	logic [12:0] read_addr;
	logic [18:0] map_read_addr;
	logic [15:0] gym_read_addr;
	logic [18:0] start_read_addr; 
	logic [18:0] collision_read_addr;
	logic [15:0] collision_gym_read_addr;
	logic [3:0] palette_color;
	logic [7:0] map_palette_color;
	logic [5:0] gym_palette_color;
	logic [4:0] start_palette_color;
	logic [23:0] thecolor;
	logic [1:0] palette_select;
	logic [3:0] collision_status;
	logic [3:0] collision_gym_status;
	logic [1:0] game_completed;
	
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
	 
	gymRAM gymRAM(
		.data_In(0),
		.write_address(0),
		.read_address(gym_read_addr),
		.we(0),
		.Clk(Clk),
		.data_Out(gym_palette_color)
	 );
	 
	startmenuRAM startmenuRAM(
		.data_In(0),
		.write_address(0),
		.read_address(start_read_addr),
		.we(0),
		.Clk(Clk),
		.data_Out(start_palette_color)
	);
	
	collisionRAM collisionRAM(
		.data_In(0),
		.write_address(0),
		.read_address(collision_read_addr),
		.we(0),
		.Clk(Clk),
		.data_Out(collision_status)
	);
	
	collisionGymRAM collisionGymRAM(
		.data_In(0),
		.write_address(0),
		.read_address(collision_gym_read_addr),
		.we(0),
		.Clk(Clk),
		.data_Out(collision_gym_status)
	);
	 
	palettes palettes(
		.select(palette_select),
		.palette_color(palette_color),
		.gym_palette_color(gym_palette_color),
		.map_palette_color(map_palette_color),
		.start_palette_color(start_palette_color),
		.thecolor(thecolor),
	);
	 
	logic signed [12:0] topleftX, topleftY;
	logic [2:0] movementDelay;
	logic signed [13:0] topleftXChar, topleftYChar;
	logic [5:0] transitionDelay;
	
	always_comb begin:start_menu_addr
		start_read_addr = (DrawY-80) / 3 * 200 + (DrawX) * 10 / 32;
	end
	
	
	always_comb begin
		collision_read_addr = topleftYChar / 4 * 320 + topleftXChar / 4;
		collision_gym_read_addr = topleftYChar / 4 * 160 + topleftXChar / 4;
	end
	
	always_comb begin:Character_Proc
		if(DrawX >= 10'd311 && DrawX <= 10'd329 && DrawY >= 10'd340 && DrawY <= 10'd368) begin 
			Character_Here = 1'b1;
			if(($signed(DrawX) + topleftX) < 0 || ($signed(DrawY) + topleftY) < 0) begin
				map_read_addr = 0;
				gym_read_addr = 0;
			end
			else begin
				map_read_addr = ($signed(DrawY) + topleftY) / 4 * 320 + ($signed(DrawX) + topleftX) / 4;
				gym_read_addr = ($signed(DrawY) + topleftY) / 4 * 160 + ($signed(DrawX) + topleftX) / 4;
			end
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
			if(($signed(DrawX) + topleftX) < 0 || ($signed(DrawY) + topleftY) < 0) begin
				map_read_addr = 0;
				gym_read_addr = 0;
			end
			else begin
				map_read_addr = ($signed(DrawY) + topleftY) / 4 * 320 + ($signed(DrawX) + topleftX) / 4;
				gym_read_addr = ($signed(DrawY) + topleftY) / 4 * 160 + ($signed(DrawX) + topleftX) / 4;
			end
		end
	end 
	
//	always @(posedge Clk) begin
//		Curr_State <= Next_State;
//	end
	always_ff @(posedge Clk) begin
		Curr_State<= Next_State;
		Curr_Game_State <= Next_Game_State;
	end
	
	always_ff @(posedge VS) begin:Move_FSM
		unique case(Curr_Game_State)
			START:
				if (keycode == 8'h2c) begin
					Next_Game_State <= OVERWORLD;
					Next_State <= downRest1;
					topleftX <= 11'd100;
					topleftY <= 11'd100;
					topleftXChar <= 11'd100 + 11'd311;
					topleftYChar <= 11'd100 + 11'd340;
					transitionDelay <= 0;
				end
				else begin
					Next_Game_State <= Next_Game_State;
				end
			OVERWORLD: begin
				if(topleftXChar < 440 && topleftXChar > 420 && topleftYChar == 395) begin
					topleftX <= 11'd0;
					topleftY <= 11'd300;
					topleftXChar <= 11'd0 + 11'd311;
					topleftYChar <= 11'd300 + 11'd340;
					Next_State<= upRest1;
					Next_Game_State <= GYM_PAUSE;
					transitionDelay <= 0;
				end
				else begin
					Next_Game_State <= Next_Game_State;
				end
			end
				
			GYM_PAUSE: begin
				if(transitionDelay == 6'b111111) begin
					topleftX <= 11'd0;
					topleftY <= 11'd300;
					topleftXChar <= 11'd0 + 11'd311;
					topleftYChar <= 11'd300 + 11'd340;
					Next_Game_State <= GYM;
					Next_State<= upRest1;
				end
				else begin
					transitionDelay <= transitionDelay + 1;
				end
			end
					
			GYM: begin
				if(topleftYChar > 660 && topleftYChar < 670 && topleftXChar > 301 && topleftXChar < 321) begin
					topleftX <= 11'd119;
					topleftY <= 11'd100;
					topleftXChar <= 11'd119 + 11'd311;
					topleftYChar <= 11'd100 + 11'd340;
					Next_State <= downRest1;
					Next_Game_State <= OVERWORLD_PAUSE;
					transitionDelay <= 0;
				end
				else if(game_completed == 2'b11) begin
					Next_Game_State <= START;
				end
				else begin
					Next_Game_State <= Next_Game_State;
				end
			end
			
			OVERWORLD_PAUSE: begin	
				if(transitionDelay == 6'b111111) begin
					topleftX <= 11'd119;
					topleftY <= 11'd100;
					topleftXChar <= 11'd119 + 11'd311;
					topleftYChar <= 11'd100 + 11'd340;
					Next_State <= downRest1;
					Next_Game_State <= OVERWORLD;
				end
				else begin
					transitionDelay <= transitionDelay + 1;
				end
			end
			
			BATTLE: begin
				Next_Game_State <= START;
			end
			
			default: begin
				Next_Game_State <= START;
				game_completed <= 2'b00;
			end
		endcase
		
		unique case(Curr_Game_State)
			START:;
			OVERWORLD:
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
								if(topleftY > -340 && collision_status[3] == 0)begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftY > -340 && collision_status[3] == 0) begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftY > -340 && collision_status[3] == 0)begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftY > -340 && collision_status[3] == 0)begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftX <= 951 && collision_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
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
								if(topleftX <= 951 && collision_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
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
								if(topleftX <= 951 && collision_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
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
								if(topleftX <= 951 && collision_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
								
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
								if(topleftY <= 594 && collision_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftY <= 594 && collision_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftY <= 594 && collision_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftY <= 594 && collision_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftX > -311 && collision_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
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
								if(topleftX > -311 && collision_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
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
								if(topleftX > -311 && collision_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
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
								if(topleftX > -311 && collision_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
							end
						end
				
					default:
						Next_State <= upRest1;
				endcase
				
			GYM:
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
								if(topleftY > -250 && collision_gym_status[3] == 0)begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
						if(Character_Moving == 0 && collision_gym_status[3] == 0) begin
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
								if(topleftY > -250 && collision_gym_status[3] == 0) begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftY > -250 && collision_gym_status[3] == 0)begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftY > -250 && collision_gym_status[3] == 0)begin
									topleftY <= topleftY - 1;
									topleftYChar <= topleftYChar - 1;
								end
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
								if(topleftX <= 700 && collision_gym_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
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
								if(topleftX <= 700 && collision_gym_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
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
								if(topleftX <= 700 && collision_gym_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
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
								if(topleftX <= 700 && collision_gym_status[0] == 0)begin
									topleftX <= topleftX + 1;
									topleftXChar <= topleftXChar + 1;
								end
								
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
								if(topleftY <= 700 && collision_gym_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftY <= 700 && collision_gym_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftY <= 700 && collision_gym_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftY <= 700 && collision_gym_status[1] == 0)begin
									topleftY <= topleftY + 1;
									topleftYChar <= topleftYChar + 1;
								end
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
								if(topleftX > -141 && collision_gym_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
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
								if(topleftX > -141 && collision_gym_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
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
								if(topleftX > -141 && collision_gym_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
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
								if(topleftX > -141 && collision_gym_status[2] == 0)begin
									topleftX <= topleftX - 1;
									topleftXChar <= topleftXChar - 1;
								end
							end
						end
					default:
						Next_State <= upRest1;
				endcase
			default:;
		endcase
	end
	
	always_ff @(posedge pixel_clk) begin:RGB_Display
		unique case (Curr_Game_State)
			OVERWORLD: begin
				if(!blank || ($signed(DrawY) + topleftY) / 4 >= 240 || ($signed(DrawX) + topleftX) / 4 >= 320 || 
					($signed(DrawX) + topleftX) < 0 || ($signed(DrawY) + topleftY) < 0) begin
					{Red, Green, Blue} <= 24'h000000;
				end
				else begin
					if (Character_Here == 1 && palette_color != 0) begin 
						palette_select <= 0;
					end
					else begin
						palette_select <= 1;
					end
					{Red, Green, Blue} <= thecolor;
				end
			end
			GYM: begin
				if(!blank || ($signed(DrawY) + topleftY) / 4 >= 224 || ($signed(DrawX) + topleftX) / 4 >= 160 || 
					($signed(DrawX) + topleftX) < 0 || ($signed(DrawY) + topleftY) < 0) begin
					{Red, Green, Blue} <= 24'h000000;
				end
				else begin
					if (Character_Here == 1 && palette_color != 0) begin 
						palette_select <= 0;
					end
					else begin
						palette_select <= 2;
					end
					{Red, Green, Blue} <= thecolor == 24'hfefefe ? 24'h000000 : thecolor;
				end
			end
			GYM_PAUSE: begin
				if(!blank) begin
					{Red, Green, Blue} <= 24'h000000;
				end
				else begin
					{Red, Green, Blue} <= {8'hff - DrawY[10:3], 8'hff - DrawY[10:3], 8'hff - DrawY[10:3]};
				end
			end
			
			OVERWORLD_PAUSE: begin
				if(!blank) begin
					{Red, Green, Blue} <= 24'h000000;
				end
				else begin
					{Red, Green, Blue} <= {8'hff - DrawY[10:3], 8'hff - DrawY[10:3], 8'hff - DrawY[10:3]};
				end
			end
			
			default: begin
				if (!blank || DrawY < 80 || DrawY > 370) begin
					{Red, Green, Blue} <= 24'h000000;
				end
				else begin
					palette_select <= 3;
					{Red, Green, Blue} <= thecolor;
				end
			end
		endcase
		
	end
endmodule
