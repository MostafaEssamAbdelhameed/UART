`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:05:01 07/05/2023 
// Design Name: 
// Module Name:    RX_FSM 
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
module RX_FSM(
    input clk_slow,rst,
    input rx,
    input tick7,
	 input tick15,
    output reg count7,
	 output reg count15,
    output [7:0] rx_out
    );
	
	parameter state_reg_width = 2;
	parameter [state_reg_width -1 : 0] idle_state = 0,
												  start_state = 1,
												  data_state = 2,
												  stop_state = 3;
	
  reg [1 : 0] curr_state, next_state;
  

												  
	always@(posedge clk_slow , posedge rst) 
		begin
			if(rst) curr_state <= idle_state;
			else    curr_state <= next_state;
		end
		
 	reg [7:0] data_val;
	reg [2:0] bit_no;	
	
	always@(*)
		begin
			case(curr_state)
				idle_state: 
				begin
					 data_val =0;
					 count7 = 0;
					 count15 = 0;
					 if(~rx)
					 begin
						count7 = 1;
						next_state = start_state;
					 end
					 else next_state = idle_state;
				end
				
				start_state:
				begin
					if(tick7)
					begin
						count7=1;
						count15=1;
						bit_no=0;
						next_state = data_state;
					end
					else next_state = start_state;
				end
				
				data_state:
				begin
					if(tick15)
					begin
						data_val= {rx,data_val[7:1]};
						if(bit_no==7)begin
							next_state = stop_state;
						end
						else begin
							bit_no = bit_no + 1;
							next_state = data_state;
						end
					end
					else next_state = data_state;
				end
				
				stop_state:
				begin
					if(tick15) begin
						bit_no=0;
						next_state=idle_state;
					end
					else next_state = stop_state;
				end
				
				default:
				begin
					next_state = idle_state;
				end
			endcase
	end		

	assign rx_out = data_val;
	
endmodule
