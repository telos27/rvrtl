//行波进位加法器
`include "FA_1.v"
module RCA_8 (a, b, cin, sum, cout);
    input [7:0] a, b;
    input cin;

    output [7:0] sum;
    output cout;

    wire [6:0] ctemp;

    FA_1 fa  ( .a(a[0]), .b(b[0]), .c(cin),      .sum(sum[0]), .carry(ctemp[0]) );
    FA_1 fa1 ( .a(a[1]), .b(b[1]), .c(ctemp[0]), .sum(sum[1]), .carry(ctemp[1]) );
    FA_1 fa2 ( .a(a[2]), .b(b[2]), .c(ctemp[1]), .sum(sum[2]), .carry(ctemp[2]) );
    FA_1 fa3 ( .a(a[3]), .b(b[3]), .c(ctemp[2]), .sum(sum[3]), .carry(ctemp[3]) );
    FA_1 fa4 ( .a(a[4]), .b(b[4]), .c(ctemp[3]), .sum(sum[4]), .carry(ctemp[4]) );
    FA_1 fa5 ( .a(a[5]), .b(b[5]), .c(ctemp[4]), .sum(sum[5]), .carry(ctemp[5]) );
    FA_1 fa6 ( .a(a[6]), .b(b[6]), .c(ctemp[5]), .sum(sum[6]), .carry(ctemp[6]) );
    FA_1 fa7 ( .a(a[7]), .b(b[7]), .c(ctemp[6]), .sum(sum[7]), .carry(cout) );

endmodule