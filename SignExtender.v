module SignExtender (shift5, rsa, sign, signextend);
    input [4:0] shift5;
    input rsa, sign;
    output reg [31:0] signextend;

    always @(shift5 or sign or rsa) begin
        if (sign && rsa) begin
            case (shift5)
                //0~3
                5'b00000: signextend <= 32'h0000_0000;
                5'b00001: signextend <= 32'h8000_0000;
                5'b00010: signextend <= 32'hc000_0000;
                5'b00011: signextend <= 32'he000_0000;
                //4~7
                5'b00100: signextend <= 32'hf000_0000;
                5'b00101: signextend <= 32'hf800_0000;
                5'b00110: signextend <= 32'hfc00_0000;
                5'b00111: signextend <= 32'hfe00_0000;
                //8~11
                5'b01000: signextend <= 32'hff00_0000;
                5'b01001: signextend <= 32'hff80_0000;
                5'b01010: signextend <= 32'hffc0_0000;
                5'b01011: signextend <= 32'hffe0_0000;
                //12~15
                5'b01100: signextend <= 32'hfff0_0000;
                5'b01101: signextend <= 32'hfff8_0000;
                5'b01110: signextend <= 32'hfffc_0000;
                5'b01111: signextend <= 32'hfffe_0000;
                //16~19
                5'b10000: signextend <= 32'hffff_0000;
                5'b10001: signextend <= 32'hffff_8000;
                5'b10010: signextend <= 32'hffff_c000;
                5'b10011: signextend <= 32'hffff_e000;
                //20~23
                5'b10100: signextend <= 32'hffff_f000;
                5'b10101: signextend <= 32'hffff_f800;
                5'b10110: signextend <= 32'hffff_fc00;
                5'b10111: signextend <= 32'hffff_fe00;
                //24~27
                5'b11000: signextend <= 32'hffff_ff00;
                5'b11001: signextend <= 32'hffff_ff80;
                5'b11010: signextend <= 32'hffff_ffc0;
                5'b11011: signextend <= 32'hffff_ffe0;
                //28~31
                5'b11100: signextend <= 32'hffff_fff0;
                5'b11101: signextend <= 32'hffff_fff8;
                5'b11110: signextend <= 32'hffff_fffc;
                5'b11111: signextend <= 32'hffff_fffe;
            endcase
        end
        else begin
            signextend <= 32'h0000_0000;
        end
    end
endmodule