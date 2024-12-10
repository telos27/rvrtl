//内存（ChatGPT）
module RAM (
    input wire clk,               // 时钟信号
    input wire [31:0] address,    // 32位地址信号
    input wire [31:0] data_in,    // 写入数据
    input wire write_enable,      // 写入使能信号
    input wire read_enable,       // 读取使能信号
    output reg [31:0] data_out    // 读出数据
);

    // 定义64KB的RAM存储器，32位宽
    reg [31:0] mem [0:16383];     // 64KB = 65536字节，32位 = 4字节，每个存储单元存储4字节，共16384个存储单元

    always @(posedge clk) begin
        // 在时钟上升沿，如果写入使能信号有效，写入数据
        if (write_enable) begin
            mem[address[15:0]] <= data_in; // 写入数据到对应地址，截取低16位地址
        end
    end

    always @(negedge clk) begin
        // 在时钟下降沿，根据读取使能信号决定输出
        if (read_enable) begin
            data_out <= mem[address[15:0]]; // 从对应地址读取数据，截取低16位地址
        end else begin
            data_out <= 32'b0;              // 如果读取使能信号为0，输出32位0
        end
    end

endmodule
