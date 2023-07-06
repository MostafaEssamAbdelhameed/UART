`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:06 06/24/2023 
// Design Name: 
// Module Name:    clk_div_tb 
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
module clk_tb();
  parameter clk_period = 10;
  reg clk_tb = 0;
  always #(clk_period/2) clk_tb = ~clk_tb;
  
 wire clk_slow_tb;
  
  clk_div DUT ( .clk(clk_tb),
                .clk_slow(clk_slow_tb)
              );
              
   initial begin
    $monitor(
		 "@ %t\n",$time,
		 "clk_slow = %d \n",clk_slow_tb
		);
	end  

endmodule
