//控制模块
module Control (clk, clr, opcode, func3, compare,
    PCWrite, IorD, MemoryWrite, IRWrite, RegFetch, S_rd, RegWrite,
    S_rs1, S_rs2, S_func3, S_sub, ALUOutRegWrite, S_PC, PCWriteCond);
    input clk, clr;
    input [6:0] opcode;
    input [2:0] func3, compare;
    output  PCWrite, IorD, MemoryWrite, IRWrite, RegFetch, RegWrite;
    output  S_rs1, S_func3, ALUOutRegWrite, S_PC, PCWriteCond;
    output  [1:0] S_rs2, S_sub, S_rd;

    reg [1:0] state;

    always @(posedge clk) begin
        case (state)
            0: state <= 1;
            1: state <= 2;
            2: state <= 3;
            3: state <= 0;
        endcase
    end

    assign PCWrite = !clr & ((state==0) | (state==2) & (opcode==7'b1101111 | 7'b1100111));

    assign IorD = !clr & (state==3) & (opcode==(7'b0000011 | 7'b0100011));

    assign MemoryWrite = !clr & (state==3) & (opcode==7'b0100011);

    assign IRWrite = !clr & (state==0);

    assign RegFetch = !clr & (state==1);

    assign S_rd[0] = !clr & (state==3) & (opcode==7'b0000011);
    assign S_rd[1] = !clr & (state==2) & (opcode==(7'b0110111 | 7'b0010111));

    assign RegWrite = !clr & ((state==3) & (opcode==(7'b0110011 | 7'b0010011)) |
        (state==1) & (opcode==(7'b1101111 | 7'b1100111)) |
        (state==2) & (opcode==7'b0010111));

    assign S_rs1 = !clr & ((state==2) & (opcode==(7'b0110011 | 7'b0010011 | 7'b1100011)) |
        (state==2) & (opcode==7'b1100111));

    assign S_rs2[0] = !clr & (state==0);
    assign S_rs2[1] = !clr & (((state==1) |
        (state==2) & (opcode==(7'b0010011 | 7'b0000011 | 7'b0100011 | 7'b1100111))));

    assign S_func3 = !clr & (state==3) & (opcode==(7'b0110011 | 7'b0010011));

    assign S_sub[0] = !clr & (state==3) & (opcode==(7'b0110011 | 7'b0010011));
    assign S_sub[1] = !clr & (state==3) & (opcode==7'b1100011);

    assign ALUOutRegWrite = !clr & ((state==1) |
        (state==2) & (opcode==(7'b0110011 | 7'b0010011 | 7'b0000011 | 7'b0100011)));

    assign S_PC = !clr & (state==2) & (opcode==7'b1101111 | 7'b1100111);

    assign PCWriteCond = !clr & (state==2) & (opcode==7'b1100011) &
        ((func3==0) & (compare==0) | (func3==1) & (compare==1) |
         (func3==4) & (compare==0) | (func3==5) & (compare==2) |
         (func3==6) & (compare==0) | (func3==7) & (compare==4));
    
    /*case (opcode)
        0110011: begin  //R-type，arithmetic logic operation，算术逻辑运算
            assign PCWrite = !clr & state==0;
            assign IorD = 0;
            assign MemoryWrite = 0;
            assign MemoryRead = !clr & state==0;
            assign IRWrite = 0;
            assign ALUOutRegWrite = 0;
            assign S_rs1 = !clr & state!=0;
            assign S_rs2 = (!clr & (state==0)) ? 2'b01 : 2'b00;   // 2-bit
            assign Regwrite = !clr & (state==3);
            assign S_func3 = !clr & (state!=0) ;
            assign S_PC = !clr & (state==0);
            assign Branch = 0;
        end
        0010011: begin  //I-type，arithmetic logic operation，算术逻辑运算
            assign PCWrite = !clr & state==0;
            assign IorD = 0;
            assign MemoryWrite = 0;
            assign MemoryRead = !clr & state==0;
            assign IRWrite = 0;
            assign ALUOutRegWrite = 0;
            assign S_rs1 = !clr & state!=0;
            assign S_rs2 = (!clr & (state==0)) ? 2'b11 : 2'b00;
            assign Regwrite = !clr & (state==3);
            assign S_func3 = !clr & (state!=0) ;
            assign S_PC = !clr & (state==0);
            assign Branch = 0;
        end
        0000011: begin  //I-type，Load，加载
            
        end
        0100011: begin  //I-type，Store，存储
            
        end
        1100011: begin  //B-type，Branch，分支
            
        end
        1101111: begin  //J-type，Jump And Link，跳转和链接
            
        end
        1100111: begin  //J-type，Jump And Link，跳转和链接寄存器
            
        end
        0110111: begin  //U-type，Load Upper Imm，加载 Upper Imm
            
        end
        0010111: begin  //U-type，Add Upper Imm to PC，将 Upper Imm 添加到 PC
            
        end
        1110011: begin  //I-type，Environment Call and Environment Break，环境调用和环境中断
            
        end
    endcase*/
endmodule
