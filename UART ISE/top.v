`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:10 07/05/2023 
// Design Name: 
// Module Name:    top 
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
module top(
    input rx,
    input rst,
    input clk,
    output [7:0] rx_out
    );
	// Instantiate the module
	clk_div clk_divider (
    .clk(clk), 
    .clk_slow(clk_slow)
    );
	 
	 // Instantiate the module
	 timer baud_timer (
    .clk_slow(clk_slow), 
    .rst(rst), 
    .count7(count7), 
    .count15(count15), 
    .tick7(tick7), 
    .tick15(tick15)
    );
	 
	 // Instantiate the module
	 RX_FSM fsm (
    .clk_slow(clk_slow), 
    .rst(rst), 
    .rx(rx), 
    .tick7(tick7), 
    .tick15(tick15), 
    .count7(count7), 
    .count15(count15), 
    .rx_out(rx_out)
    );


endmodule
