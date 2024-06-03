`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 01:35:19 AM
// Design Name: 
// Module Name: present_round_data
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


module present_round_data(
    input clk,
    input [63:0] plaintext,
    output [63:0] ciphertext,
    input [63:0] keyin,
    input reset,
    input done
    );
    
    wire [63:0] datain_mux_out, pdata_out, dataregin_mux_out, datareg_out, sbox_out;
    
    mux_2x1_64bit datain_mux (.in1(plaintext),.in2(pdata_out),.out(datain_mux_out),.sel(reset)); 
    mux_2x1_64bit dataregin_mux (.in1(datain_mux_out),.in2(datareg_out),.out(dataregin_mux_out),.sel(done)); 
    
    datareg64bit uutdatareg (.clk(clk),.D(dataregin_mux_out),.enable(~done),.Q(datareg_out));
           
    assign ciphertext = datareg_out ^ keyin;
    
    present_sbox_parallel_64bit uut_psbox (.in(ciphertext),.out(sbox_out));
    present_pdata uut_pdata (.in(sbox_out),.out(pdata_out));
    
    
    
endmodule
