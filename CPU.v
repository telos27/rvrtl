//CPU
`include "PC.v"
`include "Decode.v"
`include "Control.v"
`include "Register.v"
`include "ALU.v"
`include "RAM.v"
`include "Mux"
module CPU (clk,clr);
    input clk, clr;
    wire [31:0] pc, instruction, imm, rs1data, rs2data, rddata, address, result;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [4:0] rd, rs1, rs2;
    wire Regwrite, Memorywrite, ALU_b_rs2, overflow;
    PC
        PC0(.clk(clk), .clr(clr), .pc(pc));
    Decode
        Decode0 (.instruction(instruction),
                .func3(func3), .func7(func7), .rd(rd), .rs1(rs1), .rs2(rs2), .imm(imm));
    Control
        Control0 (.opcode(instruction[6:0]),
                .Regwrite(Regwrite), .Memorywrite(Memorywrite), .Mux_ALU_b(ALU_b_rs2));
    Mux
        Mux_PC (.select(), .datain0(pc), .datain1(result), .dataout(address));
    RAM
        RAM_Instruction (.address(address), .write(Memorywrite), .clk(clk), .clr(clr), .datain(result),
                        .dataout(instruction));
    Register
        Register0 (.clk(clk), .write(Regwrite), .rd(rd), .rs1(rs1), .rs2(rs2), .rddata(dataout),
                 .rs1data(rs1data), .rs2data(rs2data));
    Mux
        Mux_ALU_b (.select(ALU_b_rs2), .datain0(imm), .datain1(rs2data), .dataout(ALU_b));
    ALU
        ALU0 (.a(rs1data), .b(ALU_b), .sub(func7[5]), .func3(func3),
            .result(result), .overflow(overflow));
    RAM
        RAM_DATA (.address(result), .write(Memorywrite), .clk(clk), .clr(clr), .datain(result),
                .dataout(dataout));
endmodule
