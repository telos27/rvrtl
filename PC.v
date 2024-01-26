module PC (PCWrite, clr, newpc, pc);
    input PCWrite, clr;
    input [31:0] newpc;
    output reg [31:0] pc;

    initial begin
        if (clr)
            pc <= 32'b0;
    end

    always @(posedge PCWrite) begin
        pc <= newpc;
    end
endmodule