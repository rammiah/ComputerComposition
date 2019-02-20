`timescale 1ns / 1ps

module ROM_bc();
    reg [9:0] addr;
    wire [31:0] data;
    ROM rom(.addr(addr), .data(data));
    
//    reg [9:0] a;
    initial
    begin
        for (addr = 0; addr < 200; addr = addr + 1) 
        begin
            #10;
        end
    end

endmodule
