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

    parameter ALUR   = 7'b0110011, ALUI   = 7'b0010011,
              load   = 7'b0000011, store  = 7'b0100011,
              branch = 7'b1100011, jal    = 7'b1101111,
              jalr   = 7'b1100111, lui    = 7'b0110111,
              auipc  = 7'b0010111, system = 7'b1110011;

    assign AddSrc   = !clr &  (opcode == jalr);     //地址计算立即数或寄存器选择

    assign ALUSrc   = !clr & !(opcode == ALUR);     //ALU rs2寄存器或立即数选择

    assign Branch   = !clr &  ((opcode == branch)
                             | (opcode == jal)
                             | (opcode == jalr));   //分支指令控制

    assign MemWrite = !clr &  (opcode == store);    //内存写控制

    assign MemRead  = !clr &  (opcode == load);     //内存读控制

    assign MemtoReg = !clr &  (opcode == load);     //寄存器写 ALU 结果或内存数据选择

    assign RegWrite = !clr &  ((opcode == ALUR)
                             | (opcode == ALUI)
                             | (opcode == load));   //寄存器写控制
endmodule