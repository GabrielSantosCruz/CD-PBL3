module seven_seg_digit_alt(clock, digit);
	input clock;
	output reg [3:0] digit;
	
	// Valor inicial dos dígitos
	initial begin
		digit = 4'b1110; // Dígito 1 - MSB; Dígito 4 - LSB;
	end
	
	always @(posedge clock) begin
		digit <= {digit[2:0], digit[3]}; // Desloca o bit mais significativo para o final, tornando ele o menos significativo.
	end
endmodule
