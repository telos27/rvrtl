//移位信号生成
module Shift_Signal (s, datain, right, sra, dataout, shift);
    input [4:0] s;
    input [31:0] datain;
    input sra, right;
    output reg [31:0] shift, dataout;
    wire sign;

    assign sign = right & sra & datain[31];

    always @(*) begin
    case (s)
        //0~3
        5'b00000: shift = 32'h1;
        5'b00001: shift = {31'b1,sign};
        5'b00010: shift = {30'b1,{2{sign}}};
        5'b00011: shift = {29'b1,{3{sign}}};
        //4~7
        5'b00100: shift = {28'b1,{4{sign}}};
        5'b00101: shift = {27'b1,{5{sign}}};
        5'b00110: shift = {26'b1,{6{sign}}};
        5'b00111: shift = {25'b1,{7{sign}}};
        //8~11
        5'b01000: shift = {24'b1,{8{sign}}};
        5'b01001: shift = {23'b1,{9{sign}}};
        5'b01010: shift = {22'b1,{10{sign}}};
        5'b01011: shift = {21'b1,{11{sign}}};
        //12~15
        5'b01100: shift = {20'b1,{12{sign}}};
        5'b01101: shift = {19'b1,{13{sign}}};
        5'b01110: shift = {18'b1,{14{sign}}};
        5'b01111: shift = {17'b1,{15{sign}}};
        //16~19
        5'b10000: shift = {16'b1,{16{sign}}};
        5'b10001: shift = {15'b1,{17{sign}}};
        5'b10010: shift = {14'b1,{18{sign}}};
        5'b10011: shift = {13'b1,{19{sign}}};
        //20~23
        5'b10100: shift = {12'b1,{20{sign}}};
        5'b10101: shift = {11'b1,{21{sign}}};
        5'b10110: shift = {10'b1,{22{sign}}};
        5'b10111: shift = {9'b1,{23{sign}}};
        //24~27
        5'b11000: shift = {8'b1,{24{sign}}};
        5'b11001: shift = {7'b1,{25{sign}}};
        5'b11010: shift = {6'b1,{26{sign}}};
        5'b11011: shift = {5'b1,{27{sign}}};
        //28~31
        5'b11100: shift = {4'b1,{28{sign}}};
        5'b11101: shift = {3'b1,{29{sign}}};
        5'b11110: shift = {2'b1,{30{sign}}};
        5'b11111: shift = {1'b1,{31{sign}}};
    endcase
    end
    //移位信号输出
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
