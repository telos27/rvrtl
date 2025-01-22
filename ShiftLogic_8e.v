//8位移位逻辑（带扩展）
module ShiftLogic_8e (datain, shift, shiftl, dataout);
    input [7:0] datain;
    input [7:0] shift;
    input [6:0] shiftl;
    output [7:0] dataout;

    wire [3:0] outtemp03l, outtemp03r, outtemp47l, outtemp47r;
    ShiftLogic_4e sle0 (.datain(datain[3:0]), .shift(shift[3:0]), .shiftl(shiftl[6:4]), .dataout(outtemp03l[3:0]));
    ShiftLogic_4e sle1 (.datain(datain[7:4]), .shift(shiftl[6:3]), .shiftl(shiftl[2:0]), .dataout(outtemp03r[3:0]));
    ShiftLogic_4e sle2 (.datain(datain[3:0]), .shift(shift[7:4]), .shiftl(shift[3:1]), .dataout(outtemp47l[3:0]));
    ShiftLogic_4e sle3 (.datain(datain[7:4]), .shift(shift[3:0]), .shiftl(shiftl[6:4]), .dataout(outtemp47r[3:0]));

    assign dataout[3:0] = outtemp03l[3:0] | outtemp03r[3:0];
    assign dataout[7:4] = outtemp47l[3:0] | outtemp47r[3:0];

endmodule