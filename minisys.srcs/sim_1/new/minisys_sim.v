`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module minisys_sim();
    reg clk = 1'b0;
    reg rst = 1'b1;
    reg [23:0] switch2N4 = 24'b101011000000000000000000;
    wire [23:0] led2N4;
    
    minisys u (clk, rst, switch2N4, led2N4);
    
    initial begin
        #7000 rst = 1'b0;
    end
    
    always #10
        clk = ~clk;
endmodule
