`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Ifetc32(Instruction,Add_result,Read_data_1,next_PC,PC_plus_4_out,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,reset,opcplus4,PC,PC15_2);
    output[31:0] Instruction;			// ���ָ�����ģ��
    input[31:0]  Add_result;            // ����ִ�е�Ԫ,�������ת��ַ
    input[31:0]  Read_data_1;           // �������뵥Ԫ��jrָ���õĵ�ַ
    output[31:0] next_PC;               // ��һ��ָ������
    output[31:0] PC_plus_4_out;         // (pc+4)��ִ�е�Ԫ
    input        Branch;                // ���Կ��Ƶ�Ԫ
    input        nBranch;               // ���Կ��Ƶ�Ԫ
    input        Jmp;                   // ���Կ��Ƶ�Ԫ
    input        Jal;                   // ���Կ��Ƶ�Ԫ
    input        Jrn;                   // ���Կ��Ƶ�Ԫ
    input        Zero;                  //����ִ�е�Ԫ
    input        clock,reset;           //ʱ���븴λ
    output[31:0] opcplus4;              // JALָ��ר�õ�PC+4
    output[31:0] PC;                    //���������
    output[14:0] PC15_2;                //PC��15��2λ
    
    wire[31:0]   PC_plus_4;             // PC+4
    reg[31:0]    PC;                   // PC�Ĵ����������������
    reg[31:0]    next_PC;               // ����ָ���PC����һ����PC+4)
    reg[31:0]    opcplus4;
    wire[13:0]   PC15_2;
    
   //����64KB ROM��������ʵ��ֻ�� 64KB ROM
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