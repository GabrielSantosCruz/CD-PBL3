module pbl1 (
	input H, M, L, T, Us, Ua, clock,
	output Bs, Vs, Ve, Al, E, segA, segB, segC, segD, segE, segF, segG,
	output [3:0] seven_seg_digit,
	output [4:0] column,
	output [6:0] lines
);

  // FIOS INTERMEDIÁRIOS:
  wire W0, W1, W2, W3, W4, W5, W4b, W6, W7, W8, W9, W10, W11, W12, W13;

  // VÁLVULA DE ENTRADA:
  nor nor0 (W8, Al, H);
  nor nor1 (W9, H, M, L);
  or or0 (Ve, W8, W9);

  //ASPERSÃO:
  nor nor2 (Bs, Us, Vs, Al);

  // GOTEJAMENTO:
  nand nand0 (W3, Ua, T);
  nor nor3 (W4, W3, Us);
  nor nor4 (W5, Us, T, M);
  and and0 (W4b, W5, Ua);
  or or1 (W6, W4, W4b);
  not not0 (W7, Al);
  and and1 (Vs, W6, W7);

  // ALARME:
  nand nand1 (W0, M, L);
  and and2 (W2, W0, H);
  nor nor5 (W1, H, L);
  or or2 (Al, W1, W2, E);

  // ERRO:
  not not1 (W10, L);
  and and3 (W11, W10, M);
  not not2 (W12, M);
  and and4 (W13, W12, H);
  or or3 (E, W11, W13);
  
  // Instancionando o Módulo que Implementa o PBL 2 e sua Melhorias:
	pbl2 part2(.H(H), .M(M), .L(L), .Bs(Bs), .Vs(Vs), .clock(clock), .column(column), .lines(lines), .A(segA),
	.B(segB), .C(segC), .D(segD), .E(segE), .F(segF), .G(segG), .seven_seg_digit(seven_seg_digit), .Error(E));

endmodule