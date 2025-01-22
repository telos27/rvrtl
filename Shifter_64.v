//64位移位器
`include "Reverser_64.v"
`include "ShiftDecoder_64.v"
`include "ShiftLogic_64.v"
`include "SRASignExtender.v"

module Shifter_64 (datain, shift, right, sra, dataout);
    input [63:0] datain;
    input [5:0] shift;
    input right;
    input sra;
    output [63:0] dataout;

    wire [63:0] intemp, shiftcode, outtemp0, outtemp1, signextend;

    Reverser_64 reverserin (.right(right), .datain(datain), .dataout(intemp));

    ShiftDecoder_64 decoder (.datain(shift), .dataout(shiftcode));

    ShiftLogic_64 shiftlogic (.datain(intemp), .shift(shiftcode), .dataout(outtemp0));

    Reverser_64 reverserout (.right(right), .datain(outtemp0), .dataout(outtemp1));

    SRASignExtender srasignextender (.signex(right & sra), .datain(outtemp1), .signextend(signextend));

    assign dataout = outtemp1 | signextend;

endmodule