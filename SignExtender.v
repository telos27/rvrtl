module SignExtender (shift32, se);
    input  [31:0] shift32;
    output [31:0] se;

    genvar i;
    assign se[0] = shift32[31] | shift32[31];
    generate
        for (i = 1; i<32; i = i + 1) begin
            or ori (se[i], se[i-1], shift32[31-i]);
        end
    endgenerate
endmodule