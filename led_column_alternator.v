module led_column_alternator(clock, column);
	input clock;
	output reg [4:0] column;
	
	// Valor inicial da coluna
	initial begin
		column = 5'b00001; // Coluna 5 - MSB; Coluna 0 - LSB;
	end
	
	always @(posedge clock) begin
		column <= {column[3:0], column[4]}; // Desloca o bit mais significativo para o final, tornando ele o menos significativo.
	end
endmodule