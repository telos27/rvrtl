//具有成组进位产生/传播功能的4位成组先行进位生成部件
module BCLG_4 (g, p, cin, gg, gp, cout);
    input [3:0] g, p;
    input cin;
    output [2:0] cout;
    output gg, gp;

    assign cout[0] = g[0] | (p[0] & cin);
    assign cout[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign cout[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

    assign gg = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
    assign gp = p[3] & p[2] & p[1] & p[0] & cin;

endmodule