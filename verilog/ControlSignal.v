`timescale 1ns / 1ps

module ControlSignal(op, func, MemToReg, MemWrite, AluSrc, RegWrite,
                     SysCall, SignedExt, RegDst, Beq, Bne, JR, JMP, JAL);
    input wire [5:0] op, func;
    output reg MemToReg, MemWrite, AluSrc,
               RegWrite, SysCall, SignedExt,
               RegDst, Beq, Bne, JR, JMP, JAL;
    
    wire OP0, OP1, OP2, OP3, OP4, OP5;
    wire F5, F4, F3, F2, F1, F0;
    assign {F5, F4, F3, F2, F1, F0} = func;
    assign {OP5, OP4, OP3, OP2, OP1, OP0} = op;
    
    always @(op, func)
    begin
        MemToReg <= OP5&~OP4&~OP3&~OP2&OP1&OP0;
        MemWrite <= OP5&~OP4&OP3&~OP2&OP1&OP0 |
        OP5&~OP4&OP3&~OP2&~OP1&OP0;
        AluSrc <= ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 |
        ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | 
        ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&OP0 | 
        OP5&~OP4&~OP3&~OP2&OP1&OP0 | 
        OP5&~OP4&OP3&~OP2&OP1&OP0 | 
        ~OP5&~OP4&OP3&OP2&OP1&~OP0 | 
        OP5&~OP4&OP3&~OP2&~OP1&OP0;
        RegWrite <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&~F1&~F0 |
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&OP1&OP0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&~OP2&~OP1&OP0 | 
        ~OP5&~OP4&OP3&~OP2&OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&OP0 | 
        OP5&~OP4&~OP3&~OP2&OP1&OP0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&F0 | 
        ~OP5&~OP4&OP3&OP2&OP1&~OP0;
        SysCall <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&F2&~F1&~F0;
        SignedExt <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 |
        ~OP5&~OP4&OP3&OP2&~OP1&~OP0 | 
        ~OP5&~OP4&OP3&OP2&~OP1&OP0 | 
        ~OP5&~OP4&OP3&OP2&OP1&~OP0;
        RegDst <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&~F1&~F0 |
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&~F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&~F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&~F3&F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&~F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&F5&~F4&F3&~F2&F1&F0 | 
        ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&~F3&F2&F1&F0;
        Beq <= ~OP5&~OP4&~OP3&OP2&~OP1&~OP0;
        Bne <= ~OP5&~OP4&~OP3&OP2&~OP1&OP0;
        JR <= ~OP5&~OP4&~OP3&~OP2&~OP1&~OP0&~F5&~F4&F3&~F2&~F1&~F0;
        JMP <= ~OP5&~OP4&~OP3&~OP2&OP1&~OP0;
        JAL <= ~OP5&~OP4&~OP3&~OP2&OP1&OP0;
    end

endmodule
