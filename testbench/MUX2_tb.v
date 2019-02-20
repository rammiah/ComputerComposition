`timescale 1ns / 1ps

module MUX2_tb();
    parameter N = 16;
    reg [N - 1:0] D0, D1;
    wire [N - 1:0] Dout;
    reg sel;
    MUX2 #(.N(N)) mux2(.sel(sel), .D0(D0), .D1(D1), .Dout(Dout));
    
    initial
    begin
        D0 <= 10;
        D1 <= 11;
        sel <= 1;
        #10 sel = 0;
        #10 sel = 1;
        # 10 D1 = 22;
    end

endmodule
