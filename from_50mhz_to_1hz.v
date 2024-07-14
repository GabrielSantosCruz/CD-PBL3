module from_50mhz_to_1hz (clock, one_second_clock, led_matriz_clock);
	input clock;
	output one_second_clock, led_matriz_clock;
	
	// Fios para cascateamento de divisores de clock:
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9,
	w10, w11, w12, w13, w14, w15, w16, w17, w18,
	w19, w20, w21, w22, w23;
	
	// Instancias para dividir 25 vezes o clock de 50MHz
	clock_divisor d0(.clock(clock), .divided_clock(w0));
	clock_divisor d1(.clock(w0), .divided_clock(w1)); // 0.078 us
	clock_divisor d2(.clock(w1), .divided_clock(w2)); // 0.156 us
	clock_divisor d3(.clock(w2), .divided_clock(w3)); // 0.312 us
	clock_divisor d4(.clock(w3), .divided_clock(w4)); // 0.625 us
	clock_divisor d5(.clock(w4), .divided_clock(w5)); // 1.25 us
	clock_divisor d6(.clock(w5), .divided_clock(w6)); // 2.5 us
	clock_divisor d7(.clock(w6), .divided_clock(w7)); // 5 us
	clock_divisor d8(.clock(w7), .divided_clock(w8)); // 10 us
	clock_divisor d9(.clock(w8), .divided_clock(w9)); // 20 us
	clock_divisor d10(.clock(w9), .divided_clock(w10)); // 40us
	clock_divisor d11(.clock(w10), .divided_clock(w11)); // 80us
	clock_divisor d12(.clock(w11), .divided_clock(w12)); // 160us
	clock_divisor d13(.clock(w12), .divided_clock(w13)); // 320 us
	clock_divisor d14(.clock(w13), .divided_clock(led_matriz_clock)); // 640 us // 1560Hz
	clock_divisor d15(.clock(led_matriz_clock), .divided_clock(w14)); // 1.280 us
	clock_divisor d16(.clock(w14), .divided_clock(w15)); // 2.560 us
	clock_divisor d17(.clock(w15), .divided_clock(w16)); // 5.120 us
	clock_divisor d18(.clock(w16), .divided_clock(w17)); // 10.240 us
	clock_divisor d19(.clock(w17), .divided_clock(w18)); // 20.480 us
	clock_divisor d20(.clock(w18), .divided_clock(w19)); // 40.960 us
	clock_divisor d21(.clock(w19), .divided_clock(w20)); // 81.920 us
	clock_divisor d22(.clock(w20), .divided_clock(w21)); // 163.840 us
	clock_divisor d23(.clock(w21), .divided_clock(w22)); // 327.680 us
	clock_divisor d24(.clock(w22), .divided_clock(w23)); // 655.360 us
	clock_divisor d25(.clock(w23), .divided_clock(one_second_clock)); // 1.310.720 us -> 1.3 segundos
endmodule