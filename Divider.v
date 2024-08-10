//32位除法器
`include "Remainder.v"
module Divider (a, b, sign, quotient, remainder);
    input  [31:0] a;
    input  [31:0] b;
    input  sign;
    output [31:0] quotient;
    output [31:0] remainder;

    wire   [31:0] abar;
    assign abar = ~a;

    wire [31:0][63:0] divisor;
    assign divisor[0]  = sign ? 64'b0 : {{1{abar[31]}}, {abar[31]}, abar, 31'b0};
    assign divisor[1]  = {{2{abar[31]}},  abar, 30'b0};
    assign divisor[2]  = {{3{abar[31]}},  abar, 29'b0};
    assign divisor[3]  = {{4{abar[31]}},  abar, 28'b0};
    assign divisor[4]  = {{5{abar[31]}},  abar, 27'b0};
    assign divisor[5]  = {{6{abar[31]}},  abar, 26'b0};
    assign divisor[6]  = {{7{abar[31]}},  abar, 25'b0};
    assign divisor[7]  = {{8{abar[31]}},  abar, 24'b0};
    assign divisor[8]  = {{9{abar[31]}},  abar, 23'b0};
    assign divisor[9]  = {{10{abar[31]}}, abar, 22'b0};
    assign divisor[10] = {{11{abar[31]}}, abar, 21'b0};
    assign divisor[11] = {{12{abar[31]}}, abar, 20'b0};
    assign divisor[12] = {{13{abar[31]}}, abar, 19'b0};
    assign divisor[13] = {{14{abar[31]}}, abar, 18'b0};
    assign divisor[14] = {{15{abar[31]}}, abar, 17'b0};
    assign divisor[15] = {{16{abar[31]}}, abar, 16'b0};
    assign divisor[16] = {{17{abar[31]}}, abar, 15'b0};
    assign divisor[17] = {{18{abar[31]}}, abar, 14'b0};
    assign divisor[18] = {{19{abar[31]}}, abar, 13'b0};
    assign divisor[19] = {{20{abar[31]}}, abar, 12'b0};
    assign divisor[20] = {{21{abar[31]}}, abar, 11'b0};
    assign divisor[21] = {{22{abar[31]}}, abar, 10'b0};
    assign divisor[22] = {{23{abar[31]}}, abar,  9'b0};
    assign divisor[23] = {{24{abar[31]}}, abar,  8'b0};
    assign divisor[24] = {{25{abar[31]}}, abar,  7'b0};
    assign divisor[25] = {{26{abar[31]}}, abar,  6'b0};
    assign divisor[26] = {{27{abar[31]}}, abar,  8'b0};
    assign divisor[27] = {{28{abar[31]}}, abar,  4'b0};
    assign divisor[28] = {{29{abar[31]}}, abar,  3'b0};
    assign divisor[29] = {{30{abar[31]}}, abar,  2'b0};
    assign divisor[30] = {{31{abar[31]}}, abar,  1'b0};
    assign divisor[31] = {{32{abar[31]}}, abar};

    wire [63:0] bb;
    wire [31:0][63:0] remainder_temp;
    assign bb = {{32{b[31]}}, b};
    Remainder Remainder_0 (.a(bb), .b(divisor[0]), .sub(1'b1),
        .remainder(remainder_temp[0]), .quotient(quotient[31]));
    genvar i;
    generate
        for (i=1; i<32; i=i+1) begin
            Remainder Remainder_i (.a(remainder_temp[i-1]), .b(divisor[i]), .sub(1'b1),
                                .remainder(remainder_temp[i]), .quotient(quotient[31-i]));
        end
    endgenerate
    assign remainder = remainder_temp[31][31:0];
endmodule