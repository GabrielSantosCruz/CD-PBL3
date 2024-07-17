module pbl1(H, M, L, Bs, Vs, Ve, Us, Ua, Key_Ad, Ad, T, Al, E, clock, column, lines, segA, segB, segC, segD, segE, segF, segG, seven_seg_digit, seven_seg_digit_of);
	// Declaração das Portas
	input H, M, L, T, Us, Ua, clock, Key_Ad;
	output Bs, Vs, Ve, Al, E, Ad, segA, segB, segC, segD, segE, segF, segG;
	output [1:0] seven_seg_digit;
	output [1:0] seven_seg_digit_of;
	output [4:0] column;
	output [6:0] lines;
	
	// FIOS INTERMEDIÁRIOS:
	wire W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14;

	// VÁLVULA DE ENTRADA:
	nor nor0 (W0, Al, H);
	nor nor1 (W1, H, M, L);
	or or0 (Ve, W0, W1);

	// ERRO:
	not not0 (W2, L);
	and and0 (W3, W2, M);
	not not1 (W4, M);
	and and1 (W5, W4, H);
	or or1 (E, W3, W5);

	// ALARME:
	nand nand0 (W6, M, L);
	and and2 (W7, W6, H);
	nor nor2 (W8, H, L);
	or or2 (Al, W8, W7);

	//ASPERSÃO:
	nor nor3 (Bs, Us, Vs, Al);

	// GOTEJAMENTO:
	nand nand1 (W9, Ua, T);
	nor nor4 (W10, W9, Us);
	nor nor5 (W11, Us, T, M);
	and and3 (W12, W11, Ua);
	or or3 (W13, W10, W12);
	not not2 (W14, Al);
	and and4 (Vs, W13, W14);
	
	// AGRODEFENSIVO
	and (Ad, Bs, Key_Ad);
	
	// Instancionando o Módulo que Implementa o PBL 2 e sua Melhorias:
	pbl2 part2(.H(H), .M(M), .L(L), .Bs(Bs), .Vs(Vs), .clock(clock), .column(column), .lines(lines), .A(segA),
	.B(segB), .C(segC), .D(segD), .E(segE), .F(segF), .G(segG), .seven_seg_digit(seven_seg_digit), .seven_seg_digit_of(seven_seg_digit_of), .Error(E));
	
endmodule 