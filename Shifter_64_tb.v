`timescale 1ps/1ps
`include "Shifter_64.v"

module Shifter_64_tb;
    reg signed [63:0] datain;
    reg [5:0] shift;
    reg right, sra;
    wire [63:0] dataout;

    // 实例化Shifter_64模块
    Shifter_64 uut (.datain(datain), .shift(shift), .right(right), .sra(sra), .dataout(dataout));

    integer j;
    reg [63:0] expected;
    initial begin
        // 初始化信号
        datain = 64'h800F_0F0F_0F0F_0F0F;
        right = 0;
        sra = 0;

        // 打开VCD文件
        $dumpfile("Shifter_64_tb.vcd");
        $dumpvars(0, Shifter_64_tb);

        // 测试 shift 从 0 到 63，分别测试左移、逻辑右移和算术右移
        for (j = 0; j < 64; j = j + 1) begin
            shift = j;
            right = 0;
            sra = 0;
            expected = datain <<< j;
            #5;
            $display("dataout=%b，expected=%b。shift=%d", dataout, expected, j);
        end

        $finish;
    end
endmodule
