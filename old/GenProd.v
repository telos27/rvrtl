//部分积生成
module GenProd (a, neg, zero, one, two, prod);
    input [31:0] a;
    input neg, zero, one, two;
    output [32:0] prod;

    reg [32:0] prodtemp;

    always @(*) begin
        if (zero) begin
            prodtemp <= 33'b0;
        end
        else if (one)begin
            prodtemp <= {1'b0, a};
        end
        else if (two)begin
            prodtemp <= {a, 1'b0};
        end
        else begin
            prodtemp <= 33'b0;
        end
    end
    assign prod = neg ? (~prodtemp): prodtemp;
endmodule
