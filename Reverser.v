module Reverser (right, datain, dataout);
    input right;
    input [31:0] datain;
    output reg [31:0] dataout;
    integer i;
    always @(*) begin
        if (right) begin
            for (i = 0; i < 32 ; i +=1) begin
                dataout[i] <= datain[31-i];
            end
        end
        else begin
            dataout <= datain;
        end
    end
endmodule