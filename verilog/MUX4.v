`timescale 1ns / 1ps

module MUX4(sel, D0, D1, D2, D3, Dout);
    parameter N = 32;
    input wire [1:0] sel;
    input wire [N - 1:0] D0, D1, D2, D3;
    output wire [N - 1:0] Dout;
    
    assign Dout = sel == 2'b00 ? D0 :
                  sel == 2'b01 ? D1 :
                  sel == 2'b10 ? D2 : D3;
endmodule
