// 64位全先行进位的加法器
`include "BCLG_16.v"
`include "CLG_4.v"

module FastAdder_64 (a, b, cin, sum, cout);
    input [63:0] a, b;
    input cin;
    output [63:0] sum;
    output cout;
    
    wire [63:0] g, p;
    assign g = a & b;
    assign p = a ^ b;

    wire [3:0] gg, pp, cctemp;
    wire [14:0] ctemp0, ctemp1, ctemp2, ctemp3;
    BCLG_16 bclg0 (.g(g[15:0]), .p(p[15:0]), .cin(cin), .gg(gg[0]), .pp(pp[0]), .cout(ctemp0[14:0]));
    BCLG_16 bclg1 (.g(g[31:16]), .p(p[31:16]), .cin(cctemp[1]), .gg(gg[1]), .pp(pp[1]), .cout(ctemp1[14:0]));
    BCLG_16 bclg2 (.g(g[47:32]), .p(p[47:32]), .cin(cctemp[2]), .gg(gg[2]), .pp(pp[2]), .cout(ctemp2[14:0]));
    BCLG_16 bclg3 (.g(g[63:48]), .p(p[63:48]), .cin(cctemp[3]), .gg(gg[3]), .pp(pp[3]), .cout(ctemp3[14:0]));

    CLG_4 clg (.g(gg[3:0]), .p(pp[3:0]), .cin(cin), .cout(cctemp[3:0]));

    assign sum[0] = p[0] ^ cin;
    assign sum[14:1] = ctemp0[14:0] ^ p[14:1];
    assign sum[15] = cctemp[0] ^ p[15];
    assign sum[30:16] = ctemp1[14:0] ^ p[30:16];
    assign sum[31] = cctemp[1] ^ p[31];
    assign sum[47:32] = ctemp2[14:0] ^ p[47:32];
    assign sum[48] = cctemp[2] ^ p[48];
    assign sum[63:49] = ctemp3[14:0] ^ p[63:49];
    assign cout = cctemp[3];

endmodule