//CPU
`include "PC.v"
`include "Immediate.v"
`include "Control.v"
`include "Register.v"
`include "ALU.v"
`include "RAM.v"

module CPU (clk, clr);
    input clk, clr;
    wire [31:0] PC, newPC, nextPC, PCBranch;
    wire [31:0] instruction, immediate, rs1data, rs2data, mux_rs2, dataout, ALU_result;
    wire PCWrite, InstructionRead, Regwrite, Memorywrite, rs2_s, Branch, overflow, readdata;
    wire [2:0] compare;

    PC PC0 (.PCWrite(PCWrite), .clr(clr), .newpc(newPC), .pc(PC));

    Adder_32 AdderPC (.a(PC), .b(32'h4), .sub(), .sum(nextPC), .overflow(), .zeroflag());

    Adder_32 AdderPCBranch (.a(PC), .b(immediate), .sub(), .sum(PCBranch), .overflow(), .zeroflag());

    Mux Mux_PC (.select(Branch), .datain0(nextPC), .datain1(PCBranch), .dataout(newPC));

    RAM RAM_Instruction (.address(PC), .clk(clk), .clr(clr), .write(), .read(InstructionRead),
        .datain(), .dataout(instruction));

    Immediate Immediate0 (.instruction(instruction), .immediate(immediate));

    Control Control0 (.opcode(instruction[6:0]), .PCWrite(PCWrite), .InstructionRead(InstructionRead),
        .compare(compare), .Regwrite(Regwrite), .Memorywrite(Memorywrite), .Mux_ALU_rs2(rs2_s), .Branch(Branch));

    Register Register0 (.clk(clk), .write(Regwrite), .rd(instruction[11:7]), .rs1(instruction[19:15]),
        .rs2(instruction[24:20]), .rddata(dataout), .rs1data(rs1data), .rs2data(rs2data));
        
    Mux Mux_ALU_rs2 (.select(rs2_s), .datain0(immediate), .datain1(rs2data), .dataout(mux_rs2));

    ALU ALU0 (.rs1(rs1data), .rs2(mux_rs2), .sub(instruction[30]), .func3(instruction[14:12]),
        .result(ALU_result), .compare(compare));

    RAM RAM_DATA (.address(ALU_result), .clk(clk), .clr(clr), .write(Memorywrite), .read(readdata),
        .datain(ALU_result), .dataout(dataout));
endmodule