module mux_4x1bit(
    input [1:0] Selecao,
    output [3:0] Saida
);

    // Seleção da saída com base em Selecao
    assign Saida = (Selecao == 2'b00) ? 4'b0001 :
                   (Selecao == 2'b01) ? 4'b0010 :
                   (Selecao == 2'b10) ? 4'b0100 :
                   (Selecao == 2'b11) ? 4'b1000 :
                   4'b0000; // Caso padrão, embora isso nunca deva ser alcançado.

endmodule
