`timescale 1ns / 1ps

module MUX4_tb();
    parameter N = 10;
    reg [1:0] sel;
    reg[N - 1:0] D0, D1, D2, D3;
    wire [N - 1:0] Dout;
    MUX4 #(.N(N)) mux4(.sel(sel), .D0(D0), .D1(D1), .D2(D2), .D3(D3), .Dout(Dout));
    
    initial
    begin
        D0 <= 0;
        D1 <= 1;
        D2 <= 2;
        D3 <= 3;
        for (sel = 0; sel <= 3; sel = sel + 1)
        begin
            #10;
        end
    end

endmodule
