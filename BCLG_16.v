//具有成组进位产生/传播功能的16位成组先行进位部件
`include "BCLG_4.v"

module BCLG_16 (g, t, cin, cout, ggout, gtout);
    input [15:0] g, t;
    input cin;
    output [14:0] cout;
    output ggout, gtout;

    wire [3:0] gg, gt;

    // 4位先行进位
    BCLG_4 bclg0 (.g(g[3:0]), .t(t[3:0]), .cin(cin), .cout(cout[2:0]), .gg(gg[0]), .gt(gt[0]));
    BCLG_4 bclg1 (.g(g[7:4]), .t(t[7:4]), .cin(cout[3]), .cout(cout[6:4]), .gg(gg[1]), .gt(gt[1]));
    BCLG_4 bclg2 (.g(g[11:8]), .t(t[11:8]), .cin(cout[7]), .cout(cout[10:8]), .gg(gg[2]), .gt(gt[2]));
    BCLG_4 bclg3 (.g(g[15:12]), .t(t[15:12]), .cin(cout[11]), .cout(cout[14:12]), .gg(gg[3]), .gt(gt[3]));

    // 4位组间进位
    BCLG_4 bclg4 (.g(gg), .t(gt), .cin(cin), .cout({cout[11], cout[7], cout[3]}), .gg(ggout), .gt(gtout));

endmodule