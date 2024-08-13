//算数逻辑运算单元
`include "Mux_2_32.v"
`include "Adder_32.v"
`include "Shifter_32.v"
`include "Multiplier.v"
module ALU (clr, rs1, rs2, func7, func3, result, BranchALU);
    input [31:0] rs1, rs2;
    input clr;
    input [6:0] func7;
    input [2:0] func3;
    output reg [31:0] result;
    output reg [2:0] BranchALU;

    wire [31:0] rs1_as, rs2_as, rs1_mu, rs2_mu, rs1_di, rs2_di, rs1_sh;
    wire [4:0]  rs2_sh;
    assign rs1_as = (~func7[0]&((func3==0)|(func3==2)|(func3==3))) ? rs1 : 32'h0;
    assign rs2_as = (~func7[0]&((func3==0)|(func3==2)|(func3==3))) ? rs2 : 32'h0;
    assign rs1_mu = ( func7[0]&~func3[2]) ? rs1 : 32'h0;
    assign rs2_mu = ( func7[0]&~func3[2]) ? rs2 : 32'h0;
    assign rs1_di = ( func7[0]& func3[2]) ? rs1 : 32'h0;
    assign rs2_di = ( func7[0]& func3[2]) ? rs2 : 32'hffff_ffff;
    assign rs1_sh = (~func7[0]&((func3==1)|(func3==5))) ? rs1 : 32'h0;
    assign rs2_sh = (~func7[0]&((func3==1)|(func3==5))) ? rs2[4:0] : 4'h0;

    //加减法
    wire [31:0] rs2_as_in;
    wire overflow;
    assign rs2_as_in = func7[5] ? ~rs2_as : rs2_as;
    Adder_32 Adder (.a(rs1_as), .b(rs2_as_in), .sub((func7[5]|func3[1])), .sum(sum), .overflow(overflow), .zeroflag(zero));

    wire [63:0] product;
    //乘法
    Multiplier Multiplier (.a(rs1_mu), .b(rs2_mu), .sign(func3[1]), .prod(product), .overflow(overflow));

    wire [31:0] quotient, remainder;
    //除法
    Division Division (.a(rs1_di), .b(rs2_di), .sign(func3[0]), .quotient(quotient), .remainder(remainder));

    wire [31:0] shiftresult;
    //移位
    Shifter_32 shifter32 (.shift5(rs2_sh), .datain(rs1_sh), .right(func3==5), .sra(func7[5]), .dataout(shiftresult));

    assign slt = sum[31]^overflow;
    //ALU输出
    always @(*) begin
        if (clr) begin
            result <= 32'b0;
        end
        else if (func7[0]) begin
            case (func3)
            0: result <= sum;                   //有符号乘法低位结果
            1: result <= shiftresult;           //有符号乘法高位结果
            2: result <= slt?32'b1:32'b0;       //
            3: result <= overflow?32'b1:32'b0;  //无符号小于置1
            4: result <= rs1 ^ rs2;             //逻辑异或
            5: result <= shiftresult;           //右移
            6: result <= rs1 | rs2;             //逻辑或
            7: result <= rs1 & rs2;             //逻辑与
            default: result <= 32'b0;
            endcase
        end
        else begin
            case (func3)
            0: result <= sum;                   //算数结果
            1: result <= shiftresult;           //左移
            2: result <= slt?32'b1:32'b0;       //小于置1
            3: result <= overflow?32'b1:32'b0;  //无符号小于置1
            4: result <= rs1 ^ rs2;             //逻辑异或
            5: result <= shiftresult;           //右移
            6: result <= rs1 | rs2;             //逻辑或
            7: result <= rs1 & rs2;             //逻辑与
            default: result <= 32'b0;
            endcase
        end
        //设置标志位
        BranchALU <=  ((func3==0) & zero)       //等于0
                    | ((func3==1) & ~zero)      //不等于0
                    | ((func3==4) & slt)        //小于
                    | ((func3==5) & ~slt)       //大于等于
                    | ((func3==6) & overflow)   //无符号小于
                    | ((func3==7) & ~overflow); //无符号大于等于
    end
endmodule