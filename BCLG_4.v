//具有成组进位产生/传播功能的4位成组先行进位部件

module BCLG_4 (g, t, cin, cout, gg, gt);
    input [3:0] g, t;
    input cin;
    output [2:0] cout;
    output gg, gt;

    assign cout[0] = g[0] | (t[0] & cin);
    assign cout[1] = g[1] | (t[1] & g[0]) | (t[1] & t[0] & cin);
    assign cout[2] = g[2] | (t[2] & g[1]) | (t[2] & t[1] & g[0]) | (t[2] & t[1] & t[0] & cin);

    assign gg = g[3] | (t[3] & g[2]) | (t[3] & t[2] & g[1]) | (t[3] & t[2] & t[1] & g[0]);
    assign gt = t[3] & t[2] & t[1] & t[0];

endmodule