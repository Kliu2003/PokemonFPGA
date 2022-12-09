module warp_rom (
input clk,
input [13:0] addr,
output logic [7:0] q
)

logic [7:0] rom [15174];
always_ff @(posedge clk) begin
	q <= rom[addr];
end
initial begin $readmemh("warp.txt", rom); end
endmodule