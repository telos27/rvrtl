//算数逻辑运算单元
`include "Mux.v"
`include "Adder_32"
`include "Decoder_5to32.v"
`include "Shifter_32"
module ALU (rs1, rs2, sub, func3, result, overflow, zeroflag);
    input [31:0]rs1, rs2;
    input sub;
    input [2:0]func3;
    output [31:0]result;
    output overflow, zeroflag;
    wire [31:0]rs2bar, muxrs2, addout, muxshift, shift, shiftleft, shiftright;
    //rs2取反
    assign rs2bar = ~rs2;
    Mux Mux_b (.select(sub), .datain0(rs2), .datain1(rs2bar), .dataout(muxrs2));
    //加法器
    Adder_32 Adder (.a(rs1), .b(muxrs2), .sub(sub), .s(addout), .cout(overflow), .zeroflag(zeroflag));
    //移位模块
    Mux Mux_Shifter (.select(opcode[2]), .datain0(rs2[4:0]), .datain1(imm[4:0]), .dataout(muxshift));
    Decoder_5to32 Decoder_Shift (.s(muxshift), .sout(shift));
    Shifter_32 Shifter (.s(shift), .din(rs1), .dleftout(shiftleft), .drightout(shiftright));
    //ALU输出
    case (func3)
        3'b000: result = addout;//算数结果
        3'b001: result = shiftleft;//左移
        3'b010: result = ;//小于置1
        3'b011: result = ;//无符号小于置1
        3'b100: result = a ^ b;//逻辑异或
        3'b101: result = shiftright;//右移
        3'b110: result = a | b;//逻辑或
        3'b111: result = a & b;//逻辑与
    endcase
endmodule
