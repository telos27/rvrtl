//4位移位模块(带扩展)
module ShiftLogic_4e (datain, shift, shiftl, dataout);
    input [3:0] datain;
    input [3:0] shift;
    input [2:0] shiftl;
    output [3:0] dataout;

    assign dataout[0] = datain[0] & shift[0] | datain[1] & shiftl[2] | datain[2] & shiftl[1] | datain[3] & shiftl[0];
    assign dataout[1] = datain[0] & shift[1] | datain[1] & shift[0] | datain[2] & shiftl[2] | datain[3] & shiftl[1];
    assign dataout[2] = datain[0] & shift[2] | datain[1] & shift[1] | datain[2] & shift[0] | datain[3] & shiftl[2];
    assign dataout[3] = datain[0] & shift[3] | datain[1] & shift[2] | datain[2] & shift[1] | datain[3] & shift[0];

endmodule