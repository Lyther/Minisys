`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module control32(Opcode,Jrn,Function_opcode,Alu_resultHigh,RegDST,ALUSrc,MemorIOtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
    input[21:0]  Alu_resultHigh;
    input[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
    input[5:0]   Function_opcode;  	// ����ȡָ��Ԫr-���� instructions[5..0]
    output       MemRead;
    output       IORead;
    output       IOWrite;
    output       Jrn;         	 // Ϊ1������ǰָ����jr
    output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    output       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    output       MemorIOtoReg;   	//  Ϊ1������Ҫ�Ӵ洢�������ݵ��Ĵ���
    output       RegWrite;   	//  Ϊ1������ָ����Ҫд�Ĵ���
    output       MemWrite;   	//  Ϊ1������ָ����Ҫд�洢��
    output       Branch;    	//  Ϊ1������Beqָ��
    output       nBranch;   	//  Ϊ1������Bneָ��
    output       Jmp;        	//  Ϊ1������Jָ��
    output       Jal;        	//  Ϊ1������Jalָ��
    output       I_format;  	//  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
    output       Sftmd;     	//  Ϊ1��������λָ��
    output[1:0]  ALUOp;	        //  ��R-���ͻ�I_format=1ʱλ1Ϊ1, beq��bneָ����λ0Ϊ1
   
    wire Jmp,I_format,Jal,Branch,nBranch;
    wire R_format;        // Ϊ1��ʾ��R-����ָ��
    wire Lw;               // Ϊ1��ʾ��lwָ��
    wire Sw;               // Ϊ1��ʾ��swָ��
    
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;    	//--00h 
    assign RegDST = R_format;                               //˵��Ŀ����rd��������rt

    assign I_format = Opcode[5:3] == 3'b001;
    assign Lw = (Opcode == 6'b100011) ? 1'b1 : 1'b0;
    assign Jal = (Opcode == 6'b000011) ? 1'b1 : 1'b0;
    assign Jrn = (Opcode == 6'b000000) && (Function_opcode == 6'b001000);
    assign RegWrite = !Jrn && (I_format || Lw || Jal || R_format);

    assign Sw = (Opcode == 6'b101011) ? 1'b1 : 1'b0;
//    assign ALUSrc = (~Branch && ~nBranch && ~Jmp && ~Jal && ~Sftmd && ~R_format) && (I_format || Lw || Sw);
    assign ALUSrc = I_format || MemWrite || IOWrite || MemorIOtoReg;
    assign Branch = Opcode == 6'b000100;
    assign nBranch = Opcode == 6'b000101;
    assign Jmp = Opcode == 6'b000010;
    
//    assign MemWrite = (~Branch && ~nBranch && ~Jmp && ~Jal && ~I_format && ~Lw && ~R_format && ~Sftmd) && Sw;
//    assign MemtoReg = ~Jmp && ~Jal && ~I_format && ~Sftmd && ~R_format && Lw;
    assign Sftmd = (Opcode == 6'b000000) && (Function_opcode[5:3] == 3'b000);
  
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};  // ��R��type����Ҫ��������32λ��չ��ָ��1λΪ1,beq��bneָ����0λΪ1
    
    assign RegWrite = (R_format || Lw || Jal || I_format) && (!Jrn);
    assign MemWrite = ((Sw == 1) && (Alu_resultHigh[21:0] != 22'b1111111111111111111111)) ? 1'b1 : 1'b0;
    assign MemRead = ((Lw == 1) && (Alu_resultHigh[21:0] != 22'b1111111111111111111111)) ? 1'b1 : 1'b0;
    assign IOWrite = ((Sw == 1) && (Alu_resultHigh[21:0] == 22'b1111111111111111111111)) ? 1'b1 : 1'b0;
    assign IORead = ((Lw == 1) && (Alu_resultHigh[21:0] == 22'b1111111111111111111111)) ? 1'b1 : 1'b0;
    assign MemorIOtoReg = IORead || MemRead;
endmodule