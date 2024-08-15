//访存转发
module Forwarding_MEM (
    MemRead,
    MemWrite,
    MEM_WB_rd,
    EX_MEM_rd,
    ForwardMem
);
    input MemRead, MemWrite;
    input [4:0] MEM_WB_rd, EX_MEM_rd;
    output reg ForwardMem;

    always @(*) begin
        if (MemRead & MemWrite & (MEM_WB_rd == EX_MEM_rd)) begin
            ForwardMem <= 1'b1; end //由先前的写回寄存器数据转发
        else begin ForwardMem <= 1'b0; end  //来自寄存器文件
    end
endmodule