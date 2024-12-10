//取指
`include "PC.v"
`include "RAM.v"
module IF (
    clk, clr,
    PCSrc,
    PCWrite,
    AddSum,
    PC,
    Instruction
);
    input clk, clr;
    input PCSrc, PCWrite;
    input [31:0] AddSum;

    output [31:0] PC, Instruction;

    wire [31:0] nextPC, PCout, PCinc;

    assign nextPC = PCSrc ? AddSum : PCinc;
    //程序计数器
    PC PC0 (.clk(clk), .clr(clr), .PCWrite(PCWrite), .nextPC(nextPC), .PCout(PC));
    //PC+4
    Adder_32 Addinc (.a(PCout), .b(32'h4), .sub(), .sum(PCinc), .overflow(), .zeroflag());
    //指令内存
    RAM InstructionMemory (.clk(clk), .address(PC), .write_enable(), .read_enable(),
        .data_in(), .data_out(Instruction));
endmodule