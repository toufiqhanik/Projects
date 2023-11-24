`timescale 1ns / 1ps

module dfirstround(clk, inputdata, inkey, r_out);

input clk;
input [127:0] inputdata, inkey;
output [127:0] r_out;

wire[127:0] xordata;

reg [127:0] r_out;
wire [127:0] s_byte, srow;

	assign xordata = inputdata^inkey;


	//dmixcolumn mc (xordata, mixclm);

	dshiftrow sr (xordata, srow);
	dsubbytes sb (srow, s_byte);

	
	
	always @ (s_byte && clk)
		begin
			assign r_out =  s_byte;
			end


endmodule
