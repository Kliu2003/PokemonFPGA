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
		input Character_Moving,
		input [1:0] Direction,
		input [9:0] DrawX, DrawY,
		output logic [7:0]  Red, Green, Blue 
);
    
	logic character_here;

	always_comb begin:character_proc
		if(DrawX >= 10'd292 && DrawX <= 10'd308 && DrawY >= 10'd350 && DrawY <= 10'd373) begin 
			character_here = 1'b1;
		end
		else begin
			character_here = 1'b0;
		end
	end 
	 
	always_comb begin:RGB_Display
		if (character_here == 1) begin 
			unique case(Direction) begin
				
			endcase
		end       
		else begin 
			Red = 8'h00; 
			Green = 8'h7f - DrawY[9:3];
			Blue = 8'h7f - DrawX[9:3];
		end
	end 
 
endmodule
