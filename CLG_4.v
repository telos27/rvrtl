//4位先行进位部件

module CLG_4 (g, t, cin, cout);
    input [3:0] g, t;
    input cin;
    output [3:0] cout;

    assign cout[0] = g[0] | (t[0] & cin);
    assign cout[1] = g[1] | (t[1] & g[0]) | (t[1] & t[0] & cin);
    assign cout[2] = g[2] | (t[2] & g[1]) | (t[2] & t[1] & g[0]) | (t[2] & t[1] & t[0] & cin);
    assign cout[3] = g[3] | (t[3] & g[2]) | (t[3] & t[2] & g[1]) | (t[3] & t[2] & t[1] & g[0]) | (t[3] & t[2] & t[1] & t[0] & cin);

endmodule