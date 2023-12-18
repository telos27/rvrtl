//32位加法器
`include "FastAdder_16.v"
module Adder_32 (a, b, sub, s, overflow, zeroflag);
    input [31:0] a, b;
    input sub;
    output [31:0] s;
    output overflow;
    wire gtemp, ptemp, ctemp;
    //2个16位快速加法器串联
    FastAdder_8 FastAdder_16_0 (.a(a[15:0]), .b(b[15:0]), .cin(sub),
            .s(s[15:0]),.cout(ctemp[0]), .gin(), .pin(), .gout(gtemp), .pout(ptemp));
    FastAdder_8 FastAdder_16_1 (.a(a[31:16]), .b(b[31:16]), .cin(ctemp),
            .s(s[31:16]), .cout(overflow), .gin(gtemp), .pin(ptemp), .gout(), .pout());
    //零标志寄存器
    if (s)
        zeroflag = 1'b0;
    else
        zeroflag = 1'b1;
endmodule
