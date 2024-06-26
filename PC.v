module PC (clk, clr, newPC, PCout);
    input clk , clr;
    input [31:0] newPC;
    output reg [31:0] PCout;

    always @(posedge clk) begin
        if (clr) begin 
            PCout <= 32'b0;
        end 
        else begin
            PCout <= newPC;
        end
    end
endmodule