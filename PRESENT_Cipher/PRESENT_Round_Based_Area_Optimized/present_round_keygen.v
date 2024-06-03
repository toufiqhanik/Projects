`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use it on your own risk

//module key generator for round based PRESENT cipher*/
//Note: 
//Create Date: 05/29/2024 01:35:19 AM
// 
//////////////////////////////////////////////////////////////////////////////////


module present_round_keygen(
    input clk,
    input [79:0] key,
    input [4:0] counter,
    input done,
    input reset,
    output [63:0] key_round
    );
    
    wire [79:0] key_mux_out, keyregin_mux_out, keyreg_out, keyreg_out_shifted, key_round_80bit;
    wire [3:0] sbox_out;
    wire [4:0] key_xor_count;
    
    mux_2x1_80bit keyin_mux (.in1(key),.in2(key_round_80bit),.out(key_mux_out),.sel(reset)); 
    mux_2x1_80bit keyregin_mux (.in1(key_mux_out),.in2(keyreg_out),.out(keyregin_mux_out),.sel(done)); 
    
    keyreg80bit uutkeyreg (.clk(clk),.D(keyregin_mux_out),.enable(~done),.Q(keyreg_out));

    assign key_round = keyreg_out[79:16];
    assign keyreg_out_shifted = {keyreg_out[18:0], keyreg_out[79:19]};
    
    present_sbox  uut_keysbox (.in(keyreg_out_shifted[79:76]),. out(sbox_out));
    assign key_xor_count = keyreg_out_shifted[19:15] ^ counter; 
    
    assign key_round_80bit = {sbox_out, keyreg_out_shifted[75:20], key_xor_count, keyreg_out_shifted[14:0]};
    
        
endmodule
