module flipflop_D(D, clock, Q);
	input D, clock;
	output reg Q;
	
	// Em todas as subidas de clock, "Q" recebe o valor de "D";
	always @(posedge clock) begin
		Q <= D;
	end
endmodule