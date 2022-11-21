module i2s_xmit #(parameter SIZE) (
	output reg sd,
	input clk, // sck - serial clock
	input ws, // selects between left-0/right-1 data
	input [SIZE-1:0] data_left, // left audio input
	input [SIZE-1:0] data_right // right audio input
);
	
	logic wsd; // ws but delay one clk cycle
	logic wsdd; // ws but delay two clk cycle
	logic wsp; // for parallel load
	
	always @(posedge clk) begin:wsd_ff
		wsdd <= wsd;
		wsd <= ws;
	end
	
	always @(wsd or wsdd) begin:wsp_comb
		wsp = wsdd ^ wsd;
	end
	
	i2s_sr shift_reg(.sd(sd), .clk(clk), .data(0), .data_pl((wsd ? data_left : data_right)), .pl(wsp));

endmodule 

// note xmit is transmit, rcv is receive