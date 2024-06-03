`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use on your own risk

//module mux_2x1_80bit*/
//Note: 
//Create Date: 05/29/2024 01:35:19 AM
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_2x1_80bit(
    input [79:0] in1,
    input [79:0] in2,
    output [79:0] out,
    input sel    
    );
        
    assign out = (sel == 1'b1)? in2 : in1;    
    
endmodule
