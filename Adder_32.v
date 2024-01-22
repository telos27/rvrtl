//32位加法器
`include "FastAdder_16.v"

module Adder_32 (a, b, sub, sum, overflow, zeroflag);
    input [31:0] a, b;
    input sub;
    output [31:0] sum;
    output overflow, zeroflag;
    wire gtemp, ptemp, ctemp;

    //2个16位快速加法器串联
    FastAdder_16 FastAdder_16_0 (.a(a[15:0]), .b(b[15:0]), .cin(sub),
            .sum(sum[15:0]),.cout(ctemp), .gin(), .pin(), .gout(gtemp), .pout(ptemp));
    FastAdder_16 FastAdder_16_1 (.a(a[31:16]), .b(b[31:16]), .cin(ctemp),
            .sum(sum[31:16]), .cout(overflow), .gin(gtemp), .pin(ptemp), .gout(), .pout());
    
    //零标志寄存器
    assign zeroflag = (sum==0)?1'b0:1'b1;
endmodule
