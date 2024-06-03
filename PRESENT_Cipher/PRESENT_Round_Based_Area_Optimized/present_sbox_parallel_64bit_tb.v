`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 12:06:28 AM
// Design Name: 
// Module Name: present_sbox_parallel_64bit_tb
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


module present_sbox_parallel_64bit_tb();

reg [63:0] in;
wire [63:0] out;

present_sbox_parallel_64bit uut1 (.in(in),.out(out));

initial begin
    in = 64'h0123456789abcdef;
    #10;
    $display("Output: %h", out);
    in={in[59:0],in[63:60]};
    #10;
    $display("Output: %h", out);
end
	
	
endmodule
