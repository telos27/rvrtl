//访存
module MEM (
    clk, clr,
    Branch,
    MemWrite, MemRead, ALUflag,
    ALUresult, rs2,
    PCSrc,
    Readdata
);
    input clk, clr;
    input Branch, MemWrite, MemRead, ALUflag;
    input [31:0] ALUresult, rs2;

    output PCSrc;
    output [31:0] Readdata, ALUresult_out;

    //Branch
    //assign PCSrc = Branch & ALUflag;
    // assign ALUflag = (func3==0) & (flag==3'b000) |   //等于
    //                  (func3==1) & (flag==3'b001) |   //不等于
    //                  (func3==4) & (flag==3'b000) |   //小于
    //                  (func3==5) & (flag==3'b002) |   //大于等于
    //                  (func3==6) & (flag==3'b000) |   //小于（无符号）
    //                  (func3==7) & (flag==3'b004);    //大于等于（无符号）

    ARM DataMemory (.clk(clk), .clr(clr), .address(ALUresult), .write(MemWrite), .read(MemRead),
        .datain(ALUresult), .dataout(Readdata));
endmodule