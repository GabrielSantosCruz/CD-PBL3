module encoder_bcd_7seg_until_2(bcd, A, B, C, D, E, F, G);
	input [3:0] bcd;
	output A, B, C, D, E, F, G;
	
	wire bcdA, bcdB, bcdC, bcdD;
	assign bcdA = bcd[3];
	assign bcdB = bcd[2];
	assign bcdC = bcd[1];
	assign bcdD = bcd[0];
	
	assign A = (!bcdA & !bcdB & !bcdC & bcdD);
	assign B = 0;
	assign C = (!bcdA & !bcdB & !bcdC & !bcdD);
	assign D = (!bcdA & !bcdB & !bcdC & bcdD);
	assign E = (!bcdA & !bcdB & !bcdC & bcdD);
	assign F = (!bcdA & !bcdB & !bcdC);
	assign G = (!bcdA & !bcdB & (bcdC ^ bcdD));
	
endmodule