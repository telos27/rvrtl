//控制模块
module Control (opcode, Regwrite, Memorywrite, Mux_ALU_b);
    input [6:0] opcode;
    output Regwrite, Memorywrite;

    case (opcode)
        //读内存，写寄存器，ALU_b端口为寄存器输入
        7'b0110011: begin
            Regwrite <= 1'b1;
            Memorywrite <= 1'b0;
            Mux_ALU_b <= 1'b1;
        end
        //读内存，写寄存器，ALU端口为立即数输入
        7'b0010011:
        7'b0000011: begin
            Regwrite <= 1'b1;
            Memorywrite <= 1'b0;
            Mux_ALU_b <= 1'b0;
        end
        //读寄存，器写内存
        7'b0100011: begin
            Regwrite <= 0'b1;
            Memorywrite <= 1'b0;
            Mux_ALU_b <= 1'b0;
        end
    endcase
endmodule
