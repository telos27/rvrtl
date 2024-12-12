//4基booth编码器
module BoothEncode (code, neg, zero, one, two);
    input [2:0] code;
    output neg, zero, one, two;

    assign neg  = code[2];
    assign zero = (code == 3'b000) | (code == 3'b111);
    assign two  = (code == 3'b100) | (code == 3'b011);
    assign one  = !(zero | two);
endmodule