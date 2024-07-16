module pbl2(
	input H, M, L, Bs, Vs, clock, Error,
	output one_second_clock, clock_mostradores,
	output A, B, C, D, E, F, G,
	output [3:0] seven_seg_digit,
	output [4:0] column,
	output [6:0] lines,
	output [3:0] bcd, bcd_10s, bcd_1m, bcd_10m
);
		
	// Divisor de Clock, de 50MHz para 1Hz e 1560Hz -> Serão usados nos displays de 7-Segmentos e LEDs, respectivamente.
	from_50mhz_to_1hz d0(.clock(clock), .clock_mostradores(clock_mostradores), .one_second_clock(one_second_clock));
			
	// Exibindo os números de acordo com o dígito ativo
	// Fios para melhorar a organização das expressões
	wire wd0, wd1;
	assign wd0 = seven_seg_digit[0];
	assign wd1 = seven_seg_digit[1];
	assign seven_seg_digit[2] = 1;
	assign seven_seg_digit[3] = 1;
	
	// Multiplexadores das letras, de acordo com os dígitos
	assign A = (!wd0 & A_1s) || (!wd1 & A_10s);
	assign B = (!wd0 & B_1s) || (!wd1 & B_10s);
	assign C = (!wd0 & C_1s) || (!wd1 & C_10s);
	assign D = (!wd0 & D_1s) || (!wd1 & D_10s);
	assign E = (!wd0 & E_1s) || (!wd1 & E_10s);
	assign F = (!wd0 & F_1s) || (!wd1 & F_10s);
	assign G = (!wd0 & G_1s) || (!wd1 & G_10s);		

	// Fios que serão usandos no multiplexador de 7-segmentos:
	wire A_1s, B_1s, C_1s, D_1s, E_1s, F_1s, G_1s;
	wire A_10s, B_10s, C_10s, D_10s, E_10s, F_10s, G_10s;
	wire A_1m, B_1m, C_1m, D_1m, E_1m, F_1m, G_1m;
	wire A_10m, B_10m, C_10m, D_10m, E_10m, F_10m, G_10m;
	
	// Cada contador depende de um ativador associado ao contador anterior.
	counter_9to0 bcd0(.clock(one_second_clock), .bcd(bcd), .Bs(Bs), .Vs(Vs), .Error(Error)); // Passando Bs, Vs e Error para Desativar o Contador
	counter_3to0 bcd1(.Bbcd(bcd), .bcd(bcd_10s));
	// Varrendo os Dígitos do Mostrador de 7-Segmentos - 1560Hz
	seven_seg_digit_alt alt1(.clock(led_matriz_clock), .digit(seven_seg_digit));
	
	// Instanciandos os encoders de BCD para 7-segmentos:
	decoder_7seg(.bcd(bcd), .A(A_1s), .B(B_1s), .C(C_1s), .D(D_1s), .E(E_1s), .F(F_1s), .G(G_1s));
	
	
	//-------------------------------------------------------------------------------------------------------------------------------------------
	// MATRIZ DE LEDS
	assign lines[3] = 1; // Vai apagar a linha 3, pois ela não foi usada.
	
	// Varrendo a matriz de LEDs - 1560Hz
	led_column_alternator alt0(.clock(clock_mostradores), .column(column));
	
	// Níveis do tanque na matriz de LEDs:
	assign lines[0] = !(L);
	assign lines[1] = !(M);
	assign lines[2] = !(H);
	
	// INÍCIO - BLOCO DOS SISTEMAS DE ASPERSÃO E GOTEJAMENTO NA MATRIZ DE 7-SEG: -------------------------------------------------
	// Acende partes da letra "A" na linha "6" -> Se a aspersão (Bs) e uma das colunas, de 3 a 0, estiverem ligadas.
	// Acende partes da letra "g" na linha "6" -> Se o gotejamento (Vs) e qualquer uma das colunas estiverem ligados.
	assign lines[6] = !((Bs && (column[3] || column[2] || column[1] || column[0])) || Vs);
	
	// Acende partes da letra "A" na linha "5" -> Se a aspersão (Bs) e uma das colunas, 4 ou 2, estiverem ligadas.
	// Acende partes da letra "g" na linha "5" -> Se o gotejamento (Vs) e uma das colunas, 4 ou 2 ou 0, estiverem ligadas.
	assign lines[5] = !((Bs && (column[4] || column[2])) || (Vs && (column[4] || column[2] || column[0])));
	
	// Acende partes da letra "A" na linha "4" -> Se a aspersão (Bs) e uma das colunas, de 3 a 0, estiverem ligadas.
	// Acende partes da letra "g" na linha "4" -> Se o gotejamento (Vs) e uma das colunas, 4 ou 3 ou 2 ou 0, estiverem ligadas.
	assign lines[4] = !((Bs && (column[3] || column[2] || column[1] || column[0])) || (Vs && (column[4] || column[3] || column[2] || column[0])));
	// FIM  - BLOCO DOS SISTEMAS DE ASPERSÃO E GOTEJAMENTO NA MATRIZ DE 7-SEG ----------------------------------------------------
	

	
	
	// Sistemas de redução de nível do tanque:
	// Com Bs (Aspersão) ativo: reduz um nível a cada 5 minutos
	// Com Vs (Gotejamento) ativo: reduz um nível a cada 10 minutos
	wire twenty_five_minutes, twenty_minutes, fifteen_minutes, ten_minutes, zero_minutes;
	assign twenty_five_minutes = (!bcd_10m[3] & !bcd_10m[2] & bcd_10m[1] & !bcd_10m[0]) & (!bcd_1m[3] & bcd_1m[2] & !bcd_1m[1] & bcd_1m[0]);
	assign twenty_minutes = (!bcd_10m[3] & !bcd_10m[2] & bcd_10m[1] & !bcd_10m[0]) & (!bcd_1m[3] & !bcd_1m[2] & !bcd_1m[1] & !bcd_1m[0]);
	assign fifteen_minutes = (!bcd_10m[3] & !bcd_10m[2] & !bcd_10m[1] & bcd_10m[0]) & (!bcd_1m[3] & bcd_1m[2] & !bcd_1m[1] & bcd_1m[0]);
	assign ten_minutes = (!bcd_10m[3] & !bcd_10m[2] & !bcd_10m[1] & bcd_10m[0]) & (!bcd_1m[3] & !bcd_1m[2] & !bcd_1m[1] & !bcd_1m[0]);
	assign zero_minutes = (!bcd[3:0]) & (!bcd_10s[3:0]) & (!bcd_1m[3:0]) & (!bcd_10m[3:0]);
endmodule