`timescale 1ns / 1ps

module AluController(OP, F, AluOp);
    input [5:0] OP, F;
    output reg [3:0] AluOp;
    wire OP5, OP4, OP3, OP2, OP1, OP0;
    wire F5, F4, F3, F2, F1, F0;
    assign {OP5, OP4, OP3, OP2, OP1, OP0} = OP;
    assign {F5, F4, F3, F2, F1, F0} = F;

    always @(OP, F)
    begin
        AluOp[0] <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0 |
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | 
        ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | 
        OP5&~OP4&~OP3&~OP2&OP1&OP0 | 
        OP5&~OP4&OP3&~OP2&OP1&OP0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&F0 | 
        ~OP5&~OP4&OP3&OP2&OP1&~OP0 | 
        OP5&~OP4&OP3&~OP2&~OP1&OP0 | 
        ~OP5&~OP4&~OP3&OP2&OP1&OP0;
        AluOp[1] <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0 |
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | 
        ~OP5&~OP4&~OP3&OP2&OP1&OP0;
        AluOp[2] <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 |
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | 
        OP5&~OP4&~OP3&~OP2&OP1&OP0 | 
        OP5&~OP4&OP3&~OP2&OP1&OP0 | 
        OP5&~OP4&OP3&~OP2&~OP1&OP0;
        AluOp[3] <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0 |
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | 
        ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&OP0 | 
        ~OP5&~OP4&OP3&OP2&OP1&~OP0 | 
        ~OP5&~OP4&~OP3&OP2&OP1&OP0;
    end

endmodule
