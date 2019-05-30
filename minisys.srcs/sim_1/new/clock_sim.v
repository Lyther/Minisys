`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module clock_sim();
    reg clk = 1'b0;
    wire clk_out;
    
    clock u (clk_out, clk);
    
    always #1 clk = ~clk;
endmodule
