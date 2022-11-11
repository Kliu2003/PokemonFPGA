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


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic [7:0]  Red, Green, Blue );
    
	logic ball_on;

	always_comb begin:Ball_on_proc
		if (DrawX > 300 && DrawX < 340 && DrawY > 220 && DrawY < 260) begin 
            ball_on = 1'b1;
		end
		else begin
			ball_on = 1'b0;
		end
	end 
	 
	always_comb begin:RGB_Display
		if ((ball_on == 1'b1)) begin 
			Red = 8'h00; 
			Green = 8'h00;
			Blue = 8'h7f - BallX[9:3];
		end       
		else begin 
			Red = 8'h00; 
			Green = 8'h00;
			Blue = 8'h7f - DrawX[9:3];
		end
	end 
 
endmodule
