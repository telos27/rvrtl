//控制模块
module Control (clk, clr, opcode, func3, compare,
    PCWrite, IorD, MemoryWrite, MemoryRead, IRWrite, ALUOutRegWrite,
    S_rs1, S_rs2, Regwrite, S_func3, S_PC, Branch);
    input clk, clr;
    input [6:0] opcode;
    input [2:0] func3, compare;
    output  PCWrite, IorD, MemoryWrite, MemoryRead, IRWrite, ALUOutRegWrite;
    output  S_rs1, Regwrite, S_func3, S_PC, Branch;
    output  [1:0] S_rs2;

    reg [2:0] state;

    assign PCWrite = !clr & state==0;

    assign IorD = 0 ;

    assign MemoryWrite = 0 ;

    assign MemoryRead = !clr & state==0 ;

    assign IRWrite = 0 ;

    assign ALUOutRegWrite = 0 ;

    assign S_rs1 = !clr & state!=0 ;

    assign S_rs2 = !clr & (state==0);   // 2-bit

    assign Regwrite = !clr & (state==3);

    assign S_func3 = !clr & (state!=0) ;

    assign S_PC = !clr & (state==0);

    assign Branch = 0 ;


    /*

    always @(posedge clk) begin
        if (clr == 1) begin
            state = 0;
            assign PCWrite = 0;
            IorD <= 0;
            MemoryWrite <= 0;
            MemoryRead <= 0;
            IRWrite <= 0;
            ALUOutRegWrite <= 0;
            S_rs1 <= 0;
            S_rs2 <= 0;
            Regwrite <= 0;
            S_func3 <= 0;
            S_PC <= 0;
            Branch <=0;
        end
    end
    */
    always @(posedge clk) begin
        if (clr) 
            state <= 0 ;
        else
        case (state)
            0: state <= 1;
            1: state <= 2;
            2: state <= 3;
            3: state <= 4;
            4: state <= 0;
        endcase
    end
    /*
    always @(posedge clk) begin
        case (state)
            0: begin
                assign PCWrite = 1;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 1;
                IRWrite <= 0;
                ALUOutRegWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 1;
                Regwrite <= 0;
                S_func3 <= 0;
                S_PC <= 1;
                Branch <=0;
            end
            1: begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 0;
                IRWrite <= 0;
                ALUOutRegWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 0;
                Regwrite <= 0;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end
            2: begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 0;
                IRWrite <= 0;
                ALUOutRegWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 0;
                Regwrite <= 0;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end
            3: begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 0;
                IRWrite <= 0;
                ALUOutRegWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 0;
                Regwrite <= 1;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end            
            4: begin
                PCWrite <= 0;
                IorD <= 0;
                MemoryWrite <= 0;
                MemoryRead <= 0;
                IRWrite <= 0;
                ALUOutRegWrite <= 0;
                S_rs1 <= 0;
                S_rs2 <= 0;
                Regwrite <= 0;
                S_func3 <= 0;
                S_PC <= 0;
                Branch <=0;
            end
        endcase
        
        case (opcode)
            //R-type，寄存器算术逻辑运算
            0110011:begin
                PCWrite <= 1 & (state == 0);
                IorD <= 0 & (state == 1);
                MemoryWrite <= 0;
                MemoryRead <= 1 & (state == 1);
                IRWrite <= 0 & (state == 4);
                ALUOutRegWrite <= (1 & (state == 1)) | (1 & (state == 2));
                S_rs1 <= (0 & (state == 0)) | (1 & (state == 2));
                S_rs2 <= (1 & (state == 0)) | (0 & (state == 2));
                Regwrite <= 1 & (state == 3);
                S_func3 <= (0 &(state == 0)) | (1 & (state == 2));
                S_PC <= 0;
                Branch <=0;
            end
            //I-type，立即数算术逻辑运算
            0010011:begin
                PCWrite <= 1 & (state == 0);
                IorD <= 0 & (state == 1);
                MemoryWrite <= 0;
                MemoryRead <= 1 & (state == 1);
                IRWrite <= 0 & (state == 2);
                ALUOutRegWrite <= 1 & (state == 1) | (1 & (state == 2));
                S_rs1 <= (0 & (state == 0)) | (1 & (state == 2));
                S_rs2 <= (1 & (state == 0)) | (2 & (state == 2));
                Regwrite <= 1 & (state == 3);
                S_func3 <= (0 &(state == 0)) | (1 & (state == 2));
                S_PC <= 0;
                Branch <=0;
            end
            //I-type，Load
            0000011:begin

            end
            //I-type，Store
            0100011:begin
                
            end
            //B-type，Branch
            1100011:begin
                
            end
            //J-type，Jump And Link
            1101111:begin
                
            end
            //I-type，Jump And Link Reg
            1100111:begin
                
            end
            //U-type，Load Upper Imm
            0110111:begin
                
            end
            //U-type，Add Upper Imm to PC
            0010111:begin
                
            end
            //I-type，Environment Call & Break
            1110011:begin
                
            end
        endcase
        */
//    end
endmodule
