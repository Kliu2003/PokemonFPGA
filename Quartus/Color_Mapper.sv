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


module  color_mapper 
( 
		input Clk, Reset,
		input Character_Moving,
		input [1:0] Direction,
		input [9:0] DrawX, DrawY,
		output logic [7:0]  Red, Green, Blue 
);
    
	logic Character_Here;
	
	typedef enum logic [3:0] {upRest1, upRest2, upM1, upM2, 
									leftRest1, leftRest2, leftM1, leftM2, 
									downRest1, downRest2, downM1, downM2, 
									rightRest1, rightRest2, rightM1, rightM2} Anim_State;

	Anim_State Curr_State, Next_State;
	
	always_comb begin:Character_Proc
		if(DrawX >= 10'd292 && DrawX <= 10'd308 && DrawY >= 10'd350 && DrawY <= 10'd373) begin 
			Character_Here = 1'b1;
		end
		else begin
			Character_Here = 1'b0;
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
	
	always_ff @(posedge Clk) begin:Move_FSM // TODO change 'posedge clk' to VS (vertical sync)
		unique case(Curr_State)
		
			//Up Check
			upRest1:
				if(Character_Moving == 0) begin
					Next_State = upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upM1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			upM1:
				if(Character_Moving == 0) begin
					Next_State = upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest2;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			upRest2:
				if(Character_Moving == 0) begin
					Next_State = upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upM2;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			upM2:
				if(Character_Moving == 0) begin
					Next_State = upRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			//Right Check	
			rightRest1:
				if(Character_Moving == 0) begin
					Next_State = rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightM1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			rightM1:
				if(Character_Moving == 0) begin
					Next_State = rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest2;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			rightRest2:
				if(Character_Moving == 0) begin
					Next_State = rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightM2;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			rightM2:
				if(Character_Moving == 0) begin
					Next_State = rightRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			//Down Check
			downRest1:
				if(Character_Moving == 0) begin
					Next_State = downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downM1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			downM1:
				if(Character_Moving == 0) begin
					Next_State = downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest2;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			downRest2:
				if(Character_Moving == 0) begin
					Next_State = downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downM2;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			downM2:
				if(Character_Moving == 0) begin
					Next_State = downRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
				
			//Left Check
			leftRest1:
				if(Character_Moving == 0) begin
					Next_State = leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftM1;
					end
				end
				
			leftM1:
				if(Character_Moving == 0) begin
					Next_State = leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest2;
					end
				end
				
			leftRest2:
				if(Character_Moving == 0) begin
					Next_State = leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftM2;
					end
				end
				
			leftM2:
				if(Character_Moving == 0) begin
					Next_State = leftRest1;
				end
				else begin
					if(Direction == 2'd0) begin
						Next_State = upRest1;
					end
					else if(Direction == 2'd1) begin
						Next_State = rightRest1;
					end
					else if(Direction == 2'd2) begin
						Next_State = downRest1;
					end
					else if(Direction == 2'd3) begin
						Next_State = leftRest1;
					end
				end
		
			default:
				Next_State = upRest1;
		endcase
	end
	
	always_ff @(posedge Clk) begin:Draw_Character
		if (Character_Here == 1) begin 
			
//			unique case(Curr_State)
//				//Draw Up Sprites
//				upRest1: begin
//					;
//				end
//				upM1: begin
//					;
//				end
//				upRest2: begin
//					;
//				end
//				upM2: begin
//					;
//				end
//				
//				//Draw Right Sprites
//				rightRest1: begin
//					;
//				end
//				rightM1: begin
//					;
//				end
//				rightRest2: begin
//					;
//				end
//				rightM2: begin
//					;
//				end
//				
//				//Draw Down Sprites
//				downRest1: begin
//					;
//				end
//				downM1: begin
//					;
//				end
//				downRest2: begin
//					;
//				end
//				downM2: begin
//					;
//				end
//				
//				//Draw Left Sprites
//				leftRest1: begin
//					;
//				end
//				leftM1: begin
//					;
//				end
//				leftRest2: begin
//					;
//				end
//				leftM2: begin
//					;
//				end
//			endcase
		end       
		else begin
//			Red = 8'h00; 
//			Green = 8'h7f - DrawY[9:3];
//			Blue = 8'h7f - DrawX[9:3];
			Red = 8'h00;
			Green = 8'h00;
			Blue = 8'h00;
		end
	end
 
endmodule
