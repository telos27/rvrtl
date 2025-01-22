`timescale 1ps/1ps
`include "Complementarium_64.v"

module Complementarium_64_tb;
    reg [63:0] datain;
    wire [63:0] dataout;
    reg [63:0] expected;

    // 实例化被测试模块
    Complementarium_64 uut (.datain(datain), .dataout(dataout));

    integer i;
    initial begin
        // 初始化信号
        datain = 64'b0;

        // 打开VCD文件
        $dumpfile("Complementarium_64_tb.vcd");
        $dumpvars(0, Complementarium_64_tb);

        // 使用for循环测试所有情况
        for (i = 0; i < 1000; i = i + 1) begin
            datain = $random; // 随机生成输入
            expected = ~datain + 1; // 计算期望输出
            #5;
            if (dataout !== expected) begin
                $display("错误: datain=%h, dataout=%h, expected=%h", datain, dataout, expected);
            end
        end
        $finish;
    end
endmodule
