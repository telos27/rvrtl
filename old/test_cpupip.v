timescale 1ns/1ps
`include "CPUpip.v"

module test_cpupip ();
    CPUpip CPUpip(.clk(), .clr());

    reg clk, reset;

    initial begin
        clk <= 0;
    end

    always begin
        #5 clk <= ~clk;
    end

    initial begin
        reset = 1;
        #22
        reset = 0;
    end

    initial begin
        $readmemh("tpip.hex" , uut_cpu.Memory.ramdata);
    end

    initial begin
        $dumpfile ("test_cpu.vcd");
        $dumpvars (0 , test_cpu);
        #1000;
        $display ("done");
        $finish;
    end
endmodule