//4位Ling进位生成部件
module LingCLG_4 (g, t, cin, h);
    input [3:0] g;
    input [2:0] t;
    input cin;
    output [3:0] h;

    assign h[0] = g[0] | cin;
    assign h[1] = g[1] | g[0] | (t[0] & cin);
    assign h[2] = g[2] | g[1] | (t[1] & g[0]) | (t[1] & t[0] & cin);
    assign h[3] = g[3] | g[2] | (t[2] & g[1]) | (t[2] & t[1] & g[0]) | (t[2] & t[1] & t[0] & cin);

endmodule