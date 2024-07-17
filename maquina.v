module maquina (
  input Clock, Reset, H, M, L, Ve, Bs, Bs_Ag, Vs, E,
  output reg S_Enchendo, S_Cheio, S_Aspersao, S_Agro, S_Gotejamento, S_Limpeza, S_SaidaLimpeza, S_Erro
);

  // DECLARAÇÃO DOS ESTADOS:
  reg [3:0] Estado;
  parameter E_Enchendo = 0, E_Cheio = 1, E_Aspersao = 2, E_Gotejamento = 3, E_Limpando = 4, E_Erro = 5;

  always @ (posedge Clock or posedge Reset) begin
    if (Reset) begin 
      Estado <= E_Enchendo;
    end 
    else begin
      case (Estado) 
		
        // ESTADO "ENCHENDO":
        E_Enchendo: begin
          if (Ve) begin
            Estado <= E_Enchendo;
          end 
          else if (E) begin
            Estado <= E_Erro;
          end
          else if (L) begin 
            Estado <= E_Limpando;
          end
        end 
		
        // ESTADO "CHEIO":
        E_Cheio: begin
          if (Bs) begin
            Estado <= E_Aspersao;
          end
          else if (Vs) begin
            Estado <= E_Gotejamento;
          end
          else begin
            Estado <= E_Cheio;
          end
        end 
		  
        // ESTADO "ASPERSÃO":
        E_Aspersao: begin
          if (E) begin
            Estado <= E_Erro;
          end
          else if (L) begin 
            Estado <= E_Limpando;
          end
          else begin
            Estado <= E_Aspersao;
          end	
        end 
			
        // ESTADO "GOTEJAMENTO":
        E_Gotejamento: begin
          if (E) begin
            Estado <= E_Erro;
          end
          else if (L) begin
            Estado <= E_Limpando;
          end
          else begin
            Estado <= E_Gotejamento;
          end
        end
			
        // ESTADO "LIMPANDO":
        E_Limpando: begin
          if (Ve) begin
            Estado <= E_Enchendo;
          end
          else begin
            Estado <= E_Limpando;
          end
        end // Aqui estava faltando um "end"
			
        // ESTADO "ERRO":
        E_Erro: begin 
          if (!E) begin
            Estado <= E_Enchendo;
          end
          else begin
            Estado <= E_Erro;
          end
        end 
			
        // ESTADO PADRÃO:
        default: begin 
          Estado <= E_Enchendo;
        end 
      endcase 
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
      E_Enchendo: begin
        if (Ve) begin
          S_Enchendo = 1'b1;
        end
      end

      E_Cheio: begin
        if (H) begin
          S_Cheio = 1'b1;
        end
      end
      
      E_Aspersao: begin
        if (Bs) begin
          S_Aspersao = 1'b1;
        end
        else if (Bs_Ag) begin
          S_Aspersao = 1'b1;
          S_Agro = 1'b1;
        end
      end
      
      E_Gotejamento: begin
        if (Vs) begin
          S_Gotejamento = 1'b1;
        end
      end
      
      E_Limpando: begin
        if (L) begin
          S_Limpeza = 1'b1;
          S_SaidaLimpeza = 1'b1;
        end
      end
      
      E_Erro: begin
        if (E) begin
          S_Erro = 1'b1;
        end
      end
    endcase
  end
endmodule
