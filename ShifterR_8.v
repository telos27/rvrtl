//8bit右移模块
module ShifterR_8 (s, sin, din, dout);
    input [7:0] s, din;
    input [6:0] sin;
    output [7:0] dout;

    assign dout[7] = (sin[0] & din[0]) | (sin[1] & din[1]) | (sin[2] & din[2]) | (sin[3] & din[3])
                    |(sin[4] & din[4]) | (sin[5] & din[5]) | (sin[6] & din[6]) | (s[0] & din[7]);

    assign dout[6] = (sin[1] & din[0]) | (sin[2] & din[1]) | (sin[3] & din[2]) | (sin[4] & din[3])
                    |(sin[5] & din[4]) | (sin[6] & din[5]) | (s[0] & din[6]) | (s[1] & din[7]);

    assign dout[5] = (sin[2] & din[0]) | (sin[3] & din[1]) | (sin[4] & din[2]) | (sin[5] & din[3])
                    |(sin[6] & din[4]) | (s[0] & din[5]) | (s[1] & din[6]) | (s[2] & din[7]);

    assign dout[4] = (sin[3] & din[0]) | (sin[4] & din[1]) | (sin[5] & din[2]) | (sin[6] & din[3])
                    |(s[0] & din[3]) | (s[1] & din[2]) | (s[2] & din[1]) | (s[3] & din[7]);

    assign dout[3] = (sin[4] & din[0]) | (sin[5] & din[1]) | (sin[6] & din[2]) | (s[0] & din[3])
                    |(s[1] & din[4]) | (s[2] & din[5]) | (s[3] & din[6]) | (s[4] & din[7]);

    assign dout[2] = (sin[5] & din[0]) | (sin[6] & din[1]) | (s[0] & din[2]) | (s[1] & din[3])
                    |(s[2] & din[4]) | (s[3] & din[5]) | (s[4] & din[6]) | (s[5] & din[7]);

    assign dout[1] = (sin[6] & din[0]) | (s[0] & din[1]) | (s[1] & din[2]) | (s[2] & din[3])
                    |(s[3] & din[4]) | (s[4] & din[5]) | (s[5] & din[6]) | (s[6] & din[7]);

    assign dout[0] = (s[0] & din[0]) | (s[1] & din[1]) | (s[2] & din[2]) | (s[3] & din[3])
                    |(s[4] & din[4]) | (s[5] & din[5]) | (s[6] & din[6]) | (s[7] & din[7]);
endmodule
