//64位求补器
module Complementarium_64 (datain, dataout);
    input  [63:0] datain;
    output [63:0] dataout;

    wire [62:0] ornet;

    assign ornet[0] = datain[0] | datain[0];
    assign dataout[0] = datain[0];

    genvar i;
    generate
        for (i = 1; i < 63; i = i + 1) begin
            assign ornet[i] = ornet[i-1] | datain[i];
            assign dataout[i] = datain[i] ^ ornet[i-1];
        end
    endgenerate

    assign dataout[63] = datain[63] ^ ornet[62];

endmodule