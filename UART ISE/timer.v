`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:05:38 07/05/2023 
// Design Name: 
// Module Name:    timer 
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
module timer(
    input clk_slow,rst,
    input count7,count15,
    output reg tick7,tick15
    );
	 
	 reg[2:0] count;
	 reg[3:0] count_d;	
	 
	 always@(posedge clk_slow , posedge rst) begin
	   if(rst) begin
		 count <= 0;
		 count_d <=0;
		end
		else begin
		if(count7==1) begin
        count <= count + 1;
		end
		  
		if (count==7) begin
			tick7<=1;
			count<=0;
		end
		
		else begin 
			tick7 <= 0;
		end
		
		if (count15==1) begin
		   count_d <= count_d + 1;
		end
		
		if (count_d==15) begin
			tick15<=1;
			count_d<=0;
		end
		
		else begin 
			tick15 <= 0;
		end
		
	 end
	end
endmodule
