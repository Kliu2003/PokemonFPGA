module palettes (
	input logic [1:0] select, // 0 is palette, 1 is map_palette
	input logic [3:0] palette_color,
	input logic [7:0] map_palette_color,
	input logic [4:0] start_palette_color,
	input logic [5:0] gym_palette_color,
	output logic [23:0] thecolor
);
	
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
	
	logic [23:0] Start_Palette [32];
	assign Start_Palette[0] = 24'hf6e05d;
	assign Start_Palette[1] = 24'hf6eda0;
	assign Start_Palette[2] = 24'hf4c916;
	assign Start_Palette[3] = 24'he0af11;
	assign Start_Palette[4] = 24'hdb9a57;
	assign Start_Palette[5] = 24'hfbf4ca;
	assign Start_Palette[6] = 24'ha06225;
	assign Start_Palette[7] = 24'ha79c5a;
	assign Start_Palette[8] = 24'haa9425;
	assign Start_Palette[9] = 24'hda7638;
	assign Start_Palette[10] = 24'h59675a;
	assign Start_Palette[11] = 24'hdf7b44;
	assign Start_Palette[12] = 24'hb0c85d;
	assign Start_Palette[13] = 24'h685e23;
	assign Start_Palette[14] = 24'h251d0f;
	assign Start_Palette[15] = 24'hdcb48b;
	assign Start_Palette[16] = 24'h572b07;
	assign Start_Palette[17] = 24'ha7734b;
	assign Start_Palette[18] = 24'ha4a892;
	assign Start_Palette[19] = 24'h345162;
	assign Start_Palette[20] = 24'h778561;
	assign Start_Palette[21] = 24'h596f91;
	assign Start_Palette[22] = 24'h20354c;
	assign Start_Palette[23] = 24'h8b3a15;
	assign Start_Palette[24] = 24'hb8ca9c;
	assign Start_Palette[25] = 24'hb8c237;
	assign Start_Palette[26] = 24'h728a8f;
	assign Start_Palette[27] = 24'h3a4a34;
	assign Start_Palette[28] = 24'h335e85;
	assign Start_Palette[29] = 24'hb4c9d6;
	assign Start_Palette[30] = 24'h768338;
	assign Start_Palette[31] = 24'hfcd62f;
	
	logic [23:0] Gym_Palette [64];
	assign Gym_Palette[0] = 24'h99a4aa;
	assign Gym_Palette[1] = 24'hb18f5f;
	assign Gym_Palette[2] = 24'h604c36;
	assign Gym_Palette[3] = 24'hae480f;
	assign Gym_Palette[4] = 24'h8c735d;
	assign Gym_Palette[5] = 24'h6e9e9c;
	assign Gym_Palette[6] = 24'hd0611d;
	assign Gym_Palette[7] = 24'h9db8d0;
	assign Gym_Palette[8] = 24'hc43b00;
	assign Gym_Palette[9] = 24'h6aa2ea;
	assign Gym_Palette[10] = 24'h7fc0f9;
	assign Gym_Palette[11] = 24'h707a85;
	assign Gym_Palette[12] = 24'h9acb93;
	assign Gym_Palette[13] = 24'h363e44;
	assign Gym_Palette[14] = 24'hdaa889;
	assign Gym_Palette[15] = 24'hcbd0d4;
	assign Gym_Palette[16] = 24'h78655c;
	assign Gym_Palette[17] = 24'hbcc4c9;
	assign Gym_Palette[18] = 24'h0f6f91;
	assign Gym_Palette[19] = 24'h6a8b79;
	assign Gym_Palette[20] = 24'h64331b;
	assign Gym_Palette[21] = 24'h250c01;
	assign Gym_Palette[22] = 24'he4c263;
	assign Gym_Palette[23] = 24'h1e475c;
	assign Gym_Palette[24] = 24'hd3af55;
	assign Gym_Palette[25] = 24'hf0d68a;
	assign Gym_Palette[26] = 24'h880015;
	assign Gym_Palette[27] = 24'hfefefe;
	assign Gym_Palette[28] = 24'h000000;
	assign Gym_Palette[29] = 24'h303130;
	assign Gym_Palette[30] = 24'h481b04;
	assign Gym_Palette[31] = 24'h272928;
	assign Gym_Palette[32] = 24'h5c431c;
	assign Gym_Palette[33] = 24'h192020;
	assign Gym_Palette[34] = 24'h4d260d;
	assign Gym_Palette[35] = 24'h181b1a;
	assign Gym_Palette[36] = 24'h2e1609;
	assign Gym_Palette[37] = 24'h72777b;
	assign Gym_Palette[38] = 24'h672705;
	assign Gym_Palette[39] = 24'h87c7f9;
	assign Gym_Palette[40] = 24'h513a27;
	assign Gym_Palette[41] = 24'h4f5455;
	assign Gym_Palette[42] = 24'h503816;
	assign Gym_Palette[43] = 24'h912901;
	assign Gym_Palette[44] = 24'h79838c;
	assign Gym_Palette[45] = 24'hede9e6;
	assign Gym_Palette[46] = 24'h4a4b4c;
	assign Gym_Palette[47] = 24'h535866;
	assign Gym_Palette[48] = 24'h631b00;
	assign Gym_Palette[49] = 24'h312315;
	assign Gym_Palette[50] = 24'h8f3606;
	assign Gym_Palette[51] = 24'ha3d39c;
	assign Gym_Palette[52] = 24'h1f1f20;
	assign Gym_Palette[53] = 24'h73b4f8;
	assign Gym_Palette[54] = 24'hc94800;
	assign Gym_Palette[55] = 24'hab2d00;
	assign Gym_Palette[56] = 24'h5a666e;
	assign Gym_Palette[57] = 24'h8a9399;
	assign Gym_Palette[58] = 24'h63461d;
	assign Gym_Palette[59] = 24'h6d564d;
	assign Gym_Palette[60] = 24'h39454c;
	assign Gym_Palette[61] = 24'hb83000;
	assign Gym_Palette[62] = 24'h67676e;
	assign Gym_Palette[63] = 24'h6e552c;
	
	
	always_comb begin
		unique case (select)
			0: begin
				thecolor = Palette[palette_color];
			end
			1: begin
				thecolor = Map_Palette[map_palette_color];
			end
			2: begin
				thecolor = Gym_Palette[gym_palette_color];
			end
			3: begin
				thecolor = Start_Palette[start_palette_color]; 
			end
			default:
				thecolor = 24'h000000;
		endcase
	end
endmodule
