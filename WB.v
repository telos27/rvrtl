//写回
module WB (
    MemtoReg,
    Readdata, ALUresult,
    Writeregister
);
    input MemtoReg;
    input [31:0] Readdata, ALUresult;

    output [31:0] Writeregister;

    Mux_2_32 MuxMemReg (.select(MemtoReg), .datain0(ALUresult), .datain1(Readdata), .dataout(Writeregister));
endmodule