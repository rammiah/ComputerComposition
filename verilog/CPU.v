`timescale 1ns / 1ps

module CPU(clk, rst, SEG, AN, ext_a, sel, freq, go);
    input clk, rst, freq, go;
    output [7:0] SEG, AN;
    input [4:0] ext_a;
    input [2:0] sel;
    // C1 >= SHM_SRC
    wire [5:0]OP, Func;
    wire MemToReg, MemWrite, AluSrc, RegWrite,
         SysCall, UnsignedExt, RegDst, Beq, Bne, JR, JMP, JAL;
    wire [3:0]AluOp;
    wire ShaSrc, Sh, Bgtz;
    wire clk_N;
    // wire .SHM_SRC(C1), .SH(M), .BGTZ(B)
    wire [9:0] rom_addr;
    wire [31:0] rom_out;
    wire [31:0] pc_out;
    wire [31:0] pc_in;
    wire [4:0] rs, rt, rd;
    wire [4:0] reg_r1, reg_r2, reg_w;
    wire [31:0] reg_din;
    wire [31:0] reg_d1, reg_d2;
    wire [4:0] tmp0;
    wire run, pause;
    
    wire [31:0] pc4;
    wire [31:0] ext_d;
    wire clk_H, clk_L;
    Divider #(.N(32))div_l(.clk(clk), .clk_N(clk_L));
//    assign clk_H = clk;
    Divider #(.N(50_000_000)) div_h(.clk(clk), .clk_N(clk_H));
//    assign go = 0;
    assign clk_N = freq ? clk_H : clk_L;
    assign pc4 = pc_out + 4;
    assign run = ~pause | go;
    assign rom_addr = pc_out[11:2];
    assign OP = rom_out[31:26];
    assign Func = rom_out[5:0];
    assign rs = rom_out[25:21];
    assign rt = rom_out[20:16];
    assign rd = rom_out[15:11];
    Register pc(.Din(pc_in), .Dout(pc_out), .en(run), .clk(clk_N), .rst(rst));
    ROM rom(.addr(rom_addr), .data(rom_out));
    MUX2 #(.N(5)) m0(.sel(SysCall), .D0(rs), .D1(5'b00010), .Dout(reg_r1));
    MUX2 #(.N(5)) m1(.sel(SysCall), .D0(rt), .D1(5'b00100), .Dout(reg_r2));
    
    MUX2 #(.N(5)) m2(.sel(RegDst), .D0(rt), .D1(rd), .Dout(tmp0));
    MUX2 #(.N(5)) m3(.sel(JAL), .D0(tmp0), .D1(5'b11111), .Dout(reg_w));
    
    RegFile regfile(.RA1(reg_r1), .RA2(reg_r2), .WA(reg_w), .Din(reg_din),
                    .WE(RegWrite), .clk(clk_N), .R1(reg_d1), .R2(reg_d2));

    wire [31:0] alu_b;
    wire [31:0] tmp1;
    
    MUX2 #(.N(32)) m4(.sel(UnsignedExt), .D0({{16{rom_out[15]}},rom_out[15:0]}), 
           .D1({{16{1'b0}},rom_out[15:0]}), .Dout(tmp1));    
    MUX2 #(.N(32)) m5(.sel(AluSrc), .D0(reg_d2), .D1(tmp1), .Dout(alu_b));
    wire [4:0] shamt;
    wire [31:0] Result, Result2;
    wire Equal;
    // alu
    ALU alu(.X(reg_d1), .Y(alu_b), .shamt(shamt), .AluOp(AluOp),
            .Result(Result), .Result2(Result2), .Equal(Equal));
    MUX2 #(.N(5)) m6(.sel(ShaSrc), .D0(rom_out[10:6]), .D1(reg_d1[4:0]),.Dout(shamt));
    
    wire [31:0] ram_out;
    wire [31:0] ram_in;
    MUX2 #(.N(32)) m7(.sel(Sh&Result[1]), .D0(reg_d2), .D1(reg_d2<<16), .Dout(ram_in));
    // ram
    wire [3:0] sel_bytes;
    assign sel_bytes = Sh ? (Result[1] ? 4'hc : 4'h3) : 4'hf;
    
    RAM ram(.clk(clk_N), .Addr(Result[6:2]), .Din(ram_in), .we(MemWrite), 
            .sel(sel_bytes), .ld(MemToReg), .Dout(ram_out), .ext_a(ext_a), .ext_d(ext_d));
    
    MUX4 #(.N(4)) m8(.sel({Sh, Result[1]}), .D0(4'h3), .D1(4'hc), .D2(4'hf), .D3(4'hf));
    
    // reg data in
    wire [31:0] tmp2;
    MUX2 #(.N(32)) m9(.sel(MemToReg), .D0(Result), .D1(ram_out), .Dout(tmp2));
    MUX2 #(.N(32)) m10(.sel(JAL), .D0(tmp2), .D1(pc4), .Dout(reg_din));   
    
    // set pc part
    wire b_en; // branch
    wire j_en;
    assign b_en = Bgtz & ~(Result[0] | Equal) |
                  Beq & Equal |
                  Bne & ~Equal;
    assign j_en = JAL | JMP; // NO JR, JR is another case
    wire [31:0] tmp3;
    MUX4 #(.N(32)) m11(.sel({JR, b_en}), .D0(pc4), .D1(pc4 + (tmp1<<2)), .D2(reg_d1), .Dout(tmp3));
    MUX2 #(.N(32)) m12(.sel(j_en), .D0(tmp3), .D1({pc_out[31:26], rom_out[25:0]<<2}), .Dout(pc_in));
    assign pause = SysCall & (reg_d1 != 34);
    wire [31:0] led_data;
    Register led_reg(.Din(reg_d2), .Dout(led_data), .en(SysCall & (reg_d1 == 34)), .clk(clk_N), .rst(rst));
    
    Controller controller(.OP(OP), .Func(Func),  .MemToReg(MemToReg), .MemWrite(MemWrite),
               .AluSrc(AluSrc), .RegWrite(RegWrite), .SysCall(SysCall), 
               .SignedExt(UnsignedExt), .RegDst(RegDst), .Beq(Beq), .Bne(Bne),
               .JR(JR), .JMP(JMP), .JAL(JAL), .AluOp(AluOp), .C1(ShaSrc),
               .M(Sh), .B(Bgtz));
     wire [31:0] jmp, branch,  sum;
     Counter cnt_jmp(.clk(clk_N), .en(j_en | JR), .rst(rst), .cnt(jmp));
     Counter cnt_b(.clk(clk_N), .en(b_en), .rst(rst), .cnt(branch));
     Counter cnt_sum(.clk(clk_N), .en(run), .rst(rst), .cnt(sum));
     
     wire [31:0] dis_in;
     // todo display clk
     wire dis_clk;
     Divider #(.N(1000)) dis_div(.clk(clk), .clk_N(dis_clk));
     Display display(.SEG(SEG), .AN(AN), .clk(dis_clk), .data(dis_in));
     
     assign dis_in = sel == 3'b000 ? led_data : 
                     sel == 3'b001 ? ext_d :
                     sel == 3'b010 ? sum :
                     sel == 3'b011 ?  jmp :
                     sel == 3'b100 ? branch : 0;
     
endmodule
