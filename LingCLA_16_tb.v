`timescale 1ps/1ps
`include "LingCLA_16.v"
module LingCLA_16_tb;
    reg [15:0] a, b;
    reg cin;
    wire [15:0] sum;
    wire cout;

    // 实例化LingCLA_16模块
    LingCLA_16 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    reg [16:0] expectedsum;
    initial begin
        // 初始化信号
        a = 16'b0;
        b = 16'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("LingCLA_16_tb.vcd");
        $dumpvars(0, LingCLA_16_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 1000; i = i + 1) begin
            a = $random;
            b = $random;
            cin = $random % 2;
            expectedsum = a + b + cin;
            #5;
            if (expectedsum[15:0] != sum || expectedsum[16] !== cout) begin
                $display("结果不正确：a=%h, b=%h, cin=%b, cout=%b, expectedcout=%b,\n        sum=%h %h %h %h,\nexpectedsum=%h %h %h %h", 
                    a, b, cin, cout, expectedsum[16], expectedsum[15:12], expectedsum[11:8], expectedsum[7:4], expectedsum[3:0], sum[15:12], sum[11:8], sum[7:4], sum[3:0]);
            end
        end
        $finish;
    end
endmodule
