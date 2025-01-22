// 16位比较器
`include "Comparator_4.v"

module Comparator_16 (a, b, greatin, equalin, lessin, great, equal, less);
    input [15:0] a, b;
    input greatin, equalin, lessin;
    output great, equal, less;

    wire [3:0] great_temp, less_temp;

    Comparator_4 comp0 (.a(a[3:0]), .b(b[3:0]), 
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[0]), .equal(), .less(less_temp[0]));
    Comparator_4 comp1 (.a(a[7:4]), .b(b[7:4]), 
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[1]), .equal(), .less(less_temp[1]));
    Comparator_4 comp2 (.a(a[11:8]), .b(b[11:8]),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[2]), .equal(), .less(less_temp[2]));
    Comparator_4 comp3 (.a(a[15:12]), .b(b[15:12]),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[3]), .equal(), .less(less_temp[3]));

    Comparator_4 comp4 (.a(great_temp), .b(less_temp),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great), .equal(equal), .less(less));

endmodule