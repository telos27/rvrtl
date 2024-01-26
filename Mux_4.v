//4-1选择器
module Mux (select, datain0, datain1, datain2, datain3, dataout);
    input [1:0] select;
    input [31:0] datain0, datain1, datain2, datain3;
    output reg [31:0] dataout;

    always @(*) begin
        case (select)
            0: dataout <= datain0;
            1: dataout <= datain1;
            2: dataout <= datain2;
            3: dataout <= datain3;
        endcase
    end
endmodule
