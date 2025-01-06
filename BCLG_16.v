//具有成组进位产生/传播功能的16位成组先行进位生成部件
`include "BCLG_4.v"

module BCLG_16 (g, p, cin, gg, gp, cout);
    input [15:0] g, p;
    input cin;
    output [14:0] cout;
    output gg, gp;

    wire [3:0] ggtemp, pptemp;
    wire [2:0] cctemp;

    // 4个BCLG_4模块，第一级进位产生/传播功能
    BCLG_4 bclg0 (.g(g[3:0]),   .p(p[3:0]),   .cin(cin),       .gg(ggtemp[0]), .gp(pptemp[0]), .cout(cout[2:0]  ));
    BCLG_4 bclg1 (.g(g[7:4]),   .p(p[7:4]),   .cin(cctemp[0]), .gg(ggtemp[1]), .gp(pptemp[1]), .cout(cout[6:4]  ));
    BCLG_4 bclg2 (.g(g[11:8]),  .p(p[11:8]),  .cin(cctemp[1]), .gg(ggtemp[2]), .gp(pptemp[2]), .cout(cout[10:8] ));
    BCLG_4 bclg3 (.g(g[15:12]), .p(p[15:12]), .cin(cctemp[2]), .gg(ggtemp[3]), .gp(pptemp[3]), .cout(cout[14:12]));

    // 一个BCLG_4模块，第二级进位产生/传播功能
    BCLG_4 bclg4 (.g(ggtemp[3:0]), .p(pptemp[3:0]), .cin(cin), .gg(gg), .gp(gp), .cout(cctemp[2:0]));
    assign cout[3] = cctemp[0];
    assign cout[7] = cctemp[1];
    assign cout[11] = cctemp[2];

endmodule