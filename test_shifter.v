`default_nettype none 
`timescale 1ns/1ps
`include "Shift_Signal.v"
`include "Shifter_32.v"

module test_shifter() ;

Shift_Signal Shift_Signal (.shift(b), .shift(s32));

Shifter_32 shifter32 (.shift(s32), .right(right), .datain(shift_data0) , .dataout(dataout));

reg [31:0] a ;
reg [4:0] b ;
reg [31:0] shift_data;
reg right, sra;

wire[31:0] s32;

wire[31:0] dataout, shift_data0;
integer expected_shiftleft , expected_shiftright ;

integer i; // 循环计数器

initial begin
    $dumpfile ("test_shifter.vcd") ;
    $dumpvars (0 , test_shifter) ;

    // 测试
    for (i = 0; i < 32; i = i + 1) begin
      // 输入到模块的测试信号
      shift_data = 32'h8fff_ffff;
      a = shift_data;
      b = i;
      right = 1;
      sra = 1;
      #10; // 延时使模块稳定

      // 预期输出
      expected_shiftright = (a)>>b ;
      expected_shiftleft = (a)<<b ;

      #10;

        if ((dataout!==expected_shiftright) && (right==1)) 
            $display("错误:%d测试用例的右移不匹配,\n%b >> %d = %b , expected = %b", i , a , b[4:0] , dataout , expected_shiftright);
        else $display("%b >> %d = %b , expected = %b", a , b[4:0] , dataout , expected_shiftright);
        if (dataout!==expected_shiftleft & right==0) 
            $display("错误:%d测试用例左移不匹配,\n%b << %d = %b , expected = %b", i , a , b[4:0] , dataout , expected_shiftleft);
        //else $display("%b << %d = %b , expected = %b", a , b[4:0] , dataout , expected_shiftleft);
    end
    $finish; // 运行所有测试用例后停止模拟
  end

endmodule