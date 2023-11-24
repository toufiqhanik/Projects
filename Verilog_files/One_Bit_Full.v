`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2022 12:12:22 PM
// Design Name: 
// Module Name: One_Bit_Full
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


module One_Bit_Full(A, B, Cn, Co, S);
input A, B, Cn;
output Co, S;
wire d, e, f, g; 

xor xor_1 (d, A, B);
xor xor_2 (S, d, Cn);

and and1 (e, Cn, B);
and and2 (f, Cn, A);
and and3 (g, A, B);
or or1 (Co, e, f, g);





    
endmodule
