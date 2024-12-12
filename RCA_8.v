//行波进位加法器
`include "FA.v"
module RCA_8 (a, b, cin, sum, cout);
    input [7:0] a, b;
    input cin;

    output [7:0] sum;
    output [7:0] cout;
    
    wire [6:0] ctemp;

    FA_1 FA0 (.a(a[0]), .b(b[0]), .c(1'b0), .sum(sum[0]), .carry(1'b0));
    FA_1 FA0 (.a(a[0]), .b(b[0]), .c(1'b0), .sum(sum[0]), .carry(1'b0));

endmodule