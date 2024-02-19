//CPU
`include "PC.v"
`include "Immediate.v"
`include "Control.v"
`include "Register.v"
`include "Mux_4.v"
`include "ALU.v"
`include "RAM.v"

module CPU (clk, clr);
    input clk, clr;
    //数据线
    wire [31:0] PC, newPC, memoryaddress, nextPC, PCBranch;
    wire [31:0] memorydata, mux_writereg, immediate, rs1data, rs2data, mux_rs1, mux_rs2, dataout, ALU_result;
    wire [2:0] mux_func3, compare;
    //控制线
    wire PCWrite, IorD, MemoryWrite, MemoryRead, IRWrite, S_rs1, S_func3, S_PC, Branch;
    wire [1:0] S_rs2;
    //寄存器
    reg [31:0] InstReg, MemorydataReg, rs1Reg, rs2Reg, ALUOutReg;

    PC PC0 (.PCWrite(PCWrite), .clr(clr), .newpc(newPC), .pc(PC));

    Mux_2 Mux_MemoryAddress (.select(IorD), .datain0(PC), .datain1(ALUOut), .dataout(memoryaddress));

    RAM Memory (.address(memoryaddress), .clk(clk), .clr(clr), .write(MemoryWrite), .read(MemoryRead),
        .datain(rs2Reg), .dataout(memorydata));

    always @(MemoryRead) begin
        if (MemoryRead) begin
            InstReg <= memorydata;
            MemorydataReg <= memorydata;
        end
    end

    Mux_2 Mux_MemtoReg (.select(MemtoReg), .datain0(ALUOutReg), .datain1(MemorydataReg), .dataout(mux_writereg));
    Register Register0 (.clk(clk), .write(Regwrite), .rd(MemorydataReg[11:7]), .rs1(MemorydataReg[19:15]),
        .rs2(MemorydataReg[24:20]), .rddata(mux_writereg), .rs1data(rs1data), .rs2data(rs2data));
    Immediate Immediate0 (.instruction(InstReg), .immediate(immediate));

    always @(posedge clk) begin
        rs1Reg <= rs1data;
        rs2Reg <= rs2data;
    end

    Mux_2 Mux_ALU_rs1 (.select(S_rs1), .datain0(PC), .datain1(rs1Reg), .dataout(mux_rs1));
    Mux_4 Mux_ALU_rs2 (.select(S_rs2), .datain0(rs2Reg), .datain1(32'h4), .datain2(immediate), 
        .dataout(mux_rs2));
    Mux_2 Mux_func3 (.select(S_func3), .datain0(3'b0), .datain1(InstReg[14:12]), .dataout(mux_func3));
    Mux_2 Mux_sub (.select(S_sub), .datain0(1'b1), .datain1(InstReg[30]), .dataout(mux_sub));

    ALU ALU0 (.rs1(mux_rs1), .rs2(mux_rs2), .sub(mux_sub), .func3(mux_func3),
        .result(ALU_result), .compare(compare));

    always @(posedge clk) begin
        ALUOutReg <= ALU_result;
    end

    Mux_2 Mux_PC (.select(S_PC), .datain0(ALU_result), .datain1(ALUOutReg), .dataout(newPC));

    Control Control0 (.clk(clk), .opcode(instruction[6:0]), .PCWrite(PCWrite),
        .MemoryWrite(MemoryWrite), .MemoryRead(MemoryRead), .IRWrite(IRWrite), .Memorydata(Memorydata),
        .S_rs1(S_rs1), .S_rs2(S_rs2), .S_func3(S_func3), .S_PC(S_PC), .Branch(Branch));
endmodule