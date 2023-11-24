`timescale 1ns / 1ps


module subbytes(inputdata, sbyte); //subbytes 

input [127:0] inputdata;
output [127:0] sbyte;

	//column 0
	softbox t00 ( .din(inputdata[127:120]), .dout(sbyte[127:120]) );
	softbox t10 ( .din(inputdata[119:112]), .dout(sbyte[119:112]) );
	softbox t20 ( .din(inputdata[111:104]), .dout(sbyte[111:104]) );
	softbox t30 ( .din(inputdata[103:96]), .dout(sbyte[103:96]) );

    //column 1
	softbox t01 ( .din(inputdata[95:88]), .dout(sbyte[95:88]) );
	softbox t11 ( .din(inputdata[87:80]), .dout(sbyte[87:80]) );
	softbox t21 ( .din(inputdata[79:72]), .dout(sbyte[79:72]) );
	softbox t31 ( .din(inputdata[71:64]), .dout(sbyte[71:64]) );


	//column 2
	softbox t02 ( .din(inputdata[63:56]), .dout(sbyte[63:56]) );
	softbox t12 ( .din(inputdata[55:48]), .dout(sbyte[55:48]) );
	softbox t22 ( .din(inputdata[47:40]), .dout(sbyte[47:40]) );
	softbox t32 ( .din(inputdata[39:32]), .dout(sbyte[39:32]) );

	//column 3
	softbox t03 ( .din(inputdata[31:24]), .dout(sbyte[31:24]) );
	softbox t13 ( .din(inputdata[23:16]), .dout(sbyte[23:16]) );
	softbox t23 ( .din(inputdata[15:8]), .dout(sbyte[15:8]) );
	softbox t33 ( .din(inputdata[7:0]), .dout(sbyte[7:0]) );

endmodule
