//
`include "Reverser.v"
`include "SignExtender.v"
`include "Decoder_5to32.v"
`include "ShifterTriangles_8.v"
`include "ShifterSquare_8.v"
module Shifter_32 (shift5, datain, right, sra, dataout);
    input   [4:0]   shift5;     //5位移位信号
    input   [31:0]  datain;     //移位数据输入
    input           right;      //右移控制信号
    input           sra;        //有符号右移符号扩展
    output  [31:0]  dataout;    //移位数据输出

    wire    [31:0]  shift32;
    wire    [31:0]  shiftin;
    wire    [31:0]  shiftout;
    wire    [31:0]  shiftouttemp;
    wire    [31:0]  signextend;
    wire    [7:0]   shiftdata0;
    wire    [7:0]   shiftdata1;
    wire    [7:0]   shiftdata2;
    wire    [7:0]   shiftdata3;
    wire    [7:0]   shiftdata4;
    wire    [7:0]   shiftdata5;
    wire    [7:0]   shiftdata6;
    wire    [7:0]   shiftdata7;
    wire    [7:0]   shiftdata8;

    Reverser ReverserIn (.right(right), .datain(datain), .dataout(shiftin));
    Reverser ReverserOut (.right(right), .datain(shiftout), .dataout(shiftouttemp));
    SignExtender SignExtender (.shift32(shift32), .se(signextend));
    assign dataout = sra ? (shiftouttemp | signextend) : shiftouttemp;

    Decoder_5to32 Decoder_5to32 (.select(shift5), .out(shift32));
    //0~7位
    ShifterTriangles_8 ShifterTriangles_8_0 (.shift(shift32[7:0]), .datain(datain[7:0]), .dataout(shiftout[7:0]));
    //8~15位
    ShifterSquare_8 ShifterSquare_8_0 (.shift(shift32[15:8]), .shiftin(shift32[7:1]), .datain(datain[7:0]), .dataout(shiftdata0[7:0]));
    ShifterTriangles_8 ShifterTriangles_8_1 (.shift(shift32[7:0]), .datain(datain[15:8]), .dataout(shiftdata1[7:0]));
    assign shiftout[8] = shiftdata0[0] | shiftdata1[0];
    assign shiftout[9] = shiftdata0[1] | shiftdata1[1];
    assign shiftout[10] = shiftdata0[2] | shiftdata1[2];
    assign shiftout[11] = shiftdata0[3] | shiftdata1[3];
    assign shiftout[12] = shiftdata0[4] | shiftdata1[4];
    assign shiftout[13] = shiftdata0[5] | shiftdata1[5];
    assign shiftout[14] = shiftdata0[6] | shiftdata1[6];
    assign shiftout[15] = shiftdata0[7] | shiftdata1[7];
    //16~23位
    ShifterSquare_8 ShifterSquare_8_1 (.shift(shift32[23:16]), .shiftin(shift32[15:9]), .datain(datain[7:0]), .dataout(shiftdata2[7:0]));
    ShifterSquare_8 ShifterSquare_8_2 (.shift(shift32[15:8]), .shiftin(shift32[7:1]), .datain(datain[15:8]), .dataout(shiftdata3[7:0]));
    ShifterTriangles_8 ShifterTriangles_8_2 (.shift(shift32[7:0]), .datain(datain[23:16]), .dataout(shiftdata4[7:0]));
    assign shiftout[16] = shiftdata2[0] | shiftdata3[0] | shiftdata4[0];
    assign shiftout[17] = shiftdata2[1] | shiftdata3[1] | shiftdata4[1];
    assign shiftout[18] = shiftdata2[2] | shiftdata3[2] | shiftdata4[2];
    assign shiftout[19] = shiftdata2[3] | shiftdata3[3] | shiftdata4[3];
    assign shiftout[20] = shiftdata2[4] | shiftdata3[4] | shiftdata4[4];
    assign shiftout[21] = shiftdata2[5] | shiftdata3[5] | shiftdata4[5];
    assign shiftout[22] = shiftdata2[6] | shiftdata3[6] | shiftdata4[6];
    assign shiftout[23] = shiftdata2[7] | shiftdata3[7] | shiftdata4[7];
    //24~31位
    ShifterSquare_8 ShifterSquare_8_3 (.shift(shift32[31:24]), .shiftin(shift32[23:17]), .datain(datain[7:0]), .dataout(shiftdata5[7:0]));
    ShifterSquare_8 ShifterSquare_8_4 (.shift(shift32[23:16]), .shiftin(shift32[15:9]), .datain(datain[15:8]), .dataout(shiftdata6[7:0]));
    ShifterSquare_8 ShifterSquare_8_5 (.shift(shift32[15:8]), .shiftin(shift32[7:1]), .datain(datain[23:16]), .dataout(shiftdata7[7:0]));
    ShifterTriangles_8 ShifterTriangles_8_3 (.shift(shift32[7:0]), .datain(datain[31:24]), .dataout(shiftdata8[7:0]));
    assign shiftout[24] = shiftdata5[0] | shiftdata6[0] | shiftdata7[0] | shiftdata8[0];
    assign shiftout[25] = shiftdata5[1] | shiftdata6[1] | shiftdata7[1] | shiftdata8[1];
    assign shiftout[26] = shiftdata5[2] | shiftdata6[2] | shiftdata7[2] | shiftdata8[2];
    assign shiftout[27] = shiftdata5[3] | shiftdata6[3] | shiftdata7[3] | shiftdata8[3];
    assign shiftout[28] = shiftdata5[4] | shiftdata6[4] | shiftdata7[4] | shiftdata8[4];
    assign shiftout[29] = shiftdata5[5] | shiftdata6[5] | shiftdata7[5] | shiftdata8[5];
    assign shiftout[30] = shiftdata5[6] | shiftdata6[6] | shiftdata7[6] | shiftdata8[6];
    assign shiftout[31] = shiftdata5[7] | shiftdata6[7] | shiftdata7[7] | shiftdata8[7];
endmodule
