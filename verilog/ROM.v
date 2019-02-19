`timescale 1ns / 1ps

module ROM(addr, data);
    // 输出数据宽度为32位，字为单位
    output reg [31:0] data;
    // 指令数目不要超过1024
    input wire [9:0] addr;
    reg [31:0] my_rom[1023:0];
    reg [31:0] ha;
    initial
    begin
        // 这里是我的指令所在位置，不需要v2.0 raw头，直接16进制读取
        $readmemh("E:/Documents/Computer/MIPS_CPU/instr.hex", my_rom);
        $display("0x00: %h", my_rom[8'h00]);
        data = my_rom[8'h00];
    end
    // 地址改变时输出新的数据
    always @(addr)
    begin
        data <= my_rom[addr];
    end
    
endmodule
