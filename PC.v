module PC (PCWrite, clr, newpc, pc);
    input PCWrite, clr;
    input[31:0] newpc;
    output [31:0] pc;

    reg [31:0] pc;

    case (clr)
        1'b1: pc = 31'b0;
    endcase

    always @(posedge PCWrite) begin
        pc = newpc;
    end
endmodule
