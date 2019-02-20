`timescale 1ns / 1ps

module Pattern(code, patt);
    input [3:0] code;
    output reg [7:0] patt;

    parameter num00 = 4'b0000;
    parameter num01 = 4'b0001;
    parameter num02 = 4'b0010;
    parameter num03 = 4'b0011;
    parameter num04 = 4'b0100;
    parameter num05 = 4'b0101;
    parameter num06 = 4'b0110;
    parameter num07 = 4'b0111;
    parameter num08 = 4'b1000;
    parameter num09 = 4'b1001;
    parameter num10 = 4'b1010;
    parameter num11 = 4'b1011;
    parameter num12 = 4'b1100;
    parameter num13 = 4'b1101;
    parameter num14 = 4'b1110;
    parameter num15 = 4'b1111;
    parameter dec00 = 8'b11000000;
    parameter dec01 = 8'b11111001;
    parameter dec02 = 8'b10100100;
    parameter dec03 = 8'b10110000;
    parameter dec04 = 8'b10011001;
    parameter dec05 = 8'b10010010;
    // 01001001  10010010
    parameter dec06 = 8'b10000010;
    parameter dec07 = 8'b11111000;
    parameter dec08 = 8'b10000000;
    parameter dec09 = 8'b10010000;
    parameter dec10 = 8'b10001000;
    parameter dec11 = 8'b10000011;
    parameter dec12 = 8'b11000110;
    parameter dec13 = 8'b10100001;
    parameter dec14 = 8'b10000110;
    parameter dec15 = 8'b10001110;

    
    always @(code)
    begin
        case(code)
        num00: patt = dec00;
        num01: patt = dec01;
        num02: patt = dec02;
        num03: patt = dec03;
        num04: patt = dec04;
        num05: patt = dec05;
        num06: patt = dec06;
        num07: patt = dec07;
        num08: patt = dec08;
        num09: patt = dec09;
        num10: patt = dec10;
        num11: patt = dec11;
        num12: patt = dec12;
        num13: patt = dec13;
        num14: patt = dec14;
        num15: patt = dec15;
        default: patt = 8'b11111111;
        endcase
    end
    
endmodule