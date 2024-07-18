//访存
module MEM (
    clk, clr,
    Branch,
    BranchALU,
    MemWrite,
    MemRead,
    ALUresult,
    rs2,
    Readdata
);
    input clk, clr;
    input Branch, BranchALU, MemWrite, MemRead;
    input [31:0] ALUresult, rs2;

    output [31:0] Readdata;

    //Branch
    assign PCSrc = Branch & BranchALU;

    RAM DataMemory (.clk(clk), .clr(clr), .address(ALUresult), .write(MemWrite), .read(MemRead),
        .datain(rs2), .dataout(Readdata));
endmodule