//执行转发
module Forwarding_EX (
    EX_MEM_RegWrite,
    MEM_WB_RegWrite,
    EX_MEM_rd,
    MEM_WB_rd,
    ID_EX_rs1,
    ID_EX_rs2,
    ForwardA,
    ForwardB
);
    input EX_MEM_RegWrite, MEM_WB_RegWrite;
    input [4:0] EX_MEM_rd, MEM_WB_rd, ID_EX_rs1, ID_EX_rs2;
    output reg [1:0] ForwardA, ForwardB;

    always @(*) begin
        //第一个 ALU 操作数
        if  (EX_MEM_RegWrite & (EX_MEM_rd != 0) & (EX_MEM_rd == ID_EX_rs1)) begin
            ForwardA <= 2'b10;  //由之前的 ALU 结果转发
            end
        else if  (MEM_WB_RegWrite & (MEM_WB_rd != 0)
            & ~(EX_MEM_RegWrite & (EX_MEM_rd != 0) & EX_MEM_rd == ID_EX_rs1)
            & (MEM_WB_rd == ID_EX_rs1)) begin ForwardA <= 2'b01; end //由数据存储器或先前的 ALU 结果转发
        else begin ForwardA <= 2'b00; end   //来自寄存器文件

        //第二个 ALU 操作数
        if  (EX_MEM_RegWrite
        & (EX_MEM_rd != 0)
        & (EX_MEM_rd == ID_EX_rs2)) begin ForwardB <= 2'b10; end  //由之前的 ALU 结果转发
        else if  (MEM_WB_RegWrite & (MEM_WB_rd != 0)
            & ~(EX_MEM_RegWrite & (EX_MEM_rd != 0) & EX_MEM_rd == ID_EX_rs2)
            & (MEM_WB_rd == ID_EX_rs2)) begin ForwardB <= 2'b01; end  //由数据存储器或先前的 ALU 结果转发
        else begin ForwardB <= 2'b00; end   //来自寄存器文件
    end
endmodule