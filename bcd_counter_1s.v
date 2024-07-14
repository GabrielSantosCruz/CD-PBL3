module bcd_counter_1s(clock, bcd, Bs, Vs, Error);
	input clock, Bs, Vs, Error;
	output [3:0] bcd;
	
	wire A, B, C, D; // A é o mais significativo
	wire d0, d1, d2, d3; // Valores das entradas "D" dos flip-flops
	
	assign d3 = (!A & B & C & D || A & !B & !C & !D) && (Bs || Vs) && !Error;
	assign d2 = (!A & (B & !C || C & (B ^ D))) && (Bs || Vs) && !Error;
	assign d1 = (!A & (C ^ D)) && (Bs || Vs) && !Error;
	assign d0 = (!D & (!A || A & !B & !C)) && (Bs || Vs) && !Error;
	
	flipflop_D c0(.D(d3), .clock(clock), .Q(A));
	flipflop_D c1(.D(d2), .clock(clock), .Q(B));
	flipflop_D c2(.D(d1), .clock(clock), .Q(C));
	flipflop_D c3(.D(d0), .clock(clock), .Q(D));
	
	assign bcd[3] = A;
	assign bcd[2] = B;
	assign bcd[1] = C;
	assign bcd[0] = D;
endmodule