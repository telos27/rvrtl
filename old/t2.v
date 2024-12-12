`define FETCH 1'b0
`define EXECUTE 1'b1

module cu(input clk , output read_mem , output write_reg) ;

    reg state ;

    initial begin
       state <= `FETCH ; 
    end

    assign read_mem = state==`FETCH ;
    assign write_reg = state==`EXECUTE ;

    always @(posedge clk) begin
        case (state) 
            `FETCH: begin state <= `EXECUTE ; end 
            `EXECUTE: begin state <= `FETCH ; end
        endcase end
endmodule



