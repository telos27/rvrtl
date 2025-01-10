// 64位Ling进位加法器
`include "LingBCLG_16.v"
`include "CLG_4.v"

module LingCLA_64 (a, b, cin, sum, cout);
    input [63:0] a, b;
    input cin;
    output [63:0] sum;
    output cout;

    wire [63:0] h;
    wire [3:0] gg, gt;
    wire [2:0] c;

    LingBCLG_16 lingbclg0 (.a(a[15:0]),  .b(b[15:0]),  .cin(cin),  .sum(sum[15:0]),  .ggout(gg[0]), .gtout(gt[0]));
    LingBCLG_16 lingbclg1 (.a(a[31:16]), .b(b[31:16]), .cin(c[0]), .sum(sum[31:16]), .ggout(gg[1]), .gtout(gt[1]));
    LingBCLG_16 lingbclg2 (.a(a[47:32]), .b(b[47:32]), .cin(c[1]), .sum(sum[47:32]), .ggout(gg[2]), .gtout(gt[2]));
    LingBCLG_16 lingbclg3 (.a(a[63:48]), .b(b[63:48]), .cin(c[2]), .sum(sum[63:48]), .ggout(gg[3]), .gtout(gt[3]));

    CLG_4 clg (.g(gg), .t(gt), .cin(cin), .cout({cout, c}));

endmodule