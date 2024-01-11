//控制模块
module Control (clk, opcode, compare, PCWrite, InstructionRead, Regwrite, Memorywrite, Mux_ALU_rs2, Branch);
    input clk;
    input [6:0] opcode;
    input [2:0] compare;
    output PCWrite, InstructionRead, Regwrite, Memorywrite, Mux_ALU_rs2, Branch;

    reg state;

    always @(posedge clk) begin
        case (state)
            0: state <= 1 ;
            1: state <= 0 ;
        endcase
    end

    assign InstructionRead = (state==0)?0:1;
    assign PCWrite = (state==1)?0:1;

    //根据操作码设置各部件控制信号
    always @(posedge clk)
    if (state) begin
        case (opcode)
            //R-type，算数逻辑计算
            7'b0110011: begin
                PCWrite <= 0;
                InstructionRead <= 0;
                Regwrite <= 1;
                Memorywrite <= 0;
                Mux_ALU_rs2 <= 1;
                Branch <= 0;
            end
            //I-type，算数逻辑计算
            7'b0010011:begin
                PCWrite <= 0;
                InstructionRead <= 0;
                Regwrite <= 1;
                Memorywrite <= 0;
                Mux_ALU_rs2 <= 0;
                Branch <= 0;
            end
            //I-type，Load，从数据RAM到寄存器组
            7'b0000011: begin
                PCWrite <= 0;
                InstructionRead <= 0;
                Regwrite <= 1;
                Memorywrite <= 0;
                Mux_ALU_rs2 <= 0;
                Branch <= 0;
            end
            //S-type，Store，从寄存器组到数据RMA
            7'b0100011: begin
                PCWrite <= 0;
                InstructionRead <= 0;
                Regwrite <= 1;
                Memorywrite <= 1;
                Mux_ALU_rs2 <= 0;
                Branch <= 0;
            end
            7'b1100011:begin
                PCWrite <= 0;
                InstructionRead <= 0;
                Regwrite <= 1;
                Memorywrite <= 1;
                Mux_ALU_rs2 <= 0;
                case (func3)
                    0: Branch <= compare[0];//相等
                    1: Branch <= ~compare[0];//不等
                    4: Branch <= compare[1];//小于
                    5: Branch <= compare[1] & compare[0];//小于等于
                    6: Branch <= compare[2];//无符号小于
                    7: Branch <= compare[2] & compare[0];//无符号小于等于
                endcase
            end
        endcase
    end
    else begin
        PCWrite <= 1;
        InstructionRead <= 1;
        Regwrite <= 0;
        Memorywrite <= 0;
        Mux_ALU_rs2 <= 0;
        Branch <= 0;
    end

endmodule