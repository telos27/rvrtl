//译码
`include "Register.v"
`include "Immediate.v"
module ID (
    clk, clr,
    AddSrc,
    RegWrite,
    Instruction,
    Writedata,
    rd,
    rs1data,
    rs2data,
    immediate,
    func7,
    func3
);
    input clk, clr;
    input AddSrc, RegWrite;
    input [31:0] Instruction, PCin, Writedata;
    input [4:0] rd;

    output [31:0] rs1data, rs2data, immediate;
    output [6:0] func7;
    output [2:0] func3;

    Mux_2_32 MuxAdd (.select(AddSrc), .datain0(PC), .datain1(rs1), .dataout(Addb));
    Adder_32 AddSum (.a(PC), .b(Addb), .sub(), .sum(SumAdd), .overflow(), .zeroflag());

    Register RegisterInt (.clk(clk), .clr(clr), .write(RegWrite),
        .rd(rd), .rs1(Instruction[19:15]), .rs2(Instruction[24:20]),
        .rddata(Writedata), .rs1data(rs1data), .rs2data(rs2data));

    Immediate Immediate0 (.instruction(Instruction), .immediate(immediate));
endmodule