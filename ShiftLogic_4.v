//4位移位模块

module ShiftLogic_4 (datain, shift, dataout);
    input [3:0] datain;
    input [3:0] shift;
    output [3:0] dataout;

    assign dataout[0] = datain[0] & shift[0];
    assign dataout[1] = datain[0] & shift[1] | datain[1] & shift[0];
    assign dataout[2] = datain[0] & shift[2] | datain[1] & shift[1] | datain[2] & shift[0];
    assign dataout[3] = datain[0] & shift[3] | datain[1] & shift[2] | datain[2] & shift[1] | datain[3] & shift[0];

endmodule