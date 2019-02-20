`timescale 1ns / 1ps

module PC_tb();
    wire [31:0] Din;
    wire [31:0] Dout; 
    reg en, clk, rst;
    assign Din = Dout + 1;
    
    Register pc(.Din(Din), .Dout(Dout), .en(en), .clk(clk), .rst(rst));
    
    initial 
    begin
        clk <= 0;
        en <= 0;
        rst <= 0;
        #30 en <= 1;
        #10 rst <= 1;
        #10 rst <= 0;
        #30 $stop;
    end
    
    
    
    always #5 clk = ~clk;

endmodule
