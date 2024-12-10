//译码
`include "Register.v"
`include "Immediate.v"
`include "Controlpip.v"
module ID (
    clk, clr,
    AddSrc,
    PCin,
    RegWrite,
    Instruction,
    Writedata,
    rd,
    rs1data,
    rs2data,
    Control,
    PCSrc,
    immediate
);
    input clk, clr;
    input AddSrc, RegWrite;
    input [31:0] Instruction, PCin, Writedata;
    input [4:0] rd;

    output [31:0] SumAdd, rs1data, rs2data, immediate;
    output [4:0] Control;
    output PCSrc;

    //控制单元
    wire AddSrc, Branch, Jump, ALUSrc, MemWrite, MemRead, MemtoReg, RegWrite;
    Controlpip Controlpip (
        .clr        (clr),              //input ，清零
        .opcode     (Instruction[6:0]), //input ，指令操作码字段
        .AddSrc     (AddSrc),           //output，地址分支选择
        .Branch     (Branch),           //output，分支控制
        .Jump       (Jump),             //output，跳转控制
        .ALUSrc     (ALUSrc),           //output，ALU_rs2选择
        .MemWrite   (MemWrite),         //output，内存写控制
        .MemRead    (MemRead),          //output，内存读控制
        .MemtoReg   (MemtoReg),         //output，写回数据选择
        .RegWrite   (RegWrite)          //output，寄存器写控制
    );
    assign Control = {RegWrite, MemtoReg, MemRead, MemWrite, ALUSrc};

    //分支地址加法器
    wire [31:0] PC, Addb;
    assign PC = AddSrc ? rs1data : PCin;
    Adder_32 AddSum (.a(PC), .b(immediate), .sub(), .sum(SumAdd), .overflow(), .zeroflag());

    //寄存器文件
    Register RegisterI (.clk(clk), .clr(clr), .write(RegWrite),
        .rd(rd), .rs1(Instruction[19:15]), .rs2(Instruction[24:20]),
        .rddata(Writedata), .rs1data(rs1data), .rs2data(rs2data));

    //条件分支
    wire [31:0] sum, rs1b, rs2b;
    wire overflow, zero, Condition, PCSrc;
    assign rs1b = Branch ?  rs1 : 32'b0;
    assign rs2b = Branch ? ~rs2 : 32'b0;
    Adder_32 Comparator (.a(rs1b), .b(rs2b), .sub(Branch), .sum(sum), .overflow(overflow), .zeroflag(zero));
    assign Condition <=  (((Instruction[14:12]==0) &  zero)                 //等于0
                        | ((Instruction[14:12]==1) & ~zero)                 //不等于0
                        | ((Instruction[14:12]==4) &  (sum[31]^overflow))   //小于
                        | ((Instruction[14:12]==5) & ~(sum[31]^overflow))   //大于等于
                        | ((Instruction[14:12]==6) &  overflow)             //无符号小于
                        | ((Instruction[14:12]==7) & ~overflow));           //无符号大于等于
    assign PCSrc = (Condition & Branch) | Jump;

    //立即数生成单元
    Immediate Immediate (.instruction(Instruction), .immediate(immediate));
endmodule