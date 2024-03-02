module PC (clk , clr , PCWrite, newpc, pc);
    input clk , clr ;
    input PCWrite;
    input [31:0] newpc;
    output reg [31:0] pc;

    always @(posedge clk) begin
        if (clr) begin 
            pc <= 32'b0 ;
        end else begin
            pc <= newpc;
        end    
    end
endmodule