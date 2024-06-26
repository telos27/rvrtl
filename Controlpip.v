//流水线控制
module Controlpip (
    clr,
    opcode,
    RegWrite,
    ALUSrc, AddSrc,
    Branch, MemWrite, MemRead,
    MemtoReg
);
    input clr;
    input [6:0] opcode;
    output ALUSrc, AddSrc;
    output Branch, MemWrite, MemRead;
    output MemtoReg, RegWrite;

    assign ALUSrc = !clr & !(opcode == 7'b0110011);

    assign AddSrc = !clr & ((opcode == 7'b1101111) | (opcode == 7'b1100111));

    assign Branch = !clr & (opcode == 7'b1100011);

    assign MemWrite = !clr & (opcode == 7'b0100011);

    assign MemtoReg = !clr & (opcode == 7'b0000011);

    assign RegWrite = !clr & ((opcode == 7'b0110011) | (opcode == 7'b0010011) | (opcode == 7'b0000011));
endmodule