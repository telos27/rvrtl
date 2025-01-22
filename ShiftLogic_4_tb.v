`timescale 1ps/1ps
`include "ShiftLogic_4.v"

module ShiftLogic_4_tb;
    reg [3:0] datain, shift;
    wire [3:0] dataout;

    // 实例化ShifterLogic_4模块
    ShiftLogic_4 uut (.datain(datain), .shift(shift), .dataout(dataout));

    integer j;
    reg [3:0] expected;
    initial begin
        // 初始化信号
        datain = 4'h1;

        // 打开VCD文件
        $dumpfile("ShiftLogic_4_tb.vcd");
        $dumpvars(0, ShiftLogic_4_tb);

        // 测试 shift 从 0x01到0x08
        for (j = 0; j < 4; j = j + 1) begin
            shift = 4'h1 << j;
            expected = datain << j;
            #5;
            $display("dataout=%b，expected=%b。", dataout, expected);
        end
        $finish;
    end
endmodule
