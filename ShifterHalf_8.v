//8bit移位模块（对角线）
module ShifterHalf_8 (s, din, dout);
    input [7:0] s, din;
    output [7:0] dout;

    assign dout[7] = (s[7] & din[0]) | (s[6] & din[1]) | (s[5] & din[2]) | (s[4] & din[3])
                    |(s[3] & din[4]) | (s[2] & din[5]) | (s[1] & din[6]) | (s[0] & din[7]);
    assign dout[6] = (s[6] & din[0]) | (s[5] & din[1]) | (s[4] & din[2]) | (s[3] & din[3])
                    |(s[2] & din[4]) | (s[1] & din[5]) | (s[0] & din[6]);
    assign dout[5] = (s[5] & din[0]) | (s[4] & din[1]) | (s[3] & din[2]) | (s[2] & din[3])
                    |(s[1] & din[4]) | (s[0] & din[5]);
    assign dout[4] = (s[4] & din[0]) | (s[3] & din[1]) | (s[2] & din[2]) | (s[1] & din[3])
                    |(s[0] & din[4]);
    assign dout[3] = (s[3] & din[0]) | (s[2] & din[1]) | (s[1] & din[2]) | (s[0] & din[3]);
    assign dout[2] = (s[2] & din[0]) | (s[1] & din[1]) | (s[0] & din[2]);
    assign dout[1] = (s[1] & din[0]) | (s[0] & din[1]);
    assign dout[0] = (s[0] & din[0]);

endmodule
