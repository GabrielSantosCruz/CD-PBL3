module maquina (
  input Clock, Reset, H, M, L, Ve, Bs, Bs_Ag, Vs, E,
  output S_Enchendo, S_Cheio, S_Aspersao, S_Agro, S_Gotejamento, S_Limpeza, S_SaidaLimpeza, S_Erro
);

  // DECLARAÇÃO DOS ESTADOS:
  reg [3:0] Estado;
  parameter E_Enchendo = 0, E_Cheio = 1, E_Aspersao = 2, E_Gotejamento = 3, E_Limpeza = 4, E_Erro = 5;

  always @ (posedge Clock or posedge Reset) begin
    if (Reset) begin
      Estado <= E_Enchendo;
    end

    else begin
      case (Estado)
        
        // TRANSIÇÕES DO ESTADO "ENCHENDO":
        E_Enchendo:
          if (Ve) begin
            Estado <= E_Enchendo;
          end

          else if (E) begin
            Estado <= E_Erro;
          end

          else if (L) begin
            Estado <= E_Limpando;
          end

        // TRANSIÇÕES DO ESTADO "CHEIO":
        E_Cheio:
          if (Bs) begin 
            Estado <= E_Aspersao;
          end

          else if (Vs) begin
            Estado <= E_Gotejamento;
          end

          else begin
            Estado <= E_Cheio;
          end          
        
        // TRANSIÇÕES DO ESTADO "ASPERSÃO":
        E_Aspersao:
          if (E) begin
            Estado <= E_Erro;
          end

          else if (L) begin
            Estado <= E_Limpando;
          end

          else begin
            Estado <= E_Aspersao;
          end

        // TRANSIÇÕES DO ESTADO "GOTEJAMENTO":
        E_Gotejamento:
          if (E) begin
            Estado <= E_Erro;
          end

          else if (L) begin
            Estado <= E_Limpando;
          end

          else begin
            Estado <= E_Gotejamento;
          end

        // TRANSIÇÕES DO ESTADO "LIMPANDO":
        E_Limpando:
          if (Ve) begin
            Estado <= E_Enchendo;
          end

          else begin
            Estado <= E_Limpando;
          end
        
        // TRANSIÇÕES DO ESTADO "ERRO":
        E_Erro:
          if (!E) begin
            Estado <= E_Enchendo;
          end

          else begin
            Estado <= E_Erro;
          end
        
        // DEFININDO O ESTADO PADRÃO:
        default:
          Estado <= E_Enchendo;
      
      encase
    
    end
  
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

      // SAÍDA DO ESTADO "ENCHENDO":      
      E_Enchendo:
        if (Ve) begin
          S_Enchendo = 1'b1;
        end

      // SAÍDA DO ESTADO "CHEIO":
      E_Cheio:
        if (H) begin
          S_Cheio = 1'b1;
        end
      
      // SAÍDA DO ESTADO "ASPERSÃO":
      E_Aspersao:
        if (Bs) begin
          S_Aspersao = 1'b1;
        end
        
        else if (Bs_Ag) begin
          S_Aspersao = 1'b1;
          S_Agro = 1'b1;
        end
      
      // SAÍDA DO ESTADO "GOTEJAMENTO":
      E_Gotejamento:
        if (Vs) begin
          S_Gotejamento = 1'b1;
        end
      
      // SAÍDA DO ESTADO "LIMPANDO":
      E_Limpando:
        if (L) begin
          S_Limpeza = 1'b1;
          S_SaidaLimpeza = 1'b1;
        end
      
      // // SAÍDA DO ESTADO "ERRO":
      E_Erro:
        if (E) begin
          S_Erro = 1'b1;
        end
      
    endcase

  end

endmodule