//具有成组进位产生/传播功能的4位成组Ling先行进位

module LingBCLG_4 (g, t, cin, gg, gt, h);
    input [3:0] g;
    input [2:0] t;
    input cin;
    output gg, gt;
    output [2:0] h;

    assign h[0] = g[0] | cin;
    assign h[1] = g[1] | & g[0] | (t[0] & cin);
    assign h[2] = g[2] | & g[1] | (t[1] & g[0]) | (t[1] & t[0] & cin);

    assign gg = g[3] | & g[2] | (t[2] & g[1]) | (t[2] & t[1] & g[0]);
    assign gt = t[2] & t[1] & t[0];

endmodule