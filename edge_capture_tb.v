`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.02.2024 15:46:10
// Design Name: 
// Module Name: edge_capture_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module edge_capture_tb();
	
	reg  clk;
	reg  reset;
	reg  [31:0] data_i;
	wire [31:0] edge_o;
	
	edge_capture ec0(
		.clk		(		clk			),
		.reset		(		reset		),
		.data_i		(		data_i		),
		.edge_o		(		edge_o		)
	);
	
	always #5 clk = ~clk;
	
	task sample_sim();
	begin 
		#10;				// Time elapsed: 10
		reset <= 0;
		
		#10;				// Time elapsed: 20
		data_i <= 32'hA6;
		
		#10;				// Time elapsed: 30
		data_i <= 32'hBC;
		
		#10;				// Time elapsed: 40
		data_i <= 32'hBA;
		
		#10;				// Time elapsed: 50
		data_i <= 32'hEB;
		
		#50;				// Time elapsed: 100
		$stop;
	end
	endtask	
	
	initial begin 
		clk     = 1;
		reset  <= 1;
		data_i <= 0;
		
		sample_sim();
	end 
	
endmodule
