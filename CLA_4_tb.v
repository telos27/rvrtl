`timescale 1ns/1ps
`include "CLA_4.v"
module CLA_4_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    // 实例化CLA_4模块
    CLA_4 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    initial begin
        // 初始化信号
        a = 4'b0;
        b = 4'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("CLA_4_tb.vcd");
        $dumpvars(0, CLA_4_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i; b = j; cin = 1'b0;
                #5;
                if ({cout, sum} != a + b + cin) begin
                    $display("结果不正确：a=%h, b=%h, cin=%b, sum=%h, cout=%b, expected=%h", 
                            a, b, cin, sum, cout, a + b + cin);
                end
            end
        end
        $finish;
    end
endmodule
