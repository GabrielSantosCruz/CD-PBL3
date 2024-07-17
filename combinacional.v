// MÓDULO DO CIRCUITO COMBINACIONAL:
module combinacional (
  input H, M, L, Ua, Us, T, 
  output Ve, Bs, Vs, Al, E;
);

  // FIOS INTERMEDIÁRIOS:
  wire W0, W1, W2, W3, W4, W5, W4, W6, W7, W8, W9, W10, W11, W12, W13;
	
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
	and and0 (W4, W5, Ua);
	or or1 (W6, W4, W4);
	not not0 (W7, Al);
	and and1 (Vs, W6, W7);

  // ALARME:
	nand nand1 (W0, M, L);
	and and1 (W2, W0, H);
	nor nor5 (W1, H, L);
	or or2 (Al, W1, W2);

  // ERRO:
  not not1 (W10, L);
  and and2 (W11, W10, M);
  not not2 (W12, M);
  and and3 (W13, W12, H);
  or or3 (E, W11, W13);

endmodule