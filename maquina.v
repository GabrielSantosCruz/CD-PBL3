module maquina (
  input Clock, Reset, Ve, Bs, Vs, E, Ag,
  output S_Enchendo, S_Cheio, S_Aspersao, S_Agro, S_Gotejamento, S_Limpeza, S_SaidaLimpeza, S_Erro
);

  // DECLARAÇÃO DOS ESTADOS:
  reg [3:0] Estado;
  parameter E_Enchendo = 0, E_Cheio = 1, E_Aspersao = 2, E_Gotejamento = 3, E_Limpeza = 4, E_Erro = 5;

  always @ (posedge Clock or posedge Reset) begin
    if (Reset)
      Estado <= E_Enchendo;
    
    else
      case (Estado)
        
        // ESTADO "ENCHENDO":
        E_Enchendo:
          if (Ve)
            Estado <= E_Enchendo;
          else if (E)
            Estado <= E_Erro;
          else if (L)
            Estado <= E_Limpando;

        // ESTADO "CHEIO":
        E_Cheio:
          if (Bs)
            Estado <= E_Aspersao;
          else if (Vs)
            Estado <= E_Gotejamento;
          else
            Estado <= E_Cheio;
        
        // ESTADO "ASPERSÃO":
        E_Aspersao:
          if (E)
            Estado <= E_Erro;
          else if (L)
            Estado <= E_Limpando;
          else
            Estado <= E_Aspersao;
        
        // ESTADO "GOTEJAMENTO":
        E_Gotejamento:
          if (E)
            Estado <= E_Erro;
          else if (L)
            Estado <= E_Limpando;
          else
            Estado <= E_Gotejamento;

        // ESTADO "LIMPANDO":
        E_Limpando:
          if (Ve)
            Estado <= E_Enchendo;
          else
            Estado <= E_Limpando;
        
        // ESTADO "ERRO":
        E_Erro:
          if (!E)
            Estado <= E_Enchendo;
          else
            Estado <= E_Erro;
        
        // ESTADO PADRÃO:
        default:
          Estado <= E_Enchendo;
      
      encase
  
  end

  // SAÍDAS DA MÁQUINA DE ESTADOS:
  always @ (posedge Clock) begin
    S_Enchendo = 1'b0; 
    S_Cheio = 1'b0;
    S_Aspersao = 1'b0;
    S_Gotejamento = 1'b0; 
    S_Limpeza = 1'b0; 
    S_Erro = 1'b0;

    case (Estado)
      E_Enchendo:
        if (Ve)
          begin
            S_Enchendo = 1'b1;
          end

      E_Cheio:
        if (H)
          begin
            S_Cheio = 1'b1;
          end
      
      E_Aspersao:
        if (Bs)
          begin
            S_Aspersao = 1'b1;
          end
        
        else if (Ag)
          begin
            S_Aspersao = 1'b1;
            S_Agro = 1'b1;
          end
      
      E_Gotejamento:
        if (Vs)
          begin
            S_Gotejamento = 1'b1;
          end
      
      E_Limpando:
        if (L)
          begin
            S_Limpeza = 1'b1;
            S_SaidaLimpeza = 1'b1;
          end
      
      E_Erro:
        if (E)
          begin
            S_Erro = 1'b1;
          end
      
    endcase

  end

endmodule