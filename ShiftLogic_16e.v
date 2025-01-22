//16位移位逻辑(带扩展)
module ShiftLogic_16e (datain, shift, shiftl, dataout);
    input [15:0] datain;
    input [15:0] shift;
    input [14:0] shiftl;
    output [15:0] dataout;

    wire [7:0] temp07l, temp07r, temp815l, temp815r;
    ShiftLogic_8e sle0 (.datain(datain[7:0]), .shift(shift[7:0]), .shiftl(shiftl[14:8]), .dataout(temp07l[7:0]));
    ShiftLogic_8e sle1 (.datain(datain[15:8]), .shift(shiftl[14:7]), .shiftl(shiftl[6:0]), .dataout(temp07r[7:0]));
    ShiftLogic_8e sle2 (.datain(datain[7:0]), .shift(shift[15:8]), .shiftl(shift[7:1]), .dataout(temp815l[7:0]));
    ShiftLogic_8e sle3 (.datain(datain[15:8]), .shift(shift[7:0]), .shiftl(shiftl[14:8]), .dataout(temp815r[7:0]));

    assign dataout[7:0] = temp07l[7:0] | temp07r[7:0];
    assign dataout[15:8] = temp815l[7:0] | temp815r[7:0];

endmodule