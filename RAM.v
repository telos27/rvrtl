//内存
module RAM (clk, clr, address, write, read, datain, dataout);
    input clk, clr, write, read;
    input [31:0] address, datain;
    output reg [31:0] dataout;
    reg [31:0] ramdata[1023:0];

    integer i;

    always @(posedge clk) begin
        if (clr)
            for (i = 0; i < 1024; i = i ++) begin
                ramdata[i] = 32'b0;
            end
        else if (write)
            ramdata[address] <= datain;
        else if (read)
            dataout <= ramdata[address];
        else
            dataout <= 32'b0;
    end
endmodule
