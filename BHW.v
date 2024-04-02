//8bit、16bit、32bit选择模块
module BHW (func3, datain, dataout);
    input [2:0] func3;
    input [31:0] datain;
    output [31:0] dataout;
    //0~7
    assign dataout[0] = datain[0];
    assign dataout[1] = datain[1];
    assign dataout[2] = datain[2];
    assign dataout[3] = datain[3];
    assign dataout[4] = datain[4];
    assign dataout[5] = datain[5];
    assign dataout[6] = datain[6];
    assign dataout[7] = datain[7];
    //8~15
    assign dataout[8] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[9] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[10] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[11] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[12] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[13] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[14] = (datain[7] & func3[0] & !func3[2]);
    assign dataout[15] = (datain[7] & func3[0] & !func3[2]);
    //16~31
    assign dataout[16] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[17] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[18] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[19] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[20] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[21] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[22] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[23] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[24] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[25] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[26] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[27] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[28] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[29] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[30] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
    assign dataout[31] = (datain[7] & func3[0] & !func3[2]) | (datain[15] & func3[1] & !func3[2]);
endmodule