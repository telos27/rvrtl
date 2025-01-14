//32位移位逻辑
`include "ShiftLogic_16.v"
`include "ShiftLogic_16e.v"

module ShiftLogic_32 (datain, shift, dataout);
    input [31:0] datain;
    input [31:0] shift;
    output [31:0] dataout;

    wire [15:0] temp0, temp1;
    ShiftLogic_16 sl0 (.datain(datain[15:0]), .shift(shift[15:0]), .dataout(dataout[15:0]));
    ShiftLogic_16e sle0 (.datain(datain[15:0]), .shift(shift[31:16]), .shiftl(shift[15:1]), .dataout(temp0[15:0]));
    ShiftLogic_16 sl1 (.datain(datain[31:16]), .shift(shift[15:0]), .dataout(temp1[15:0]));

    assign dataout[31:16] = temp0[15:0] | temp1[15:0];

endmodule