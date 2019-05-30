`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Ifetc32_sim();
    // input
    reg[31:0]  Add_result = 32'h00000000;
    reg[31:0]  Read_data_1 = 32'h00000000;
    reg        Branch = 1'b0;
    reg        nBranch = 1'b0;
    reg        Jmp = 1'b0;
    reg        Jal = 1'b0;
    reg        Jrn = 1'b0;
    reg        Zero = 1'b0;
    reg        clock = 1'b0,reset = 1'b1;

    // output
    wire[31:0] Instruction;            //  ‰≥ˆ÷∏¡Ó
    wire[31:0] next_PC;
    wire[31:0] PC_plus_4_out;
    wire[31:0] opcplus4;
    wire[31:0] PC;
    wire[13:0] PC15_2;
        
    Ifetc32 Uifetch(Instruction,Add_result,
            Read_data_1,next_PC,PC_plus_4_out,Branch,nBranch,Jmp,Jal,Jrn,Zero,
            clock,reset,opcplus4,PC,PC15_2);

    initial begin
        #100   reset = 1'b0;
        #100   Jal = 1;
        #100   begin Jrn = 1;Jal = 0; Read_data_1 = 32'h0000019c;end
        #100   begin Jrn = 0;Branch = 1'b1; Zero = 1'b1; Add_result = 32'h00000002;end
        #100   begin Branch = 1'b0; Zero = 1'b0; end
    end
    
    always #50 clock = ~clock;
endmodule