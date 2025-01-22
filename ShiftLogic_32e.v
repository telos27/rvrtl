//32位移位逻辑（带扩展）
module ShiftLogic_32e (datain, shift, shiftl, dataout);
    input [31:0] datain;
    input [31:0] shift;
    input [30:0] shiftl;
    output [31:0] dataout;

    wire [15:0] temp015l, temp015r, temp1631l, temp1631r;

    ShiftLogic_16e sle0 (.datain(datain[15:0]), .shift(shift[15:0]), .shiftl(shiftl[30:16]), .dataout(temp015l[15:0]));
    ShiftLogic_16e sle1 (.datain(datain[31:16]), .shift(shiftl[30:15]), .shiftl(shiftl[14:0]), .dataout(temp015r[15:0]));
    ShiftLogic_16e sle2 (.datain(datain[15:0]), .shift(shift[31:16]), .shiftl(shift[15:1]), .dataout(temp1631l[15:0]));
    ShiftLogic_16e sle3 (.datain(datain[31:16]), .shift(shift[15:0]), .shiftl(shiftl[30:16]), .dataout(temp1631r[15:0]));

    assign dataout[15:0] = temp015l[15:0] | temp015r[15:0];
    assign dataout[31:16] = temp1631l[15:0] | temp1631r[15:0];

endmodule