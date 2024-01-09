//8bit移位模块（三角形）
module ShifterTriangles_8 (shift, datain, dataout);
    input [7:0] shift, datain;
    output [7:0] dataout;

    assign dataout[7] = (shift[7] & datain[0]) | (shift[6] & datain[1]) | (shift[5] & datain[2]) | (shift[4] & datain[3])
                    | (shift[3] & datain[4]) | (shift[2] & datain[5]) | (shift[1] & datain[6]) | (shift[0] & datain[7]);
    assign dataout[6] = (shift[6] & datain[0]) | (shift[5] & datain[1]) | (shift[4] & datain[2]) | (shift[3] & datain[3])
                    | (shift[2] & datain[4]) | (shift[1] & datain[5]) | (shift[0] & datain[6]);
    assign dataout[5] = (shift[5] & datain[0]) | (shift[4] & datain[1]) | (shift[3] & datain[2]) | (shift[2] & datain[3])
                    | (shift[1] & datain[4]) | (shift[0] & datain[5]);
    assign dataout[4] = (shift[4] & datain[0]) | (shift[3] & datain[1]) | (shift[2] & datain[2]) | (shift[1] & datain[3])
                    | (shift[0] & datain[4]);
    assign dataout[3] = (shift[3] & datain[0]) | (shift[2] & datain[1]) | (shift[1] & datain[2]) | (shift[0] & datain[3]);
    assign dataout[2] = (shift[2] & datain[0]) | (shift[1] & datain[1]) | (shift[0] & datain[2]);
    assign dataout[1] = (shift[1] & datain[0]) | (shift[0] & datain[1]);
    assign dataout[0] = (shift[0] & datain[0]);
endmodule
