`timescale 1ns / 1ps

module round(clk, rc, inputdata, inkey, outkey, r_out);

input clk;
input [3:0] rc;
input [127:0] inputdata, inkey;
output [127:0] outkey, r_out;

reg [127:0] r_out;
wire [127:0] outkey;
wire [127:0] s_byte, srow, mixclm;



	roundkey rk (inkey, outkey, rc);
	subbytes sb (inputdata, s_byte);
	shiftrow sr (s_byte, srow);
	mixcolumn mc (srow, mixclm);

	always @ (mixclm && clk)
		begin
			assign r_out = outkey^mixclm;
			end


endmodule
