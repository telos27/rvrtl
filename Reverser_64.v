//64位全位反接
module Reverser_64 (right, datain, dataout);
    input               right;
    input       [63:0]  datain;
    output reg  [63:0]  dataout;

    integer i;
    always @(*) begin
        if (right) begin
            for (i = 0; i < 64 ; i +=1) begin
                dataout[i] <= datain[63-i];
            end
        end
        else begin
            dataout <= datain;
        end
    end

endmodule