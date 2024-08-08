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
    wire [31:0] rs2bar, muxrs2, sum, muxshift, shift, product;
    wire [31:0] shiftresult;
    wire overflow, zero, slt;
    //rs2取反
    assign rs2bar = ~rs2;
    Mux_2_32 Mux_b (.select(func7[5]), .datain0(rs2), .datain1(rs2bar), .dataout(muxrs2));
    //加法器
    Adder_32 Adder (.a(rs1), .b(muxrs2), .sub(func7[5]), .sum(sum), .overflow(overflow), .zeroflag(zero));
    //乘法器
    //Multiplier Multiplier (.a(rs1), .b(rs2), .sign(func3[1]), .prod(product), .overflow());
    //除法器
    //Division Division (.a(rs1), .b(rs2), .sign(), .q(), .r());
    //移位模块
    Shifter_32 shifter32 (.shift5(rs2[4:0]), .datain(rs1), .right(func3==5), .sra(func7[5]), .dataout(shiftresult));

    assign slt = sum[31]^overflow;
    //ALU输出
    always @(*) begin
        if (clr) begin
            result <= 32'b0;
        end
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
        //设置标志位
        BranchALU <=  ((func3==0) & zero)       //等于0
                    | ((func3==1) & ~zero)      //不等于0
                    | ((func3==4) & slt)        //小于
                    | ((func3==5) & ~slt)       //大于等于
                    | ((func3==6) & overflow)   //无符号小于
                    | ((func3==7) & ~overflow); //无符号大于等于
    end
endmodule