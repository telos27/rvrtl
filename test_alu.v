`default_nettype none 
`timescale 1ns/1ps
`include "Adder_32.v"
`include "Shifter_32.v"
`include "Decoder_5to32.v"

module test_alu() ;

Adder_32 adder32(.a(a), .b(b), .sub(zero), .s(s), .overflow(overflow));

//Decoder_5to8 decoder(.s(b[4:0]), .shift(s32));

Shifter_32 shifter32(.shift(s32) , .din(shift_data) , .dleftout(shiftleft), .drightout(shiftright));

reg [31:0] a ;
reg [31:0] b ;
wire [31:0] s ;
wire [31:0] shift_data ;
wire overflow ;
wire zero ;

reg[4:0] s5 ;
wire[31:0] s32;
wire[31:0] shiftleft, shiftright;

integer i; // 循环计数器
integer expected_sum ;
integer expected_overflow ;
integer expected_s32 ;
integer expected_shiftleft , expected_shiftright ;
integer seed = 100 ;

assign zero = 0 ;

initial begin
    $dumpfile ("test_alu.vcd") ;
    $dumpvars (0 , test_alu) ;

    //seed = 100 ;
/*
    for (i=0 ; i<32 ; i= i+1) begin
      s5 = i ;

      #10
      expected_s32 = 1 << i ;

      if (s32!==expected_s32) begin
        $display("ERROR: s5=0x%x , s32=0x%x , expected=0x%x" , s5 , s32 , expected_s32);
      end
    end
*/
    // 随机测试 1000 次
    for (i = 0; i < 10; i = i + 1) begin
      // 为 a 和 b 生成 32 位随机值
      a = $random(seed);
      b = $random(seed);
      s32 = 32'hffff_ffff_ffff_ffff
      #10; // 延时使模块稳定

      // 基于加法运算的预期输出
      expected_sum = a + b;
      expected_overflow = (a+b<a);

      expected_shiftright = (a)>>b[4:0] ;
      expected_shiftleft = (a)<<b[4:0] ;

      #10;

      // 检查加法器输出是否与预期值一致
      if (s!==expected_sum) $display("错误：第%d个测试用例的总和不匹配, s = %b , expected = %b", i , s , expected_sum);
      if (overflow!==expected_overflow) $display("错误：%d测试用例的溢出不匹配", i);

      if (shiftright!==expected_shiftright) 
        $display("错误：%d测试用例的右移不匹配,\n%b >> %d = %b , expected = %b", i , a , b[4:0] , shiftright , expected_shiftright);
      if (shiftleft!==expected_shiftleft) 
        $display("错误：%d测试用例左移不匹配,\n%b << %d = %b , expected = %b", i , a , b[4:0] , shiftleft , expected_shiftleft);


      // 打印测试用例结果
      $display("测试用例%d已通过: a = %x, b = %x, s = %x, overflow = %d", i, a, b, s, overflow);
      //$display("符号扩展 a: %x[12] -> %x[32]\n" , a[11:0] , {{20{a[11]}},a[11:0]});
    end
    $finish; // 运行所有测试用例后停止模拟
  end

endmodule