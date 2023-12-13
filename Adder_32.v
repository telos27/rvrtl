//32位加法器
`include "FastAdder_8.v"
module Adder_32 (a, b, sub, s, overflow, zeroflag);
    input [31:0] a, b;
    input sub;
    output [31:0] s;
    output overflow;
    wire [3:0] gtemp, ptemp, ctemp;
    //4个8位快速加法器串联
    FastAdder_8
        FastAdder_8_0 (.a(a[7:0]), .b(b[7:0]), .cin(sub),
            .s(s[7:0]),.cout(ctemp[0]), .gin(), .pin(), .gout(gtemp[0]), .pout(ptemp[0])),
        FastAdder_8_1 (.a(a[15:8]), .b(b[15:8]), .cin(ctemp[0]),
            .s(s[15:8]), .cout(ctemp[1]), .gin(gtemp[0]), .pin(ptemp[0]), .gout(gtemp[1]), .pout(ptemp[1])),
        FastAdder_8_2 (.a(a[24:16]), .b(b[24:16]), .cin(ctemp[1]),
            .s(s[24:16]),.cout(ctemp[2]), .gin(gtemp[1]), .pin(ptemp[1]), .gout(gtemp[2]), .pout(ptemp[2])),
        FastAdder_8_3 (.a(a[31:15]), .b(b[31:15]), .cin(ctemp[2]),
            .s(s[31:15]), .cout(overflow), .gin(gtemp[2]), .pin(ptemp[2]), .gout(), .pout());
    //零标志寄存器
    if (s)
        zeroflag = 1'b0;
    else
        zeroflag = 1'b1;
endmodule
