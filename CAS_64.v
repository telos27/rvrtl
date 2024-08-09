//64位可控加减单元
`include "FastAdder_16.v"
module CAS_64 (a, b, sub, result, q);
    input  [63:0] a;
    input  [63:0] b;
    input  sub;
    output [63:0] result;
    output q;

    wire ctemp0, ctemp1, ctemp2;
    wire [63:0] sum;

    FastAdder_16 FastAdder_16_0 (.a(a[15:0]),  .b(b[15:0]),  .cin(sub),    .sum(sum[15:0]),  .cout(ctemp0));
    FastAdder_16 FastAdder_16_1 (.a(a[31:16]), .b(b[31:16]), .cin(ctemp0), .sum(sum[31:16]), .cout(ctemp1));
    FastAdder_16 FastAdder_16_2 (.a(a[47:32]), .b(b[47:32]), .cin(ctemp1), .sum(sum[47:32]), .cout(ctemp2));
    FastAdder_16 FastAdder_16_3 (.a(a[63:48]), .b(b[63:48]), .cin(ctemp2), .sum(sum[63:48]), .cout());

    assign result = sum[63] ? a : sum;
    assign q = ~sum[63];
endmodule