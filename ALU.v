//算数逻辑运算单元
module ALU (a, b, sub, func3, result, overflow, zeroflag);
    input [31:0]a, b;
    input sub;
    input [2:0]func3;
    output [31:0]result;
    output overflow, zeroflag;
    wire [31:0]bbar, muxaout, muxbout, addout;
   //减法
    assign bbar = ~b;
    Mux
        Mux_b(.select(sub), .datain0(b), .datain1(bbar), .dataout(muxbout));
    //加法器
    Adder_32
        Adder(.a(a), .b(muxbout), .sub(sub), .s(addout), .cout(overflow), .zeroflag(zeroflag));
    //ALU输出
    case (func3)
        3'b000: result = addout;//算数结果
        3'b001: result = ;//左移
        3'b010: result = ;//小于置1
        3'b011: result = ;//无符号小于置1
        3'b100: result = a ^ b;//逻辑异或
        3'b101: result = ;//右移
        3'b110: result = a | b;//逻辑或
        3'b111: result = a & b;//逻辑与
    endcase
endmodule
