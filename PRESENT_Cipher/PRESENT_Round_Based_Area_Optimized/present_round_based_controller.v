`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use on your own risk

//module Present present_round_based_controller*/
//Note: 
//Create Date: 05/29/2024 01:35:19 AM
// 
//////////////////////////////////////////////////////////////////////////////////


module present_round_based_controller(
    input clk,
    input n_reset,
    output [4:0] count,
    output reg done
    );
    
    counter_5bit uutcounter (.clk(clk),.reset(~n_reset),.enable(~done), .count(count));
    
    always @ (posedge clk)
    begin
        if (n_reset == 1'b0) done <= 1'b0;
        else if (count == 5'b11111 || count == 5'b00000) done <= 1'b1; // intentionally count == 5'b00000 is added such that done stays 1 till a reset.
        else  done <= 1'b0;
    end
    

endmodule
