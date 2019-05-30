`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 17:09:05
// Design Name: 
// Module Name: clock_sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_sim();
    reg clk = 1'b0;
    wire clk_out;
    
    clock u (clk_out, clk);
    
    always #1 clk = ~clk;
endmodule
