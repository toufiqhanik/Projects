`timescale 1ns / 1ps


module dsubbytes(inputdata, sbyte); //subbytes 

input [127:0] inputdata;
output [127:0] sbyte;

	//column 0
	dsoftbox t00 ( .din(inputdata[127:120]), .dout(sbyte[127:120]) );
	dsoftbox t10 ( .din(inputdata[119:112]), .dout(sbyte[119:112]) );
	dsoftbox t20 ( .din(inputdata[111:104]), .dout(sbyte[111:104]) );
	dsoftbox t30 ( .din(inputdata[103:96]), .dout(sbyte[103:96]) );

    //column 1
	dsoftbox t01 ( .din(inputdata[95:88]), .dout(sbyte[95:88]) );
	dsoftbox t11 ( .din(inputdata[87:80]), .dout(sbyte[87:80]) );
	dsoftbox t21 ( .din(inputdata[79:72]), .dout(sbyte[79:72]) );
	dsoftbox t31 ( .din(inputdata[71:64]), .dout(sbyte[71:64]) );


	//column 2
	dsoftbox t02 ( .din(inputdata[63:56]), .dout(sbyte[63:56]) );
	dsoftbox t12 ( .din(inputdata[55:48]), .dout(sbyte[55:48]) );
	dsoftbox t22 ( .din(inputdata[47:40]), .dout(sbyte[47:40]) );
	dsoftbox t32 ( .din(inputdata[39:32]), .dout(sbyte[39:32]) );

	//column 3
	dsoftbox t03 ( .din(inputdata[31:24]), .dout(sbyte[31:24]) );
	dsoftbox t13 ( .din(inputdata[23:16]), .dout(sbyte[23:16]) );
	dsoftbox t23 ( .din(inputdata[15:8]), .dout(sbyte[15:8]) );
	dsoftbox t33 ( .din(inputdata[7:0]), .dout(sbyte[7:0]) );

endmodule
