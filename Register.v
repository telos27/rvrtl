//32个整型寄存器
module Register (clk, write, rd, rs1, rs2, rddata, rs1data, rs2data);
    input clk, write;
    input [4:0] rd, rs1, rs2;
    input [31:0] rddata;
    output reg [31:0] rs1data, rs2data;
    
    reg [31:0] x[31:0];

    integer i ;

    always @(posedge clk) begin
        if (clr) begin
            for (i=0 ; i<32 ; i++) begin
                x[i] = 0;
            end
        end
        if (write) begin
            x[rd] = rddata;
            x[0] = 32'b0;
        end
        else begin
            rs1data <= x[rs1];
            rs2data <= x[rs2];
        end
    end
endmodule
