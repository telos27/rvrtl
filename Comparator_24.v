`include "Comparator_4.v"

// 24位比较器模块
module Comparator_24 ( a, b, greatin, equalin, lessin, great, equal, less );
    input [23:0] a, b; // 24位输入a和b
    input greatin, equalin, lessin; // 初始比较输入
    output great, equal, less; // 比较结果输出

    wire [4:0] ltemp, gtemp; // 中间比较结果
    wire etemp; // 中间相等结果

    // 第一层比较
    Comparator_4 Comp0 (.a(a[3:0]), .b(b[3:0]),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(gtemp[0]), .equal(etemp), .less(ltemp[0]));
    Comparator_4 Comp1 (.a(a[8:5]), .b(b[8:5]),
                        .greatin(a[4]), .equalin(1'b0), .lessin(b[4]),
                        .great(gtemp[1]), .equal(), .less(ltemp[1]));
    Comparator_4 Comp2 (.a(a[13:10]), .b(b[13:10]),
                        .greatin(a[9]), .equalin(1'b0), .lessin(b[9]),
                        .great(gtemp[2]), .equal(), .less(ltemp[2]));
    Comparator_4 Comp3 (.a(a[18:15]), .b(b[18:15]),
                        .greatin(a[14]), .equalin(1'b0), .lessin(b[14]),
                        .great(gtemp[3]), .equal(), .less(ltemp[3]));
    Comparator_4 Comp4 (.a(a[23:20]), .b(b[23:20]), .greatin(a[19]), .equalin(1'b0), .lessin(b[19]),
                        .great(gtemp[4]), .equal(), .less(ltemp[4]));

    // 第二层比较
    Comparator_4 Comp5 (.a(gtemp[4:1]), .b(ltemp[4:1]),
                        .greatin(gtemp[0]), .equalin(etemp), .lessin(ltemp[0]),
                        .great(great), .equal(equal), .less(less));

endmodule