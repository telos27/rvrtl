module PC (clk, clr, newpc, pcout);
    input clk, clr;
    input[31:0] newpc;
    output [31:0] pcout;
    reg [31:0] pc;

    case (clr)
        1'b1: pc = 31'b0;
    endcase

    always @(posedge clk) begin
        pc = newpc;
        pcout = pc;
    end
endmodule
