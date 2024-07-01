//流水线控制
module Controlpip (
    clr,
    opcode,
    ALUSrc, AddSrc,
    Branch, MemWrite, MemRead,
    MemtoReg, RegWrite
);
    input clr;
    input [6:0] opcode;
    
    output ALUSrc, AddSrc;
    output Branch, MemWrite, MemRead;
    output MemtoReg, RegWrite;

    parameter ALUR   = 7'b0110011, ALUI   = 7'b0010011, load  = 7'b0000011,
              store  = 7'b0100011, branch = 7'b1100011, jal   = 7'b1101111,
              jalr   = 7'b1100111, lui    = 7'b0110111, auipc = 7'b0010111,
              system = 7'b1110011;

    assign AddSrc   = !clr & (opcode == jalr);

    assign ALUSrc   = !clr & !(opcode == ALUR);

    assign Branch   = !clr & ((opcode == branch) | (opcode == jal) | (opcode == jalr));

    assign MemWrite = !clr & (opcode == store);

    assign MemRead  = !clr & (opcode == load);

    assign MemtoReg = !clr & (opcode == load);

    assign RegWrite = !clr & ((opcode == ALUR) | (opcode == ALUI) | (opcode == load));
endmodule