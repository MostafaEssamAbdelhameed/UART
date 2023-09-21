`timescale 1ns / 1ps

module TOP_rx_tb ();

/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////

parameter clk_period= 5.0; 
reg clk_tb=0; 
always #(clk_period/2) clk_tb = ~clk_tb;

/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////

reg		    RX_IN_tb;
reg  [5:0]	prescale_tb; 
reg	    	PAR_EN_tb;
reg		    PAR_TYP_tb;
reg	    	rst_tb;
wire [7:0]	P_DATA_tb; 
wire		data_valid_tb;

 TOP_rx DUT (
		.RX_IN(RX_IN_tb),
		.prescale(prescale_tb),
		.PAR_EN(PAR_EN_tb),
		.PAR_TYP(PAR_TYP_tb),
		.clk(clk_tb),
		.rst(rst_tb),
		.P_DATA(P_DATA_tb),
		.data_valid(data_valid_tb)
		);


/////////////////////////////////////////////////////
///////////////////Initial Block/////////////////////
/////////////////////////////////////////////////////

initial begin 

	$dumpfile("TOP_rx.vcd"); 
	$dumpvars; 
	reset();
	#(clk_period);


//data_transmit(DATA , PRESCALE , PAR_EN , PAR_TYP , PARITY_BIT , GLITCH ?);

data_transmit( 8'b10101010 , 8 , 1 , 0 , 0 , 1); //Glitch

data_transmit( 8'b10101010 , 8 , 1 , 0 , 1 , 0); //PAR_ERR

data_transmit( 8'b11110000 , 16 , 1 , 0 , 0 , 0); // passed

data_transmit( 8'b00001111 , 32 , 1 , 0 , 0 , 0); //passed

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

task data_transmit ;
input [7:0] DATA ;
input [5:0] prescale;
input PAR_EN;
input PAR_TYP;
input parity ;
input glitch;
integer i;
 begin
 PAR_EN_tb = PAR_EN;
 PAR_TYP_tb = PAR_TYP;
 prescale_tb=prescale;
 
 RX_IN_tb = 1;
 #(prescale*clk_period);
 
// start_bit
if(!glitch) begin

RX_IN_tb = 0 ;
#(prescale*clk_period);

// DATA_bits
for (i=0 ; i<8 ; i=i+1) begin
RX_IN_tb = DATA[i];
#(prescale*clk_period);
end

// Parity_bit
if(PAR_EN) begin
RX_IN_tb = parity ;
#(prescale*clk_period);
end
 
// Stop_bit
RX_IN_tb = 1;
#(prescale*clk_period);
 
 @( FSM.curr_state == 0)
 #(0.5*clk_period);
 if(data_valid_tb) $display ("Frame with prescale = %d is passed",prescale_tb);
 else $display ("Frame with prescale = %d has Error Flag",prescale_tb); 
 #(5*clk_period); 
 end
 
else begin

//start_bit
RX_IN_tb = 0 ;
#(0.25*prescale*clk_period);
RX_IN_tb = 1;
#(0.75*prescale*clk_period)

// DATA_bits
for (i=0 ; i<8 ; i=i+1) begin
RX_IN_tb = DATA[i];
#(prescale*clk_period);
end

// Parity_bit
if(PAR_EN) begin
RX_IN_tb = parity ;
#(prescale*clk_period);
end

// Stop_bit
RX_IN_tb = 1;
#(prescale*clk_period);

 @(FSM.curr_state == 0)
 #(0.5*clk_period);
 if(data_valid_tb) $display ("Frame with glitch is passed");
 else $display ("Frame with glitch is ignored ",prescale_tb); 
 #(5*clk_period); 
 end
 
end

endtask

endmodule

