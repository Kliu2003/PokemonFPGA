//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module Character_Movement 
( 
		input Reset, frame_clk,
		input [7:0] keycode,
		output Character_Moving,
		output [1:0] Direction
);
    
	 logic Movement;
	 logic [1:0] Current_Direction;
	 
   
    always_ff @ (posedge Reset or posedge frame_clk)
    begin:Move_Check
        if (Reset)  // Asynchronous Reset
        begin 
//          Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
//				Ball_X_Motion <= 10'd0; //Ball_X_Step;
//				Ball_Y_Pos <= Ball_Y_Center;
//				Ball_X_Pos <= Ball_X_Center;
				Character_Moving = 1'b0;
				Current_Direction = 2'd0;
        end
           
        else // TODO: implement collision logic for trees, buildings, fences, etc. once we make the map
        begin 
				unique case (keycode)
					8'h04 : begin //A
							if(Current_Direction == 2'd3) begin
								Movement <= 1'b1;
							end
							else begin
								Current_Direction <= 2'd3;
								Movement <= 1'b1;
							end
						end
							  
					8'h07 : begin //D
							if(Current_Direction == 2'd1) begin
								Movement <= 1'b1;
							end
							else begin
								Current_Direction <= 2'd1;
								Movement <= 1'b1;
							end
						end

							  
					8'h16 : begin //S
							if(Current_Direction == 2'd2) begin
								Movement <= 1'b1;
							end
							else begin
								Current_Direction <= 2'd2;
								Movement <= 1'b1;
							end
						end
							  
					8'h1A : begin //W
							if(Current_Direction == 2'd0) begin
								Movement <= 1'b1;
							end
							else begin
								Current_Direction <= 2'd0;
								Movement <= 1'b1;
							end
					end	  
							 
					default: begin //No key or irrelevant key presses
							Current_Direction <= Current_Direction;
							Movement <= 1'b0;
					end
				endcase	
			end  
    end
	 
	 assign Character_Moving = Movement;
	 assign Direction = Current_Direction;
     
endmodule
