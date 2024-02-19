//控制模块
module Control (clk, clr , opcode, func3, compare,
    PCWrite, MemoryWrite, MemoryRead, IRWrite, S_rs1, S_rs2, S_func3, S_PC, Branch);
    input clk, clr;
    input [6:0] opcode;
    input [2:0] func3, compare;
    output PCWrite, MemoryWrite, MemoryRead, IRWrite , S_rs1 ;
    output [1:0] S_rs2;
    output S_func3 , S_PC , Branch ;

    reg [2:0] state = 0;

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
    end
    
    always @(posedge clk) begin
        case (state)
            0: state <= 1;
            1: state <= 2;
            2: state <= 3;
            3: state <= 4;
            4: state <= 0;
        endcase
    end
    
    always @(posedge clk) begin
        case (opcode)
            0110011:begin
                PCWrite <= 0 & (state == 0);
                IorD <= 0 & (state == 1);
                MemoryWrite <= 0;
                MemoryRead <= 1;
                IRWrite <= 0 & (state == 2);
                S_rs1 <= 0;
                S_rs2 <= 0;
                S_func3 <= 1;
                S_PC <= 0;
                Branch <=0;
            end
            0010011:begin
                PCWrite <= 0 & (state == 0);
                IorD <= 0 & (state == 1);
                MemoryWrite <= 0;
                MemoryRead <= 1;
                IRWrite <= 0 & (state == 2);
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
endmodule
