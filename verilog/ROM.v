`timescale 1ns / 1ps

module ROM(addr, data);
    // output data
    output reg [31:0] data;
    // inputr addr
    input wire [9:0] addr;
    reg [31:0] my_rom[1023:0];
    reg [31:0] ha;
    initial
    begin
        $readmemh("E:/Documents/Computer/MIPS_CPU/instr.hex", my_rom);
        $display("0x00: %h", my_rom[8'h00]);
        data = my_rom[8'h00];
    end
    // data load when addr is updated
    always @(addr)
    begin
        data <= my_rom[addr];
    end
    
endmodule
