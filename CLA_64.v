// 64位先行进位加法器
`include "BCLG_16.v"
`include "CLG_4.v"

module CLA_64 (a, b, cin, sum, cout);
    input [63:0] a, b;
    input cin;
    output [63:0] sum;
    output cout;

    wire [63:0] p, g, t;
    wire [62:0] c;
    wire [3:0] gg, gt;

    // 计算每一位的g和t
    assign p[63:0] = a[63:0] ^ b[63:0];
    assign g[63:0] = a[63:0] & b[63:0];
    assign t[63:0] = a[63:0] ^ b[63:0];

    // 16位先行进位
    BCLG_16 bclg0 (.g(g[15:0]), .t(t[15:0]), .cin(cin), .cout(c[14:0]), .ggout(gg[0]), .gtout(gt[0]));
    BCLG_16 bclg1 (.g(g[31:16]), .t(t[31:16]), .cin(c[15]), .cout(c[30:16]), .ggout(gg[1]), .gtout(gt[1]));
    BCLG_16 bclg2 (.g(g[47:32]), .t(t[47:32]), .cin(c[31]), .cout(c[46:32]), .ggout(gg[2]), .gtout(gt[2]));
    BCLG_16 bclg3 (.g(g[63:48]), .t(t[63:48]), .cin(c[47]), .cout(c[62:48]), .ggout(gg[3]), .gtout(gt[3]));

    // 16位组间进位
    CLG_4 clg (.g(gg), .t(gt), .cin(cin), .cout({cout, c[47], c[31], c[15]}));

    // 计算和
    assign sum[0] = p[0] ^ cin;
    assign sum[63:1] = p[63:1] ^ c[62:0];

endmodule