`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Ifetc32(Instruction,Add_result,Read_data_1,next_PC,PC_plus_4_out,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,reset,opcplus4,PC,PC15_2);
    output[31:0] Instruction;			// 输出指令到其他模块
    input[31:0]  Add_result;            // 来自执行单元,算出的跳转地址
    input[31:0]  Read_data_1;           // 来自译码单元，jr指令用的地址
    output[31:0] next_PC;               // 下一条指令的序号
    output[31:0] PC_plus_4_out;         // (pc+4)送执行单元
    input        Branch;                // 来自控制单元
    input        nBranch;               // 来自控制单元
    input        Jmp;                   // 来自控制单元
    input        Jal;                   // 来自控制单元
    input        Jrn;                   // 来自控制单元
    input        Zero;                  //来自执行单元
    input        clock,reset;           //时钟与复位
    output[31:0] opcplus4;              // JAL指令专用的PC+4
    output[31:0] PC;                    //程序计数器
    output[14:0] PC15_2;                //PC的15至2位
    
    wire[31:0]   PC_plus_4;             // PC+4
    reg[31:0]    PC;                   // PC寄存器（程序计数器）
    reg[31:0]    next_PC;               // 下条指令的PC（不一定是PC+4)
    reg[31:0]    opcplus4;
    wire[13:0]   PC15_2;
    
   //分配64KB ROM，编译器实际只用 64KB ROM
    prgrom instmem(
        .clka(clock),         // input wire clka
        .addra(PC[15:2]),     // input wire [13 : 0] addra
        .douta(Instruction)         // output wire [31 : 0] douta
    );

    assign PC_plus_4[31:0] = {{next_PC[29:0]}, {2'b00}};
    assign PC_plus_4_out = PC_plus_4[31:0];
    assign PC15_2[13:0] = PC[15:2];

    always @(clock) begin  // beq $n ,$m if $n=$m branch   bne if $n /=$m branch jr
        if (Branch && Zero) begin next_PC = Add_result; PC = next_PC<<2; end
        else if (Branch && ~Zero) next_PC = (PC>>2) + 1;
        else if (nBranch && Zero) next_PC = (PC>>2) + 1;
        else if (nBranch && ~Zero) begin next_PC = Add_result; PC = next_PC<<2; end
        else if (Jrn) begin PC = Read_data_1<<2; next_PC = Read_data_1; end
        
        if (reset) PC = 0;
        else if (Jmp) PC = Instruction[25:0];
        else if (Jal) begin
            opcplus4 = next_PC;
            PC = Instruction[25:0]<<2;
        end else PC = PC + 4;
        next_PC = (PC>>2) + 1;
    end
endmodule