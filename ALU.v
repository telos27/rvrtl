//算数逻辑运算单元
`include "Mux.v"
`include "Adder_32.v"
`include "Decoder_5to32.v"
`include "Shifter_32.v"
module ALU (rs1, rs2, sub, func3, result, zeroflag);
    input [31:0]rs1, rs2;
    input sub;
    input [2:0]func3;
    output reg [31:0]result;
    output zeroflag;
    wire [31:0]rs2bar, muxrs2, sum, muxshift, shift, shiftdata;
    //rs2取反
    assign rs2bar = ~rs2;
    Mux Mux_b (.select(sub), .datain0(rs2), .datain1(rs2bar), .dataout(muxrs2));
    //加法器
    Adder_32 Adder (.a(rs1), .b(muxrs2), .sub(sub), .sum(sum), .overflow(overflow), .zeroflag(zeroflag));
    //移位模块
    Decoder_5to32 Decoder_Shift (.s(rs2[4:0]), .shift(shift), .right(func3[2]), .sra(sub));
    Shifter_32 Shifter (.shift(shift), .datain(rs1), .dataout(shiftdata));
    //ALU输出
    always @(sum or shiftleft or sum or overflow or rs1 or rs2 or shiftright) begin
        case (func3)
            3'b000: result = sum;//算数结果
            3'b001, 3'b101: result = shiftdata;//移位结果
            3'b010: result = sum[31];//小于置1
            3'b011: result = overflow;//无符号小于置1
            3'b100: result = rs1 ^ rs2;//逻辑异或
            3'b110: result = rs1 | rs2;//逻辑或
            3'b111: result = rs1 & rs2;//逻辑与
        endcase
    end
endmodule
