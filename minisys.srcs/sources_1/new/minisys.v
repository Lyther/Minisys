`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module minisys(clk, rst, switch2N4, led2N4);
    input clk, rst;
    input [23:0] switch2N4;
    output [23:0] led2N4;
    
    wire clk_out;
    wire [31:0] PC;
    wire [31:0] Instruction;
    wire Branch;
    wire nBranch;
    wire Jmp;
    wire Jal;
    wire Jrn;
    wire Zero;
    wire Lw;
    wire Sw;
    wire [31:0] Register[0:31];
    
    wire [31:0] ALU_result;
    wire [21:0] ALU_result_high = ALU_result[31:10];
    wire [31:0] Add_result;
    wire [31:0] Read_data;
    wire [31:0] Read_data_1;
    wire [31:0] Read_data_2;
    wire [31:0] Write_data;
    wire [15:0] IO_read_data;
    wire [31:0] Next_PC;
    wire [31:0] PC_plus_4_out;
    wire [31:0] Opcplus4;
    wire [31:0] Sign_extend;
    wire [31:0] Address;
    wire [4:0] Read_register_1_address;
    wire [14:0] PC15_2;
    wire [5:0] Function_opcode = Instruction[5:0];
    wire [5:0] Exe_opcode = Instruction[31:26];
    wire [1:0] ALU_opcode;
    wire [4:0] Shamt = Instruction[10:6];
    wire [1:0] Led_address = Address[1:0];
    wire [1:0] Switch_address = Address[1:0];
    wire [15:0] Led_write_data = Write_data[15:0];
//    wire [23:0] Led_out;
    wire [15:0] Switch_read_data;
//    wire [23:0] Switch_in;
    wire Sftmd;
    wire ALUSrc;
    wire I_format;
    wire MemRead;
    wire MemWrite;
    wire IORead;
    wire IOWrite;
    wire RegWrite;
    wire MemtoReg;
    wire RegDst;
    wire switchctrl;
    wire ledctrl;
    
//    assign led2N4 = Led_out;
//    assign Switch_in = switch2N4;
//    assign led2N4 = {{clk_out}, {6'b000000}, {Branch, nBranch, Zero, Jrn, Jal, Jmp, rst}, {PC_plus_4_out[4:0]}, {PC[4:0]}};
    
    clock clock_u (clk_out, clk);
    Ifetc32 ifetc_u (Instruction, Add_result, Read_data_1, Next_PC, PC_plus_4_out, Branch, nBranch, Jmp, Jal, Jrn, Zero, clk_out, rst, Opcplus4, PC, PC15_2);
    Idecode32 idecode_u (Read_data_1, Read_data_2, Instruction, Read_data, ALU_result, Jal, RegWrite, MemtoReg, RegDst, Sign_extend, clk_out, rst, Opcplus4, Read_register_1_address, Register);
    Executs32 executes_u (Read_data_1, Read_data_2, Sign_extend, Function_opcode, Exe_opcode, ALU_opcode, Shamt, ALUSrc, I_format, Zero, Jrn, Sftmd, ALU_result, Add_result, PC_plus_4_out);
    control32 control_u (Exe_opcode, Jrn, Function_opcode, ALU_result_high, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, IORead, IOWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALU_opcode);
    dmemory32 dmemory_u (Read_data, Address, Write_data, MemWrite, clk_out);
    ioread ioread_u (rst, IORead, switchctrl, IO_read_data, Switch_read_data);
    leds leds_u (clk_out, rst, ledctrl, ledctrl, Led_address, Led_write_data, led2N4);
    memorio memorio_u (ALU_result, Address, MemRead, MemWrite, IORead, IOWrite, Read_data, IO_read_data, Read_data_2, Read_data, Write_data, ledctrl, switchctrl);
    switchs switchs_u (clk_out, rst, switchctrl, switchctrl, Switch_address, Switch_read_data, switch2N4);
endmodule
