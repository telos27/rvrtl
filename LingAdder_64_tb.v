`timescale 1ns/1ps
`include "LingAdder_64.v"

module LingAdder_64_tb;
    reg [63:0] a, b;
    reg cin;
    wire [63:0] sum;
    wire cout;

    // 实例化被测试的模块
    LingAdder_64 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    initial begin
        // 初始化信号
        a = 64'b0;
        b = 64'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("LingAdder_64_tb.vcd");
        $dumpvars(0, LingAdder_64_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                #5 a = i; b = j; cin = 1'b0;
                #5;
                // 检查结果
                if (sum !== (a + b)) begin
                    $display("结果不正确：\n________a=%b,\n________b=%b,\nfalse_sum=%b,\nture__sum=%b\n", a, b, sum, a+b);
                end
            end
        end
        #10 $finish;
    end
endmodule
