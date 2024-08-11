//求补器
module Complementarium (datain, dataout);
    input  [31:0] datain;
    output [31:0] dataout;

    wire [30:0] oro;

    assign dataout[0] = datain[0] ^ 1'b0;
    assign oro[0] = datain[0] | 1'b0;

    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin
            assign dataout[i] = (oro[i-1] & 1'b1) ^ datain[i];
        end
    endgenerate
    generate
        for (i = 1; i < 31; i = i + 1) begin
            assign oro[i] = oro[i-1] | datain[i];
        end
    endgenerate
endmodule