//控制模块
module Control (clk, opcode, PCWrite, InstructionRead, Regwrite, Memorywrite, Mux_ALU_rs2, Branch);
    input clk;
    input [6:0] opcode;
    output reg Regwrite, Memorywrite, Mux_ALU_rs2, Branch;
    output PCWrite, InstructionRead;

    reg state;

    always @(posedge clk) begin
        case (state)
            1'b0: state <= 1'b1 ;
            1'b1: state <= 1'b0 ;
        endcase
    end

    assign InstructionRead = (state==0)?1'b0:1'b1;
    assign PCWrite = (state==1)?1'b0:1'b1;

    //根据操作码设置各部件控制信号
    always @(posedge clk)
    case (opcode)
        //寄存器算数逻辑运算：读内存，写寄存器，ALU_b端口为寄存器输入，没有分支
        7'b0110011: begin
            Regwrite <= 1'b1 & (state==1'b1);
            Memorywrite <= 1'b0;
            Mux_ALU_rs2 <= 1'b1;
            Branch <= 1'b0;
        end
        //立即数算数逻辑运算：读内存，写寄存器，ALU_b端口为立即数输入，没有分支
        7'b0010011:begin
            Regwrite <= 1'b1 & (state==1'b1);
            Memorywrite <= 1'b0;
            Mux_ALU_rs2 <= 1'b0;
            Branch <= 1'b0;
        end
        //加载内存数据到寄存器：读内存，写寄存器，ALU_b端口为立即数输入，没有分支
        7'b0000011: begin
            Regwrite <= 1'b1 & (state==1'b1);
            Memorywrite <= 1'b0;
            Mux_ALU_rs2 <= 1'b0;
            Branch <= 1'b0;
        end
        //存储寄存器数据到内存：读寄存器，写内存，ALU_b端口为立即数输入，没有分支
        7'b0100011: begin
            Regwrite <= 1'b1 & (state==1'b1);
            Memorywrite <= 1'b0;
            Mux_ALU_rs2 <= 1'b0;
            Branch <= 1'b0;
        end
        // 7'b1100011: begin
        //     sub <= 1'b1;
        // end
    endcase
endmodule
