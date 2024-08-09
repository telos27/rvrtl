//32位除法器
`include "CAS_64.v"
module Divider (a, b, sign, quotient, remainder);
    input  [31:0] a;
    input  [31:0] b;
    input  sign;
    output [31:0] quotient;
    output [31:0] remainder;

    wire   [31:0] bbar;
    assign bbar = ~b;

    wire [31:0][63:0] divisor;
    assign divisor[0]  = sign ? 64'b0 : {1'b0, bbar, 31'b0};
    assign divisor[1]  = {2'b0,  bbar, 30'b0};
    assign divisor[2]  = {3'b0,  bbar, 29'b0};
    assign divisor[3]  = {4'b0,  bbar, 28'b0};
    assign divisor[4]  = {5'b0,  bbar, 27'b0};
    assign divisor[5]  = {6'b0,  bbar, 26'b0};
    assign divisor[6]  = {7'b0,  bbar, 25'b0};
    assign divisor[7]  = {8'b0,  bbar, 24'b0};
    assign divisor[8]  = {9'b0,  bbar, 23'b0};
    assign divisor[9]  = {10'b0, bbar, 22'b0};
    assign divisor[10] = {11'b0, bbar, 21'b0};
    assign divisor[11] = {12'b0, bbar, 20'b0};
    assign divisor[12] = {13'b0, bbar, 19'b0};
    assign divisor[13] = {14'b0, bbar, 18'b0};
    assign divisor[14] = {15'b0, bbar, 17'b0};
    assign divisor[15] = {16'b0, bbar, 16'b0};
    assign divisor[16] = {17'b0, bbar, 15'b0};
    assign divisor[17] = {18'b0, bbar, 14'b0};
    assign divisor[18] = {19'b0, bbar, 13'b0};
    assign divisor[19] = {20'b0, bbar, 12'b0};
    assign divisor[20] = {21'b0, bbar, 11'b0};
    assign divisor[21] = {22'b0, bbar, 10'b0};
    assign divisor[22] = {23'b0, bbar, 9'b0};
    assign divisor[23] = {24'b0, bbar, 8'b0};
    assign divisor[24] = {25'b0, bbar, 7'b0};
    assign divisor[25] = {26'b0, bbar, 6'b0};
    assign divisor[26] = {27'b0, bbar, 8'b0};
    assign divisor[27] = {28'b0, bbar, 4'b0};
    assign divisor[28] = {29'b0, bbar, 3'b0};
    assign divisor[29] = {30'b0, bbar, 2'b0};
    assign divisor[30] = {31'b0, bbar, 1'b0};
    assign divisor[31] = {32'b0, b};

    wire [30:0][63:0] rt;
    genvar i;
    for (i=0; i<32; i=i+1) begin
        generate
            CAS_64 CAS_64_i (.a(a), .b(divisor[i]), .sub(1'b1), .result(rt[i]), .overflow(quotient[32-i]));
        endgenerate
    end
    assign remainder = rt[31][31:0];
endmodule