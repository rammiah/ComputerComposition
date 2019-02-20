`timescale 1ns / 1ps

module Display(SEG, AN, clk, data);
    input clk;
    input [31:0]data;
    output [7:0]SEG;
    output reg [7:0]AN;
    

    parameter NONE = 8'b11111111; 

    reg [3:0]show;
    reg [3:0]Seg_RAM[7:0];
    reg [3:0]control;

    initial 
    begin
        control <= 0;
    end

    Pattern patt(.code(show), .patt(SEG));

    always@(posedge clk)
    begin
        control <= (control + 1) % 8;
    end
    
    always @(clk) 
    begin
        case (control)
        0: AN <= 8'b11111110;
        1: AN <= 8'b11111101;
        2: AN <= 8'b11111011;
        3: AN <= 8'b11110111;
        4: AN <= 8'b11101111;
        5: AN <= 8'b11011111;
        6: AN <= 8'b10111111;
        7: AN <= 8'b01111111;
        default: AN <= NONE;
        endcase
    end
    
    always @(clk)
    begin
        case (control)
        0:show <= data[3:0];
        1:show <= data[7:4];
        2:show <= data[11:8];
        3:show <= data[15:12];
        4:show <= data[19:16];
        5:show <= data[23:20];
        6:show <= data[27:24];
        7:show <= data[31:28];
        default: show <= 4'b0000;
        endcase
    end

endmodule
