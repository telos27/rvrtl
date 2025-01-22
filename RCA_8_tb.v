`timescale 1ps/1ps
`include "RCA_8.v"
module RCA_8_tb;
    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;

    // 实例化你的RCA_8模块
    RCA_8 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    initial begin
        // 初始化信号
        a = 8'b0;
        b = 8'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("RCA_8_tb.vcd");
        $dumpvars(0, RCA_8_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                #10 a = i; b = j; cin = 1'b0;
            end
        end
        #10 $finish;
    end
endmodule