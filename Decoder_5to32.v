//移位信号生成
module Decoder_5to32 (s, right, sra, shift);
    input [4:0] s;
    input sra, right;
    output reg [31:0] shift;

    reg [31:0] shifttemp;
    wire sign;

    assign sign = right & sra & sign;

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
    always @(*) begin
        if (right) begin
            //0~3
            shift[31] = shifttemp[0];
            shift[30] = shifttemp[1];
            shift[29] = shifttemp[2];
            shift[28] = shifttemp[3];
            //4~7
            shift[27] = shifttemp[4];
            shift[26] = shifttemp[5];
            shift[25] = shifttemp[6];
            shift[24] = shifttemp[7];
            //8~11
            shift[23] = shifttemp[8];
            shift[22] = shifttemp[9];
            shift[21] = shifttemp[10];
            shift[20] = shifttemp[11];
            //12~15
            shift[19] = shifttemp[12];
            shift[18] = shifttemp[13];
            shift[17] = shifttemp[14];
            shift[16] = shifttemp[15];
            //16~19
            shift[15] = shifttemp[16];
            shift[14] = shifttemp[17];
            shift[13] = shifttemp[18];
            shift[12] = shifttemp[19];
            //20~23
            shift[11] = shifttemp[20];
            shift[10] = shifttemp[21];
            shift[9] = shifttemp[22];
            shift[8] = shifttemp[23];
            //24~27
            shift[7] = shifttemp[24];
            shift[6] = shifttemp[25];
            shift[5] = shifttemp[26];
            shift[4] = shifttemp[27];
            //28~31
            shift[3] = shifttemp[28];
            shift[2] = shifttemp[29];
            shift[1] = shifttemp[30];
            shift[0] = shifttemp[31];
        else
            shift <= shifttemp;
        end
    end
endmodule
