//2-1选择器
module Mux_2_1 (select, datain0, datain1, dataout);
    input select;
    input datain0, datain1;
    output reg dataout;

    always @(*) begin
        if (select) 
            dataout <= datain1;
        else
            dataout <= datain0;
    end
endmodule
