//除法器余数计算单元
module Remainder (a, b, remainder, quotient);
    input  [63:0] a;
    input  [63:0] b;
    output [63:0] remainder;
    output quotient;

    wire ctemp0, ctemp1, ctemp2;
    wire [63:0] remainder_temp;

    FastAdder_16 FastAdder_16_0 (.a(a[15:0]),  .b(b[15:0]),  .cin(1'b0),
                                .sum(remainder_temp[15:0]),  .cout(ctemp0));
    FastAdder_16 FastAdder_16_1 (.a(a[31:16]), .b(b[31:16]), .cin(ctemp0),
                                .sum(remainder_temp[31:16]), .cout(ctemp1));
    FastAdder_16 FastAdder_16_2 (.a(a[47:32]), .b(b[47:32]), .cin(ctemp1),
                                .sum(remainder_temp[47:32]), .cout(ctemp2));
    FastAdder_16 FastAdder_16_3 (.a(a[63:48]), .b(b[63:48]), .cin(ctemp2),
                                .sum(remainder_temp[63:48]), .cout());
    assign quotient = ~remainder_temp[63];
    assign remainder = remainder_temp[63] ? a : remainder_temp;
endmodule