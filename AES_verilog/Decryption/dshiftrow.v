`timescale 1ns / 1ps

module dshiftrow (sbyte, srow);

input [127:0] sbyte;
output [127:0] srow;
	//row 0
	assign srow[127:120]= sbyte[127:120];
	assign srow[95:88]= sbyte[95:88];
	assign srow[63:56]= sbyte[63:56];
	assign srow[31:24]= sbyte[31:24];


	//row 1
	assign srow[119:112]= sbyte[23:16];
	assign srow[87:80]= sbyte[119:112];
	assign srow[55:48]= sbyte[87:80];
	assign srow[23:16]= sbyte[55:48];

	//row 2
	assign srow[111:104]= sbyte[47:40];
	assign srow[79:72]= sbyte[15:8];
	assign srow[47:40]= sbyte[111:104];
	assign srow[15:8]= sbyte[79:72];

	//row 3
	assign srow[103:96]= sbyte[71:64];
	assign srow[71:64]= sbyte[39:32];
	assign srow[39:32]= sbyte[7:0];
	assign srow[7:0]= sbyte[103:96];

endmodule
