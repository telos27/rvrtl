//执行
`include "ALU.v"
`include "Mux_4_32.v"
module EX (
    clk, clr,
    ALUSrc,
    WriteRegister,
    priorALUresult,
    ForwardA,
    ForwardB,
    rs1data,
    rs2data,
    immediate,
    func7,
    func3,
    ALUresult,
    BranchALU
);
    input clk, clr;
    input ALUSrc;
    input [1:0] ForwardA, ForwardB;
    input [31:0] rs1data, rs2data, immediate;
    input [31:0] WriteRegister, priorALUresult;
    input [6:0] func7;
    input [2:0] func3;

    output [31:0] ALUresult;
    output BranchALU;
    output [1:0] forwardA, forwardB;

    wire [31:0] ALUrs1, ALUrs2f, ALUrs2;

    Mux_4_32 MuxForwardA (.select(ForwardA), .datain0(rs1data), .datain1(WriteRegister),
                        .datain2(priorALUresult), .datain3(), .dataout(ALUrs1));
    Mux_4_32 MuxForwardB (.select(ForwardB), .datain0(rs2data), .datain1(WriteRegister),
                        .datain2(priorALUresult), .datain3(), .dataout(ALUrs2f));

    assign ALUrs2 = ALUSrc ? immediate : ALUrs2f;
    ALU ALU0 (.clr(clr), .rs1(ALUrs1), .rs2(ALUrs2), .func7(func7), .func3(func3),
            .result(ALUresult), .BranchALU(BranchALU));
endmodule