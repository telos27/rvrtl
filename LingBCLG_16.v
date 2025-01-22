//具有成组进位产生/传播功能的16位成组先行进位部件
`include "LingBCLG_4.v"
`include "BCLG_4.v"

module LingBCLG_16 (a, b, cin, sum, ggout, gtout);
    input [15:0] a, b;
    input cin;
    output [15:0] sum;
    output ggout, gtout;

    wire [15:0] p, g, t;
    assign p = a ^ b;
    assign g = a & b;
    assign t = a | b;

    wire [15:0] h;
    wire [3:0] gg, gt, ggin, gtin;
    wire [2:0] c;

    LingBCLG_4 u0 (.g(g[3:0]),   .t(t[2:0]),   .cin(cin),  .gg(gg[0]), .gt(gt[0]), .h(h[2:0]));
    LingBCLG_4 u1 (.g(g[7:4]),   .t(t[6:4]),   .cin(c[0]), .gg(gg[1]), .gt(gt[1]), .h(h[6:4]));
    LingBCLG_4 u2 (.g(g[11:8]),  .t(t[10:8]),  .cin(c[1]), .gg(gg[2]), .gt(gt[2]), .h(h[10:8]));
    LingBCLG_4 u3 (.g(g[15:12]), .t(t[14:12]), .cin(c[2]), .gg(gg[3]), .gt(gt[3]), .h(h[14:12]));

    assign ggin[3:0] = gg[3:0] & {t[15], t[11], t[7], t[3]};
    assign gtin[3:0] = gt[3:0] & {t[15], t[11], t[7], t[3]};

    BCLG_4 bclg (.g(ggin), .t(gtin), .cin(cin), .cout(c), .gg(ggout), .gt(gtout));

    assign sum[0] = p[0] ^ cin;
    assign sum[3:1] = p[3:1] ^ h[2:0] & t[2:0];
    assign sum[4] = p[4] ^ c[0];
    assign sum[7:5] = p[7:5] ^ h[6:4] & t[6:4];
    assign sum[8] = p[8] ^ c[1];
    assign sum[11:9] = p[11:9] ^ h[10:8] & t[10:8];
    assign sum[12] = p[12] ^ c[2];
    assign sum[15:13] = p[15:13] ^ h[14:12] & t[14:12];

endmodule