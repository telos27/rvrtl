//指令分解
module Decode (instruction, func3, func7, rd, rs1, rs2, imm);
    input [31:0]instruction;
    output [2:0] func3;
    output [6:0] func7;
    output [4:0] rd, rs1, rs2;
    output [31:0] imm;
    //按RISC-V指令集格式分解指令
    case (instruction[6:0])
        //R-type
        7'b0110011:begin
            assign rd = instruction[11:7];
            assign func3 = instruction[14:12];
            assign rs1 = instruction[19:15];
            assign rs2 = instruction[24:20];
            assign func7 = instruction[31:25];
        end
        //I-type
        7'b0010011, 7'b0000011,
        7'b1100111, 7'b1110011:begin
            assign rd = instruction[11:7];
            assign func3 = instruction[14:12];
            assign rs1 = instruction[19:15];
            assign imm = {20'b0,instruction[31:20]};
        end
        //S-type
        7'b0100011:begin
            assign func3 = instruction[14:12];
            assign rs1 = instruction[19:15];
            assign rs2 = instruction[24:20];
            assign imm = {20'b0,instruction[31:25],instruction[11:7]};
        end
        //B-type
        7'b1100011:begin
            assign func3 = instruction[14:12];;
            assign rs1 = instruction[19:15];
            assign rs2 = instruction[24:20];
            assign imm = {19'b0,instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
        end
        //U-type
        7'b1101111:begin
            assign rd = instruction[11:7];
            assign rs1 = instruction[19:15];
            assign rs2 = instruction[24:20];
            assign imm = {instruction[31:12],12'b0};
        end
        //J-type
        7'b0110111:begin
            assign rd = instruction[11:7];
            assign imm = {11'b0, instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
        end
        default: $display ("指令操作码不存在");
    endcase
endmodule
