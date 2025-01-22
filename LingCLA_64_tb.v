`timescale 1ps/1ps
`include "LingCLA_64.v"
module LingCLA_64_tb;
    reg [63:0] a, b;
    reg cin;
    wire [63:0] sum;
    wire cout;

    // 实例化LingCLA_64模块
    LingCLA_64 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    reg [64:0] expectedsum;
    initial begin
        // 初始化信号
        a = 64'b0;
        b = 64'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("LingCLA_64_tb.vcd");
        $dumpvars(0, LingCLA_64_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 1000; i = i + 1) begin
            a = {$random, $random};
            b = {$random, $random};
            cin = $random % 2;
            expectedsum = a + b + cin;
            #5;
            if (expectedsum[63:0] != sum || expectedsum[64] !== cout) begin
                $display("结果不正确：");
                $display("    a=%h %h %h %h %h %h %h %h", a[63:56], a[55:48], a[47:40], a[39:32], a[31:24], a[23:16], a[15:8], a[7:0]);
                $display("    b=%h %h %h %h %h %h %h %h", b[63:56], b[55:48], b[47:40], b[39:32], b[31:24], b[23:16], b[15:8], b[7:0]);
                $display("  cin=%b, cout=%b, expectedcout=%b", cin, cout, expectedsum[64]);
                $display("  sum=%h %h %h %h %h %h %h %h", sum[63:56], sum[55:48], sum[47:40], sum[39:32], sum[31:24], sum[23:16], sum[15:8], sum[7:0]);
                $display("exsum=%h %h %h %h %h %h %h %h", expectedsum[63:56], expectedsum[55:48], expectedsum[47:40], expectedsum[39:32], expectedsum[31:24], expectedsum[23:16], expectedsum[15:8], expectedsum[7:0]);
            end
        end
        $finish;
    end
endmodule
