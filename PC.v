module PC (clk, clr, nextPC, PCout);
    input clk , clr;
    input [31:0] nextPC;
    output reg [31:0] PCout;

    always @(posedge clk) begin
        if (clr) begin 
            PCout <= 32'b0;
        end 
        else begin
            PCout <= nextPC;
        end
    end
endmodule