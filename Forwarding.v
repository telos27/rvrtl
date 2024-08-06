//转发单元
module Forwarding (
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
    output reg [1:0] FowardA, FowardB;

    always @(*) begin
        if (EX_MEM_RegWrite and (EX_MEM_rd != 0) and (EX_MEM_rd == ID_EX_rs1)) begin
            ForwardA <= 2'b10;
        end
        else if (MEM_WB_RegWrite and (MEM_WB_rd != 0)
            and !(EX_MEM_RegWrite and (EX_MEM_rd != 0) and EX_MEM_rd != ID_EX_rs1)
            and (MEM_WB_rd == ID/EX_rs1)) begin
            ForwardA <= 2'b01;
        end
        else begin  ForwardA <= 2'b00; end
        if (EX_MEM_RegWrite and (EX_MEM_rd != 0) and (EX_MEM_rd == ID_EX_rs2)) begin
            ForwardB <= 2'b10;
        end
        else if (MEM_WB_RegWrite and (MEM_WB_rd ≠ 0)
            and !(EX_MEM_RegWrite and (EX_MEM_rd != 0) and EX_MEM_rd != ID_EX_rs2)
            and (MEM_WB_rd = ID_EX_rs2)) begin
            ForwardB <= 2'b01;
        end
        else begin ForwardB = 2'b00; end
    end
endmodule