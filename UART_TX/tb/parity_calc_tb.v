`timescale 1ns / 1ps

module parity_calc_tb ();

/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////

parameter clk_period = 10; 
reg clk_tb = 0; 
always #(clk_period/2) clk_tb = ~clk_tb;

/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////

reg     [7:0]   P_DATA_tb; 
reg		        par_en_tb;
reg		        PAR_TYP_tb;
reg		        rst_tb;
wire			PAR_BIT_tb;

 parity_calc DUT (
		.P_DATA(P_DATA_tb),
		.par_en(par_en_tb),
		.PAR_TYP(PAR_TYP_tb),
		.clk(clk_tb),
		.rst(rst_tb),
		.PAR_BIT(PAR_BIT_tb)
		);


/////////////////////////////////////////////////////
///////////////////Initial Block/////////////////////
/////////////////////////////////////////////////////

initial begin 
	reset();
	
	P_DATA_tb = 8'b11000000;
	PAR_TYP_tb = 1;
	par_en_tb=1;
	#(clk_period);
    par_en_tb=0;
    
    #(12*clk_period);

	P_DATA_tb = 8'b10000000;
	PAR_TYP_tb = 0;
	par_en_tb=1;
	#(clk_period);
    par_en_tb=0;
    
    #(12*clk_period);

	P_DATA_tb = 8'b10000000;
	PAR_TYP_tb = 1;
	par_en_tb=1;
	#(clk_period);
    par_en_tb=0;
	
end 

/////////////////////////////////////////////////////
//////////////////////Tasks//////////////////////////
/////////////////////////////////////////////////////

task reset;
 begin
 rst_tb=1;
 #(clk_period);
 rst_tb=0;
 #(clk_period);
 rst_tb=1;
 end
endtask
endmodule
