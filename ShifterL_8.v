//8bit左移模块
module ShifterL_8 (shift, sin, din, dout);
    input [7:0] shift, din;
    input [6:0] sin;
    output [7:0] dout;

    assign dout[7] = (shift[7] & din[0]) | (shift[6] & din[1]) | (shift[5] & din[2]) | (shift[4] & din[3])
                    |(shift[3] & din[4]) | (shift[2] & din[5]) | (shift[1] & din[6]) | (shift[0] & din[7]);

    assign dout[6] = (shift[6] & din[0]) | (shift[5] & din[1]) | (shift[4] & din[2]) | (shift[3] & din[3])
                    |(shift[2] & din[4]) | (shift[1] & din[5]) | (shift[0] & din[6]) | (sin[6] & din[7]);

    assign dout[5] = (shift[5] & din[0]) | (shift[4] & din[1]) | (shift[3] & din[2]) | (shift[2] & din[3])
                    |(shift[1] & din[4]) | (shift[0] & din[5]) | (sin[6] & din[6]) | (sin[5] & din[7]);

    assign dout[4] = (shift[4] & din[0]) | (shift[3] & din[1]) | (shift[2] & din[2]) | (shift[1] & din[3])
                    |(shift[0] & din[4]) | (sin[6] & din[5]) | (sin[5] & din[6]) | (sin[4] & din[7]);

    assign dout[3] = (shift[3] & din[0]) | (shift[2] & din[1]) | (shift[1] & din[2]) | (shift[0] & din[3])
                    |(sin[6] & din[4]) | (sin[5] & din[5]) | (sin[4] & din[6]) | (sin[3] & din[7]);

    assign dout[2] = (shift[2] & din[0]) | (shift[1] & din[1]) | (shift[0] & din[2]) | (sin[6] & din[3])
                    |(sin[5] & din[4]) | (sin[4] & din[5]) | (sin[3] & din[6]) | (sin[2] & din[7]);

    assign dout[1] = (shift[1] & din[0]) | (shift[0] & din[1]) | (sin[6] & din[2]) | (sin[5] & din[3])
                    |(sin[4] & din[4]) | (sin[3] & din[5]) | (sin[2] & din[6]) | (sin[1] & din[7]);

    assign dout[0] = (shift[0] & din[0]) | (sin[6] & din[1]) | (sin[5] & din[2]) | (sin[4] & din[3])
                    |(sin[3] & din[4]) | (sin[2] & din[5]) | (sin[1] & din[6]) | (sin[0] & din[7]);
endmodule
