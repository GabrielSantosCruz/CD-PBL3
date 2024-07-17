<<<<<<< Updated upstream
// Declaração do Módulo
module pbl1(H, M, L, Bs, Vs, Ve, Us, Ua, T, Al, E, clock, column, lines, segA, segB, segC, segD, segE, segF, segG, seven_seg_digit);
	// Declaração das Portas
	input H, M, L, T, Us, Ua, clock;
	output Bs, Vs, Ve, Al, E, segA, segB, segC, segD, segE, segF, segG;
	output [3:0] seven_seg_digit;
	output [4:0] column;
	output [6:0] lines;
	
	// Declaração dos Fios
	wire w0, w1, notL, notM, w4, w5, w6, w7, lowUs, lowUa, w10, w11, lowTemp, w13, w14, w15, w16, w17, notErro, notH, w20, notAlarme;
	
	// Circuito de Erro de Medição
	not Not0 (notL, L);
	not Not1 (notM, M);
	and And0 (w0, M, notL);
	and And1 (w1, H, notM);
	or Or0 (E, w0, w1);
	not Not2 (notErro, E); // Inversor do Erro para Fechar os Acionamentos
	
	// Circuito de Acionamento da Válvula de Entrada
	not Not3 (notH, H);
	and And2 (w4, notH, notM, notL, notErro);
	and And3 (w5, notH, L, notErro);
	or Or1 (Ve, w4, w5);
	
	// Circuito de Acionamento do Alarme
	and And4 (w6, notH, notM, L); // Nível mínimo
	and And5 (w7, notH, notM, notL); // Nível crítico
	or Or2 (Al, w6, w7, E); // Nível mínimo, crítico ou erro de medição
	
	// Circuito de Acionamento do Sistema de Aspersão
	not Not4 (lowUs, Us);
	not Not5 (lowUa, Ua);
	and And7 (w10, lowUs, lowUa);
	and And8 (w11, lowUs, Ua, T, M);
	or Or4 (w16, w10, w11);
	and And9 (Bs, w16, notErro); // Fechar o Acionamento em Caso de Erro
	
	// Circuito de Acionamento do Sistema de Gotejamento
	not Not6 (lowTemp, T);
	and And10 (w13, lowUs, Ua, lowTemp);
	and And11 (w14, lowUs, Ua, T, notM, L);
	or Or5 (w17, w13, w14);
	and And12 (Vs, w17, notErro); // Fechar o Acionamento em Caso de Erro
		
	// Instancionando o Módulo que Implementa o PBL 2 e sua Melhorias:
	pbl2 part2(.H(H), .M(M), .L(L), .Bs(Bs), .Vs(Vs), .clock(clock), .column(column), .lines(lines), .A(segA),
	.B(segB), .C(segC), .D(segD), .E(segE), .F(segF), .G(segG), .seven_seg_digit(seven_seg_digit), .Error(E));
	
endmodule 
=======
module pbl1 (
	input H, M, L, T, Us, Ua, clock,
	output Bs, Vs, Ve, Al, E, segA, segB, segC, segD, segE, segF, segG,
	output [3:0] seven_seg_digit,
	output [4:0] column,
	output [6:0] lines
);

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
  
  // Instancionando o Módulo que Implementa o PBL 2 e sua Melhorias:
	pbl2 part2(.H(H), .M(M), .L(L), .Bs(Bs), .Vs(Vs), .clock(clock), .column(column), .lines(lines), .A(segA),
	.B(segB), .C(segC), .D(segD), .E(segE), .F(segF), .G(segG), .seven_seg_digit(seven_seg_digit), .Error(E));

endmodule
>>>>>>> Stashed changes
