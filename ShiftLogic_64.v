//64位移位逻辑
`include "ShiftLogic_32.v"
`include "ShiftLogic_32e.v"

module ShiftLogic_64 (datain, shift, dataout);
    input [63:0] datain;
    input [63:0] shift;
    output [63:0] dataout;

    wire [31:0] temp0, temp1;
    ShiftLogic_32 sl0 (.datain(datain[31:0]), .shift(shift[31:0]), .dataout(dataout[31:0]));
    ShiftLogic_32e sle0 (.datain(datain[31:0]), .shift(shift[63:32]), .shiftl(shift[31:1]), .dataout(temp0[31:0]));
    ShiftLogic_32 sl1 (.datain(datain[63:32]), .shift(shift[31:0]), .dataout(temp1[31:0]));

    assign dataout[63:32] = temp0[31:0] | temp1[31:0];

endmodule