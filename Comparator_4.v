//4位比较器
`include "Comparator_1"
module Comparator_4 (a, b, cl, ce, cg, great, equal, less);
    input [3:0] a, b;
    input greatin, equalin, lessin;

    output less, equal, great;

    wire [3:0] ltemp, etemp, gtemp;

    Comparator_1 Comp0 (.a(a[0]), .b(b[0]), .great(gtemp[0]), .equal(etemp[0]), .less(ltemp[0]));
    Comparator_1 Comp1 (.a(a[1]), .b(b[1]), .great(gtemp[1]), .equal(etemp[1]), .less(ltemp[1]));
    Comparator_1 Comp2 (.a(a[2]), .b(b[2]), .great(gtemp[2]), .equal(etemp[2]), .less(ltemp[2]));
    Comparator_1 Comp3 (.a(a[3]), .b(b[3]), .great(gtemp[3]), .equal(etemp[3]), .less(ltemp[3]));

    assign great = gtemp[3] |
        (etemp[3] & gtemp[2]) |
        (etemp[3] & etemp[2] & gtemp[1]) |
        (etemp[3] & etemp[2] & etemp[1] & gtemp[0]) |
        (etemp[3] & etemp[2] & etemp[1] & etemp[0] & greatin);

    assign equal = etemp[0] & etemp[1] & etemp[2] & etemp[3] & greatin;

    assign less = ltemp[3] |
        (etemp[3] & ltemp[2]) |
        (etemp[3] & etemp[2] & ltemp[1]) |
        (etemp[3] & etemp[2] & etemp[1] & ltemp[0]) |
        (etemp[3] & etemp[2] & etemp[1] & ltemp[0] & lessin)

endmodule