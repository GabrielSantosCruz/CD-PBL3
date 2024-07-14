module bcd_counter_1m(bcd_10s, bcd);
	input [3:0] bcd_10s;
	output [3:0] bcd;
	
	wire clock_1m;
	assign clock_1m = (!bcd_10s[3] & !bcd_10s[2] & !bcd_10s[1] & !bcd_10s[0]);
	
	wire A, B, C, D; // A é o mais significativo
	wire d0, d1, d2, d3; // Valores das entradas "D" dos flip-flops
	
	assign d3 = (!A & B & C & D || A & !B & !C & !D);
	assign d2 = (!A & B & !C || !A & C & (B ^ D));
	assign d1 = (!A & (C ^ D));
	assign d0 = (!A & !D || A & !B & !C & !D);
	
	flipflop_D c0(.D(d3), .clock(clock_1m), .Q(A));
	flipflop_D c1(.D(d2), .clock(clock_1m), .Q(B));
	flipflop_D c2(.D(d1), .clock(clock_1m), .Q(C));
	flipflop_D c3(.D(d0), .clock(clock_1m), .Q(D));
	
	assign bcd[3] = A;
	assign bcd[2] = B;
	assign bcd[1] = C;
	assign bcd[0] = D;
endmodule