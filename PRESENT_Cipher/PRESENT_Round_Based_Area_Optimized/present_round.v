`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use it on your own risk

//module Present present_round_based_controller*/
//Note: 
// //Create Date: 05/29/2024 01:35:19 AM
//////////////////////////////////////////////////////////////////////////////////


module present_round(
    input [63:0] plaintext,
    output [63:0] chiphertext,
    input [79:0] key,
    input n_reset,
    input clk,
    output done,
    output [4:0] round_count
    );
    
    wire [63:0] key_round;
    
    present_round_data uutprd (.clk(clk),.plaintext(plaintext),.ciphertext(chiphertext),.keyin(key_round),.reset(n_reset),.done(done));
    present_round_keygen uutprk (.clk(clk), .key(key),.counter(round_count),.done(done),.reset(n_reset),.key_round(key_round));
    present_round_based_controller uutprbc (.clk(clk),.n_reset(n_reset),.count(round_count),.done(done));
    
endmodule
