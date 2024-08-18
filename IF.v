//取指
`include "PC.v"
`include "RAM.v"
module IF (
    clk, clr,
    PCSrc,
    AddSum,
    PC,
    Instruction
);
    input clk, clr;
    input PCSrc;
    input [31:0] AddSum;

    output [31:0] PC, Instruction;

    wire [31:0] nextPC, PCout, PCinc;

    assign nextPC = PCSrc ? AddSum : PCinc;

    PC PC0 (.clk(clk), .clr(clr), .nextPC(nextPC), .PCout(PC));

    Adder_32 Add (.a(PCout), .b(32'h4), .sub(), .sum(PCinc), .overflow(), .zeroflag());

    RAM InstructionMemory (.clk(clk), .address(PC), .write_enable(), .read_enable(),
        .data_in(), .data_out(Instruction));
endmodule