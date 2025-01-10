//16位先行进位加法器
`include "BCLG_4.v"
`include "CLG_4.v"

module CLA_16 (a, b, cin, sum, cout);
    input [15:0] a, b;
    input cin;
    output [15:0] sum;
    output cout;

    wire [15:0] p, g, t;
    wire [14:0] c;
    wire [3:0] gg, gt;

    // 计算每一位的g和t
    assign p[15:0] = a[15:0] ^ b[15:0];
    assign g[15:0] = a[15:0] & b[15:0];
    assign t[15:0] = a[15:0] ^ b[15:0];

    // 4位先行进位
    BCLG_4 bclg0 (.g(g[3:0]), .t(t[3:0]), .cin(cin), .cout(c[2:0]), .gg(gg[0]), .gt(gt[0]));
    BCLG_4 bclg1 (.g(g[7:4]), .t(t[7:4]), .cin(c[3]), .cout(c[6:4]), .gg(gg[1]), .gt(gt[1]));
    BCLG_4 bclg2 (.g(g[11:8]), .t(t[11:8]), .cin(c[7]), .cout(c[10:8]), .gg(gg[2]), .gt(gt[2]));
    BCLG_4 bclg3 (.g(g[15:12]), .t(t[15:12]), .cin(c[11]), .cout(c[14:12]), .gg(gg[3]), .gt(gt[3]));

    // 4位组间进位
    CLG_4 clg (.g(gg), .t(gt), .cin(cin), .cout({cout, c[11], c[7], c[3]}));

    // 计算和
    assign sum[0] = p[0] ^ cin;
    assign sum[15:1] = p[15:1] ^ c[14:0];

endmodule