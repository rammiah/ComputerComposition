`timescale 1ns / 1ps

module ALU(X, Y, shamt, AluOp, Result, Result2, Equal);
    input wire [31:0] X, Y;
    input wire [3:0] AluOp;
    input wire [4:0] shamt;
    output reg [31:0] Result, Result2;
    output wire Equal;
    assign Equal = (X == Y);
    
    always @(X, Y, shamt, AluOp)
    begin
        case (AluOp)
        0: Result <= Y << shamt;
        1: Result <= $signed(Y) >>> shamt;
        2: Result <= Y >> shamt;
        3: {Result2, Result} <= X * Y;
        4: Result <= X / Y;
        5: Result <= X + Y;
        6: Result <= X - Y;
        7: Result <= X & Y;
        8: Result <= X | Y;
        9: Result <= X ^ Y;
        10: Result <= ~(X | Y);
        11: Result <= $signed(X) < $signed(Y); 
        12: Result <= $unsigned(X) < $unsigned(Y);
        default: Result <= 0;
        endcase
    end
    
    always @(X, Y, shamt, AluOp)
    begin
        case (AluOp)
        4: Result2 <= X % Y; 
        default: Result2 <= 0;
        endcase    
    end


endmodule
