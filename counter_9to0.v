module counter_9to0(clock, bcd, Bs, Vs, Error); // contador que vai de 9 a 0

    input clock, Bs, Vs, Error;
	output [3:0] bcd;
	
	wire A, B, C, D; // A é o mais significativo
	wire d0, d1, d2, d3; // Valores das entradas "D" dos flip-flops

    assign d3 = (!D) && (Bs || Vs) && !Error;
	assign d2 = (B & !C & !D | A & !D | C & D) && !Error;
	assign d1 = (A & !D | B & D | B & C) && (Bs || Vs) && !Error;
	assign d0 = (!A & !B & !C & !D || A & D) && (Bs || Vs) && !Error;
	
	flipflop_D c0(.D(d3), .clock(clock), .Q(A));
	flipflop_D c1(.D(d2), .clock(clock), .Q(B));
	flipflop_D c2(.D(d1), .clock(clock), .Q(C));
	flipflop_D c3(.D(d0), .clock(clock), .Q(D));
	
	assign bcd[3] = A;
	assign bcd[2] = B;
	assign bcd[1] = C;
	assign bcd[0] = D;

endmodule 