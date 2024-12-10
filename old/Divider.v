//32位除法器
`include "Remainder.v"
`include "Complementarium.v"
module Divider (a, b, sign, quotient, remainder);
    input  [31:0] a;
    input  [31:0] b;
    input  sign;
    output [31:0] quotient;
    output [31:0] remainder;

    wire   [31:0] acom;
    Complementarium Complementarium (.datain(a), .dataout(acom));

    wire [31:0][63:0] divisor;
    assign divisor[0]  = sign ? 64'b0 : {{acom[31]}, acom, 31'b0};
    genvar di;
    generate
        for (di = 1; di < 32; di = di + 1) begin
            assign divisor[di] = {{di+1{acom[31]}}, acom, {31-di{1'b0}}};
        end
    endgenerate

    wire [63:0] bb;
    wire [31:0][63:0] remainder_temp;
    assign bb = {32'b0, b};
    Remainder Remainder_0 (.a(bb), .b(divisor[0]),
        .remainder(remainder_temp[0]), .quotient(quotient[31]));
    genvar r;
    generate
        for (r = 1; r < 32; r = r + 1) begin
            Remainder Remainder_i (.a(remainder_temp[r-1]), .b(divisor[r]),
                                .remainder(remainder_temp[r]), .quotient(quotient[31-r]));
        end
    endgenerate
    assign remainder = remainder_temp[31][31:0];
endmodule