//写回
module WB (
    MemtoReg,
    Readdata, ALUresult,
    Writeregister
);
    input MemtoReg;
    input [31:0] Readdata, ALUresult;

    output [31:0] Writeregister;

    assign WriteRegister = MemtoReg ? ALUresult : Readdata;
endmodule