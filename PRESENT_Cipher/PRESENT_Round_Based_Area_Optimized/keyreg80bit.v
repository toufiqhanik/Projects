`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use on your own risk

//module 80 bit DFF with enable*/
//Note: written in RTL 
//////////////////////////////////////////////////////////////////////////////////


module keyreg80bit(
    input clk,
    input [79:0] D,
    input enable,
    output reg [79:0] Q
    );
        
    
    always @ (posedge clk)
    begin
        if (enable) Q <= D;
        else Q <= Q;
    end
    
endmodule
