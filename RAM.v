//内存
module RAM (address, clk, clr, write, read, datain, dataout);
    input [31:0] address, datain;
    input write, read, clk, clr;
    output reg [31:0] dataout;
    reg [31:0] ramdata[1023:0];

    integer i;

    initial begin
        if (clr)
            for (i = 0; i < 1024; i +=i) begin
                ramdata[i] = 32'b0;
            end
    end

    always @(posedge clk or write or read) begin
        if (write)
            ramdata[address] <= datain;
        else if (read)
            dataout <= ramdata[address];
        else
            dataout <= 32'b0;
    end
endmodule
