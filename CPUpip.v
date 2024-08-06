//流水线结构
`include "IF.v"
`include "ID.v"
`include "EX.v"
`include "MEM.v"
`include "WB.v"
`include "Controlpip.v"
`include "Fowarding.v"
module CPUpip (
    clk, clr
);
    input clk, clr;
    //取指
    wire PCSrc;
    wire [31:0] PC, Instruction, SumAdd;
    IF IF (
        .clk(clk), .clr(clr),           //input ，时钟、清零
        .PCSrc          (PCSrc),        //input ，程序计数器分支选择
        .AddSum         (SumAdd),       //input ，指令计算地址
        .PC             (PC),           //output，程序计数器
        .Instruction    (Instruction)   //output，指令输出
    );
    //取指、译码
    reg [31:0]  IF_ID_PC, IF_ID_Ins;
    always @(posedge clk) begin
        IF_ID_PC    <= PC;
        IF_ID_Ins   <= Instruction;
    end
    //译码
    wire [4:0]  rd;
    wire [31:0] rs1data, rs2data, immediate;
    wire [6:0]  func7;
    wire [2:0]  func3;
    ID ID (
        .clk(clk), .clr(clr),                   //input ，时钟、清零
        .RegWrite       (MEM_WB_Control[1]),    //input ，寄存器写控制
        .Instruction    (IF_ID_Ins),            //input ，指令输入
        .AddSrc         (AddSrc),               //input ，地址分支选择
        .Writedata      (WriteRegister),        //input ，写入寄存器数据
        .rd             (rd),                   //input ，写入寄存器编号
        .rs1data        (rs1data),              //output，rs1数据
        .rs2data        (rs2data),              //output，rs2数据
        .immediate      (immediate),            //output，立即数输出
        .func7          (func7),                //output，指令func7字段
        .func3          (func3)                 //output，指令func3字段
    );
    //控制模块
    wire ALUSrc, AddSrc, Branch, MemWrite, MemRead, MemtoReg, RegWrite;
    Controlpip Controlpip (
        .clr        (clr),              //input ，清零
        .opcode     (Instruction[6:0]), //input ，指令操作码字段
        .ALUSrc     (ALUSrc),           //output，ALU_rs2选择
        .AddSrc     (AddSrc),           //output，地址分支选择
        .Branch     (Branch),           //output，分支控制
        .MemWrite   (MemWrite),         //output，内存写入控制
        .MemRead    (MemRead),          //output，内存读取控制
        .MemtoReg   (MemtoReg),         //output，写回数据选择
        .RegWrite   (RegWrite)          //output，寄存器写控制
    );
    //译码、执行
    reg [31:0]  ID_EX_rs1data, ID_EX_rs2data, ID_EX_imm;
    reg [6:0]   ID_EX_func7, ID_EX_Control;
    reg [2:0]   ID_EX_func3;
    reg [4:0]   ID_EX_rd, ID_EX_rs1, ID_EX_rs2;
    always @(posedge clk) begin
        ID_EX_rs1data   <= rs1data;
        ID_EX_rs2data   <= rs2data;
        ID_EX_imm       <= immediate;
        ID_EX_func7     <= func7;
        ID_EX_func3     <= func3;
        ID_EX_rd        <= IF_ID_Ins[11:7];
        ID_EX_Control   <= {RegWrite, MemtoReg, MemRead, MemWrite, Branch, ALUSrc};
        ID_EX_rs1       <= IF_ID_Ins[19:15];
        ID_EX_rs2       <= IF_ID_Ins[24:20];
    end
    //执行
    wire [31:0] ALUresult;
    wire        BranchALU;
    EX EX (
        .clk(clk), .clr(clr),               //input ，时钟、清零
        .ALUSrc         (ID_EX_Control[0]), //input ，ALU_rs2选择
        .WriteRegister  (WriteRegister),    //input ，写回阶段写入寄存器数据
        .priorALUresult (EX_MEM_ALUresult), //input ，先前指令的ALU结果
        .ForwardA       (ForwardA),         //input ，rs1输入转发控制信号
        .ForwardB       (ForwardB),         //input ，rs2输入转发控制信号
        .rs1data        (ID_EX_rs1data),    //input ，ALU_rs1数据
        .rs2data        (ID_EX_rs2data),    //input ，ALU_rs2数据
        .immediate      (ID_EX_imm),        //input ，立即数
        .func7          (ID_EX_func7),      //input ，指令func7字段
        .func3          (ID_EX_func3),      //input ，指令func3字段
        .ALUresult      (ALUresult),        //output，ALU计算结果
        .BranchALU      (BranchALU)         //output，ALU分支条件
    );
    //转发单元
    wire ForwardA, ForwardB;
    Forwarding Forwarding (
        .EX_MEM_RegWrite(EX_MEM_Control[4]),    //input ，执行、访存阶段寄存器写入控制信号
        .MEM_WB_RegWrite(MEM_WB_Control[1]),    //input ，访存、写回阶段寄存器写入控制信号
        .EX_MEM_rd(EX_MEM_rd),                  //input ，执行、访存阶段写入目标寄存器编号
        .MEM_WB_rd(MEM_WB_rd),                  //input ，访存、写回阶段写入目标寄存器编号
        .ID_EX_rs1(ID_EX_rs1),                  //input ，译码、执行阶段rs1寄存器编号
        .ID_EX_rs2(ID_EX_rs2),                  //input ，译码、执行阶段rs2寄存器编号
        .ForwardA(ForwardA),                    //output，rs1输入转发控制信号
        .ForwardB(ForwardB)                     //output，rs2输入转发控制信号
    );
    //执行、访存
    reg [31:0]  EX_MEM_ALUresult, EX_MEM_rs2;
    reg [2:0]   EX_MEM_BranchALU;
    reg [4:0]   EX_MEM_rd;
    reg [4:0]   EX_MEM_Control;
    always @(posedge clk) begin
        EX_MEM_ALUresult    <= ALUresult;
        EX_MEM_BranchALU    <= BranchALU;
        EX_MEM_rs2          <= ID_EX_rs2;
        EX_MEM_rd           <= ID_EX_rd;
        EX_MEM_Control      <= ID_EX_Control[5:1];  //RegWrite, MemtoReg, MemRead, MemWrite, Branch
    end
    //访存
    wire [31:0] Readdata;
    MEM MEM (
        .clk(clk), .clr(clr),               //input ，时钟、清零
        .Branch     (EX_MEM_Control[0]),    //input ，分支控制
        .MemWrite   (EX_MEM_Control[1]),    //input ，内存写入控制
        .MemRead    (EX_MEM_Control[2]),    //input ，内存读取控制
        .BranchALU  (EX_MEM_BranchALU),     //input ，ALU分支条件
        .PCSrc      (PCSrc),                //input ，分支输出
        .ALUresult  (EX_MEM_ALUresult),     //input ，ALU计算结果
        .rs2        (EX_MEM_rs2),           //input，写入内存数据
        .Readdata   (Readdata)              //output，内存读取数据
    );
    //访存、写回
    reg [31:0]  MEM_WB_Readdata, MEM_WB_ALUresult;
    reg [4:0]   MEM_WB_rd;
    reg [1:0]   MEM_WB_Control;
    always @(posedge clk) begin
        MEM_WB_ALUresult    <= EX_MEM_ALUresult;
        MEM_WB_Readdata     <= Readdata;
        MEM_WB_rd           <= EX_MEM_rd;
        MEM_WB_Control      <= EX_MEM_Control[4:3]; //RegWrite, MemtoReg
    end
    //写回
    wire [31:0] WriteRegister;
    Mux_2_32 WB (
        .select     (MEM_WB_Control[0]),    //input ，写回数据选择
        .datain0    (MEM_WB_Readdata),      //input ，读取内存数据
        .datain1    (MEM_WB_ALUresult),     //input ，ALU计算结果
        .dataout    (WriteRegister)         //output，寄存器写入数据
    );
endmodule