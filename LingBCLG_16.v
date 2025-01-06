//具有成组进位产生/传播功能的16位成组Ling进位生成部件
`include "LingBCLG_4.v"

module LingBCLG_16 (g, t, cin, gg, gt, h);
    input [15:0] g;
    input [14:0] t;
    input cin;
    output gg, gt;
    output [14:0] h;

    wire [3:0] ggtemp;
    wire [2:0] gttemp;
    // 4个LingBCLG_4模块，第一级进位产生/传播功能
    LingBCLG_4 u0 (.g(g[3:0]),   .t(t[2:0]),   .cin(cin),           .gg(ggtemp[0]), .gt(gttemp[0]), .h(h[2:0]));
    LingBCLG_4 u1 (.g(g[7:4]),   .t(t[6:4]),   .cin(h[3] & t[3]),   .gg(ggtemp[1]), .gt(gttemp[1]), .h(h[6:4]));
    LingBCLG_4 u2 (.g(g[11:8]),  .t(t[10:8]),  .cin(h[7] & t[7]),   .gg(ggtemp[2]), .gt(gttemp[2]), .h(h[10:8]));
    LingBCLG_4 u3 (.g(g[15:12]), .t(t[14:12]), .cin(h[11] & t[11]), .gg(ggtemp[3]), .gt(),          .h(h[14:12]));

    // 1个LingBCLG_4模块，第二级进位产生/传播功能
    LingBCLG_4 u4 (.g(ggtemp), .t(gttemp), .cin(cin), .gg(gg), .gt(gt), .h({h[11], h[7], h[3]}));

endmodule