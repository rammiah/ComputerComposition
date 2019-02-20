`timescale 1ns / 1ps

module CPU_tb();
    reg clk, rst;
    
    CPU cpu(.clk(clk), .rst(rst), .freq(1'b1), .sel(3'b000));
    initial
    begin
        rst <= 1;
        clk <= 0;
        #5 rst <= 0; // reset cpu
        #4000;
        $stop;
    end
    
    always #1 clk = ~clk;

endmodule
