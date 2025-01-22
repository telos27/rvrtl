// 64位比较器
`include "Comparator_16.v"

module Comparator_64 (a, b, greatin, equalin, lessin, great, equal, less);
    input [63:0] a, b;
    input greatin, equalin, lessin;
    output great, equal, less;

    wire [3:0] great_temp, less_temp;

    Comparator_16 comp0 (.a(a[15:0]), .b(b[15:0]), 
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[0]), .equal(), .less(less_temp[0]));
    Comparator_16 comp1 (.a(a[31:16]), .b(b[31:16]), 
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[1]), .equal(), .less(less_temp[1]));
    Comparator_16 comp2 (.a(a[47:32]), .b(b[47:32]),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[2]), .equal(), .less(less_temp[2]));
    Comparator_16 comp3 (.a(a[63:48]), .b(b[63:48]),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great_temp[3]), .equal(), .less(less_temp[3]));

    Comparator_4 comp4 (.a(great_temp), .b(less_temp),
                        .greatin(1'b0), .equalin(1'b1), .lessin(1'b0),
                        .great(great), .equal(equal), .less(less));
    
endmodule