
module Controlpip (clk, clr, opcode,
    ALUSrc, Branch, MemWrite, MemtoReg, RegWrite
);
    input clk, clr;
    input [6:0] opcode;
    output AluSrc, Branch, MemWrite, MemtoReg, RegWrite;

    reg [1:0] state;

    always @(posedge clk) begin
        if (clr) begin
            state <= 0;
        end
        case (state)
            0: state <= 1;
            1: state <= 2;
            2: state <= 3;
            3: state <= 4;
            4: state <= 0;
        endcase
    end

    assign ALUSrc = ;

    assign Branch = ;

    assign MemWrite = ;
    
    assign MemtoReg = ;

    assign RegWrite = ;
endmodule