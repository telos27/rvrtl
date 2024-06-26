//取指
`include "PC.v"
`include "RAM.v"
module IF (
    clk, clr,
    PCSrc,
    AddSum,
    PC, Instruction
);
    input clk, clr;
    input PCSrc;
    input [31:0] AddSum;

    output [31:0] PC, Instruction;

    wire [31:0] newPC, PCout, PCinc;

    Mux_2_32 MuxPC (.select(PCSrc), .datain0(PCinc), .datain1(AddSum), .dataout(newPC));

    PC PC0 (.clk(clk), .clr(clr), .newPC(newPC), .PCout(PC));

    Adder_32 Add (.a(PCout), .b(32'h4), .sub(), .sum(PCinc), .overflow(), .zeroflag());

    RAM InstructionMemory (.clk(clk), .clr(clr), .address(PC), .write(), .read(),
        .datain(), .dataout(Instruction));
endmodule