`timescale 1ns / 1ps

module Divider(clk, clk_N);
    parameter N = 1;
    reg [31:0] num;
    input wire clk;
    output reg clk_N;
    reg [31:0] cnt;
    initial
    begin
        clk_N = 0;
        cnt = 0;
        num = 50_000_000 / N;
    end
    // 100M N = 100M => clk_N 
    
    always @(posedge clk)
    begin
        cnt = cnt + 1;
        if (cnt >= num)
        begin
            clk_N = ~clk_N;
            cnt <= 0;
        end
    end
endmodule
