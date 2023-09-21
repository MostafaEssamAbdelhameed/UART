`timescale 1ns / 1ps

module TX_top_tb ();

/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////

parameter clk_period= 5; 
parameter half_clk_period = 2.5;
reg clk_tb=0; 
always #(half_clk_period) clk_tb = ~clk_tb;

/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////

reg  [7:0]	P_DATA_tb; 
reg		    data_valid_tb;
reg	    	PAR_EN_tb;
reg		    PAR_TYP_tb;
reg		    rst_tb;
wire		TX_OUT_tb;
wire		busy_tb;

 TX_top DUT (
		.P_DATA(P_DATA_tb),
		.data_valid(data_valid_tb),
		.PAR_EN(PAR_EN_tb),
		.PAR_TYP(PAR_TYP_tb),
		.clk(clk_tb),
		.rst(rst_tb),
		.TX_OUT(TX_OUT_tb),
		.busy(busy_tb)
		);


/////////////////////////////////////////////////////
///////////////////Initial Block/////////////////////
/////////////////////////////////////////////////////

initial begin 
	$dumpfile("TX_top.vcd"); 
	$dumpvars; 
	reset();
/*	#(clk_period);
	
	P_DATA_tb = 8'b10101010;
	PAR_EN_tb = 1;
	PAR_TYP_tb=0;
	data_valid_tb=1;
	#(clk_period);
	data_valid_tb=0;
	#(10*clk_period);
	data_valid_tb=1;
	P_DATA_tb = 8'b01010101;
	#(clk_period);
	data_valid_tb=0;
	#(11*clk_period);
	*/

	//check_2frames( DATA1 , PAR_TYP1 , EXPEC_OUT1 , DATA2 , PAR_TYP2 , EXPEC_OUT2 )
	check_2frames_p( 8'b11110000 , 1 , 11'b11111100000 , 8'b00001111 , 1 ,  11'b11000011110 );
	

	$stop;
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

/*task check_data_p ;
input [7:0] data;
input par_typ;
input [10:0] expec_out;
integer i;
reg [10:0] register;
begin

P_DATA_tb = data;
PAR_EN_tb = 1;
PAR_TYP_tb = par_typ;
data_valid_tb = 1;
#(clk_period);
data_valid_tb = 0;
#(clk_period);

for (i=0 ; i<11 ; i=i+1) begin
register[i]=TX_OUT_tb;
#(clk_period);
end

if (register == expec_out) $display("Frame Succeeded");
else $display("Frame Failed");

end
endtask*/



task check_2frames_p ;
input [7:0] data1;
input par_typ1;
input [10:0] expec_out1;
input [7:0] data2;
input par_typ2;
input [10:0] expec_out2;
reg [10:0] register ;
integer i ;

begin
	#(clk_period);
	P_DATA_tb = data1;
	PAR_EN_tb = 1;
	PAR_TYP_tb=par_typ1;
	data_valid_tb=1;
	#(clk_period);
	data_valid_tb=0;
	
@(negedge TX_OUT_tb)
	#(half_clk_period);

for (i=0 ; i<11 ; i=i+1) begin
register[i]=TX_OUT_tb;

if (FSM.curr_state == 5'b10000) begin

	P_DATA_tb = data2;
	PAR_EN_tb = 1;
	PAR_TYP_tb=par_typ2;
	data_valid_tb=1;
	#(clk_period);
	data_valid_tb=0;
	register[i+1]=TX_OUT_tb;

    if (register == expec_out1) $display("Frame 1 Succeeded");
    else $display("Frame 1 Failed");
    	
    @(negedge TX_OUT_tb)
    #(half_clk_period);
    for (i=0 ; i<11 ; i=i+1) begin
    register[i]=TX_OUT_tb;
    #(clk_period);
    end
    
    if (register == expec_out2) $display("Frame 2 Succeeded");
    else $display("Frame 2 Failed");	

end
else #(clk_period);
end
end
endtask




endmodule