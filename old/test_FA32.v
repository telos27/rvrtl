`timescale 1ns/1ps
`include "Adder_32.v"
module test_FA32 ();

    Adder_32 FA32 (.a(a), .b(b), .sum(sum), .sub(sub), .overflow(overflow), .zeroflag(zeroflag));

    reg  [31:0] a;
    reg  [31:0] b;
    reg sub;

    wire [31:0] sum;
    wire overflow, zeroflag;

    integer i, j;
    integer expected_sum;

    initial begin
        $dumpfile ("test_FA32.vcd");
        $dumpvars (0 , test_FA32);

        sub = 0;

        for (i=0; i<999; i=i+1) begin
            for (j=0; j<9; j=j+1) begin
                a = i;
                b = j;
                expected_sum = i + j;

                #5

                if (sum !== expected_sum) begin
                    $display("错误 %h + %h = %h , expected = %h", i , j , sum , expected_sum);
                end
                else begin
                    $display("%h + %h = %h , expected = %h", i , j , sum , expected_sum);
                end
            end
        end
        $finish;
    end
endmodule