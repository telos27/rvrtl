`default_nettype none 
`timescale 1ns/1ps
`include "Adder_32.v"
`include "Shifter_32.v"
`include "Decoder_5to32.v"

module test_alu() ;

Adder_32 adder32(.a(a), .b(b), .sub(zero), .s(s), .overflow(overflow));

Decoder_5to8 decoder(.s(s5), .shift(s32));
// Decoder_5to8 decoder(.s(b[4:0]), .shift(s32));

Shifter_32 shifter32(.shift(s32) , .din(a) , .dleftout(shiftleft), .drightout(shiftright));
// Shifter_32 shifter32(.shift(s32) , .din(a) , .dleftout(shiftleft), .drightout(shiftright));

reg [31:0] a ;
reg [31:0] b ;
wire [31:0] s ;
wire overflow ;
wire zero ;

reg[4:0] s5 ;
wire[31:0] s32;
wire[31:0] shiftleft, shiftright;

integer i; // Loop counter
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

    for (i=0 ; i<32 ; i= i+1) begin
      s5 = i ;
      a = 32'h13468acd ;
      //32h'13468acd ;

      #10
      /*
      expected_s32 = 1 << i ;

      if (s32!==expected_s32) begin
        $display("ERROR: s5=0x%x , s32=0x%x , expected=0x%x" , s5 , s32 , expected_s32);
      end
      */
      expected_shiftleft = a<<s5 ;
      expected_shiftright = a>>s5 ;
      if (shiftright!==expected_shiftright) 
        $display("ERROR: shift right mismatch for %dth  case, %x>>%d=%x , expected=%x", i , a , s5 , shiftright , expected_shiftright);
      if (shiftleft!==expected_shiftleft) 
        $display("ERROR: shift left mismatch for %dth test case, %x<<%d=%x , expected=%x", i , a , s5 , shiftleft , expected_shiftleft);
    end

    // Randomly test for 1000 iterations
    for (i = 0; i < 10; i = i + 1) begin
      // Generate random 32-bit values for a and b
      a = $random(seed);
      b = $random(seed);

      #10; // Delay to allow module to settle

      // Expected output based on addition operation
      expected_sum = a + b;
      expected_overflow = (a+b<a);

      expected_shiftright = (a)>>b[4:0] ;
      expected_shiftleft = (a)<<b[4:0] ;

      #10;

      // Check if adder output matches expected values
      if (s!==expected_sum) $display("ERROR: Sum mismatch for %dth test case, s=%x , expected=%x", i , s , expected_sum);
      if (overflow!==expected_overflow) $display("ERROR: Overflow mismatch for %dth test case", i);
/*
      if (shiftright!==expected_shiftright) 
        $display("ERROR: shift right mismatch for %dth  case, %x>>%d=%x , expected=%x", i , a , b[4:0] , shiftright , expected_shiftright);
      if (shiftleft!==expected_shiftleft) 
        $display("ERROR: shift left mismatch for %dth test case, %x<<%d=%x , expected=%x", i , a , b[4:0] , shiftleft , expected_shiftleft);
*/

      // Print test case results
      $display("Test case %d passed: a=%x, b=%x, s=%x, overflow=%d", i, a, b, s, overflow);
      //$display("sign-extend a: %x[12] -> %x[32]\n" , a[11:0] , {{20{a[11]}},a[11:0]});
    end
    $finish; // Simulation stops after all test cases run
  end

endmodule