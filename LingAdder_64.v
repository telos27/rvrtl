// 64位Ling进位加法器
`include "LingBCLG_16.v"
`include "LingCLG_4.v"

module LingAdder_64 (a, b, cin, sum, cout);
    input [63:0] a, b;
    input cin;
    output [63:0] sum;
    output cout;

    wire [63:0] p, g, t;
    wire [63:0] h;
    assign p = a ^ b;
    assign g = a & b;
    assign t = a | b;

    wire [3:0] gg;
    wire [2:0] gt;
    // 4个LingBCLG_16模块，第一级进位产生/传播功能
    LingBCLG_16 bclg0 (.g(g[15:0]),  .t(t[14:0]),  .cin(cin),           .gg(gg[0]), .gt(gt[0]), .h(h[14:0]));
    LingBCLG_16 bclg1 (.g(g[31:16]), .t(t[30:16]), .cin(h[15] & t[15]), .gg(gg[1]), .gt(gt[1]), .h(h[30:16]));
    LingBCLG_16 bclg2 (.g(g[47:32]), .t(t[46:32]), .cin(h[31] & t[31]), .gg(gg[2]), .gt(gt[2]), .h(h[46:32]));
    LingBCLG_16 bclg3 (.g(g[63:48]), .t(t[62:48]), .cin(h[47] & t[47]), .gg(gg[3]), .gt(),      .h(h[62:48]));

    // 1个LingCLG_4模块，第二级进位产生/传播功能
    LingCLG_4 clg (.g(gg), .t(gt), .cin(cin), .h({h[63], h[47], h[31], h[15]}));

    assign sum[0] = p[0] ^ cin;
    assign sum[15:1] = p[15:1] ^ h[14:0] & t[14:0];
    assign sum[15] = p[15] ^ h[14] & t[14];
    assign sum[31:16] = p[31:16] ^ h[30:15] & t[30:15];
    assign sum[31] = p[31] ^ h[30] & t[30];
    assign sum[47:32] = p[47:32] ^ h[46:32] & t[46:31];
    assign sum[47] = p[47] ^ h[46] & t[46];
    assign sum[63:48] = p[63:48] ^ h[62:48] & t[62:48];
    assign cout = t[63] & h[63];

endmodule