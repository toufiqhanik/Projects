`timescale 1ns / 1ps

module mixcolumn (datain, dataout);

input[127:0] datain;
output [127:0] dataout;

 
	
		assign dataout[127:96]= mixclm(datain[127:96]);
		assign dataout[95:64]= mixclm(datain[95:64]);
		assign dataout[63:32]= mixclm(datain[63:32]);
		assign dataout[31:0]= mixclm(datain[31:0]);


function [7:0] two_mult;

	input[7:0] a;
	
 
		if (a[7]==1)
		begin
			  two_mult={a[6:0],1'b 0};
			  two_mult= two_mult^8'b 00011011;
		end

		else 
		begin
			  two_mult={a[6:0],1'b 0};
		end	
		
		
endfunction


function [31:0] mixclm ;

	input [31:0] mixclmin;

	

	begin
		mixclm[31:24] = c0(mixclmin);
		mixclm[23:16] = c1(mixclmin);
		mixclm[15:8] = c2(mixclmin);
		mixclm[7:0] = c3(mixclmin);
		end
endfunction


function [7:0] c0;

	input [31:0] minp0;
	reg [7:0] byte00,byte01,byte02,byte03,u0;

	begin
    // for U0
	 byte00 = two_mult(minp0[31:24]);
	 u0= two_mult(minp0[23:16]);
	 byte01 = u0^minp0[23:16];
	 byte02 = minp0[15:8];
	 byte03 = minp0[7:0];

	 c0[7:0]= byte00^byte01^byte02^byte03;
	 end

endfunction		


function [7:0] c1;

	input [31:0] minp1;
	reg [7:0] byte10,byte11,byte12,byte13,u1;
	
	begin   
	 // for U1
	 byte10 = minp1[31:24];
	 byte11 = two_mult(minp1[23:16]);
	 u1 = two_mult(minp1[15:8]);
	 byte12 = u1^minp1[15:8];
	 byte13 = minp1[7:0];
	 c1[7:0]= byte10^byte11^byte12^byte13;

	   end

endfunction	

function [7:0] c2;

	input [31:0] minp2;
	reg [7:0] byte20,byte21,byte22,byte23,u2;
	
	begin  
    // for U2
	 byte20 = minp2[31:24];
	 byte21 = minp2[23:16];
	 byte22 = two_mult(minp2[15:8]);
	 u2 = two_mult(minp2[7:0]);
	 byte23 = u2^minp2[7:0];
	 c2[7:0] = byte20^byte21^byte22^byte23;

	 end

endfunction

function [7:0] c3;

	input [31:0] minp3;
	reg [7:0] byte30,byte31,byte32,byte33,u3;
	
	begin
	 u3 = two_mult(minp3[31:24]);
	 byte30 = u3^minp3[31:24];
	 byte31 = minp3[23:16];
	 byte32 = minp3[15:8];
	 byte33 = two_mult(minp3[7:0]);
	 c3[7:0] = byte30^byte31^byte32^byte33;

	 end

endfunction


endmodule
