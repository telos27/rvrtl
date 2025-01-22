//4位Ling进位加法器
`include "LingCLG_4.v"

module LingCLA_4 (a, b, cin, sum, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;

    wire [3:0] g, t, p, h;
    assign g = a & b;
    assign p = a ^ b;
    assign t = a | b;

    LingCLG_4 clg (.g(g), .t(t[2:0]), .cin(cin), .h(h));

    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ h[0] & t[0];
    assign sum[2] = p[2] ^ h[1] & t[1];
    assign sum[3] = p[3] ^ h[2] & t[2];

    assign cout = h[3] & t[3];

endmodule