`timescale 1ps/1ps
`include "CLA_64.v"
module CLA_64_tb;
    reg [63:0] a, b;
    reg cin;
    wire [63:0] sum;
    wire cout;

    // 实例化CLA_64模块
    CLA_64 uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i, j;
    initial begin
        // 初始化信号
        a = 64'b0;
        b = 64'b0;
        cin = 1'b0;

        // 打开VCD文件
        $dumpfile("CLA_64_tb.vcd");
        $dumpvars(0, CLA_64_tb);

        for (i = 0; i < 100; i = i + 1) begin
            a = $random;
            b = $random;
            cin = $random % 2;
            #5;
            if ({cout, sum} != a + b + cin) begin
                $display("结果不正确：a=%h, b=%h, cin=%b, sum=%h, cout=%b, expected=%h", 
                        a, b, cin, sum, cout, a + b + cin);
            end
        end
        
        #10 $finish;
    end
endmodule
