`timescale 1ns/1ps
`include "Multiplier.v"
`include "Adder_32.v"
module test_Mul ();

    Multiplier Mul (.a(a), .b(b), .sign(sign), .prod(prod), .overflow(overflow));

    reg  [31:0] a;
    reg  [31:0] b;
    reg         sign;
    wire [63:0] prod;
    wire        overflow;

    integer i, j, seed;
    real expected_product;

    initial begin
        $dumpfile ("test_Mul.vcd");
        $dumpvars (0 , test_Mul);

        sign = 0;

        i = -1;
        j = -1;
        a = i;
        b = j;
        expected_product = i * j;

        #5

        if (prod == expected_product) begin
            $display("%h * %h = %h , expected = %h", i , j , prod , expected_product);
        end
        else begin
            $display(" %h \n %h", prod , expected_product);
        end

        $finish;
    end
endmodule