//算数逻辑运算单元
`include "Mux_2_32.v"
`include "Adder_32.v"
`include "Shift_Signal.v"
`include "Reverser.v"
`include "Shifter_32.v"
`include "SignExtender.v"
module ALU (clr, rs1, rs2, func7, func3, result, compare);
    input [31:0] rs1, rs2;
    input clr;
    input [6:0] func7;
    input [2:0] func3;
    output reg [31:0]result;
    output reg [2:0]compare;
    wire [31:0]rs2bar, muxrs2, sum, muxshift, shift;
    wire [31:0]shiftdatatemp, shiftdataout, shiftright, signextend;
    wire overflow, zeroflag, slt;
    //rs2取反
    assign rs2bar = ~rs2;
    Mux_2_32 Mux_b (.select(func7[5]), .datain0(rs2), .datain1(rs2bar), .dataout(muxrs2));
    //加法器
    Adder_32 Adder (.a(rs1), .b(muxrs2), .sub(func7[5]), .sum(sum), .overflow(overflow), .zeroflag(zeroflag));
    //移位模块
    Shift_Signal Shift_Signal (.shift5(rs2[4:0]), .shift32(shift));
    Reverser ReverserIn (.right(func3[2]), .datain(rs1), .dataout(shiftdatatemp));
    Shifter_32 Shifter (.shift(shift), .datain(shiftdatatemp), .dataout(shiftdataout));
    Reverser ReverserOut (.right(func3[2]), .datain(shiftdataout), .dataout(shiftright));
    SignExtender SignExtender (.shift5(rs2[4:0]), .rsa(func7[5]), .sign(rs1[31]), .signextend(signextend));
    //小于置1
    assign slt = (rs1[31]===rs2[31])^overflow;
    //ALU输出
    always @(*) begin
        if (clr) begin
            result <= 0;
        end
        case (func3)
            0: result <= sum;//算数结果
            1: result <= shiftdataout;//左移
            2: result <= slt?32'b1:32'b0;//小于置1
            3: result <= !overflow?32'b1:32'b0;//无符号小于置1
            4: result <= rs1 ^ rs2;//逻辑异或
            5: result <= shiftright | signextend;//右移
            6: result <= rs1 | rs2;//逻辑或
            7: result <= rs1 & rs2;//逻辑与
        endcase
        //rs1和rs2比较大小，设置标志位
        compare = {!overflow, slt, zeroflag};//零标志位、有符号溢出、无符号溢出
    end
endmodule