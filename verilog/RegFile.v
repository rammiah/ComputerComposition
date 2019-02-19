`timescale 1ns / 1ps

// 寄存器文件，要求和logisim上的完全相同
module RegFile(RA1, RA2, WA, Din, WE, clk, R1, R2);
    input wire [4:0] RA1, RA2, WA;
    input wire [31:0] Din;
    input wire WE, clk;
    output reg [31:0] R1, R2;
    reg [31:0] regs[31:0];
    initial
    begin
        regs[0] <= 0;
        R1 <= 0;
        R2 <= 0;
    end
    
    always @ (posedge clk)
    begin
        R1 <= regs[RA1];
        R2 <= regs[RA2];
        if (WE)
        begin
            regs[WA] <= Din;
        end
    end

endmodule
