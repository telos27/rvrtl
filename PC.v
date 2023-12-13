module PC (clk, clr, pcout);
    input clk, clr;
    output [31:0] pcout;
    reg [31:0] pc;

    case (clr)
        1'b1: pc = 31'b0;
    endcase

    always @(posedge clk) begin
        pc = pc + 4;
        pcout = pc;
    end
endmodule
