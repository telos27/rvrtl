//32位乘法器（4基booth）
`include "BoothEncode.v"
`include "GenProd.v"
`include "FA.v"
module Multiplier (a, b, sign, prod, overflow);
    input [31:0] a, b;
    input sign;//有符号、无符号控制信号
    output [63:0] prod;
    output overflow;

    wire [16:0] neg, zero, one;
    wire [15:0] two;
    wire [16:0][32:0] pt;

    //17个booth编码
    BoothEncode BoothEncode0 (.code({b[1:0],1'b0}), .neg(neg[0]), .zero(zero[0]), .one(one[0]), .two(two[0]));
    BoothEncode BoothEncode1 (.code(b[3:1]), .neg(neg[1]), .zero(zero[1]), .one(one[1]), .two(two[1]));
    BoothEncode BoothEncode2 (.code(b[5:3]), .neg(neg[2]), .zero(zero[2]), .one(one[2]), .two(two[2]));
    BoothEncode BoothEncode3 (.code(b[7:5]), .neg(neg[3]), .zero(zero[3]), .one(one[3]), .two(two[3]));
    BoothEncode BoothEncode4 (.code(b[9:7]), .neg(neg[4]), .zero(zero[4]), .one(one[4]), .two(two[4]));
    BoothEncode BoothEncode5 (.code(b[11:9]), .neg(neg[5]), .zero(zero[5]), .one(one[5]), .two(two[5]));
    BoothEncode BoothEncode6 (.code(b[13:11]), .neg(neg[6]), .zero(zero[6]), .one(one[6]), .two(two[6]));
    BoothEncode BoothEncode7 (.code(b[15:13]), .neg(neg[7]), .zero(zero[7]), .one(one[7]), .two(two[7]));
    BoothEncode BoothEncode8 (.code(b[17:15]), .neg(neg[8]), .zero(zero[8]), .one(one[8]), .two(two[8]));
    BoothEncode BoothEncode9 (.code(b[19:17]), .neg(neg[9]), .zero(zero[9]), .one(one[9]), .two(two[9]));
    BoothEncode BoothEncode10 (.code(b[21:19]), .neg(neg[10]), .zero(zero[10]), .one(one[10]), .two(two[10]));
    BoothEncode BoothEncode11 (.code(b[23:21]), .neg(neg[11]), .zero(zero[11]), .one(one[11]), .two(two[11]));
    BoothEncode BoothEncode12 (.code(b[25:23]), .neg(neg[12]), .zero(zero[12]), .one(one[12]), .two(two[12]));
    BoothEncode BoothEncode13 (.code(b[27:25]), .neg(neg[13]), .zero(zero[13]), .one(one[13]), .two(two[13]));
    BoothEncode BoothEncode14 (.code(b[29:27]), .neg(neg[14]), .zero(zero[14]), .one(one[14]), .two(two[14]));
    BoothEncode BoothEncode15 (.code(b[31:29]), .neg(neg[15]), .zero(zero[15]), .one(one[15]), .two(two[15]));
    BoothEncode BoothEncode16 (.code({2'b0,b[31]}), .neg(neg[16]), .zero(zero[16]), .one(one[16]), .two());
    //部分积生成
    GenProd GenProd0 (.a(a), .neg(neg[0]), .zero(zero[0]), .one(one[0]), .two(two[0]), .prod(pt[0]));
    GenProd GenProd1 (.a(a), .neg(neg[1]), .zero(zero[1]), .one(one[1]), .two(two[1]), .prod(pt[1]));
    GenProd GenProd2 (.a(a), .neg(neg[2]), .zero(zero[2]), .one(one[2]), .two(two[2]), .prod(pt[2]));
    GenProd GenProd3 (.a(a), .neg(neg[3]), .zero(zero[3]), .one(one[3]), .two(two[3]), .prod(pt[3]));
    GenProd GenProd4 (.a(a), .neg(neg[4]), .zero(zero[4]), .one(one[4]), .two(two[4]), .prod(pt[4]));
    GenProd GenProd5 (.a(a), .neg(neg[5]), .zero(zero[5]), .one(one[5]), .two(two[5]), .prod(pt[5]));
    GenProd GenProd6 (.a(a), .neg(neg[6]), .zero(zero[6]), .one(one[6]), .two(two[6]), .prod(pt[6]));
    GenProd GenProd7 (.a(a), .neg(neg[7]), .zero(zero[7]), .one(one[7]), .two(two[7]), .prod(pt[7]));
    GenProd GenProd8 (.a(a), .neg(neg[8]), .zero(zero[8]), .one(one[8]), .two(two[8]), .prod(pt[8]));
    GenProd GenProd9 (.a(a), .neg(neg[9]), .zero(zero[9]), .one(one[9]), .two(two[9]), .prod(pt[9]));
    GenProd GenProd10 (.a(a), .neg(neg[10]), .zero(zero[10]), .one(one[10]), .two(two[10]), .prod(pt[10]));
    GenProd GenProd11 (.a(a), .neg(neg[11]), .zero(zero[11]), .one(one[11]), .two(two[11]), .prod(pt[11]));
    GenProd GenProd12 (.a(a), .neg(neg[12]), .zero(zero[12]), .one(one[12]), .two(two[12]), .prod(pt[12]));
    GenProd GenProd13 (.a(a), .neg(neg[13]), .zero(zero[13]), .one(one[13]), .two(two[13]), .prod(pt[13]));
    GenProd GenProd14 (.a(a), .neg(neg[14]), .zero(zero[14]), .one(one[14]), .two(two[14]), .prod(pt[14]));
    GenProd GenProd15 (.a(a), .neg(neg[15]), .zero(zero[15]), .one(one[15]), .two(two[15]), .prod(pt[15]));
    GenProd GenProd16 (.a(a), .neg(neg[16]), .zero(zero[16]), .one(one[16]), .two(two[16]), .prod(pt[16]));
    //Wallace树
    //第零层
    wire [38:0] a00, b00, c00, s00, co00;
    assign a00 = {3'b0, neg[0], ~neg[0], ~neg[0], pt[0],neg[0]};
    assign b00 = {3'b1, ~neg[1], pt[1], 1'b0, neg[1]};
    assign c00 = {1'b1, neg[2], pt[2], 1'b0, pt[2][31], 2'b0};
    genvar i0;
    generate
        for (i0=0 ; i0<39 ; i0=i0+1) begin
            FA FA (.a(a00[i0]), .b(b00[i0]), .ci(c00[i0]), .s(s00[i0]), .co(co00[i0]));
        end
    endgenerate
    wire [40:0] a01, b01, c01, s01, co01;
    assign a01 = {5'b1, neg[3], pt[3], 1'b0, neg[3]};
    assign b01 = {3'b1, neg[4], pt[4], 1'b0, neg[4], 2'b0};
    assign c01 = {1'b1, neg[5], pt[5], 1'b0, neg[5], 4'b0};
    genvar i1;
    generate
        for (i1=0 ; i1<41 ; i1=i1+1) begin
            FA FA (.a(a01[i1]), .b(b01[i1]), .ci(c01[i1]), .s(s01[i1]), .co(co01[i1]));
        end
    endgenerate
    wire [40:0] a02, b02, c02, s02, co02;
    assign a02 = {5'b1, neg[6], pt[6], 1'b0, neg[6]};
    assign b02 = {3'b1, neg[7], pt[7], 1'b0, neg[7], 2'b0};
    assign c02 = {1'b1, neg[8], pt[8], 1'b0, neg[8], 4'b0};
    genvar i2;
    generate
        for (i2=0 ; i2<41 ; i2=i2+1) begin
            FA FA (.a(a02[i2]), .b(b02[i2]), .ci(c02[i2]), .s(s02[i2]), .co(co02[i2]));
        end
    endgenerate
    wire [40:0] a03, b03, c03, s03, co03;
    assign a03 = {5'b1, neg[9], pt[9], 1'b0, neg[9]};
    assign b03 = {3'b1, neg[10], pt[10], 1'b0, neg[10], 2'b0};
    assign c03 = {1'b1, neg[11], pt[11], 1'b0, neg[11], 4'b0};
    genvar i3;
    generate
        for (i3=0 ; i3<41 ; i3=i3+1) begin
            FA FA (.a(a03[i3]), .b(b03[i3]), .ci(c03[i3]), .s(s03[i3]), .co(co03[i3]));
        end
    endgenerate
    wire [40:0] a04, b04, c04, s04, co04;
    assign a04 = {5'b1, neg[12], pt[12], 1'b0, neg[12]};
    assign b04 = {3'b1, neg[13], pt[13], 1'b0, neg[13], 2'b0};
    assign c04 = {1'b1, neg[14], pt[14], 1'b0, neg[14], 4'b0};
    genvar i4;
    generate
        for (i4=0 ; i4<41 ; i4=i4+1) begin
            FA FA (.a(a04[i4]), .b(b04[i4]), .ci(c04[i4]), .s(s04[i4]), .co(co04[i4]));
        end
    endgenerate
    //第一层
    wire [44:0] a10, b10, c10, s10, co10;
    assign a10 = {6'b0, s00};
    assign b10 = {5'b0, co00, 1'b0};
    assign c10 = {s01, 4'b0};
    genvar j0;
    generate
        for (j0=0 ; j0<45 ; j0=j0+1) begin
            FA FA (.a(a10[j0]), .b(b10[j0]), .ci(c10[j0]), .s(s10[j0]), .co(co10[j0]));
        end
    endgenerate
    wire [46:0] a11, b11, c11, s11, co11;
    assign a11 = {5'b0, co01};
    assign b11 = {1'b0, s02, 5'b0};
    assign c11 = {co02,6'b0};
    genvar j1;
    generate
        for (j1=0 ; j1<47 ; j1=j1+1) begin
            FA FA (.a(a11[j1]), .b(b11[j1]), .ci(c11[j1]), .s(s11[j1]), .co(co11[j1]));
        end
    endgenerate
    wire [46:0] a12, b12, c12, s12, co12;
    assign a12 = {6'b0, s03};
    assign b12 = {5'b0, co03, 1'b0};
    assign c12 = {s04,6'b0};
    genvar j2;
    generate
        for (j2=0 ; j2<47 ; j2=j2+1) begin
            FA FA (.a(a12[j2]), .b(b12[j2]), .ci(c12[j2]), .s(s12[j2]), .co(co12[j2]));
        end
    endgenerate
    wire [40:0] a13, b13, c13, s13, co13;
    assign a13 = co04;
    assign b13 = {neg[15], pt[15], 1'b0, neg[15], 5'b0};
    assign c13 = {pt[16], 1'b0, neg[16], 6'b0};//第17行部分积，无符号为booth编码，有符号为0
    genvar j3;
    generate
        for (j3=0 ; j3<41 ; j3=j3+1) begin
            FA FA (.a(a13[j3]), .b(b13[j3]), .ci(c13[j3]), .s(s13[j3]), .co(co13[j3]));
        end
    endgenerate
    //第二层
    wire [51:0] a20, b20, c20, s20, co20;
    assign a20 = {7'b0, s10};
    assign b20 = {6'b0, c10, 1'b0};
    assign c20 = {s11, 5'b0};
    genvar k0;
    generate
        for (k0=0 ; k0<52 ; k0=k0+1) begin
            FA FA (.a(a20[k0]), .b(b20[k0]), .ci(c20[k0]), .s(s20[k0]), .co(co20[k0]));
        end
    endgenerate
    wire [57:0] a21, b21, c21, s21, co21;
    assign a21 = {11'b0, co11};
    assign b21 = {1'b0, s12, 10'b0};
    assign c21 = {co12, 11'b0};
    genvar k1;
    generate
        for (k1=0 ; k1<58 ; k1=k1+1) begin
            FA FA (.a(a21[k1]), .b(b21[k1]), .ci(c21[k1]), .s(s21[k1]), .co(co21[k1]));
        end
    endgenerate
    //第三层
    wire [63:0] a30, b30, c30, s30, co30;
    assign a30 = {12'b0, s20};
    assign b30 = {11'b0, co20, 1'b0};
    assign c30 = {s21, 6'b0};
    genvar l0;
    generate
        for (l0=0 ; l0<64 ; l0=l0+1) begin
            FA FA (.a(a30[l0]), .b(b30[l0]), .ci(c30[l0]), .s(s30[l0]), .co(co30[l0]));
        end
    endgenerate
    wire [56:0] a31, b31, c31, s31, co31;
    assign a31 = co21;
    assign b31 = {s13, 16'b0};
    assign c31 = {co13[39:0], 17'b0};
    genvar l1;
    generate
        for (l1=0 ; l1<57 ; l1=l1+1) begin
            FA FA (.a(a31[l1]), .b(b31[l1]), .ci(c31[l1]), .s(s31[l1]), .co(co31[l1]));
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
            FA FA (.a(a40[m0]), .b(b40[m0]), .ci(c40[m0]), .s(s40[m0]), .co(co40[m0]));
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
            FA FA (.a(a50[n0]), .b(b50[n0]), .ci(c50[n0]), .s(s50[n0]), .co(co50[n0]));
        end
    endgenerate
    //第六层
    wire prodlo;
    Adder_32 prodl (.a(s50[31:0]), .b({co50[30:0], 1'b0}), .sub(1'b0), .sum(prod[31:0]), .overflow(prodlo), .zeroflag());
    Adder_32 prodh (.a(s50[63:32]), .b(co50[62:31]), .sub(1'b0), .sum(prod[63:32]), .overflow(overflow), .zeroflag());
endmodule