module encoder_bcd_7seg_until_9(bcd, A, B, C, D, E, F, G);
	input [3:0] bcd;
	output A, B, C, D, E, F, G;
	
	wire bcdA, bcdB, bcdC, bcdD;
	assign bcdA = bcd[3];
	assign bcdB = bcd[2];
	assign bcdC = bcd[1];
	assign bcdD = bcd[0];
	
	assign A = (bcdB & !bcdC & bcdD || bcdA & !bcdD);
	assign B = (bcdB & !bcdC & !bcdD || !bcdB & bcdC & bcdD);
	assign C = (bcdB & bcdC & bcdD);
	assign D = (bcdB & !bcdC & bcdD || !bcdB & !bcdD);
	assign E = (bcdB & !bcdC || !bcdD);
	assign F = (bcdC & !bcdD || bcdA & !bcdD || bcdB & bcdC);
	assign G = (!bcdB & bcdC & !bcdD || bcdA);
	
endmodule