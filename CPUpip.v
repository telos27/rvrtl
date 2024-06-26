//流水线结构
`include "IF.v"
`include "ID.v"
`include "EX.v"
`include "MEM.v"
`include "WB.v"
`include "Controlpip.v"
module CPUpip (
    clk, clr
);
    input           clk, clr;
    //取指、译码
    reg     [31:0]  IF_ID_PC, IF_ID_Ins;
    //译码、执行
    reg     [31:0]  ID_EX_PC, ID_EX_rs1, ID_EX_rs2, ID_EX_imm;
    reg     [6:0]   ID_EX_func7;
    reg     [2:0]   ID_EX_func3;
    reg     [4:0]   ID_EX_rd;
    reg     [6:0]   ID_EX_Control;
    //执行、访存
    reg     [31:0]  EX_MEM_AddSum, EX_MEM_ALUresult, EX_MEM_rs2;
    reg     [2:0]   EX_MEM_ALUflag;
    reg     [4:0]   EX_MEM_rd;
    reg     [4:0]   EX_MEM_Control;
    //访存、写回
    reg     [31:0]  MEM_WB_Readdata, MEM_WB_ALUresult
    reg     [4:0]   MEM_WB_rd;
    reg     [1:0]   MEM_WB_Control;
    //控制线
    wire            PCSrc, ALUSrc, AddSrc, Branch, MemWrite, MemRead, MemtoReg, RegWrite;
    wire    [2:0]   ALUflag;
    //数据线
    wire    [31:0]  PC, Instruction;
    wire    [31:0]  rs1, rs2, immediate, func7, func3
    wire    [31:0]  AddSum, ALUresult;
    wire    [31:0]  Writeregister;
    wire    [31:0]  Readdata;
    //取指
    IF IF (
        .clk(clk),              .clr(clr),
        .PCSrc(PCSrc),
        .AddSum(EX_MEM_AddSum),
        .PC(PC),                .Instruction(Instruction)
    );
    //取指，译码
    always @(posedge clk) begin
        IF_ID_PC    <= PC;
        IF_ID_Ins   <= Instruction;
    end
    //译码
    ID ID (
        .clk(clk),                  .clr(clr),
        .RegWrite(MEM_WB_rd),
        .Instruction(IF_ID_Ins),    .Writedata(Writeregister),
        .rs1(rs1),                  .rs2(rs2),                  .immediate(immediate),
        .func7(func7),              .func3(func3)
    );
    //控制
    Controlpip Controlpip (
        .opcode(Instruction[6:0]),
        .ALUSrc(ALUSrc),            .AddSrc(AddSrc),
        .Branch(Branch),            .MemWrite(MemWrite), .MemRead(MemRead),
        .MemtoReg(MemtoReg),        .RegWrite(RegWrite)
    );
    //译码，执行
    always @(posedge clk) begin
        ID_EX_PC        <= IF_ID_PC;
        ID_EX_rs1       <= rs1;
        ID_EX_rs2       <= rs2;
        ID_EX_imm       <= immediate;
        ID_EX_func7     <= func7;
        ID_EX_func3     <= func3;
        ID_EX_rd        <= IF_ID_Ins[11:7];
        ID_EX_Control   <= {RegWrite, MemtoReg, MemRead, MemWrite, Branch, ALUSrc, AddSrc};
    end
    //执行
    EX EX (
        .clk(clk),                  .clr(clr),
        .AddSrc(ID_EX_Control[0]),  .ALUSrc(ID_EX_Control[1]),
        .PCin(ID_EX_PC),
        .rs1(ID_EX_rs1),            .rs2(ID_EX_rs2),            .immediate(ID_EX_imm),
        .func7(ID_EX_func7),        .func3(ID_EX_func3),
        .AddSum(AddSum),            .ALUresult(ALUresult),      .ALUflag(ALUflag)
    );
    //执行，访存
    always @(posedge clk) begin
        EX_MEM_AddSum       <= AddSum;
        EX_MEM_ALUresult    <= ALUresult;
        EX_MEM_ALUflag      <= ALUflag;
        EX_MEM_rs2          <= ID_EX_rs2;
        EX_MEM_rd           <= ID_EX_rd;
        EX_MEM_Control      <= ID_EX_Control[6:2];   //RegWrite, MemtoReg, MemRead, MemWrite, Branch
    end
    //访存
    MEM MEM (
        .clk(clk),                      .clr(clr),
        .Branch(EX_MEM_Control[0]),
        .MemWrite(EX_MEM_Control[1]),   .MemRead(EX_MEM_Control[2]), .ALUflag(EX_MEM_ALUflag),
        .PCSrc(PCSrc),
        .ALUresult(EX_MEM_ALUresult),   .rd(EX_MEM_rs2),
        .Readdata(Readdata)
    );
    //访存，写回
    always @(posedge clk) begin
        MEM_WB_ALUresult    <= EX_MEM_ALUresult;
        MEM_WB_Readdata     <= Readdata;
        MEM_WB_rd           <= EX_MEM_rd;
        MEM_WB_Control      <= EX_MEM_Control[4:3];   //RegWrite, MemtoReg
    end
    //写回
    WB WB (
        .MemtoReg(MEM_WB_Control[0]),
        .Readdata(MEM_WB_Readdata),     .ALUresult(MEM_WB_ALUresult),
        .Writeregister(Writeregister)
    );
endmodule