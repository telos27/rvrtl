//8位移位逻辑
`include "ShiftLogic_4.v"
`include "ShiftLogic_4e.v"

module ShiftLogic_8 (datain, shift, dataout);
    input [7:0] datain;
    input [7:0] shift;
    output [7:0] dataout;

    wire [3:0] temp0, temp1;
    ShiftLogic_4 sl4_0 (.datain(datain[3:0]), .shift(shift[3:0]), .dataout(dataout[3:0]));
    ShiftLogic_4e sl4e0 (.datain(datain[3:0]), .shift(shift[7:4]), .shiftl(shift[3:1]), .dataout(temp0[3:0]));
    ShiftLogic_4 sl4_1 (.datain(datain[7:4]), .shift(shift[3:0]), .dataout(temp1[3:0]));

    assign dataout[7:4] = temp0 | temp1;

endmodule