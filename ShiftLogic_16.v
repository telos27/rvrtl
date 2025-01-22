//16位移位逻辑
`include "ShiftLogic_8.v"
`include "ShiftLogic_8e.v"

module ShiftLogic_16 (datain, shift, dataout);
    input [15:0] datain;
    input [15:0] shift;
    output [15:0] dataout;

    wire [7:0] temp0, temp1;
    ShiftLogic_8 sl0 (.datain(datain[7:0]), .shift(shift[7:0]), .dataout(dataout[7:0]));
    ShiftLogic_8e sle0 (.datain(datain[7:0]), .shift(shift[15:8]), .shiftl(shift[7:1]), .dataout(temp0[7:0]));
    ShiftLogic_8 sl1 (.datain(datain[15:8]), .shift(shift[7:0]), .dataout(temp1[7:0]));

    assign dataout[15:8] = temp0[7:0] | temp1[7:0];

endmodule