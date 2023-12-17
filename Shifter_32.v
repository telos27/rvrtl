//32bit移位模块
`include "ShifterHalf_8.v"
`include "ShifterAll_8.v"
module Shifter_32 (s, din, dout);
    input [31:0] s, din;
    output [31:0] dout;
    wire [7:0], douta0, douth0, douta1, douta2, dhouth1, douta3, douta4, douta5, douth3;
    //0~7位
    ShifterHalf_8 ShifterHalf_8_0 (.s(s[7:0]), .din(din[7:0]), .dout(dout[7:0]));
    //8~15位
    ShifterAll_8 ShifterAll_8_0 (.s(s[15:8]), .din(din[7:0]), .sin(s[7:1]), .dout(douta0[7:0]));
    ShifterHalf_8 ShifterHalf_8_1 (.s(s[7:0]), .din(din[15:8]), .dout(douth0[7:0]));
    assign dout[15:8] = douta0 | douth1;
    //16~23位
    ShifterAll_8 ShifterAll_8_1 (.s(s[23:16]), .din(din[7:0]), .sin(s[15:8]), .dout(douta1[7:0]));
    ShifterAll_8 ShifterAll_8_2 (.s(s[15:8]), .din(din[15:8]), .sin(s[7:1]), .dout(douta2[7:0]));
    ShifterHalf_8 ShifterHalf_8_2 (.s(s[7:0]), .din(din[23:16]), .dout(douth1[7:0]));
    assign dout[23:16] = douta1 | douta2 | douth1;
    //24~31位
    ShifterAll_8 ShifterAll_8_3 (.s(s[31:24]), .din(din[7:0]), .sin(s[24:16]), .dout(douta3[7:0]));
    ShifterAll_8 ShifterAll_8_4 (.s(s[23:16]), .din(din[15:8]), .sin(s[15:8]), .dout(douta4[7:0]));
    ShifterAll_8 ShifterAll_8_5 (.s(s[15:8]), .din(din[23:16]), .sin(s[7:1]), .dout(douta5[7:0]));
    ShifterHalf_8 ShifterHalf_8_3 (.s(s[7:0]), .din(din[31:24]), .dout(douth3[7:0]));
    assign dout[31:24] = douta3 | douta4 | douta5 | douth3;
endmodule
