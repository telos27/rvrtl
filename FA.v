//1位全加器
module FA (a, b, ci, s, co);
    input a, b, ci;
    output s, co;
    wire st;

    assign st = a ^ b;
    assign s = st ^ ci;
    assign co = (a & b) | (st & ci);
endmodule
