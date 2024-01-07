//移位信号生成
module Shift_Signal (s, datain, right, sra, dataout, shift);
    input [4:0] s;
    input [31:0] datain;
    input sra, right;
    output reg [31:0] shift, dataout;

    reg [31:0] shifttemp;
    wire sign;

    assign sign = sra & datain[31];

    always @(*) begin
    case (s)
        //0~3
        5'b00000: shifttemp = 32'h1;
        5'b00001: shifttemp = {31'b1,sign};
        5'b00010: shifttemp = {30'b1,{2{sign}}};
        5'b00011: shifttemp = {29'b1,{3{sign}}};
        //4~7
        5'b00100: shifttemp = {28'b1,{4{sign}}};
        5'b00101: shifttemp = {27'b1,{5{sign}}};
        5'b00110: shifttemp = {26'b1,{6{sign}}};
        5'b00111: shifttemp = {25'b1,{7{sign}}};
        //8~11
        5'b01000: shifttemp = {24'b1,{8{sign}}};
        5'b01001: shifttemp = {23'b1,{9{sign}}};
        5'b01010: shifttemp = {22'b1,{10{sign}}};
        5'b01011: shifttemp = {21'b1,{11{sign}}};
        //12~15
        5'b01100: shifttemp = {20'b1,{12{sign}}};
        5'b01101: shifttemp = {19'b1,{13{sign}}};
        5'b01110: shifttemp = {18'b1,{14{sign}}};
        5'b01111: shifttemp = {17'b1,{15{sign}}};
        //16~19
        5'b10000: shifttemp = {16'b1,{16{sign}}};
        5'b10001: shifttemp = {15'b1,{17{sign}}};
        5'b10010: shifttemp = {14'b1,{18{sign}}};
        5'b10011: shifttemp = {13'b1,{19{sign}}};
        //20~23
        5'b10100: shifttemp = {12'b1,{20{sign}}};
        5'b10101: shifttemp = {11'b1,{21{sign}}};
        5'b10110: shifttemp = {10'b1,{22{sign}}};
        5'b10111: shifttemp = {9'b1,{23{sign}}};
        //24~27
        5'b11000: shifttemp = {8'b1,{24{sign}}};
        5'b11001: shifttemp = {7'b1,{25{sign}}};
        5'b11010: shifttemp = {6'b1,{26{sign}}};
        5'b11011: shifttemp = {5'b1,{27{sign}}};
        //28~31
        5'b11100: shifttemp = {4'b1,{28{sign}}};
        5'b11101: shifttemp = {3'b1,{29{sign}}};
        5'b11110: shifttemp = {2'b1,{30{sign}}};
        5'b11111: shifttemp = {1'b1,{31{sign}}};
    endcase
    end
    //移位信号输出
    integer i;
    always @(*) begin
        if (right) begin
            for (i = 0; i < 32 ; i +=1) begin
                shift[i] <= shifttemp[31-i];
                dataout[i] <= datain[31-i];
            end
        end
        else begin
            shift = shifttemp;
            dataout = datain;
        end
    end
endmodule
