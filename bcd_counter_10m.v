module bcd_counter_10m(bcd_1m, bcd);
	input [3:0] bcd_1m;
	output [3:0] bcd;
	
	wire clock_10m;
	assign clock_10m = (!bcd_1m[3] & !bcd_1m[2] & !bcd_1m[1] & !bcd_1m[0]);
	
	wire A, B, C, D; // A é o mais significativo
	wire d0, d1, d2, d3; // Valores das entradas "D" dos flip-flops
	
	assign d3 = 0;
	assign d2 = 0;
	assign d1 = (!A & !B & !C & D);
	assign d0 = (!A & !B & !C & !D);
	
	flipflop_D c0(.D(d3), .clock(clock_10m), .Q(A));
	flipflop_D c1(.D(d2), .clock(clock_10m), .Q(B));
	flipflop_D c2(.D(d1), .clock(clock_10m), .Q(C));
	flipflop_D c3(.D(d0), .clock(clock_10m), .Q(D));
	
	assign bcd[3] = A;
	assign bcd[2] = B;
	assign bcd[1] = C;
	assign bcd[0] = D;
endmodule