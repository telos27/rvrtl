`timescale 1ps/1ps
`include "ShiftLogic_8.v"

module ShiftLogic_8_tb;
    reg [7:0] datain, shift;
    wire [7:0] dataout;

    // 实例化ShifterLogic_8模块
    ShiftLogic_8 uut (.datain(datain), .shift(shift), .dataout(dataout));

    integer j;
    reg [7:0] expected;
    initial begin
        // 初始化信号
        datain = 8'h33; // 固定 datain 为全1

        // 打开VCD文件
        $dumpfile("ShiftLogic_8_tb.vcd");
        $dumpvars(0, ShiftLogic_8_tb);

        // 测试 shift 从 0x01到0x80
        for (j = 0; j < 8; j = j + 1) begin
            shift = 8'h01 << j;
            expected = datain << j;
            #5;
            $display("dataout=%b，expected=%b。", dataout, expected);
        end
        $finish;
    end
endmodule
