//CPU
`include "PC.v"
`include "Immediate.v"
`include "Control.v"
`include "BHW.v"
`include "Register.v"
`include "Mux_2_1.v"
`include "Mux_2_3.v"
`include "Mux_4_1.v"
`include "Mux_4_32.v"
`include "ALU.v"
`include "RAM.v"

module CPU (clk, clr);
    input clk, clr;
    //数据线
    wire [31:0] PC, newPC, memoryaddress, nextPC, PCBranch, mux_BHW, BHW_data;
    wire [31:0] memorydata, mux_writereg, immediate, rs1data, rs2data, mux_rs1, mux_rs2, dataout, ALU_result;
    wire [2:0] mux_func3, compare;
    //控制线
    wire PCWrite, IorD, MemoryWrite, IRWrite, RegFetch, RegWrite;
    wire S_rs1, S_func3, ALUOutRegWrite, S_PC, PCWriteCond;
    wire [1:0] S_rs2, S_sub, S_rd;
    //寄存器
    reg [31:0] InstReg, rs1Reg, rs2Reg, ALUOutReg;
    //分支控制信号和程序计数器
    assign PCWriteF = PCWriteCond | PCWrite;
    PC PC0 (.clk(clk) , .PCWrite(PCWriteF), .clr(clr), .newpc(newPC), .pc(PC));
    //内存
    Mux_2_32 Mux_MemoryAddress (.select(IorD), .datain0(PC), .datain1(ALUOutReg), .dataout(memoryaddress));
    RAM Memory (.address(memoryaddress), .clk(clk), .clr(clr), .write(MemoryWrite), .datain(rs2Reg),
        .dataout(memorydata));
    //临时寄存器
    always @(posedge clk) begin
        if (IRWrite) begin
            InstReg <= memorydata;
        end
        if (RegFetch) begin
            rs1Reg <= rs1data;
            rs2Reg <= rs2data;
        end
        if (ALUOutRegWrite) begin
            ALUOutReg <= ALU_result;
        end
    end
    //字节、半字、字控制模块
    Mux_2_32 Mux_BHW(.select(InstReg[6]), .datain0(memorydata), .datain1(rs2Reg), .dataout(mux_BHW));
    BHW BHW0 (.func3(InstReg[14:12]), .datain(mux_BHW), .dataout(BHW_data));
    //寄存器组
    Mux_4_32 Mux_S_rd (.select(S_rd), .datain0(ALUOutReg), .datain1(memorydata), .datain2(immediate),
        .dataout(mux_writereg));
    Register Register0 (.clk(clk), .write(RegWrite), .rd(memorydata[11:7]), .rs1(memorydata[19:15]),
        .rs2(memorydata[24:20]), .rddata(mux_writereg), .rs1data(rs1data), .rs2data(rs2data));
    Immediate Immediate0 (.instruction(InstReg), .immediate(immediate));
    //信号选择器
    Mux_2_32 Mux_ALU_rs1 (.select(S_rs1), .datain0(PC), .datain1(rs1Reg), .dataout(mux_rs1));
    Mux_4_32 Mux_ALU_rs2 (.select(S_rs2), .datain0(rs2Reg), .datain1(32'h4), .datain2(immediate),
        .dataout(mux_rs2));
    Mux_2_3 Mux_func3 (.select(S_func3), .datain0(3'b0), .datain1(InstReg[14:12]), .dataout(mux_func3));
    Mux_4_1 Mux_sub (.select(S_sub), .datain0(1'b0), .datain1(InstReg[30]), .datain2(1'b1),
        .dataout(mux_sub));
    //算术逻辑运算单元
    ALU ALU0 (.clr(clr),.rs1(mux_rs1), .rs2(mux_rs2), .sub(mux_sub), .func3(mux_func3),
        .result(ALU_result), .compare(compare));
    //分支选择器
    Mux_2_32 Mux_PC (.select(S_PC), .datain0(ALU_result), .datain1(ALUOutReg), .dataout(newPC));

    Control Control0 (.clk(clk), .clr(clr), .opcode(InstReg[6:0]), .func3(InstReg[14:12]), .compare(compare),
    .PCWrite(PCWrite), .IorD(IorD), .MemoryWrite(MemoryWrite), .IRWrite(IRWrite), .RegFetch(RegFetch),
    .S_rd(S_rd),.RegWrite(RegWrite), .S_rs1(S_rs1), .S_rs2(S_rs2), .S_func3(S_func3), .S_sub(S_sub),
    .ALUOutRegWrite(ALUOutRegWrite), .S_PC(S_PC), .PCWriteCond(PCWriteCond));
endmodule