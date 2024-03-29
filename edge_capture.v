/*
	Details:
	
	Quite often your logic needs to react to a change on some control signal. 
	That can be an external input, something saying that another part of the circuit 
	has done it's job and that it is safe to continue. 
	
	All sorts of scenarios exist that call for a signal generated by one part of a 
	system to be detected by another part or a different system.

	Implement a sticky edge detector (or a edge capture) circuit which captures 
	any neg-edge (from 1-0) transition on a 32-bit input signal. 
	The edge detection and capture must be performed on per bit basis 
	for all the 32-bits of the input. 
	All the flops should be positive edge triggered with asynchronous resets (if any).
	
	Interface Definition
		data_i[31:0] : Input bits to the module
		edge_o[31:0] : Output which says a neg-edge was detected
	
	Interface Requirements
		The detection should be sticky - once neg-edge is detected on any bit of the input, 
		the particular bit in the edge_o should remain asserted until reset is seen
	
	The module should produce the output on every cycle
	
*/

/*
	/////////////////////
	//	Design Thinking
	/////////////////////
	
	If past cycle value of data_i was "1" and 
	the current cycle value of data_i is "0 then
	    edge_o should be "1"
	else
		edge_o should remember its past value until reset comes.
	
	Here two points are important:
	
	* for loop will make it easy to write bit-wise if else operation.
	* Need another helper register to store the current value of 
	  decision making register variable, so that we can avoid 
	  circular combinational logic.
	
*/


module edge_capture (
	input   wire        clk,
	input   wire        reset,

	input   wire [31:0] data_i,

	output  wire [31:0] edge_o

);

	// Write your logic here...
	
	reg      [31:0] data_i_past;
	reg      [31:0] edge_reg0;
	reg      [31:0] edge_reg1;
	integer  iter;
	
	
	assign edge_o = edge_reg0;
	
	
	always @ (posedge clk or posedge reset) begin 
		if (reset) begin 
			data_i_past <= 0;
			edge_reg1   <= 0;
		end else begin
			data_i_past <= data_i;
			edge_reg1   <= edge_reg0;
		end	
	end
	
	always @ (*) begin 
		for (iter = 0; iter <= 31; iter = iter+1) begin
			edge_reg0[iter] = (reset) ? 0 :
							  ((data_i_past[iter] == 1) && (data_i[iter] == 0)) ? 1 : edge_reg1[iter];
			
		end
	end
	
	
endmodule