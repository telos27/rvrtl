//2-1选择器
module Mux_2_32 (select, datain0, datain1, dataout);
    input select;
    input [31:0] datain0, datain1;
    output reg [31:0] dataout;

    always @(*) begin
        if (select) 
            dataout <= datain1;
        else
            dataout <= datain0;
    end
endmodule
