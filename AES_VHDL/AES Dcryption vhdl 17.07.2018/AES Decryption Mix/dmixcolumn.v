`timescale 1ns / 1ps

module dmixcolumn (datain, dataout);

input[127:0] datain;
output [127:0] dataout;

 
	
		assign dataout[127:96]= mixclm(datain[127:96]);
		assign dataout[95:64]= mixclm(datain[95:64]);
		assign dataout[63:32]= mixclm(datain[63:32]);
		assign dataout[31:0]= mixclm(datain[31:0]);

	


function [7:0] xtime;
	input [7:0] x;

	reg [7:0] i1,i2,i3;

	begin
	i1={x[6:0],1'b 0};
	i2={7'b 0000000,x[7]};
	i3=i2*(8'b 00011011);

	xtime= i1^i3;
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

function [7:0] m9 ;

	input [7:0] xin;
	reg [7:0] x1,x2,x3;
	begin 
		x1 = xtime(xin);
		x2 = xtime(x1);
		x3 = xtime(x2);
		m9 =x3^xin;
	end

		
endfunction

function [7:0] m11 ;

	input [7:0] yin;
	reg [7:0] y1,y2,y3,y4;
	begin 
		y1 = xtime(yin);
		y2 = xtime(y1);
		y3 = y2^yin;
		y4 = xtime(y3);
		m11= y4^yin;

	end
		
endfunction

function [7:0] m13 ;

	input [7:0] zin;
	reg [7:0] z1,z2,z3,z4;
	begin 
		z1 = xtime(zin);
		z2 = z1^zin;
		z3 = xtime(z2);
		z4 = xtime(z3);
		m13= z4^zin;
	end
		
endfunction

function [7:0] m14 ;

	input [7:0] win;
	reg [7:0] w1,w2,w3,w4;
	begin 
		w1 = xtime(win);
		w2 = w1^win;
		w3 = xtime(w2);
		w4 = w3^win;
		m14= xtime(w4);

	end
		
endfunction


function [7:0] c0;

	input [31:0] minp0;
	reg [7:0] byte00,byte01,byte02,byte03;

	//gfmultiply(.a(),.b())

	begin
    // for U0
	 byte00 = m14(minp0[31:24]);
	 byte01 = m11(minp0[23:16]);
	 byte02 = m13(minp0[15:8]);
	 byte03 = m9(minp0[7:0]);

	 c0[7:0]= byte00^byte01^byte02^byte03;
	 end

endfunction		


function [7:0] c1;

	input [31:0] minp1;
	reg [7:0] byte10,byte11,byte12,byte13;
	
	begin   
	 // for U1
	 byte10 = m9(minp1[31:24]); 
	 byte11 = m14(minp1[23:16]); 
	 byte12 = m11(minp1[15:8]); 
	 byte13 = m13(minp1[7:0]); 
	 c1[7:0]= byte10^byte11^byte12^byte13;

	   end

endfunction	

function [7:0] c2;

	input [31:0] minp2;
	reg [7:0] byte20,byte21,byte22,byte23;
	
	begin  
    // for U2
	 byte20 = m13(minp2[31:24]); 
	 byte21 = m9(minp2[23:16]); 
	 byte22 = m14(minp2[15:8]); 
	 byte23 = m11(minp2[7:0]); 
	 c2[7:0] = byte20^byte21^byte22^byte23;

	 end

endfunction

function [7:0] c3;

	input [31:0] minp3;
	reg [7:0] byte30,byte31,byte32,byte33;
	
	begin

	 byte30 = m11(minp3[31:24]); 
	 byte31 = m13(minp3[23:16]); 
	 byte32 = m9(minp3[15:8]); 
	 byte33 = m14(minp3[7:0]); 
	 c3[7:0] = byte30^byte31^byte32^byte33;

	 end

endfunction


endmodule
