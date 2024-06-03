`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use on your own risk

//module mux 2x64 bit in to 64 bit out  */
//Note: written in RTL generate basis
//////////////////////////////////////////////////////////////////////////////////


module mux_2x1_64bit(
    input [63:0] in1,
    input [63:0] in2,
    output [63:0] out,
    input sel    
    );
        
    assign out = (sel == 1'b1)? in2 : in1;    
    
endmodule
