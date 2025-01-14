`timescale 1ps/1ps
`include "ShiftLogic_64.v"

module ShiftLogic_64_tb;
    reg [63:0] datain, shift;
    wire [63:0] dataout;

    // 实例化ShifterLogic_64模块
    ShiftLogic_64 uut (.datain(datain), .shift(shift), .dataout(dataout));

    integer j;
    reg [63:0] expected;
    initial begin
        // 初始化信号
        datain = 64'hFAFA_0F0F_FAFA_0F0F;

        // 打开VCD文件
        $dumpfile("ShiftLogic_64_tb.vcd");
        $dumpvars(0, ShiftLogic_64_tb);

        // 测试 shift 从 0x0000000000000001到0x8000000000000000
        for (j = 0; j < 64; j = j + 1) begin
            shift = 64'h0000_0000_0000_0001 << j;
            expected = datain << j;
            #5;
            $display("dataout=%b，expected=%b。shift=%d", dataout, expected, j);
        end
        $finish;
    end
endmodule
