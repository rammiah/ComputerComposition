`timescale 1ns / 1ps
module RAM(clk, Addr, Din, we, sel, ld, Dout, ext_a, ext_d);
    input wire clk, we, ld;
    input wire [31:0] Din;
    input wire [4:0] Addr, ext_a;
    input wire [3:0] sel;
    output wire [31:0] Dout, ext_d;
    // internal data
    reg [31:0] data[31:0];
    
    initial
    begin
//        Dout <= 0;
    end
    
    always @(posedge clk)
    begin
        if (we)
        begin
            if (sel&4'b0001)
            begin
                data[Addr][7:0] <= Din[7:0];
            end
            if (sel&4'b0010)
            begin
                data[Addr][15:8] <= Din[15:8];
            end
            if (sel&4'b0100)
            begin
                data[Addr][23:16] <= Din[23:16];
            end
            if (sel&4'b1000)
            begin
                data[Addr][31:24] <= Din[31:24];
            end
        end
    end 
    assign Dout = data[Addr];
    assign ext_d = data[ext_a];
    
endmodule
