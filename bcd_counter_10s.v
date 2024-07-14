module bcd_counter_10s(bcd_1s, bcd);
	input [3:0] bcd_1s;
	output [3:0] bcd;
	
	wire clock_10s;
	assign clock_10s = (!bcd_1s[3] & !bcd_1s[2] & !bcd_1s[1] & !bcd_1s[0]);
	
	wire A, B, C, D; // A é o mais significativo
	wire d0, d1, d2, d3; // Valores das entradas "D" dos flip-flops
	
	assign d3 = 0;
	assign d2 = (!A & (B & !C & !D || !B & C & D));
	assign d1 = (!A & !B & (C ^ D));
	assign d0 = (!A & !D & (!C || !B & C));
	
	flipflop_D c0(.D(d3), .clock(clock_10s), .Q(A));
	flipflop_D c1(.D(d2), .clock(clock_10s), .Q(B));
	flipflop_D c2(.D(d1), .clock(clock_10s), .Q(C));
	flipflop_D c3(.D(d0), .clock(clock_10s), .Q(D));
	
	assign bcd[3] = A;
	assign bcd[2] = B;
	assign bcd[1] = C;
	assign bcd[0] = D;
endmodule