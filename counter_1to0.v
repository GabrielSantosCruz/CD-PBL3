module counter_1to0(Bbcd, bcd); // contador que vai de 9 a 0

   input [3:0] Bbcd;
	output [3:0] bcd;
	
	wire clock;
	assign clock = (!Bbcd[3] & !Bbcd[2] & !Bbcd[1] & !Bbcd[0]);
	wire A, B, C, D; // A é o mais significativo
	wire d0, d1, d2, d3; // Valores das entradas "D" dos flip-flops
	
	assign d3 = (0);
	assign d2 = (0);
	assign d1 = (0);
	assign d0 = !D;
	
	flipflop_D c0(.D(d3), .clock(clock), .Q(A));
	flipflop_D c1(.D(d2), .clock(clock), .Q(B));
	flipflop_D c2(.D(d1), .clock(clock), .Q(C));
	flipflop_D c3(.D(d0), .clock(clock), .Q(D));
	
	assign bcd[3] = A;
	assign bcd[2] = B;
	assign bcd[1] = C;
	assign bcd[0] = D;

endmodule 