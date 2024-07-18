//执行
`include "ALU.v"
module EX (
    clk, clr,
    AddSrc,
    ALUSrc,
    rs1data,
    rs2data,
    immediate,
    func7,
    func3,
    ALUresult,
    BranchALU
);
    input clk, clr;
    input AddSrc, ALUSrc;
    input [31:0] rs1data, rs2data, immediate;
    input [6:0] func7;
    input [2:0] func3;

    output [31:0] SumAdd, ALUresult;
    output [2:0] BranchALU;

    wire [31:0] ALUrs2;

    Mux_2_32 Muxrs2 (.select(ALUSrc), .datain0(rs2data), .datain1(immediate), .dataout(ALUrs2));
    ALU ALU0 (.clr(clr), .rs1(rs1data), .rs2(ALUrs2), .func7(func7), .func3(func3),
        .result(ALUresult), .BranchALU(BranchALU));
endmodule