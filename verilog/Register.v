`timescale 1ns / 1ps

module Register(Din, Dout, en, clk, rst);
    input wire [31:0] Din;
    output reg [31:0] Dout;
    input en, clk, rst;
    
    initial
    begin
        Dout <= 0;
    end
    
    always @(posedge clk)
    begin
        if (rst)
        begin
            Dout <= 0;
        end else if (en)
        begin
            Dout <= Din;
        end
    end


endmodule
