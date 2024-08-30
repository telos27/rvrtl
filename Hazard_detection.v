//冒险检测单元
module Hazard_detection (ID_EX_MemRead, ID_EX_rd, IF_ID_rs1, IF_ID_rs2, PCWrite, IF_ID_Write, Nop);
    input ID_EX_MemRead, ID_EX_rd, IF_ID_rs1, IF_ID_rs2;
    output PCWrite, IF_ID_Write, Nop;

    always @(*) begin
        if (ID_EX_MemRead & ((ID_EX_rd == IF_ID_rs1) | (ID_EX_rd == IF_ID_Rs2))) begin
            PCWrite     <= 1'b0;
            IF_ID_Write <= 1'b0;
            Nop         <= 1'b1;
        end
        else begin
            PCWrite     <= 1'b1;
            IF_ID_Write <= 1'b1;
            Nop         <= 1'b0;
        end
    end
endmodule