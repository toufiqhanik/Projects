//###################################
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use on your own risk

//module Present Chipher Sbox 64bit*/
//Note: written in RTL generate basis
//####################################

module present_sbox_parallel_64bit (
    input [63:0] in,
	output [63:0] out);
	
	
	genvar i;
	
	generate
		for  ( i= 0; i<16; i= i+1) 
			begin: present_sbox_gen
				present_sbox  uut(.in(in[i*4 +: 4]),. out(out[i*4 +: 4]));
			end
	endgenerate 
    

endmodule
