`timescale 1ns / 1ps

module ALU_tb();
    reg [4:0] op;
    wire [31:0] r1, r2;
    wire eq;
    ALU alu(.X(21), .Y(-4), .shamt(2), .AluOp(op), .Result(r1), .Result2(r2), .Equal(eq));
    
    initial
    begin
        op = 0;
        for (op = 0; op <= 12; op = op + 1)
        begin
            #10;
        end
    end
    
    
endmodule
