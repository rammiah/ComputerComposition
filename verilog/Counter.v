`timescale 1ns / 1ps

module Counter(clk, en, rst, cnt);
    input wire clk, en, rst;
    output reg [31:0] cnt;
    
    initial
    begin
        cnt = 0;
    end
    
    
    always @(posedge clk)
    begin
        if (rst)
        begin
            cnt = 0;
        end else if (en)
        begin
            cnt = cnt + 1;
        end
    end

endmodule
