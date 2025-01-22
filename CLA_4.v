// 4位先行进位加法器
`include "CLG_4.v"

module CLA_4 (a, b, cin, sum, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;

    wire [3:0] g, t, p, c;
    assign g = a & b;
    assign p = a ^ b;
    assign t = p ^ cin;

    CLG_4 clg (.g(g), .t(t), .cin(cin), .cout(c));

    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c[0];
    assign sum[2] = p[2] ^ c[1];
    assign sum[3] = p[3] ^ c[2];

    assign cout = c[3];

endmodule