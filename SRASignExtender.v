//算术右移符号扩展
module SRASignExtender (signex, datain, signextend);
    input signex;
    input  [63:0] datain;
    output [63:0] signextend;

    wire [62:0] ornet;

    assign ornet[62] = datain[63] | datain[63];

    genvar i;
    generate
        for (i = 1; i < 63; i = i + 1) begin
            assign ornet[63-i-1] = ornet[63-i] | datain[63-i];
        end
    endgenerate

    assign signextend = ~signex ? 64'b0 : ~{datain[63], ornet};

endmodule