//1位比较器
module Comparator_1 (a, b, great, equal, less);
    input a, b;

    output great, equal, less;

    assign great = a & ~b;
    assign equal = ~(a ^ b);
    assign less = ~a & b;

endmodule