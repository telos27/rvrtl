//32bit移位模块
`include "ShifterL_8.v"
`include "ShifterR_8.v"
module Shifter_32 (shift, din, dleftout, drightout);
    input [31:0] shift, din;
    output [31:0] dleftout, drightout;
    wire [7:0] dleft0, dright0, right1, right2, right3;
    wire [7:0] dleft0, dleft1, right4, right5, right6;
    //0~7位
    ShifterLR_8 ShifterLR_8_0 (.shift(shift[7:0]), .din(din[7:0]), .dleft(dleftout[7:0]), .dright(dright0[7:0]));
    ShifterR_8 ShifterR_8_0 (.shift(shift[15:8]), .din(din[15:8]), .sin(s[7:1]), .dout(dright1[7:0]));
    ShifterR_8 ShifterR_8_1 (.shift(shift[23:16]), .din(din[23:16]), .sin(s[15:9]), .dout(dright2[7:0]));
    ShifterR_8 ShifterR_8_2 (.shift(shift[31:24]), .din(din[31:24]), .sin(s[23:17]), .dout(dright3[7:0]));
    assign dleftout[0] = dleft0[0];
    assign dleftout[1] = dleft0[1];
    assign dleftout[2] = dleft0[2];
    assign dleftout[3] = dleft0[3];
    assign dleftout[4] = dleft0[4];
    assign dleftout[5] = dleft0[5];
    assign dleftout[6] = dleft0[6];
    assign dleftout[7] = dleft0[7];
    assign drightout[0] = dright0[0] | dright1[0] | dright2[0] | dright3[0];
    assign drightout[1] = dright0[1] | dright1[1] | dright2[1] | dright3[1];
    assign drightout[2] = dright0[2] | dright1[2] | dright2[2] | dright3[2];
    assign drightout[3] = dright0[3] | dright1[3] | dright2[3] | dright3[3];
    assign drightout[4] = dright0[4] | dright1[4] | dright2[4] | dright3[4];
    assign drightout[5] = dright0[5] | dright1[5] | dright2[5] | dright3[5];
    assign drightout[6] = dright0[6] | dright1[6] | dright2[6] | dright3[6];
    assign drightout[7] = dright0[7] | dright1[7] | dright2[7] | dright3[7];
    //8~15位
    ShifterL_8 ShifterL_8_0 (.shift(shift[15:8]), .din(din[7:0]), .sin(s[7:1]), .dout(dleft0[7:0]));
    ShifterLR_8 ShifterLR_8_1 (.shift(shift[7:0]), .din(din[15:8]), .dleft(dleft1[7:0]), .dright(dright4[7:0]));
    ShifterR_8 ShifterR_8_3 (.shift(shift[15:8]), .din(din[23:16]), .sin(s[7:1]), .dout(dright5[7:0]));
    ShifterR_8 ShifterR_8_4 (.shift(shift[23:16]), .din(din[31:24]), .sin(s[15:9]), .dout(dright6[7:0]));
    assign dleftout[8] = dleft0[0] | dleft1[0];
    assign dleftout[9] = dleft0[1] | dleft1[1];
    assign dleftout[10] = dleft0[2] | dleft1[2];
    assign dleftout[11] = dleft0[3] | dleft1[3];
    assign dleftout[12] = dleft0[4] | dleft1[4];
    assign dleftout[13] = dleft0[5] | dleft1[5];
    assign dleftout[14] = dleft0[6] | dleft1[6];
    assign dleftout[15] = dleft0[7] | dleft1[7];
    assign drightout[8] = dright4[0] | dright5[0] | dright6[0];
    assign drightout[9] = dright4[1] | dright5[1] | dright6[1];
    assign drightout[10] = dright4[2] | dright5[2] | dright6[2];
    assign drightout[11] = dright4[3] | dright5[3] | dright6[3];
    assign drightout[12] = dright4[4] | dright5[4] | dright6[4];
    assign drightout[13] = dright4[5] | dright5[5] | dright6[5];
    assign drightout[14] = dright4[6] | dright5[6] | dright6[6];
    assign drightout[15] = dright4[7] | dright5[7] | dright6[7];
    //16~23位
    ShifterL_8 ShifterL_8_1 (.shift(shift[23:16]), .din(din[7:0]), .sin(s[15:9]), .dout(dleft2[7:0]));
    ShifterL_8 ShifterL_8_2 (.shift(shift[15:8]), .din(din[15:8]), .sin(s[7:1]), .dout(dleft3[7:0]));
    ShifterLR_8 ShifterLR_8_3 (.shift(shift[7:0]), .din(din[23:16]), .dleft(dleft4[7:0]), .dright(dright7[7:0]));
    ShifterR_8 ShifterR_8_5 (.shift(shift[15:8]), .din(din[31:24]), .sin(s[7:1]), .dout(dright8[7:0]));
    assign dleftout[16] = dleft2[0] | dleft3[0] | dleft4[0];
    assign dleftout[17] = dleft2[1] | dleft3[1] | dleft4[1];
    assign dleftout[18] = dleft2[2] | dleft3[2] | dleft4[2];
    assign dleftout[19] = dleft2[3] | dleft3[3] | dleft4[3];
    assign dleftout[20] = dleft2[4] | dleft3[4] | dleft4[4];
    assign dleftout[21] = dleft2[5] | dleft3[5] | dleft4[5];
    assign dleftout[22] = dleft2[6] | dleft3[6] | dleft4[6];
    assign dleftout[23] = dleft2[7] | dleft3[7] | dleft4[7];
    assign drightout[16] = dright7[0] | dright8[0];
    assign drightout[17] = dright7[1] | dright8[1];
    assign drightout[18] = dright7[2] | dright8[2];
    assign drightout[19] = dright7[3] | dright8[3];
    assign drightout[20] = dright7[4] | dright8[4];
    assign drightout[21] = dright7[5] | dright8[5];
    assign drightout[22] = dright7[6] | dright8[6];
    assign drightout[23] = dright7[7] | dright8[7];
    //24~31位
    ShifterL_8 ShifterL_8_3 (.shift(shift[31:24]), .din(din[7:0]), .sin(s[23:17]), .dout(dleft5[7:0]));
    ShifterL_8 ShifterL_8_4 (.shift(shift[23:16]), .din(din[15:8]), .sin(s[15:9]), .dout(dleft6[7:0]));
    ShifterL_8 ShifterL_8_5 (.shift(shift[15:8]), .din(din[23:16]), .sin(s[7:1]), .dout(dleft8[7:0]));
    ShifterLR_8 ShifterLR_8_3 (.shift(shift[7:0]), .din(din[31:24]), .dleft(dleft7[7:0]), .dright(dright[24:31]));
    assign dleftout[24] = dleft5[0] | dleft6[0] | dleft8[0] | dleft7[0];
    assign dleftout[25] = dleft5[1] | dleft6[1] | dleft8[1] | dleft7[1];
    assign dleftout[26] = dleft5[2] | dleft6[2] | dleft8[2] | dleft7[2];
    assign dleftout[27] = dleft5[3] | dleft6[3] | dleft8[3] | dleft7[3];
    assign dleftout[28] = dleft5[4] | dleft6[4] | dleft8[4] | dleft7[4];
    assign dleftout[29] = dleft5[5] | dleft6[5] | dleft8[5] | dleft7[5];
    assign dleftout[30] = dleft5[6] | dleft6[6] | dleft8[6] | dleft7[6];
    assign dleftout[31] = dleft5[7] | dleft6[7] | dleft8[7] | dleft7[7];
endmodule
