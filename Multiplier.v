//32位乘法器（4基booth）
`include "BoothEncode.v"
`include "GenProd.v"
`include "FA.v"
module Multiplier (a, b, sign, prod, overflow);
    input   [31:0]  a, b;
    input           sign;//有符号、无符号控制信号
    output  [63:0]  prod;
    output          overflow;

    wire    [16:0]  neg;
    wire    [16:0]  zero;
    wire    [16:0]  one;
    wire    [15:0]  two;
    wire    [16:0][32:0] pt;
    //17个booth编码
    BoothEncode BoothEncode0  (.code({b[1:0],1'b0}), .neg(neg[0]), .zero(zero[0]), .one(one[0]), .two(two[0]));
    genvar BE;
    generate
        for (BE=1; BE<16; BE = BE+1) begin
            BoothEncode BoothEn (.code(b[BE*2+1:BE*2-1]), .neg(neg[BE]), .zero(zero[BE]), .one(one[BE]), .two(two[BE]));
        end
    endgenerate
    BoothEncode BoothEncode16 (.code({2'b0,b[31]}), .neg(neg[16]), .zero(zero[16]), .one(one[16]), .two());
    //部分积生成
    genvar GP;
    generate
        for (GP=0; GP<17; GP=GP+1) begin
            GenProd GenProdi (.a(a), .neg(neg[GP]),  .zero(zero[GP]),  .one(one[GP]),  .two(two[GP]),  .prod(pt[GP]));
        end
    endgenerate
    //符号扩展
    wire [15:0] se;
    assign se[0]  = sign ? ~(neg[0] ^ b[31]) : neg[0];
    assign se[1]  = sign ? ~(neg[1] ^ b[31]) : neg[1];
    assign se[2]  = sign ? ~(neg[2] ^ b[31]) : neg[2];
    assign se[3]  = sign ? ~(neg[3] ^ b[31]) : neg[3];
    assign se[4]  = sign ? ~(neg[4] ^ b[31]) : neg[4];
    assign se[5]  = sign ? ~(neg[5] ^ b[31]) : neg[5];
    assign se[6]  = sign ? ~(neg[6] ^ b[31]) : neg[6];
    assign se[7]  = sign ? ~(neg[7] ^ b[31]) : neg[7];
    assign se[8]  = sign ? ~(neg[8] ^ b[31]) : neg[8];
    assign se[9]  = sign ? ~(neg[9] ^ b[31]) : neg[9];
    assign se[10] = sign ? ~(neg[10] ^ b[31]) : neg[10];
    assign se[11] = sign ? ~(neg[11] ^ b[31]) : neg[11];
    assign se[12] = sign ? ~(neg[12] ^ b[31]) : neg[12];
    assign se[13] = sign ? ~(neg[13] ^ b[31]) : neg[13];
    assign se[14] = sign ? ~(neg[14] ^ b[31]) : neg[14];
    assign se[15] = sign ? ~(neg[15] ^ b[31]) : neg[15];
    //Wallace树
    //第0层
    wire [38:0] a00, b00, c00, s00, co00;
    wire [40:0] a01, b01, c01, s01, co01;
    wire [40:0] a02, b02, c02, s02, co02;
    wire [40:0] a03, b03, c03, s03, co03;
    wire [40:0] a04, b04, c04, s04, co04;
    assign a00 = {3'b0,        ~se[0],  se[0],  se[0], pt[0]};
    assign b00 = {2'b0, 1'b1,  ~se[1],  pt[1],  1'b0,  se[0]};
    assign c00 = {      1'b1,  ~se[2],  pt[2],  1'b0,  se[1],  2'b0};
    assign a01 = {4'b0, 1'b1,  ~se[3],  pt[3],  1'b0,  se[2]};
    assign b01 = {2'b0, 1'b1,  ~se[4],  pt[4],  1'b0,  se[3],  2'b0};
    assign c01 = {      1'b1,  ~se[5],  pt[5],  1'b0,  se[4],  4'b0};
    assign a02 = {4'b0, 1'b1,  ~se[6],  pt[6],  1'b0,  se[5]};
    assign b02 = {2'b0, 1'b1,  ~se[7],  pt[7],  1'b0,  se[6],  2'b0};
    assign c02 = {      1'b1,  ~se[8],  pt[8],  1'b0,  se[7],  4'b0};
    assign a03 = {4'b0, 1'b1,  ~se[9],  pt[9],  1'b0,  se[8]};
    assign b03 = {2'b0, 1'b1,  ~se[10], pt[10], 1'b0,  se[9],  2'b0};
    assign c03 = {      1'b1,  ~se[11], pt[11], 1'b0,  se[10], 4'b0};
    assign a04 = {4'b0, 1'b1,  ~se[12], pt[12], 1'b0,  se[11]};
    assign b04 = {2'b0, 1'b1,  ~se[13], pt[13], 1'b0,  se[12], 2'b0};
    assign c04 = {      1'b1,  ~se[14], pt[14], 1'b0,  se[13], 4'b0};
    genvar i0, i1;
    generate
        for (i0=0 ; i0<39 ; i0=i0+1) begin
            FA FA00 (.a(a00[i0]), .b(b00[i0]), .ci(c00[i0]), .s(s00[i0]), .co(co00[i0]));
        end
        for (i1=0 ; i1<41 ; i1=i1+1) begin
            FA FA01 (.a(a01[i1]), .b(b01[i1]), .ci(c01[i1]), .s(s01[i1]), .co(co01[i1]));
            FA FA02 (.a(a02[i1]), .b(b02[i1]), .ci(c02[i1]), .s(s02[i1]), .co(co02[i1]));
            FA FA03 (.a(a03[i1]), .b(b03[i1]), .ci(c03[i1]), .s(s03[i1]), .co(co03[i1]));
            FA FA04 (.a(a04[i1]), .b(b04[i1]), .ci(c04[i1]), .s(s04[i1]), .co(co04[i1]));
        end
    endgenerate
    //第1层
    wire [44:0] a10, b10, c10, s10, co10;
    wire [46:0] a11, b11, c11, s11, co11;
    wire [46:0] a12, b12, c12, s12, co12;
    wire [40:0] a13, b13, c13, s13, co13;
    assign a10 = {6'b0, s00};
    assign b10 = {5'b0, co00, 1'b0};
    assign c10 = {s01, 4'b0};
    assign a11 = {6'b0, co01};
    assign b11 = {1'b0, s02, 5'b0};
    assign c11 = {co02, 6'b0};
    assign a12 = {6'b0, s03};
    assign b12 = {5'b0, co03, 1'b0};
    assign c12 = {s04, 6'b0};
    assign a13 = co04;
    assign b13 = {~se[15], pt[15], 1'b0, se[14], 5'b0};
    assign c13 = sign ? {33'b0, se[15], 6'b0} : {pt[16], 1'b0, se[15], 6'b0};
    genvar j0, j1, j2;
    generate
        for (j0=0 ; j0<45 ; j0=j0+1) begin
            FA FA10 (.a(a10[j0]), .b(b10[j0]), .ci(c10[j0]), .s(s10[j0]), .co(co10[j0]));
        end
        for (j1=0 ; j1<47 ; j1=j1+1) begin
            FA FA11 (.a(a11[j1]), .b(b11[j1]), .ci(c11[j1]), .s(s11[j1]), .co(co11[j1]));
            FA FA12 (.a(a12[j1]), .b(b12[j1]), .ci(c12[j1]), .s(s12[j1]), .co(co12[j1]));
        end
        for (j2=0 ; j2<41 ; j2=j2+1) begin
            FA FA13 (.a(a13[j2]), .b(b13[j2]), .ci(c13[j2]), .s(s13[j2]), .co(co13[j2]));
        end
    endgenerate
    //第二层
    wire [51:0] a20, b20, c20, s20, co20;
    wire [57:0] a21, b21, c21, s21, co21;
    assign a20 = {7'b0, s10};
    assign b20 = {6'b0, c10, 1'b0};
    assign c20 = {s11, 5'b0};
    assign a21 = {11'b0, co11};
    assign b21 = {1'b0, s12, 10'b0};
    assign c21 = {co12, 11'b0};
    genvar k0, k1;
    generate
        for (k0=0 ; k0<52 ; k0=k0+1) begin
            FA FA20 (.a(a20[k0]), .b(b20[k0]), .ci(c20[k0]), .s(s20[k0]), .co(co20[k0]));
        end
        for (k1=0 ; k1<58 ; k1=k1+1) begin
            FA FA21 (.a(a21[k1]), .b(b21[k1]), .ci(c21[k1]), .s(s21[k1]), .co(co21[k1]));
        end
    endgenerate
    //第三层
    wire [63:0] a30, b30, c30, s30, co30;
    wire [57:0] a31, b31, c31, s31, co31;
    assign a30 = {12'b0, s20};
    assign b30 = {11'b0, co20, 1'b0};
    assign c30 = {s21, 6'b0};
    assign a31 = co21;
    assign b31 = {s13, 16'b0};
    assign c31 = {co13[39:0], 17'b0};
    genvar l0, l1;
    generate
        for (l0=0 ; l0<64 ; l0=l0+1) begin
            FA FA30 (.a(a30[l0]), .b(b30[l0]), .ci(c30[l0]), .s(s30[l0]), .co(co30[l0]));
        end
        for (l1=0 ; l1<57 ; l1=l1+1) begin
            FA FA31 (.a(a31[l1]), .b(b31[l1]), .ci(c31[l1]), .s(s31[l1]), .co(co31[l1]));
        end
    endgenerate
    //第四层
    wire [63:0] a40, b40, c40, s40, co40;
    assign a40 = s30;
    assign b40 = {co30[62:0], 1'b0};
    assign c40 = {s31, 7'b0};
    genvar m0;
    generate
        for (m0=0 ; m0<64 ; m0=m0+1) begin
            FA FA40 (.a(a40[m0]), .b(b40[m0]), .ci(c40[m0]), .s(s40[m0]), .co(co40[m0]));
        end
    endgenerate
    //第五层
    wire [63:0] a50, b50, c50, s50, co50;
    assign a50 = s40;
    assign b50 = {co40[62:0], 1'b0};
    assign c50 = {co31[55:0], 8'b0};
    genvar n0;
    generate
        for (n0=0 ; n0<64 ; n0=n0+1) begin
            FA FA50 (.a(a50[n0]), .b(b50[n0]), .ci(c50[n0]), .s(s50[n0]), .co(co50[n0]));
        end
    endgenerate
    //第六层
    wire prodlo;
    Adder_32 prodl (.a(s50[31:0]), .b({co50[30:0], 1'b0}), .sub(1'b0), .sum(prod[31:0]), .overflow(prodlo), .zeroflag());
    Adder_32 prodh (.a(s50[63:32]), .b(co50[62:31]), .sub(1'b0), .sum(prod[63:32]), .overflow(overflow), .zeroflag());
endmodule