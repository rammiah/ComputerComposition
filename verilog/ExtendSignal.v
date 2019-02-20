`timescale 1ns / 1ps

module ExtendSignal(op, func, SHM_SRC, BGTZ, SH);
    input wire [5:0] op, func;
    output reg SHM_SRC, BGTZ, SH;
    
    initial
    begin
        SHM_SRC <= 0;
        BGTZ <= 0;
        SH <= 0;
    end
    wire OP0, OP1, OP2, OP3, OP4, OP5;
    wire F5, F4, F3, F2, F1, F0;
    assign {F5, F4, F3, F2, F1, F0} = func;
    assign {OP5, OP4, OP3, OP2, OP1, OP0} = op;
    
    always @(op, func)
    begin
        SHM_SRC <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&F0;
        BGTZ <= ~OP5&~OP4&~OP3&OP2&OP1&OP0;
        SH <= OP5&~OP4&OP3&~OP2&~OP1&OP0;
    end
    
endmodule
