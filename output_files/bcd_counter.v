module bcd_counter(
    input wire clk,         // Clock de entrada
    input wire rst,         // Reset
    input wire [3:0] dado,  // Dado de entrada para carga inicial
    output wire [3:0] bcd_out,  // Saída em BCD de 4 bits
    output reg carry_out     // Sinal de carry
);

    reg [3:0] contagem;
    reg carregar = 1'b1;
	  

    always @(posedge clk or posedge rst) begin
			
        if (rst) begin
            contagem <= 4'b1001;  // Inicializa com 9 (1001 em BCD) ao resetar
            carregar <= 1'b1;     // Sinal de carga ativado ao resetar
            carry_out <= 1'b0;    // Carry inicialmente desativado ao resetar
        end else begin
            if (carregar) begin
                contagem <= dado;  // Carrega dado externo quando carregar é ativado
                carregar <= 1'b0 ;  // Desativa sinal de carga após carregar
            end else begin
                if (contagem == 4'b0000) begin
                    carry_out <= 1'b1;      // Emite carry quando o contador chega a 0
                    contagem <= 4'b1001;    // Reinicia para 9 (1001 em BCD)
                end else begin
                    carry_out <= 1'b0;      // Desativa carry quando não é necessário
                    contagem <= contagem - 1;  // Contagem decrescente normal
                end
            end
        end
    end

    assign bcd_out = contagem;  // Atribui o valor do contador BCD à saída bcd_out

endmodule
