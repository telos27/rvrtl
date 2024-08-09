`timescale 1ns/1ps
`include "Multiplier.v"
`include "Adder_32.v"
module test_Mul ();

    Multiplier Mul (.a(a), .b(b), .sign(sign), .prod({prodh,prodl}), .overflow(overflow));

    reg  [31:0] a;
    reg  [31:0] b;
    reg         sign;
    wire [31:0] prodh;
    wire [31:0] prodl;
    wire        overflow;

    integer i, j;
    integer expected_product;

    initial begin
        $dumpfile ("test_Mul.vcd");
        $dumpvars (0 , test_Mul);

        sign = 1;

        for (i=0; i<64; i=i+1) begin
            for (j=0; j<64; j=j+1) begin
                a = i;
                b = j;
                expected_product = i * j;

                #5

                if (prodl !== expected_product) begin
                    $display("错误 %h * %h = %h , expected = %h", i , j , prodl , expected_product);
                end
                else begin
                    $display("%h*%h = %h , expected = %h", i , j , prodl , expected_product);
                end
            end
        end
        $finish;
    end
endmodule