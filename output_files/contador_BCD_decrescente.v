module contador_BCD_decrescente( // tem que alterar os nomes da 
    input wire clk,        // Clock de entrada
    input wire rst,        // Reset
    input wire [3:0] data, // Dado de entrada para carga inicial
    output wire [3:0] bcd,  // Saída em BCD de 4 bits
    output reg carry       // Sinal de carry
);

    reg [3:0] count;
    reg load;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'b1001; // Inicializa com 9 (1001 em BCD) ao resetar
            load <= 1'b1;     // Sinal de carga ativado ao resetar
            carry <= 1'b0;    // Carry inicialmente desativado ao resetar
        end else begin
            if (load) begin
                count <= data; // Carrega dado externo quando load é ativado
                load <= 1'b0;  // Desativa sinal de carga após carregar
            end else begin
                if (count == 4'b0000) begin
                    carry <= 1'b1;  // Emite carry quando o contador chega a 0
                    count <= 4'b1001; // Reinicia para 9 (1001 em BCD)
                end else begin
                    carry <= 1'b0;  // Desativa carry quando não é necessário
                    count <= count - 1; // Contagem decrescente normal
                end
            end
        end
    end

    assign bcd = count; // Atribui o valor do contador BCD à saída bcd

endmodule