//###################################
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use on your own risk

//module Present Chipher Sbox*/
//Note: written in RTL case statement basis
//####################################
`timescale 1ns / 1ps
module present_sbox (
    input [3:0] in,
	output reg [3:0] out);
	
	always @ (in)
		begin
			case (in)
				4'h0: out = 4'hc;
				4'h1: out = 4'h5;
				4'h2: out = 4'h6;
				4'h3: out = 4'hb;
				
				4'h4: out = 4'h9;
				4'h5: out = 4'h0;
				4'h6: out = 4'ha;
				4'h7: out = 4'hd;
				
				4'h8: out = 4'h3;
				4'h9: out = 4'he;
				4'ha: out = 4'hf;
				4'hb: out = 4'h8;
				
				4'hc: out = 4'h4;
				4'hd: out = 4'h7;
				4'he: out = 4'h1;
				4'hf: out = 4'h2;
			endcase
		
		end
    

endmodule
