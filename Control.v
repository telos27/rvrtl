//控制模块
module Control (clk, clr opcode, func3, compare,
    PCWrite, IorD, MemoryWrite, MemoryRead, IRWrite, S_rs1, S_rs2, S_func3, S_PC, Branch);
    input clk, clr;
    input [6:0] opcode;
    input [2:0] func3, compare;
    output PCWrite, InstructionRead, Regwrite, Memorywrite, Mux_ALU_rs2, Branch;
    output [1:0] S_rs2;

    reg [3:0] state = 0;

    always @(posedge clk) begin
        if (clr == 1) begin
            PCWrite <= 0;
            IorD <= 0;
            MemoryWrite <= 0;
            MemoryRead <= 0;
            IRWrite <= 0;
            S_rs1 <= 0;
            S_rs2 <= 0;
            S_func3 <= 0;
            S_PC <= 0;
            Branch <=0;
        end
        case (state)
            0: state <= 1;
            1: state <= 2;
            2: state <= 3:
            3: state <= 4;
            4: state <= 0;
        endcase
        case (state)
            0:begin
                PCWrite <= 1;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 1;
                IRWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 1;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end
            1:begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 1;
                IRWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 2;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end
            2:begin
                case (opcode)
                    0110011:begin
                        PCWrite <= 0;
                        IorD <= 0;
                        MemoryWrite <= 0;
                        MemoryRead <= 1;
                        IRWrite <= 0;
                        S_rs1 <= 0;
                        S_rs2 <= 0;
                        S_func3 <= 1;
                        S_PC <= 0;
                        Branch <=0;
                    end
                    0010011:begin
                        PCWrite <= 0;
                        IorD <= 0;
                        MemoryWrite <= 0;
                        MemoryRead <= 1;
                        IRWrite <= 0;
                        S_rs1 <= 0;
                        S_rs2 <= 2;
                        S_func3 <= 1;
                        S_PC <= 0;
                        Branch <=0;
                    end
                    0000011:begin
                        
                    end
                    0100011:begin
                        
                    end
                    1100011:begin
                        
                    end
                    1101111:begin
                        
                    end
                    1100111:begin
                        
                    end
                    0110111:begin
                        
                    end
                    0010111:begin
                        
                    end
                    1110011:begin
                        
                    end
                endcase
            end
            3:begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 0;
                IRWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 0;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end
            4:begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 0;
                IRWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 0;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0; 
            end
        endcase
    end
endmodule