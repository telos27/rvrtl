`default_nettype none 
`timescale 1ns/1ps
`include "Shifter_32.v"

module test_shifter() ;

Shifter_32 shifter32 (.shift5(b), .datain(shift_data), .right(right), .sra(sra), .dataout(dataout));

reg [31:0] a ;
reg [4:0] b ;
reg [31:0] shift_data;
reg right, sra;

wire[31:0] dataout;
integer expected_shiftleft , expected_shiftright ;

integer i; // 循环计数器

initial begin
    $dumpfile ("test_shifter.vcd") ;
    $dumpvars (0 , test_shifter) ;

    // 测试
    for (i = 0; i < 32; i = i + 1) begin
      // 输入到模块的测试信号
      shift_data = 32'ha5a5_a5a5;
      a = shift_data;
      b = i;
      right = 1;
      sra = 1;
      #10; // 延时使模块稳定

      // 预期输出
      expected_shiftright = (a)>>b ;
      expected_shiftleft = (a)<<b ;

      #5;

        if ((dataout!==expected_shiftright) && (right==1)) 
            $display("错误:%d测试用例的右移不匹配,\n%b >> %d = %b , expected = %b", i , a , b[4:0] , dataout , expected_shiftright);
        else if (dataout!==expected_shiftleft && right==0) 
            $display("错误:%d测试用例左移不匹配,\n%b << %d = %b , expected = %b", i , a , b[4:0] , dataout , expected_shiftleft);
        else $display("%b %s %d = %b , expected = %b", a , right?">>":"<<" , b[4:0] , dataout , right?expected_shiftright:expected_shiftleft);
    end
    $finish; // 运行所有测试用例后停止模拟
  end

endmodule