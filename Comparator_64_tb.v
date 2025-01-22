`timescale 1ps/1ps
`include "Comparator_64.v"

module Comparator_64_tb;
    reg [63:0] a, b;
    reg greatin, equalin, lessin;
    wire great, equal, less;

    // 实例化被测试模块
    Comparator_64 uut (
        .a(a), .b(b),
        .greatin(greatin), .equalin(equalin), .lessin(lessin),
        .great(great), .equal(equal), .less(less)
    );

    integer i, j;
    initial begin
        // 初始化信号
        a = 64'b0;
        b = 64'b0;
        greatin = 1'b0;
        equalin = 1'b1;
        lessin = 1'b0;

        // 打开VCD文件
        $dumpfile("Comparator_64_tb.vcd");
        $dumpvars(0, Comparator_64_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                #10 a = i; b = j; greatin = 1'b0; equalin = 1'b1; lessin = 1'b0;
                #1;
                if ((a > b && !great) || (a == b && !equal) || (a < b && !less)) begin
                    $display("结果不正确： a=%d , b=%d , great=%b , equal=%b , less=%b\n", a, b, great, equal, less);
                end
            end
        end
        #10 $finish;
    end
endmodule
