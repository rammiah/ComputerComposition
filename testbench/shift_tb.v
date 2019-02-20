`timescale 1ns / 1ps

module shift_tb();
    reg [31:0] data;
    
    initial
    begin
        data = -1289;
        $display("data >> %x = %x", 3, data >> 3);
        $display("signed(data) >> %x = %x", 3, $signed(data) >>> 3);

    end


endmodule
