//CPU
`include "PC.v"
`include "Adder_32.v"
`include "InstructionDecoder.v"
`include "Control.v"
`include "Register.v"
`include "ALU.v"
`include "RAM.v"
`include "Mux"
module CPU (clk,clr);
    input clk, clr;
    wire [31:0] PC, newPC, PCinc, PCBranch
    wire [31:0] instruction, immediate, rs1data, rs2data, mux_rs2, ALU_result;
    wire PCWrite, InstructionRead, Regwrite, Memorywrite, rs2_s, Branch, overflow;

    PC PC0 (.PCWrite(PCWrite), .clr(clr), .newpc(newPC), .pcout(PC));

    Adder_32 AdderPC (.a(PC), .b(3'b100), .sub(), .s(PCinc), .cout(), .zeroflag());

    Adder_32 AdderPCBranch (.a(PC), .b(immediate), .sub(), .s(PCBranch), .cout(), .zeroflag());

    Mux Mux_PC (.select(Branch), .datain0(PCinc), .datain1(PCBranch), .dataout(newPC));

    RAM RAM_Instruction (.address(PC), .write(), .clk(InstructionRead),
        .clr(clr),.datain(), .dataout(instruction));

    Immediate Immediate0 (.instruction(instruction), .immediate(immediate));

    Control Control0 (.opcode(instruction[6:0]), .PCWrite(PCWrite), .InstructionRead(InstructionRead),
        .Regwrite(Regwrite), .Memorywrite(Memorywrite), .Mux_ALU_rs2(rs2_s), .Branch(Branch));

    Register Register0 (.clk(clk), .write(Regwrite), .rd(instruction[11:7]), .rs1(instruction[19:15]),
        .rs2(instruction[24:20]), .rddata(dataout), .rs1data(rs1data), .rs2data(rs2data));
        
    Mux Mux_ALU_rs2 (.select(rs2_s), .datain0(rs2data), .datain1(immediate), .dataout(mux_rs2));

    ALU ALU0 (.rs1(rs1data), .rs2(mux_rs2), .sub(instruction[30]), .func3(instruction[14:12]),
        .result(ALU_result));

    RAM RAM_DATA (.address(ALU_result), .write(Memorywrite), .clk(clk), .clr(clr),
        .datain(result), .dataout(dataout));
endmodule