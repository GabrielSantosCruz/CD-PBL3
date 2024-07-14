module clock_divisor (clock, J, K, divided_clock);
	input clock, J, K;
	output divided_clock;
	
	// Divisor de Clock com Flip-Flop JK
	reg w0, w1, w2, Q; // Seus registradores
	always @(posedge clock) begin
		w0 <= !(w2 & J);
		w1 <= !(K & Q);
		Q <= !(w0 & w2);
		w2 <= !(Q & w1);
	end
	
	assign divided_clock = Q; // Atribui na saída o clock dividido
endmodule