`timescale 1ns/1ps
`include "Divider.v"
`include "FastAdder_16.v"
module test_Div ();

    Divider Div (.a(a), .b(b), .sign(sign), .quotient(quotient), .remainder(remainder));

    reg  [31:0] a;
    reg  [31:0] b;
    reg         sign;
    wire [31:0] quotient;
    wire [31:0] remainder;

    integer i, j;
    integer expected_quotient, expected_remainder;

    initial begin
        $dumpfile ("test_Div.vcd");
        $dumpvars (0 , test_Div);

        sign = 0;

        for (i=7; i>0; i=i-1) begin
            for (j=1; j<i; j=j+1) begin
                b = i;
                a = j;
                expected_quotient = i / j;
                expected_remainder = i % j;
                #5
                if (quotient !== expected_quotient) begin
                    $display("错误 %h ÷ %h = %h , expected = %h", i , j , quotient , expected_quotient);
                end
                else begin
                    $display("%h ÷ %h = %h , expected = %h", i , j , quotient , expected_quotient);
                end
                if (remainder !== expected_remainder) begin
                    $display("错误 %h mod %h = %h , expected = %h", i , j , remainder , expected_remainder);
                end
                else begin
                    $display("%h mod %h = %h , expected = %h", i , j , remainder , expected_remainder);
                end
            end
        end
        $finish;
    end
endmodule