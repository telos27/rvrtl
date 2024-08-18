//算数逻辑运算单元
`include "Adder_32.v"
`include "Shifter_32.v"
`include "Multiplier.v"
`include "Divider.v"
module ALU (clr, rs1, rs2, func7, branch, func3, result, BranchALU);
    input [31:0] rs1;           //操作数1
    input [31:0] rs2;           //操作数2
    input clr;                  //清零
    input branch;               //分支条件判断
    input [6:0] func7;          //7位功能码
    input [2:0] func3;             //3位功能码
    output reg [31:0] result;   //结果输出
    output reg BranchALU;       //分支信号输出

    wire overflow;

    //各计算模块输入有效控制
    wire [31:0] rs1_as, rs2_as, rs1_mu, rs2_mu, rs1_di, rs2_di, rs1_sh;
    wire [4:0]  rs2_sh;
    assign rs1_as = (~func7[0] & ((func3==0)|(func3==2)|(func3==3)) &  branch) ? rs1      : 32'h0;        //加减操作数1
    assign rs2_as = (~func7[0] & ((func3==0)|(func3==2)|(func3==3)) &  branch) ? rs2      : 32'h0;        //加减操作数2
    assign rs1_mu = ( func7[0] &  ~func3[2]                   & ~branch) ? rs1      : 32'h0;        //乘法操作数1
    assign rs2_mu = ( func7[0] &  ~func3[2]                   & ~branch) ? rs2      : 32'h0;        //乘法操作数2
    assign rs1_di = ( func7[0] &   func3[2]                   & ~branch) ? rs1      : 32'h0;        //除法操作数1
    assign rs2_di = ( func7[0] &   func3[2]                   & ~branch) ? rs2      : 32'hffff_ffff;//除法操作数2
    assign rs1_sh = (~func7[0] & ((func3==1)|(func3==5))         & ~branch) ? rs1      : 32'h0;        //移位操作数1
    assign rs2_sh = (~func7[0] & ((func3==1)|(func3==5))         & ~branch) ? rs2[4:0] :  4'h0;        //移位操作数2

    //加减法
    wire [31:0] rs2_as_in, sum;
    assign rs2_as_in = func7[5] ? ~rs2_as : rs2_as;
    Adder_32 Adder (.a(rs1_as), .b(rs2_as_in), .sub((func7[5]|func3[1]|branch)), .sum(sum), .overflow(overflow), .zeroflag(zero));
    assign slt = sum[31]^overflow;
    
    //乘法
    wire [63:0] product;
    Multiplier Multiplier (.a(rs1_mu), .b(rs2_mu), .sign(func3[1]), .prod(product), .overflow(overflow));

    //除法
    wire [31:0] quotient, remainder;
    Divider Divider (.a(rs1_di), .b(rs2_di), .sign(func3[0]), .quotient(quotient), .remainder(remainder));

    //移位
    wire [31:0] shiftresult;
    Shifter_32 shifter32 (.shift5(rs2_sh), .datain(rs1_sh), .right(func3==5), .sra(func7[5]), .dataout(shiftresult));

    //ALU输出
    always @(*) begin
        if (clr) begin
            result <= 32'b0;
        end
        if (func7[0]) begin
            case (func3)
            0: result <= product[31:0];     //有符号×有符号低位结果
            1: result <= product[63:32];    //有符号×有符号高位结果
            2: result <= product[63:32];    //无符号×有符号高位结果
            3: result <= product[63:32];    //无符号×无符号高位结果
            4: result <= quotient;          //有符号除法商
            5: result <= quotient;          //无符号除法商
            6: result <= remainder;         //有符号除法余数
            7: result <= remainder;         //无符号除法余数
            default: result <= 32'b0;
            endcase
            BranchALU <= 1'b0;
        end
        else begin
            case (func3)
            0: result <= sum;                           //加减结果
            1: result <= shiftresult;                   //左移
            2: result <= slt        ? 32'b1 : 32'b0;    //小于置1
            3: result <= overflow   ? 32'b1 : 32'b0;    //无符号小于置1
            4: result <= rs1 ^ rs2;                     //逻辑异或
            5: result <= shiftresult;                   //右移
            6: result <= rs1 | rs2;                     //逻辑或
            7: result <= rs1 & rs2;                     //逻辑与
            default: result <= 32'b0;
            endcase
            //设置标志位
            BranchALU <=  ((func3==0) &  zero)      //等于0
                        | ((func3==1) & ~zero)      //不等于0
                        | ((func3==4) &  slt)       //小于
                        | ((func3==5) & ~slt)       //大于等于
                        | ((func3==6) &  overflow)  //无符号小于
                        | ((func3==7) & ~overflow); //无符号大于等于
        end
    end
endmodule