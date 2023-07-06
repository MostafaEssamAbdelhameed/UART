`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   (1041.66667*period)6 06/22/2023
// Design Name:   UART_top
// Module Name:   /home/ise/UART_rx/UART_tb.v
// Project Name:  UART_rx
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UART_top
//
// Dependencies:
// 
// Revision:
// Revision 0.0(1041.66667*period) - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module UART_tb;
    parameter period = 100;	
    reg clk_tb = 0;
	 
  always #(period/2) clk_tb = ~clk_tb;
	// Inputs
	reg rx_tb;
	reg rst_tb;

	// Outputs
	wire [7:0] rx_out_tb;

	top dut (
		.rx(rx_tb), 
		.clk(clk_tb), 
		.rst(rst_tb), 
		.rx_out(rx_out_tb)
	);

	initial begin
		rst_tb=1;
		#(period);
		rst_tb=0;
		rx_tb=1;
		#(1041.66667*period);
		rx_tb=0;
		#(1041.66667*period);
		
		rx_tb = 1;
		#(1041.66667*period);
		rx_tb = 1;
		#(1041.66667*period);
		rx_tb = 0;
		#(1041.66667*period);
		rx_tb = 1;
		#(1041.66667*period);
		rx_tb = 1;
		#(1041.66667*period);
		rx_tb = 0;
		#(1041.66667*period);
		rx_tb= 1;
		#(1041.66667*period);
		rx_tb = 1;
		
		#(1041.66667*period);
		rx_tb = 1;
		#(1041.66667*period);


	end
	
	 initial begin
    $monitor (
	"@ %t\n",$time,
    "rx_out = %d \n",rx_out_tb
	);
	end
      
endmodule
