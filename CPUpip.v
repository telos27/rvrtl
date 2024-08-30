//流水线结构
`include "IF.v"
`include "ID.v"
`include "EX.v"
`include "MEM.v"
`include "WB.v"
`include "Hazard_detection.v"
`include "Forwarding_EX.v"
`include "Forwarding_MEM.v"
module CPUpip (
    clk, clr
);
    input clk, clr;
    //取指
    wire PCSrc;
    wire [31:0] PC, Instruction, SumAdd;
    IF IF (
        .clk(clk), .clr (clr),          //input ，时钟、清零
        .PCSrc          (PCSrc),        //input ，程序计数器分支选择
        .PCWrite        (PCWrite),      //input ，PC写控制
        .AddSum         (SumAdd),       //input ，指令计算地址
        .PC             (PC),           //output，程序计数器
        .Instruction    (Instruction)   //output，指令输出
    );

    //IF/ID，取指、译码流水线寄存器
    reg [31:0] IF_ID_PC, IF_ID_Ins;
    wire IF_ID_Write;
    always @(posedge clk) begin
        if (IF_ID_Write) begin
            IF_ID_PC    <= PC;
            IF_ID_Ins   <= Instruction;
        end
    end

    //冒险检测单元
    Hazard_detection Hazard_detection_Unit (
        .ID_EX_MemRead  (ID_EX_Control[2]), //input ，译码、执行阶段内存读控制
        .ID_EX_rd       (ID_EX_rd),         //input ，译码、执行阶段目标寄存器编号
        .IF_ID_rs1      (IF_ID_Ins[19:15]), //input ，取指、译码阶段rs1寄存器编号
        .IF_ID_rs2      (IF_ID_Ins[24:20]), //input ，取指、译码阶段rs2寄存器编号
        .PCWrite        (PCWrite),          //output，PC写控制
        .IF_ID_Write    (IF_ID_Write),      //output，取指、译码流水线寄存器写控制
        .Nop            (Nop)               //output，空指令（控制信号清零）
    );

    //译码
    wire [4:0]  rd;
    wire [31:0] rs1data, rs2data, immediate;
    wire Branch;
    wire [5:0]  Control;
    ID ID (
        .clk(clk),  .clr(clr),              //input ，时钟、清零
        .RegWrite       (MEM_WB_Control[1]),//input ，寄存器写控制
        .Instruction    (IF_ID_Ins),        //input ，指令输入
        .AddSrc         (AddSrc),           //input ，地址分支选择
        .Writedata      (WriteRegister),    //input ，写寄存器数据
        .rd             (rd),               //input ，写寄存器编号
        .rs1data        (rs1data),          //output，rs1数据
        .rs2data        (rs2data),          //output，rs2数据
        .Control        (Control),          //output，控制信号，RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc
        .PCSrc          (PCSrc),            //output，程序计数器分支选择
        .immediate      (immediate)         //output，立即数输出
    );

    //ID/EX，译码、执行流水线寄存器
    reg  [31:0] ID_EX_rs1data, ID_EX_rs2data, ID_EX_imm;
    reg  [6:0]  ID_EX_func7
    reg  [4:0]  ID_EX_Control;
    reg  [2:0]  ID_EX_func3;
    reg  [4:0]  ID_EX_rd, ID_EX_rs1, ID_EX_rs2;
    wire [4:0]  ControlorNop;
    assign ControlorNop = Nop ? 5'b0 : Control;
    always @(posedge clk) begin
        ID_EX_rs1data   <= rs1data;
        ID_EX_rs2data   <= rs2data;
        ID_EX_imm       <= immediate;
        ID_EX_func7     <= IF_ID_Ins[14:12];
        ID_EX_func3     <= IF_ID_Ins[31:25];
        ID_EX_rd        <= IF_ID_Ins[11:7];
        ID_EX_Control   <= ControlorNop; //RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc
        ID_EX_rs1       <= IF_ID_Ins[19:15];
        ID_EX_rs2       <= IF_ID_Ins[24:20];
    end

    //执行
    wire [31:0] ALUresult;
    EX EX (
        .clk(clk),  .clr(clr),              //input ，时钟、清零
        .ALUSrc         (ID_EX_Control[0]), //input ，ALU_rs2选择
        .WriteRegister  (WriteRegister),    //input ，写回阶段写寄存器数据
        .priorALUresult (EX_MEM_ALUresult), //input ，先前指令的ALU结果
        .ForwardA       (ForwardA),         //input ，rs1输入转发控制信号
        .ForwardB       (ForwardB),         //input ，rs2输入转发控制信号
        .rs1data        (ID_EX_rs1data),    //input ，ALU_rs1数据
        .rs2data        (ID_EX_rs2data),    //input ，ALU_rs2数据
        .immediate      (ID_EX_imm),        //input ，立即数
        .func7          (ID_EX_func7),      //input ，指令func7字段
        .func3          (ID_EX_func3),      //input ，指令func3字段
        .ALUresult      (ALUresult),        //output，ALU计算结果
    );

    //执行单元转发单元
    wire [1:0] ForwardA, ForwardB;
    Forwarding_EX Forwarding_EX (
        .EX_MEM_RegWrite(EX_MEM_Control[4]),//input ，执行、访存阶段寄存器写控制信号
        .MEM_WB_RegWrite(MEM_WB_Control[1]),//input ，访存、写回阶段寄存器写控制信号
        .EX_MEM_rd      (EX_MEM_rd),        //input ，执行、访存阶段写目标寄存器编号
        .MEM_WB_rd      (MEM_WB_rd),        //input ，访存、写回阶段写目标寄存器编号
        .ID_EX_rs1      (ID_EX_rs1),        //input ，译码、执行阶段rs1寄存器编号
        .ID_EX_rs2      (ID_EX_rs2),        //input ，译码、执行阶段rs2寄存器编号
        .ForwardA       (ForwardA),         //output，rs1输入转发控制信号
        .ForwardB       (ForwardB)          //output，rs2输入转发控制信号
    );

    //EX/MEM，执行、访存流水线寄存器
    reg [31:0]  EX_MEM_ALUresult, EX_MEM_rs2;
    reg [4:0]   EX_MEM_rd;
    reg [3:0]   EX_MEM_Control;
    reg [2:0]   EX_MEM_func3
    always @(posedge clk) begin
        EX_MEM_ALUresult    <= ALUresult;
        EX_MEM_rs2          <= ID_EX_rs2;
        EX_MEM_rd           <= ID_EX_rd;
        EX_MEM_Control      <= ID_EX_Control[4:1];  //RegWrite, MemtoReg, MemRead, MemWrite
        EX_MEM_func3        <= ID_EX_func3;
    end

    //访存
    wire [31:0] readdata;
    MEM MEM (
        .clk            (clk),              //input ，时钟
        .MemWrite       (EX_MEM_Control[0]),//input ，内存写控制
        .MemRead        (EX_MEM_Control[1]),//input ，内存读控制
        .ForwardMem     (ForwardMem),       //input ，内存转发控制
        .priorMEMdata   (MEM_WB_Readdata),  //input ，先前指令的内存读取数据
        .ALUresult      (EX_MEM_ALUresult), //input ，ALU计算结果
        .rs2            (EX_MEM_rs2),       //input ，写内存数据
        .readdata       (readdata)          //output，内存读数据
        .func3          (EX_MEM_func3)      //input ，指令func3字段
    );

    //访存转发单元
    wire ForwardMem;
    Forwarding_MEM Forwarding_MEM(
        .MemRead    (EX_MEM_Control[1]),//input ，内存写控制
        .MemWrite   (MEM_WB_Control[0]),//input ，内存读控制
        .MEM_WB_rd  (MEM_WB_rd),        //input ，访存、写回阶段写目标寄存器编号
        .EX_MEM_rd  (EX_MEM_rd),        //input ，执行、访存阶段写目标寄存器编号
        .ForwardMem (ForwardMem)        //output，写内存数据选择
    );

    //MEM/WB，访存、写回流水线寄存器
    reg [31:0]  MEM_WB_Readdata, MEM_WB_ALUresult;
    reg [4:0]   MEM_WB_rd;
    reg [1:0]   MEM_WB_Control; //RegWrite, MemtoReg
    always @(posedge clk) begin
        MEM_WB_ALUresult    <= EX_MEM_ALUresult;
        MEM_WB_Readdata     <= Readdata;
        MEM_WB_rd           <= EX_MEM_rd;
        MEM_WB_Control      <= EX_MEM_Control[3:2]; //RegWrite, MemtoReg
    end

    //写回
    wire [31:0] WriteRegister;
    WB WB (
        .MemtoReg(MEM_WB_Control[0]),   //input ，写回数据选择
        .Readdata(MEM_WB_Readdata),     //input ，读内存数据
        .ALUresult(MEM_WB_ALUresult),   //input ，ALU计算结果
        .Writeregister(WriteRegister)   //output，寄存器写数据
    );
endmodule