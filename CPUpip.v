`include "PC.v"
`include "RAM.v"
`include "Register.v"
`include "Immediate.v"
`include "ALU.v"
//流水线结构
module CPUpip (clr, clk);
    input clr, clk;
    //数据线
    wire [31:0] PCadd4, newPC, PCout, instruction;
    wire [31:0] immediate, rs1data, rs2data, Writedata;
    wire [31:0] addsum, ALUrs2, ALU_result;
    wire [31:0] Readdata;

    //控制线
    wire PCSrc, RegWrite, ALUSrc, Branch;
    wire [2:0] compare;

    //流水线寄存器
    reg [31:0] IFIDadd, IFIDins;
    reg [31:0] IDEXadd, IDEXrs1, IDEXrs2, IDEXimm;
    reg [2:0] IDEXfc3;
    reg [6:0] IDEXfc7;
    reg [4:0] IDEX117;
    reg [31:0] EXMEMadd, EXEMEflg, EXMEMArt;
    reg [4:0] EXMEM117;
    reg [2:0] EXMEMflg;
    reg [31:0] MEMWBMRd, MEMWBArt;
    reg [4:0] MEMWB117;

    //取指令
    Mux_2_32 MuxPC (.select(PCSrc), .datain0(EXMEMadd), .datain1(PCadd4), .dataout(newPC));

    PC PC0 (.clk(clk), .clr(clr), .newPC(newPC), .PCout(PCout));

    Adder_32 Add (.a(PCout), .b(32'h4), .sub(), .sum(PCadd4), .overflow(), .zeroflag());

    RAM Instruction_Memory (.address(PCout), .clk(clk), .clr(clr), .write(), .datain(), .dataout(instruction));

    //IF/ID
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            IFIDadd <= 32'b0;
            IFIDins <= 32'b0;
        end
        IFIDadd <= PCout;
        IFIDins <= instruction;
    end

    //Control Control0 (.clk(clk), .clr(clr), .opcode(IFIDins[6:0]),
    //  .ALUSrc(ALUSrc), .Branch(Branch), .MemWrite(MemWrite), .MemtoReg(MemtoReg), .RegWrite(RegWrite));

    Register Register0 (.clk(clk), .write(RegWrite), .rd(MEMWB117), .rs1(IFIDins[19:15]),
        .rs2(IFIDins[24:20]), .rddata(Writedata), .rs1data(rs1data), .rs2data(rs2data));

    Immediate Immediate0 (.instruction(IFIDins), .immediate(immediate));

    //ID/EX
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            IDEXadd <= 32'b0;
            IDEXrs1 <= 32'b0;
            IDEXrs2 <= 32'b0;
            IDEXimm <= 32'b0;
            IDEXfc3 <= 3'b0;
            IDEXfc7 <= 7'b0;
            IDEX117 <= 5'b0;
        end
        IDEXadd <= IFIDadd;
        IDEXrs1 <= rs1data;
        IDEXrs2 <= rs2data;
        IDEXimm <= immediate;
        IDEXfc3 <= IFIDins[2:0];
        IDEXfc7 <= IFIDins[6:0];
        IDEX117 <= IFIDins[11:7];
    end

    Adder_32 AddSum (.a(IDEXadd), .b(IDEXimm), .sub(), .sum(addsum), .overflow(), .zeroflag());

    Mux_2_32 Muxrs2 (.select(ALUSrc), .datain0(IDEXrs2), .datain1(IDEXimm), .dataout(ALUrs2));

    ALU ALU0 (.clr(clr),.rs1(IDEXrs1), .rs2(ALUrs2), .func3(IDEXfc3), .func7(IDEXfc7), 
        .result(ALU_result), .compare(compare));

    //EX/MEM
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            EXMEMadd <= 32'b0;
            EXMEMflg <= 3'b0;
            EXMEMArt <= 32'b0;
            EXMEM117 <= 5'b0;
        end
        EXMEMadd <= addsum;
        EXMEMflg <= compare;
        EXMEMArt <= ALU_result;
        EXMEM117 <= IDEX117;
    end

    //assign PCSrc <= Branch & EXMEMflg;

    RAM Data_Memory (.address(EXMEMArt), .clk(clk), .clr(clr), .write(MemWrite), .datain(EXMEMArt),
        .dataout(Readdata));
    
    //MEM/WB
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            MEMWBMRd <= 32'b0;
            MEMWBArt <= 32'b0;
            MEMWB117 <= 5'b0;
        end
        MEMWBMRd <= Readdata;
        MEMWBArt <= EXMEMArt;
        MEMWB117 <= EXMEM117;
    end

    Mux_2_32 MuxMemReg (.select(MemtoReg), .datain0(MEMWBArt), .datain1(MEMWBMRd), .dataout(Writedata));
endmodule