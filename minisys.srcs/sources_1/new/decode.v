`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module decode(Instruction, opcode, rs, rt, rd, shamt, funct, imm, address, R_format, I_format, J_format);
    input [31:0] Instruction;
    output [5:0] opcode;
    output [4:0] rs;
    output [4:0] rt;
    output [4:0] rd;
    output [4:0] shamt;
    output [5:0] funct;
    output [15:0] imm;
    output [25:0] address;
    output R_format, I_format, J_format;
    
    assign opcode = Instruction[31:26];
    assign rs = Instruction[25:21];
    assign rt = Instruction[20:16];
    assign rd = Instruction[15:11];
    assign shamt = Instruction[10:6];
    assign funct = Instruction[5:0];
    assign imm = Instruction[15:0];
    assign address = Instruction[25:0];
    assign R_format = opcode == 6'b000000;
    assign J_format = (opcode == 6'b000010) || (opcode == 6'b000011);
    assign I_format = !(R_format || J_format);
endmodule
