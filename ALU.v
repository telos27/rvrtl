//算数逻辑运算单元
`include "Mux.v"
`include "Adder_32.v"
`include "Shift_Signal.v"
`include "Reverser.v"
`include "Shifter_32.v"
`include "SignExtender.v"
module ALU (rs1, rs2, sub, func3, result, compare);
    input [31:0]rs1, rs2;
    input sub;
    input [2:0]func3;
    output reg [31:0]result;
    output reg [2:0]compare;
    wire [31:0]rs2bar, muxrs2, sum, muxshift, shift, shiftdatatemp, shiftdata, shiftright, signextend;
    //rs2取反
    assign rs2bar = ~rs2;
    Mux Mux_b (.select(sub), .datain0(rs2), .datain1(rs2bar), .dataout(muxrs2));
    //加法器
    Adder_32 Adder (.a(rs1), .b(muxrs2), .sub(sub), .sum(sum), .overflow(overflow), .zeroflag(zeroflag));
    //移位模块
    Shift_Signal Shift_Signal (.shift5(rs2[4:0]), .shift32(shift));
    Reverser ReverserIn (.right(func3[2]), .datain(rs1), .dataout(shiftdatatemp));
    Shifter_32 Shifter (.shift(shift), .datain(shiftdatatemp), .dataout(shiftdata));
    Reverser ReverserOut (.right(func3[2]), .datain(shiftdata), .dataout(shiftright));
    SignExtender SignExtender (.shift5(rs2[4:0]), .rsa(sub), .sign(rs1[31]), .signextend(signextend));
    //ALU输出
    always @(*) begin
        case (func3)
            3'b000: result <= sum;//算数结果
            3'b001: result <= shiftdata;//左移
            3'b010: result <= sum[31];//小于置1
            3'b011: result <= overflow;//无符号小于置1
            3'b100: result <= rs1 ^ rs2;//逻辑异或
            3'b101: result <= shiftright | signextend;//右移
            3'b110: result <= rs1 | rs2;//逻辑或
            3'b111: result <= rs1 & rs2;//逻辑与
        endcase
        //rs1和rs2比较大小，设置标志位
        compare <= {overflow, sum[31], zeroflag};//零标志位、有符号溢出、无符号溢出
    end
endmodule
