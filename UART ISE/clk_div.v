`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:43 06/24/2023 
// Design Name: 
// Module Name:    clk_div 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_div(
    input clk,
    output reg clk_slow
    );
    
    initial begin 
     clk_slow=0;
    end
	 
    parameter pBAUD_RATE = 9600;
    parameter pSYS_CLK_FREQ = 10000000; //(10MHZ)
    
    reg[5:0] counter = 0;
	 
    always @(posedge clk)
	 begin
    counter <= counter + 1 ;
        if (counter == (pSYS_CLK_FREQ /(16*pBAUD_RATE))/2)
			begin
            clk_slow <= ~clk_slow;
				counter<=0;	
			end
	end
endmodule
