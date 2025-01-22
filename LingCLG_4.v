//4位Ling先行进位部件

module LingCLG_4 (g, t, cin, h, gg, gt);
    input [3:0] g, t;
    input cin;
    output [3:0] h;
    output gg, gt;

    assign h[0] = g[0] | cin;
    assign h[1] = g[1] | & g[0] | (t[0] & cin);
    assign h[2] = g[2] | & g[1] | (t[1] & g[0]) | (t[1] & t[0] & cin);
    assign h[3] = gg | (gt & cin);

    assign gg = g[3] | & g[2] | (t[2] & g[1]) | (t[2] & t[1] & g[0]);
    assign gt = t[2] & t[1] & t[0];

endmodule