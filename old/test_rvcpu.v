`timescale 1ns/1ps

module test_cpu() ;

reg clk , reset ;

reg[7:0] mem[0:1023] ;

wire[7:0] b0 , b1 , b2 , b3 , b4 , b5 , b6 , b7 ;

assign b0 = mem[0];
assign b1 = mem[1];
assign b2 = mem[2];
assign b3 = mem[3];
assign b4 = mem[4];
assign b5 = mem[5];
assign b6 = mem[6];
assign b7 = mem[7];



initial begin clk <=0 ; end

always begin
    #5 clk <= ~clk ;
end


initial begin
    reset = 1 ;
    #20
    reset = 0 ;
end

initial begin
    $readmemh("t1.hex" , mem) ;
end ;


initial begin
    $dumpfile ("test_cpu.vcd") ;
    $dumpvars (0 , test_cpu) ;

    #1000 ;
    $display ("done") ;
    $finish ;

end

endmodule