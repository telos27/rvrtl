//8bit移位模块（对角线）
module ShifterHalf_8 (shift, din, dleft, dright);
    input [7:0] shift, din;
    output [7:0] dleft, dright;
    //左移
    assign dleft[7] = (shift[7] & din[0]) | (shift[6] & din[1]) | (shift[5] & din[2]) | (shift[4] & din[3])
                    | (shift[3] & din[4]) | (shift[2] & din[5]) | (shift[1] & din[6]) | (shift[0] & din[7]);
    assign dleft[6] = (shift[6] & din[0]) | (shift[5] & din[1]) | (shift[4] & din[2]) | (shift[3] & din[3])
                    | (shift[2] & din[4]) | (shift[1] & din[5]) | (shift[0] & din[6]);
    assign dleft[5] = (shift[5] & din[0]) | (shift[4] & din[1]) | (shift[3] & din[2]) | (shift[2] & din[3])
                    | (shift[1] & din[4]) | (shift[0] & din[5]);
    assign dleft[4] = (shift[4] & din[0]) | (shift[3] & din[1]) | (shift[2] & din[2]) | (shift[1] & din[3])
                    | (shift[0] & din[4]);
    assign dleft[3] = (shift[3] & din[0]) | (shift[2] & din[1]) | (shift[1] & din[2]) | (shift[0] & din[3]);
    assign dleft[2] = (shift[2] & din[0]) | (shift[1] & din[1]) | (shift[0] & din[2]);
    assign dleft[1] = (shift[1] & din[0]) | (shift[0] & din[1]);
    assign dleft[0] = (shift[0] & din[0]);
    //右移
    assign dright[7] = (shift[0] & din[7]);
    assign dright[6] = (shift[1] & din[7]) | (shift[0] & din[6]);
    assign dright[5] = (shift[2] & din[7]) | (shift[1] & din[6]) | (shift[0] & din[5]);
    assign dright[4] = (shift[3] & din[7]) | (shift[2] & din[6]) | (shift[1] & din[5]) | (shift[0] & din[4]);
    assign dright[3] = (shift[4] & din[7]) | (shift[3] & din[6]) | (shift[2] & din[5]) | (shift[1] & din[4])
                     | (shift[0] & din[3]);
    assign dright[2] = (shift[5] & din[7]) | (shift[4] & din[6]) | (shift[3] & din[5]) | (shift[2] & din[4])
                     | (shift[1] & din[3]) | (shift[0] & din[2]);
    assign dright[1] = (shift[6] & din[7]) | (shift[5] & din[6]) | (shift[4] & din[5]) | (shift[3] & din[4])
                     | (shift[2] & din[3]) | (shift[1] & din[2]) | (shift[0] & din[1]);
    assign dright[0] = (shift[7] & din[7]) | (shift[6] & din[6]) | (shift[5] & din[5]) | (shift[4] & din[4])
                     | (shift[3] & din[3]) | (shift[2] & din[2]) | (shift[1] & din[1]) | (shift[0] & din[0]);
endmodule
