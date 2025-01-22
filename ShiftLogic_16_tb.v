`timescale 1ps/1ps
`include "ShiftLogic_16.v"

module ShiftLogic_16_tb;
    reg [15:0] datain, shift;
    wire [15:0] dataout;

    // 实例化ShifterLogic_16模块
    ShiftLogic_16 uut (.datain(datain), .shift(shift), .dataout(dataout));

    integer j;
    reg [15:0] expected;
    initial begin
        // 初始化信号
        datain = 16'h000F;

        // 打开VCD文件
        $dumpfile("ShiftLogic_16_tb.vcd");
        $dumpvars(0, ShiftLogic_16_tb);

        // 测试 shift 从 0x0001到0x8000
        for (j = 0; j < 16; j = j + 1) begin
            shift = 16'h0001 << j;
            expected = datain << j;
            #5;
            $display("dataout=%b，expected=%b。shift=%d", dataout, expected, j);
        end
        $finish;
    end
endmodule
