module seven_seg_digit_alt(clock, digit);
	input clock;
	output reg [1:0] digit;
	
	reg Q;
	
	// Valor inicial dos dígitos
//	initial begin
//		digit = 4'b1110; // Dígito 1 - MSB; Dígito 4 - LSB;
//	end
//	
//	always @(posedge clock) begin
//		digit <= {digit[2:0], digit[3]}; // Desloca o bit mais significativo para o final, tornando ele o menos significativo.
//	end
		always @(posedge clock) begin
			  Q = 0; // Atribuição direta para Q
			  digit[1] = Q;
			  digit[0] = !Q;
		 end
	
endmodule
