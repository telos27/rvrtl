//访存
module MEM (
    clk,
    MemWrite,
    MemRead,
    ForwardMem,
    priorMEMdata,
    ALUresult,
    rs2,
    readdata,
    func3
);
    input clk;
    input Branch, BranchALU, MemWrite, MemRead, ForwardMem;
    input [31:0] priorMEMdata, ALUresult, rs2;
    input [2:0] func3;

    output [31:0] readdata;

    wire [31:0] memdatain;
    assign memdatain = ForwardMem ? priorMEMdata : rs2;
    RAM DataMemory (.clk(clk), .address(ALUresult), .write_enable(MemWrite), .read_enable(MemRead),
        .data_in(memdatain), .data_out(readdata));
endmodule