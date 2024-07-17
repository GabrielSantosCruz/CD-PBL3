module mux_4x1( //
    input [6:0] Entrada1, Entrada2, Entrada3, Entrada4, // Entradas de 7 bits
    input [1:0] Selecao,                                // Entrada de seleção de 2 bits
    output [6:0] Saida                                  // Saída de 7 bits
);
    wire [6:0] Sel_Entrada1, Sel_Entrada2, Sel_Entrada3, Sel_Entrada4; // Fios para armazenar as saídas parciais das entradas selecionadas
    wire Sel0_invertido, Sel1_invertido;                               // Fios para armazenar os bits invertidos da seleção

    // Inversão dos bits de seleção
    not (Sel0_invertido, Selecao[0]);               // Inverte o bit Selecao[0]
    not (Sel1_invertido, Selecao[1]);               // Inverte o bit Selecao[1]

    // Seleção para cada bit das entradas
    assign Sel_Entrada1 = {7{(Selecao == 2'b00)}} & Entrada1; // Seleciona Entrada1 se Selecao for 00
    assign Sel_Entrada2 = {7{(Selecao == 2'b01)}} & Entrada2; // Seleciona Entrada2 se Selecao for 01
    assign Sel_Entrada3 = {7{(Selecao == 2'b10)}} & Entrada3; // Seleciona Entrada3 se Selecao for 10
    assign Sel_Entrada4 = {7{(Selecao == 2'b11)}} & Entrada4; // Seleciona Entrada4 se Selecao for 11

    // Combinação final das saídas
    assign Saida = Sel_Entrada1 | Sel_Entrada2 | Sel_Entrada3 | Sel_Entrada4; // Combina as saídas selecionadas usando OR

endmodule
