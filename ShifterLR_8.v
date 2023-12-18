//8bit移位模块（对角线）
module ShifterHalf_8 (s, din, dleft, dright);
    input [7:0] s, din;
    output [7:0] dleft, dright;
    //左移
    assign dleft[7] = (s[7] & din[0]) | (s[6] & din[1]) | (s[5] & din[2]) | (s[4] & din[3])
                    | (s[3] & din[4]) | (s[2] & din[5]) | (s[1] & din[6]) | (s[0] & din[7]);
    assign dleft[6] = (s[6] & din[0]) | (s[5] & din[1]) | (s[4] & din[2]) | (s[3] & din[3])
                    | (s[2] & din[4]) | (s[1] & din[5]) | (s[0] & din[6]);
    assign dleft[5] = (s[5] & din[0]) | (s[4] & din[1]) | (s[3] & din[2]) | (s[2] & din[3])
                    | (s[1] & din[4]) | (s[0] & din[5]);
    assign dleft[4] = (s[4] & din[0]) | (s[3] & din[1]) | (s[2] & din[2]) | (s[1] & din[3])
                    | (s[0] & din[4]);
    assign dleft[3] = (s[3] & din[0]) | (s[2] & din[1]) | (s[1] & din[2]) | (s[0] & din[3]);
    assign dleft[2] = (s[2] & din[0]) | (s[1] & din[1]) | (s[0] & din[2]);
    assign dleft[1] = (s[1] & din[0]) | (s[0] & din[1]);
    assign dleft[0] = (s[0] & din[0]);
    //右移
    assign dright[7] = (s[0] & din[7]);
    assign dright[6] = (s[1] & din[7]) | (s[0] & din[6]);
    assign dright[5] = (s[2] & din[7]) | (s[1] & din[6]) | (s[0] & din[5]);
    assign dright[4] = (s[3] & din[7]) | (s[2] & din[6]) | (s[1] & din[5]) | (s[0] & din[4]);
    assign dright[3] = (s[4] & din[7]) | (s[3] & din[6]) | (s[2] & din[5]) | (s[1] & din[4])
                     | (s[0] & din[3]);
    assign dright[2] = (s[5] & din[7]) | (s[4] & din[6]) | (s[3] & din[5]) | (s[2] & din[4])
                     | (s[1] & din[3]) | (s[0] & din[2]);
    assign dright[1] = (s[6] & din[7]) | (s[5] & din[6]) | (s[4] & din[5]) | (s[3] & din[4])
                     | (s[2] & din[3]) | (s[1] & din[2]) | (s[0] & din[1]);
    assign dright[0] = (s[7] & din[7]) | (s[6] & din[6]) | (s[5] & din[5]) | (s[4] & din[4])
                     | (s[3] & din[3]) | (s[2] & din[2]) | (s[1] & din[1]) | (s[0] & din[0]);
endmodule
