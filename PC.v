module PC (clk, clr, PCWrite, nextPC, PCout);
    input clk , clr, PCWrite;
    input [31:0] nextPC;
    output reg [31:0] PCout;

    always @(posedge clk) begin
        if (clr) begin 
            PCout <= 32'b0;
        end 
        if (PCWrite) begin
            PCout <= nextPC;
        end
    end
endmodule