`timescale 1ps/1ps
`include "LingCLA_4.v"
module LingCLA_4_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    // 实例化LingCLA_4模块
    LingCLA_4 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    reg [3:0] expectedsum;
    reg expectedcout;
    initial begin
        // 初始化信号
        a = 4'b0;
        b = 4'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("LingCLA_4_tb.vcd");
        $dumpvars(0, LingCLA_4_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i; b = j; cin = 1'b0;
                expectedsum = a + b;
                expectedcout = (a + b + cin) % 2;
                #5;
                if (expectedsum != a + b + cin && expectedcout !== cout) begin
                    $display("结果不正确：a=%h, b=%h, cin=%b, sum=%h, cout=%b, expectedsum=%h, expextedcout=%b", 
                            a, b, cin, sum, cout, expectedsum, expectedcout);
                end
            end
        end
        $finish;
    end
endmodule
