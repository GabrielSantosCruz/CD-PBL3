module encoder_bcd_7seg_until_5(bcd, A, B, C, D, E, F, G);
	input [3:0] bcd;
	output A, B, C, D, E, F, G;
	
	wire bcdA, bcdB, bcdC, bcdD;
	assign bcdA = bcd[3];
	assign bcdB = bcd[2];
	assign bcdC = bcd[1];
	assign bcdD = bcd[0];
	
	assign A = (!bcdA & !bcdC & (bcdB ^ bcdD));
	assign B = (!bcdA & !bcdB & !bcdC & !bcdD);
	assign C = (!bcdA & !bcdB & bcdC & bcdD);
	assign D = (!bcdA & !bcdC & (bcdB ^ bcdD));
	assign E = (!bcdA & (!bcdD || !bcdB & !bcdC));
	assign F = (!bcdA & (!bcdB & bcdC || bcdB & !bcdC & !bcdD));
	assign G = (!bcdA & bcdB & !bcdC);
	
endmodule