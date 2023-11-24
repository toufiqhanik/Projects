`timescale 1ns / 1ps

module finalround( clk, rc, inputdata, inkey, r_out);

input clk;
input [3:0] rc;
input [127:0] inputdata, inkey;
output [127:0] r_out;
reg [127:0] r_out;


wire [127:0] sbyte, srow, outkey;


	
	roundkey rk (inkey, outkey, rc);
	subbytes sb (inputdata, sbyte);
	shiftrow sr (sbyte, srow);

		always @ (srow && clk)
			begin
			assign r_out = outkey^srow;
			end
	

	

endmodule
