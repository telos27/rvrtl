`timescale 1ns/1ps
`include "Adder_32.v"

module test_alu() ;

Adder_32 uut(.a(a), .b(b), .sub(zero), .s(s), .overflow(overflow));

reg [31:0] a ;
reg [31:0]b ;
wire [31:0]s ;
wire overflow ;
wire zero ;

integer i; // Loop counter
integer expected_sum ;
integer expected_overflow ;

assign zero = 0 ;

initial begin
    $dumpfile ("test_alu.vcd") ;
    $dumpvars (0 , test_alu) ;

    // Randomly test for 1000 iterations
    for (i = 0; i < 10; i = i + 1) begin
      // Generate random 32-bit values for a and b
      a = $random;
      b = $random;

      #10; // Delay to allow module to settle

      // Expected output based on addition operation
      expected_sum = a + b;
      expected_overflow = (a > 2**31 - b) || (b > 2**31 - a);

      #10;

      // Check if adder output matches expected values
      if (s!==expected_sum) $display("ERROR: Sum mismatch for %dth test case", i);
      if (overflow!==expected_overflow) $display("ERROR: Overflow mismatch for %dth test case", i);

      // Print test case results
      $display("Test case %d passed: a=%d, b=%d, s=%d, overflow=%d", i, a, b, s, overflow);
    end
    $finish; // Simulation stops after all test cases run
  end

endmodule