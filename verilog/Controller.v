`timescale 1ns / 1ps

module Controller(OP, Func,  MemToReg, MemWrite, AluSrc, RegWrite,
                  SysCall, SignedExt, RegDst, Beq, Bne, JR, JMP, JAL, AluOp, C1, C2, M, B);
      input [5:0] OP, Func;
      
      output wire MemToReg, MemWrite, AluSrc, RegWrite,
                  SysCall, SignedExt, RegDst, Beq, Bne, JR, JMP, JAL;
      output wire [3:0] AluOp;
      
      output wire C1, C2, M, B;
      
      ControlSignal control_signal(.op(OP), .func(Func), .MemToReg(MemToReg), .MemWrite(MemWrite),
                    .AluSrc(AluSrc), .RegWrite(RegWrite), .SysCall(SysCall), .SignedExt(SignedExt),
                    .RegDst(RegDst), .Beq(Beq), .Bne(Bne), .JR(JR), .JMP(JMP), .JAL(JAL));
      ExtendSignal ext(.op(OP), .func(Func), .SHM_SRC(C1), .SH(M), .BGTZ(B));
      
      AluController alu_ctl(.OP(OP), .F(Func), .AluOp(AluOp));
endmodule
