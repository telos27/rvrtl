//4位先行进位生成部件
module CLG_4 (g, p, cin, cout);
    input [3:0] g, p;
    input cin;
    output [3:0] cout;

    assign cout[0] = g[0] | (p[0] & cin);
    assign cout[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign cout[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
    assign cout[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

endmodule