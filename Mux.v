module Mux (select, datain0, datain1, dataout);
    input select;
    input [31:0]datain0, datain1;
    output [31:0]dataout;

    always @(*) begin
        if (select) 
            dataout <= datain1;
        else
            dataout <= datain0;
    end
endmodule
