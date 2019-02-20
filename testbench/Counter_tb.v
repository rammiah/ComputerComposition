`timescale 1ns / 1ps

module Counter_tb();
    reg clk = 0;
    reg en;
    reg rst;
    wire [15:0] cnt;
    Counter cnter(.clk(clk), .en(en), .rst(rst), .cnt(cnt));
    
    initial 
    begin
        rst = 0;
        en = 0;
        #20 en = 1;
        #40 rst = 1;
        #10 rst = 0;
        #20;
    end
    
    always #5 clk = ~clk;
    
    
endmodule
