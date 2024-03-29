`timescale 1ns / 1ps

module serializer_tb ();

/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////

parameter clk_period= 20; 
reg clk_tb=0; 
always #(clk_period/2) clk_tb = ~clk_tb;

/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////

reg     [7:0]	P_DATA_tb; 
reg		        ser_en_tb;
reg		        rst_tb;
wire			ser_done_tb;
wire			ser_data_tb;

 serializer DUT (
		.P_DATA(P_DATA_tb),
		.ser_en(ser_en_tb),
		.clk(clk_tb),
		.rst(rst_tb),
		.ser_done(ser_done_tb),
		.ser_data(ser_data_tb)
		);


/////////////////////////////////////////////////////
///////////////////Initial Block/////////////////////
/////////////////////////////////////////////////////

initial begin 
	$dumpfile("serializer.vcd"); 
	$dumpvars; 
	reset();
	P_DATA_tb = 8'b10101010;
	ser_en_tb = 1;

	#(clk_period);
	ser_en_tb = 0;
	P_DATA_tb = 8'b11110000;

end 

/////////////////////////////////////////////////////
//////////////////////Tasks//////////////////////////
/////////////////////////////////////////////////////

task reset;
 begin
 rst_tb=1;
 #(clk_period)
 rst_tb=0;
 #(clk_period)
 rst_tb=1;
 end
endtask
endmodule 