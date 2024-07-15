// Módulo da Máquina de Estados:
module mef (L, M, H, Bs, Vs, Ve, Al, Clk, Rst, Enchendo, Cheio, Gotejamento, Aspersao, Limpando, Alarme);

	// Entradas e Saídas:
	input L, M, H, Bs, Vs, Ve, Al, Clk, Rst;
	output reg Enchendo, Cheio, Gotejamento, Aspersao, Limpando, Alarme;
	
	// Declaração dos Estados:
	reg [2:0] Estado;
	parameter E_Enchendo = 0, E_Cheio = 1, E_Gotejamento = 2, E_Aspersao = 3, E_Limpando = 4, E_Alarme = 5;
	
	always @ (posedge Clk or posedge Rst) begin
		if (Rst)
			Estado <= E_Enchendo;
		else
			case (Estado)
				// Estado de Enchendo:
				E_Enchendo:
					if (H)
						Estado <= E_Cheio;
					else if (Bs)
						Estado <= E_Aspersao;
					else if (Vs)
						Estado <= E_Gotejamento;
					else
						Estado <= E_Enchendo;
				
				// Estado de Cheio:
				E_Cheio:
					if (Al)
						Estado <= E_Alarme;
					else if (L)
						Estado <= E_Limpando;
					else
						Estado <= E_Cheio;
				
				// Estado de Aspersão:
				E_Aspersao:
					if (Al)
						Estado <= E_Alarme;
					else if (L)
						Estado <= E_Limpando;
					else
						Estado <= E_Aspersao;
				
				// Estado de Gotejamento:
				E_Gotejamento:
					if (Al)
						Estado <= E_Alarme;
					else if (L)
						Estado <= E_Limpando;
					else
						Estado <= E_Gotejamento;
				
				// Estado de Limpeza:
				E_Limpando:
					if (Ve)
						Estado <= E_Enchendo;
					else
						Estado <= E_Limpando;
				
				// Estado de Alarme:
				E_Alarme:
					if (!Al)
						Estado <= E_Enchendo;
					else
						Estado <= E_Alarme;
				
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
					Alarme <= 1'b0;
				end
				
			E_Cheio:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b1;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Alarme <= 1'b0;
				end
				
			E_Aspersao:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b1;
					Limpando <= 1'b0;
					Alarme <= 1'b0;
				end
				
			E_Gotejamento:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b1;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Alarme <= 1'b0;
				end
				
			E_Limpando:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b1;
					Alarme <= 1'b0;
				end
				
			E_Alarme:
				begin
					Enchendo <= 1'b0;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Alarme <= 1'b1;
				end
				
			default:
				begin
					Enchendo <= 1'b1;
					Cheio <= 1'b0;
					Gotejamento <= 1'b0;
					Aspersao <= 1'b0;
					Limpando <= 1'b0;
					Alarme <= 1'b0;
				end
		endcase
	end
	
endmodule