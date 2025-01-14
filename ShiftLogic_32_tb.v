`timescale 1ps/1ps
`include "ShiftLogic_32.v"

module ShiftLogic_32_tb;
    reg [31:0] datain, shift;
    wire [31:0] dataout;

    // 实例化ShifterLogic_32模块
    ShiftLogic_32 uut (.datain(datain), .shift(shift), .dataout(dataout));

    integer j;
    reg [31:0] expected;
    initial begin
        // 初始化信号
        datain = 32'h0F0F_0F0F;

        // 打开VCD文件
        $dumpfile("ShiftLogic_32_tb.vcd");
        $dumpvars(0, ShiftLogic_32_tb);

        // 测试 shift 从 0x00000001到0x80000000
        for (j = 0; j < 32; j = j + 1) begin
            shift = 32'h0000_0001 << j;
            expected = datain << j;
            #5;
            $display("dataout=%b，expected=%b。shift=%d", dataout, expected, j);
        end
        $finish;
    end
endmodule
