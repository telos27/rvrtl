// 4位比较器
`include "Comparator_1.v"

module Comparator_4 (a, b, greatin, equalin, lessin, great, equal, less);
    input [3:0] a, b; // 4位输入a和b
    input greatin, equalin, lessin; // 输入的初始比较结果

    output less, equal, great; // 输出的比较结果

    wire [3:0] ltemp, etemp, gtemp; // 中间结果的临时变量

    // 实例化4个1位比较器
    Comparator_1 Comp0 (.a(a[0]), .b(b[0]), .great(gtemp[0]), .equal(etemp[0]), .less(ltemp[0]));
    Comparator_1 Comp1 (.a(a[1]), .b(b[1]), .great(gtemp[1]), .equal(etemp[1]), .less(ltemp[1]));
    Comparator_1 Comp2 (.a(a[2]), .b(b[2]), .great(gtemp[2]), .equal(etemp[2]), .less(ltemp[2]));
    Comparator_1 Comp3 (.a(a[3]), .b(b[3]), .great(gtemp[3]), .equal(etemp[3]), .less(ltemp[3]));

    // 计算最终的great信号
    assign great = gtemp[3] |
        (etemp[3] & gtemp[2]) |
        (etemp[3] & etemp[2] & gtemp[1]) |
        (etemp[3] & etemp[2] & etemp[1] & gtemp[0]) |
        (etemp[3] & etemp[2] & etemp[1] & etemp[0] & greatin);

    // 计算最终的equal信号
    assign equal = etemp[0] & etemp[1] & etemp[2] & etemp[3] & equalin;

    // 计算最终的less信号
    assign less = ltemp[3] |
        (etemp[3] & ltemp[2]) |
        (etemp[3] & etemp[2] & ltemp[1]) |
        (etemp[3] & etemp[2] & etemp[1] & ltemp[0]) |
        (etemp[3] & etemp[2] & etemp[1] & etemp[0] & lessin);

endmodule