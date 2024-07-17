// Módulo da Máquina de Estados:
module mef (L, M, H, Bs, Vs, Ve, E, Clk, Rst, Enchendo, Cheio, Gotejamento, Aspersao, Limpando, Erro);

	// Entradas e Saídas:
	input L, M, H, Bs, Vs, Ve, E, Clk, Rst;
	output reg Enchendo, Cheio, Gotejamento, Aspersao, Limpando, Erro;
	
	// Declaração dos Estados:
	reg [2:0] Estado;
	parameter E_Enchendo = 3'b000, E_Cheio = 3'b001, E_Gotejamento = 3'b010, E_Aspersao = 3'b011, E_Limpando = 3'b100, E_Erro = 3'b101;
	
	always @ (posedge Clk or posedge Rst) begin
		if (Rst)
			Estado <= E_Enchendo;
		else
			case (Estado)
				// Estado de Enchendo:
				E_Enchendo:
					if (H) // in_enchendo contador 0001 0000 
						Estado <= E_Cheio;
					else
						Estado <= E_Enchendo;
				
				// Estado de Cheio:
				E_Cheio:
					if (E)
						Estado <= E_Erro;
					else if (Bs)
						Estado <= E_Aspersao;
					else if (Vs)
						Estado <= E_Gotejamento;
					else if (L)
						Estado <= E_Limpando;
					else
						Estado <= E_Cheio;
				
				// Estado de Aspersão:
				E_Aspersao:
					if (E)
						Estado <= E_Erro;
					else if (L)
						Estado <= E_Limpando;
					else if (Bs)
						Estado <= E_Aspersao;
				
				// Estado de Gotejamento:
				E_Gotejamento:
					if (E)
						Estado <= E_Erro;
					else if (L)
						Estado <= E_Limpando;
					else if (Vs)
						Estado <= E_Gotejamento;
				
				// Estado de Limpeza:
				E_Limpando: // Verificar as condiçoes pra confirmar isso aqui
					if (Ve)
						Estado <= E_Enchendo;
					else
						Estado <= E_Limpando;
				
				// Estado de Erro:
				E_Erro:
					if (!E)
						Estado <= E_Enchendo;
					else
						Estado <= E_Erro;
				
				// Estado Inicial:
				default:
					Estado <= E_Enchendo;
			endcase
	end
	
	// Saídas da Máquina de Estados:
	always @ (posedge Clk) begin
		case (Estado)
			E_Enchendo:
				begin
					Enchendo <= 1'b1;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Erro <= 1'b0;
					// contadores
				end
				
			E_Cheio:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b1;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Erro <= 1'b0;
				end
				
			E_Aspersao:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b1;
					Limpando <= 1'b0;
					Erro <= 1'b0;
				end
				
			E_Gotejamento:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b1;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Erro <= 1'b0;
				end
				
			E_Limpando:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b1;
					Erro  <= 1'b0;
				end
				
			E_Erro:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Erro  <= 1'b1;
				end
				
			default:
				begin
					Enchendo <= 1'b1;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Erro  <= 1'b0;
				end
		endcase
	end
	
endmodule