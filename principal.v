module principal (
  input H, M, L, Ua, Us, T, Ag, Clock,
  output Ve, Bs, Bs_Ag, Vs, Al, E, S_Enchendo, S_Cheio, S_Aspersao, S_Agro, S_Gotejamento, S_Limpeza, S_SaidaLimpeza, S_Erro
);

  // FIOS INTERMEDIÁRIOS PARA RECEBER AS SAÍDAS DO MÓDULO "COMBINACIONAL":
  wire Ve_int, Bs_Ag_int, Bs_int, Vs_int, Al_int, E_int;

  // INSTÂNCIA DO MÓDULO "COMBINACIONAL":
  combinacional circuito_combinacional (
    .H(H), 
    .M(M), 
    .L(L), 
    .Ua(Ua), 
    .Us(Us), 
    .T(T), 
    .Ag(Ag),
    .Ve(Ve_int), 
    .Bs(Bs_int),
    .Bs_Ag(Bs_Ag_int),
    .Vs(Vs_int), 
    .Al(Al_int), 
    .E(E_int)
  );

  // VARIÁVEIS DO MÓDULO RECEBENDO OS VALORES DE SAÍDA DO MÓDULO "COMBINACIONAL":
  assign Ve = Ve_int, Bs = Bs_int, Bs_Ag = Bs_Ag_int, Vs = Vs_int, Al = Al_int, E = E_int;

  // INSTÂNCIA DO MÓDULO "MAQUINA":
  maquina maquina_de_estados (
    .Clock(Clock), 
    .Reset(), 
    .H(H),
    .M(M),
    .L(L),
    .Ve(Ve), 
    .Bs(Bs),
    .Bs_Ag(Bs_Ag),
    .Vs(Vs), 
    .E(E),     
    .S_Enchendo(S_Enchendo), 
    .S_Cheio(S_Cheio), 
    .S_Aspersao(S_Aspersao), 
    .S_Agro(S_Agro), 
    .S_Gotejamento(S_Gotejamento), 
    .S_Limpeza(S_Limpeza), 
    .S_SaidaLimpeza(S_SaidaLimpeza), 
    .S_Erro(S_Erro)
  );

endmodule