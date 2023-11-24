`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2022 12:45:46 PM
// Design Name: 
// Module Name: Four_Bit_Adder
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


module Four_Bit_Adder(A0,A1,A2,A3,B0,B1,B2,B3,S0,S1,S2,S3,Co);

input A0,A1,A2,A3,B0,B1,B2,B3;
output Co; 
output S0,S1,S2,S3;
wire [2:0]d; 

//First 1 Bit Adder
One_Bit_Full adder1 (A0, B0, 0, d, S0);

//Second 1 Bit Adder 
One_Bit_Full adder2 (A1, B1, d, e, S1);
//Third 1 Bit Adder 
One_Bit_Full adder3 (A2, B2, e, f, S2);
// Fourth 1 Bit Adder
One_Bit_Full adder4 (A3, B3, f, Co, S3);

endmodule
