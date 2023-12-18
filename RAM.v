//内存
module RAM (address, write, clk, clr, datain, dataout);
    input [31:0] address, datain;
    input write, clk;
    output [31:0] dataout;
    reg [31:0] ramdata[1023:0];

    case (clr)
        1'b1: ramdata = 31'b0;
    endcase

    always @(posedge clk, write) begin
        if (write) begin
            ramdata[address] <= datain;
        end
        else begin
            dataout <= ramdata[address];
        end
    end
endmodule
