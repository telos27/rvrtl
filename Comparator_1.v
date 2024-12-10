//1位比较器
module Comparator_1 (a, b, less, equal, great);
    input a, b;

    output less, equal, great;

    assign less = a & ~b;
    assign equal = ~(a ^ b);
    assign great = ~a & b;
endmodule