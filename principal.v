module principal (
  input H, M, L, Ua, Us, T, Ag, Clock, Reset
  output Ve, Bs, Vs, Al, E, S_Enchendo, S_Cheio, S_Aspersao, S_Agro, S_Gotejamento, S_Limpeza, S_SaidaLimpeza, S_Erro
);

  // FIOS INTERMEDIÁRIOS PARA RECEBER AS SAÍDAS DO MÓDULO "COMBINACIONAL":
  wire Ve_int, Bs_int, Vs_int, Al_int, E_int;

  // INSTÂNCIA DO MÓDULO "COMBINACIONAL":
  combinacional circuito_combinacional (
    .H(H), 
    .M(M), 
    .L(L), 
    .Ua(Ua), 
    .Us(Us), 
    .T(T), 
    .Ve(Ve_int), 
    .Bs(Bs_int), 
    .Vs(Vs_int), 
    .Al(Al_int), 
    .E(E_int)
  );

  // VARIÁVEIS DO MÓDULO RECEBENDO OS VALORES DE SAÍDA DO MÓDULO "COMBINACIONAL":
  assign Ve = Ve_int, Bs = Bs_int, Vs = Vs_int, Al = Al_int, E = E_int;

  // INSTÂNCIA DO MÓDULO "MAQUINA":
  maquina maquina_de_estados (
    .Clock(Clock), 
    .Reset(Reset), 
    .Ve(Ve), 
    .Bs(Bs), 
    .Vs(Vs), 
    .E(E), 
    .Ag(Ag), 
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