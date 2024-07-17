module maquina (
	input Clock, H, M, L, Ve, Bs, Vs, E, Li,
	output reg S_Enchendo, S_Cheio, S_Aspersao, S_Gotejamento, S_Limpando, S_Erro
);

	// DECLARAÇÃO DOS ESTADOS:
	reg [2:0] Estado, ProximoEstado;
	parameter E_Enchendo = 3'b000, E_Cheio = 3'b001, E_Aspersao = 3'b010, E_Gotejamento = 3'b011, E_Limpando = 3'b100, E_Erro = 3'b101;

	// OBS.: "E_" É PARA O ESTADO E "S_" É PARA SAÍDA

	always @ (posedge Clock) begin
		case (Estado)

			// TRANSIÇÕES DO ESTADO "ENCHENDO":
			E_Enchendo:
				if (H & !E)
					ProximoEstado <= E_Cheio;
				else if (E)
					ProximoEstado <= E_Erro;
				else
					ProximoEstado <= E_Enchendo;
			
			// TRANSIÇÕES DO ESTADO "CHEIO":
			E_Cheio:
				if (E)
					ProximoEstado <= E_Erro;
				else if (Bs & !E)
					ProximoEstado <= E_Aspersao;
				else if (Vs & !E)
					ProximoEstado <= E_Gotejamento;
				else
					ProximoEstado <= E_Cheio;      

			// TRANSIÇÕES DO ESTADO "ASPERSÃO":
			E_Aspersao:
				if (E)
					ProximoEstado <= E_Erro;
				else if (!Bs)
					ProximoEstado <= E_Limpando;
				else
					ProximoEstado <= E_Aspersao;

			// TRANSIÇÕES DO ESTADO "GOTEJAMENTO":
			E_Gotejamento:
				if (E)
					ProximoEstado <= E_Erro;
				else if (!Vs)
					ProximoEstado <= E_Limpando;
				else
					ProximoEstado <= E_Gotejamento;

			// TRANSIÇÕES DO ESTADO "LIMPANDO":
			E_Limpando:
				if (E)
					ProximoEstado <= E_Erro;
				else if (Li & !E & !H)
					ProximoEstado <= E_Enchendo;
				else
					ProximoEstado <= E_Limpando;

			// TRANSIÇÕES DO ESTADO "ERRO":
			E_Erro:
				if (!E & !H)
					ProximoEstado <= E_Enchendo;
				else
					ProximoEstado <= E_Erro;
		
		endcase

	end

	// SAÍDAS DA MÁQUINA DE ESTADOS:
	always @ (posedge Clock) begin
		S_Enchendo <= (Estado == E_Enchendo);
		S_Cheio <= (Estado == E_Cheio);
		S_Aspersao <= (Estado == E_Aspersao);
		S_Gotejamento <= (Estado == E_Gotejamento);
		S_Limpando <= (Estado == E_Limpando);
		S_Erro <= (Estado == E_Erro);
	end
	
	always @ (Estado) begin
		Estado = ProximoEstado;
	end

endmodule