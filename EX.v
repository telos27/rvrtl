//执行
`include "ALU.v"
module EX (
    clk, clr,
    AddSrc, ALUSrc,
    PCin,
    rs1, rs2, immediate,
    func7, func3,
    AddSum, ALUresult, ALUflag
);
    input clk, clr;
    input AddSrc, ALUSrc;
    input [31:0] PCin, rs1, rs2, immediate;
    input [6:0] func7;
    input [2:0] func3;

    output [31:0] AddSum, ALUresult;
    output [2:0] ALUflag;

    wire [31:0] Addb, ALUrs2, flag;

    Mux_2_32 MuxAdd (.select(AddSrc), .datain0(PCinc), .datain1(rs1), .dataout(Addb));
    
    Adder_32 AddSum (.a(PCin), .b(Addb), .sub(), .sum(AddSum), .overflow(), .zeroflag());

    Mux_2_32 Muxrs2 (.select(ALUSrc), .datain0(rs2), .datain1(immediate), .dataout(ALUrs2));

    ALU ALU0 (.clr(clr), .rs1(rs1), .rs2(ALUrs2), .func7(func7), .func3(func3),
        .result(ALUresult), .flag(flag));
endmodule