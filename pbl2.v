module pbl2
	// Entradas e Saídas do Módulo
	(H, M, L, Bs, Vs, clock, one_second_clock,
	led_matriz_clock, bcd, column, lines, A, B,
	C, D, E, F, G, bcd_10s, bcd_1m, bcd_10m,
	seven_seg_digit, Error);
	
	// Declarando as Entradas e Saídas:
	input H, M, L, Bs, Vs, clock, Error;
	output one_second_clock, led_matriz_clock;
	output A, B, C, D, E, F, G;
	output [3:0] seven_seg_digit;
	output [4:0] column;
	output [6:0] lines;
	output [3:0] bcd, bcd_10s, bcd_1m, bcd_10m;
	
	// Divisor de Clock, de 50MHz para 1Hz e 1560Hz -> Serão usados nos displays de 7-Segmentos e LEDs, respectivamente.
	from_50mhz_to_1hz d0(.clock(clock), .led_matriz_clock(led_matriz_clock), .one_second_clock(one_second_clock));
	
	// Varrendo a matriz de LEDs - 1560Hz
	led_column_alternator alt0(.clock(led_matriz_clock), .column(column));
	
	assign lines[3] = 1; // Vai apagar a linha 3, pois ela não foi usada.
	
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
	
	// Contadores BCD
	// bcd = contador de 1 segundo
	// bcd_10s = contador de 10 segundos
	// bcd_1m = contador de 1 minuto
	// bcd_10m = contador de 10 minutos
	// Cada contador depende de um ativador associado ao contador anterior.
	counter_9to0 bcd0(.clock(one_second_clock), .bcd(bcd), .Bs(Bs), .Vs(Vs), .Error(Error)); // Passando Bs, Vs e Error para Desativar o Contador
	
	
	// Varrendo os Dígitos do Mostrador de 7-Segmentos - 1560Hz
	seven_seg_digit_alt alt1(.clock(led_matriz_clock), .digit(seven_seg_digit));
	
	// Codificando o BCD em 7-Segmentos
	// Fios que serão usandos no multiplexador de 7-segmentos:
	wire A_1s, B_1s, C_1s, D_1s, E_1s, F_1s, G_1s;
	wire A_10s, B_10s, C_10s, D_10s, E_10s, F_10s, G_10s;
	wire A_1m, B_1m, C_1m, D_1m, E_1m, F_1m, G_1m;
	wire A_10m, B_10m, C_10m, D_10m, E_10m, F_10m, G_10m;
	// Instanciandos os encoders de BCD para 7-segmentos:
	//encoder_bcd_7seg_until_9 enc0(.bcd(bcd), .A(A_1s), .B(B_1s), .C(C_1s), .D(D_1s), .E(E_1s), .F(F_1s), .G(G_1s)); // Em conjunto com o dígito 0;
	decoder_7seg((.bcd(bcd), .A(A_1s), .B(B_1s), .C(C_1s), .D(D_1s), .E(E_1s), .F(F_1s), .G(G_1s)); // Em conjunto com o dígito 0;)
	// Exibindo os números de acordo com o dígito ativo
	// Fios para melhorar a organização das expressões

	wire wd0, wd1, wd2, wd3;
	assign wd0 = seven_seg_digit[0];
	assign wd1 = seven_seg_digit[1];
	assign wd2 = seven_seg_digit[2];
	assign wd3 = seven_seg_digit[3];
	// Multiplexadores das letras, de acordo com os dígitos
	assign A = (!wd0 & A_1s) || (!wd1 & A_10s) || (!wd2 & A_1m) || (!wd3 & A_10m);
	assign B = (!wd0 & B_1s) || (!wd1 & B_10s) || (!wd2 & B_1m) || (!wd3 & B_10m);
	assign C = (!wd0 & C_1s) || (!wd1 & C_10s) || (!wd2 & C_1m) || (!wd3 & C_10m);
	assign D = (!wd0 & D_1s) || (!wd1 & D_10s) || (!wd2 & D_1m) || (!wd3 & D_10m);
	assign E = (!wd0 & E_1s) || (!wd1 & E_10s) || (!wd2 & E_1m) || (!wd3 & E_10m);
	assign F = (!wd0 & F_1s) || (!wd1 & F_10s) || (!wd2 & F_1m) || (!wd3 & F_10m);
	assign G = (!wd0 & G_1s) || (!wd1 & G_10s) || (!wd2 & G_1m) || (!wd3 & G_10m);
	
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