module decoder_7seg(bcd, A, B, C, D, E, F, G);
	input [3:0] bcd;
	output A, B, C, D, E, F, G;
	
	wire bcdA, bcdB, bcdC, bcdD;
	assign a = bcd[3];
	assign b = bcd[2];
	assign c = bcd[1];
	assign d = bcd[0];
	
	assign A = (!a & !b & !c & d || b & !c & !d);
	assign B = (b & !c & d || b & c & !d);
	assign C = (!b & c & !d);
	assign D = (!a & !b & !c & d || b  & !c & !d || b & c & d);
	assign E = (d || b & !c);
	assign F = (!a & !b & d || !b & c || c & d);
	assign G = (!a & !b & !c || b & c & d);
	
endmodule