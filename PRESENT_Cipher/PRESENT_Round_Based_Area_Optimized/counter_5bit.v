`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use it on your own risk

//module counter_5bit for PRESENT cipher*/
//Note: 
//Create Date: 05/29/2024 01:35:19 AM
// 
//////////////////////////////////////////////////////////////////////////////////


module counter_5bit(
    input clk,
    input reset,
    input enable,
    output reg [4:0] count
    );
    
    always @ (posedge clk) 
    begin
        if (reset==1) count <= 5'd1; // while reset, initial start from 1 as needed on algorithm
        else if (enable) count <= count + 5'd1;
    end
endmodule
