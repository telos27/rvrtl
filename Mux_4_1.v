//4-1选择器
module Mux_4_1 (select, datain0, datain1, datain2, datain3, dataout);
    input [1:0] select;
    input datain0, datain1, datain2, datain3;
    output reg dataout;

    always @(*) begin
        case (select)
            0: dataout <= datain0;
            1: dataout <= datain1;
            2: dataout <= datain2;
            3: dataout <= datain3;
        endcase
    end
endmodule
