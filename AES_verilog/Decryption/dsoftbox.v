`timescale 1ns / 1ps

module dsoftbox(din, dout);

input [7:0] din;
output [7:0] dout;

reg [7:0] dout;

always @(din)
	begin
		dout = inv_svalue (din);
/*
		$display("input to inv_sbox :");
        $display("%h", din);
        $display("%b", din);

        $display("Output of inv_sbox :");
        $display("%h", dout);
        $display("%b", dout);
*/

	end



function [7:0] inv_svalue;

	input [7:0] s_inp;

	reg [3:0] r ;
	reg [3:0] clm ;


	reg [7:0] inv_sbox [0:15][0:15];

	begin
	
	    inv_sbox[0][0]=8'h52;
	    inv_sbox[0][1]= 8'h09;
	    inv_sbox[0][2]= 8'h6A;
	    inv_sbox[0][3]=8'hD5;
	    inv_sbox[0][4]=8'h30;
	    inv_sbox[0][5]=8'h36;
	    inv_sbox[0][6]= 8'hA5;
	    inv_sbox[0][7]= 8'h38;
	    inv_sbox[0][8]= 8'hBF;
	    inv_sbox[0][9]= 8'h40;
	    inv_sbox[0][10]= 8'hA3;
	    inv_sbox[0][11]= 8'h9E;
	    inv_sbox[0][12]= 8'h81;
	    inv_sbox[0][13]= 8'hF3;
	    inv_sbox[0][14]= 8'hD7;
	    inv_sbox[0][15]= 8'hFB;

	    inv_sbox[1][0]=8'h7C;
	    inv_sbox[1][1]= 8'hE3;
	    inv_sbox[1][2]= 8'h39;
	    inv_sbox[1][3]=8'h82;
	    inv_sbox[1][4]=8'h9B;
	    inv_sbox[1][5]=8'h2F;
	    inv_sbox[1][6]= 8'hFF;
	    inv_sbox[1][7]= 8'h87;
	    inv_sbox[1][8]= 8'h34;
	    inv_sbox[1][9]= 8'h8E;
	    inv_sbox[1][10]= 8'h43;
	    inv_sbox[1][11]= 8'h44;
	    inv_sbox[1][12]= 8'hC4;
	    inv_sbox[1][13]= 8'hDE;
	    inv_sbox[1][14]= 8'hE9;
	    inv_sbox[1][15]= 8'hCB;

	    inv_sbox[2][0]=8'h54;
	    inv_sbox[2][1]= 8'h7B;
	    inv_sbox[2][2]= 8'h94;
	    inv_sbox[2][3]=8'h32;
	    inv_sbox[2][4]=8'hA6;
	    inv_sbox[2][5]=8'hC2;
	    inv_sbox[2][6]= 8'h23;
	    inv_sbox[2][7]= 8'h3D;
	    inv_sbox[2][8]= 8'hEE;
	    inv_sbox[2][9]= 8'h4C;
	    inv_sbox[2][10]= 8'h95;
	    inv_sbox[2][11]= 8'h0B;
	    inv_sbox[2][12]= 8'h42;
	    inv_sbox[2][13]= 8'hFA;
	    inv_sbox[2][14]= 8'hC3;
	    inv_sbox[2][15]= 8'h4E;

	    inv_sbox[3][0]=8'h08;
	    inv_sbox[3][1]= 8'h2E;
	    inv_sbox[3][2]= 8'hA1;
	    inv_sbox[3][3]=8'h66;
	    inv_sbox[3][4]=8'h28;
	    inv_sbox[3][5]=8'hD9;
	    inv_sbox[3][6]= 8'h24;
	    inv_sbox[3][7]= 8'hB2;
	    inv_sbox[3][8]= 8'h76;
	    inv_sbox[3][9]= 8'h5B;
	    inv_sbox[3][10]= 8'hA2;
	    inv_sbox[3][11]= 8'h49;
	    inv_sbox[3][12]= 8'h6D;
	    inv_sbox[3][13]= 8'h8B;
	    inv_sbox[3][14]= 8'hD1;
	    inv_sbox[3][15]= 8'h25;

	    inv_sbox[4][0]=8'h72;
	    inv_sbox[4][1]= 8'hF8;
	    inv_sbox[4][2]= 8'hF6;
	    inv_sbox[4][3]=8'h64;
	    inv_sbox[4][4]=8'h86;
	    inv_sbox[4][5]=8'h68;
	    inv_sbox[4][6]= 8'h98;
	    inv_sbox[4][7]= 8'h16;
	    inv_sbox[4][8]= 8'hD4;
	    inv_sbox[4][9]= 8'hA4;
	    inv_sbox[4][10]= 8'h5C;
	    inv_sbox[4][11]= 8'hCC;
	    inv_sbox[4][12]= 8'h5D;
	    inv_sbox[4][13]= 8'h65;
	    inv_sbox[4][14]= 8'hB6;
	    inv_sbox[4][15]= 8'h92;

	    inv_sbox[5][0]=8'h6C;
	    inv_sbox[5][1]= 8'h70;
	    inv_sbox[5][2]= 8'h48;
	    inv_sbox[5][3]=8'h50;
	    inv_sbox[5][4]=8'hFD;
	    inv_sbox[5][5]=8'hED;
	    inv_sbox[5][6]= 8'hB9;
	    inv_sbox[5][7]= 8'hDA;
	    inv_sbox[5][8]= 8'h5E;
	    inv_sbox[5][9]= 8'h15;
	    inv_sbox[5][10]= 8'h46;
	    inv_sbox[5][11]= 8'h57;
	    inv_sbox[5][12]= 8'hA7;
	    inv_sbox[5][13]= 8'h8D;
	    inv_sbox[5][14]= 8'h9D;
	    inv_sbox[5][15]= 8'h84;

	    inv_sbox[6][0]=8'h90;
	    inv_sbox[6][1]= 8'hD8;
	    inv_sbox[6][2]= 8'hAB;
	    inv_sbox[6][3]=8'h00;
	    inv_sbox[6][4]=8'h8C;
	    inv_sbox[6][5]=8'hBC;
	    inv_sbox[6][6]= 8'hD3;
	    inv_sbox[6][7]= 8'h0A;
	    inv_sbox[6][8]= 8'hF7;
	    inv_sbox[6][9]= 8'hE4;
	    inv_sbox[6][10]= 8'h58;
	    inv_sbox[6][11]= 8'h05;
	    inv_sbox[6][12]= 8'hB8;
	    inv_sbox[6][13]= 8'hB3;
	    inv_sbox[6][14]= 8'h45;
	    inv_sbox[6][15]= 8'h06;

	    inv_sbox[7][0]=8'hD0;
	    inv_sbox[7][1]= 8'h2C;
	    inv_sbox[7][2]= 8'h1E;
	    inv_sbox[7][3]=8'h8F;
	    inv_sbox[7][4]=8'hCA;
	    inv_sbox[7][5]=8'h3F;
	    inv_sbox[7][6]= 8'h0F;
	    inv_sbox[7][7]= 8'h02;
	    inv_sbox[7][8]= 8'hC1;
	    inv_sbox[7][9]= 8'hAF;
	    inv_sbox[7][10]= 8'hBD;
	    inv_sbox[7][11]= 8'h03;
	    inv_sbox[7][12]= 8'h01;
	    inv_sbox[7][13]= 8'h13;
	    inv_sbox[7][14]= 8'h8A;
	    inv_sbox[7][15]= 8'h6B;

	    inv_sbox[8][0]=8'h3A;
	    inv_sbox[8][1]= 8'h91;
	    inv_sbox[8][2]= 8'h11;
	    inv_sbox[8][3]=8'h41;
	    inv_sbox[8][4]=8'h4F;
	    inv_sbox[8][5]=8'h67;
	    inv_sbox[8][6]= 8'hDC;
	    inv_sbox[8][7]= 8'hEA;
	    inv_sbox[8][8]= 8'h97;
	    inv_sbox[8][9]= 8'hF2;
	    inv_sbox[8][10]= 8'hCF;
	    inv_sbox[8][11]= 8'hCE;
	    inv_sbox[8][12]= 8'hF0;
	    inv_sbox[8][13]= 8'hB4;
	    inv_sbox[8][14]= 8'hE6;
	    inv_sbox[8][15]= 8'h73;

	    inv_sbox[9][0]=8'h96;
	    inv_sbox[9][1]= 8'hAC;
	    inv_sbox[9][2]= 8'h74;
	    inv_sbox[9][3]=8'h22;
	    inv_sbox[9][4]=8'hE7;
	    inv_sbox[9][5]=8'hAD;
	    inv_sbox[9][6]= 8'h35;
	    inv_sbox[9][7]= 8'h85;
	    inv_sbox[9][8]= 8'hE2;
	    inv_sbox[9][9]= 8'hF9;
	    inv_sbox[9][10]= 8'h37;
	    inv_sbox[9][11]= 8'hE8;
	    inv_sbox[9][12]= 8'h1C;
	    inv_sbox[9][13]= 8'h75;
	    inv_sbox[9][14]= 8'hDF;
	    inv_sbox[9][15]= 8'h6E;

	    inv_sbox[10][0]=8'h47;
	    inv_sbox[10][1]= 8'hF1;
	    inv_sbox[10][2]= 8'h1A;
	    inv_sbox[10][3]=8'h71;
	    inv_sbox[10][4]=8'h1D;
	    inv_sbox[10][5]=8'h29;
	    inv_sbox[10][6]= 8'hC5;
	    inv_sbox[10][7]= 8'h89;
	    inv_sbox[10][8]= 8'h6F;
	    inv_sbox[10][9]= 8'hB7;
	    inv_sbox[10][10]= 8'h62;
	    inv_sbox[10][11]= 8'h0E;
	    inv_sbox[10][12]= 8'hAA;
	    inv_sbox[10][13]= 8'h18;
	    inv_sbox[10][14]= 8'hBE;
	    inv_sbox[10][15]= 8'h1B;

	    inv_sbox[11][0]=8'hFC;
	    inv_sbox[11][1]= 8'h56;
	    inv_sbox[11][2]= 8'h3E;
	    inv_sbox[11][3]=8'h4B;
	    inv_sbox[11][4]=8'hC6;
	    inv_sbox[11][5]=8'hD2;
	    inv_sbox[11][6]= 8'h79;
	    inv_sbox[11][7]= 8'h20;
	    inv_sbox[11][8]= 8'h9A;
	    inv_sbox[11][9]= 8'hDB;
	    inv_sbox[11][10]= 8'hC0;
	    inv_sbox[11][11]= 8'hFE;
	    inv_sbox[11][12]= 8'h78;
	    inv_sbox[11][13]= 8'hCD;
	    inv_sbox[11][14]= 8'h5A;
	    inv_sbox[11][15]= 8'hF4;

	    inv_sbox[12][0]=8'h1F;
	    inv_sbox[12][1]= 8'hDD;
	    inv_sbox[12][2]= 8'hA8;
	    inv_sbox[12][3]=8'h33;
	    inv_sbox[12][4]=8'h88;
	    inv_sbox[12][5]=8'h07;
	    inv_sbox[12][6]= 8'hC7;
	    inv_sbox[12][7]= 8'h31;
	    inv_sbox[12][8]= 8'hB1;
	    inv_sbox[12][9]= 8'h12;
	    inv_sbox[12][10]= 8'h10;
	    inv_sbox[12][11]= 8'h59;
	    inv_sbox[12][12]= 8'h27;
	    inv_sbox[12][13]= 8'h80;
	    inv_sbox[12][14]= 8'hEC;
	    inv_sbox[12][15]= 8'h5F;

	    inv_sbox[13][0]=8'h60;
	    inv_sbox[13][1]= 8'h51;
	    inv_sbox[13][2]= 8'h7F;
	    inv_sbox[13][3]=8'hA9;
	    inv_sbox[13][4]=8'h19;
	    inv_sbox[13][5]=8'hB5;
	    inv_sbox[13][6]= 8'h4A;
	    inv_sbox[13][7]= 8'h0D;
	    inv_sbox[13][8]= 8'h2D;
	    inv_sbox[13][9]= 8'hE5;
	    inv_sbox[13][10]= 8'h7A;
	    inv_sbox[13][11]= 8'h9F;
	    inv_sbox[13][12]= 8'h93;
	    inv_sbox[13][13]= 8'hC9;
	    inv_sbox[13][14]= 8'h9C;
	    inv_sbox[13][15]= 8'hEF;

	    inv_sbox[14][0]=8'hA0;
	    inv_sbox[14][1]= 8'hE0;
	    inv_sbox[14][2]= 8'h3B;
	    inv_sbox[14][3]=8'h4D;
	    inv_sbox[14][4]=8'hAE;
	    inv_sbox[14][5]=8'h2A;
	    inv_sbox[14][6]= 8'hF5;
	    inv_sbox[14][7]= 8'hB0;
	    inv_sbox[14][8]= 8'hC8;
	    inv_sbox[14][9]= 8'hEB;
	    inv_sbox[14][10]= 8'hBB;
	    inv_sbox[14][11]= 8'h3C;
	    inv_sbox[14][12]= 8'h83;
	    inv_sbox[14][13]= 8'h53;
	    inv_sbox[14][14]= 8'h99;
	    inv_sbox[14][15]= 8'h61;

	    inv_sbox[15][0]=8'h17;
	    inv_sbox[15][1]= 8'h2B;
	    inv_sbox[15][2]= 8'h04;
	    inv_sbox[15][3]=8'h7E;
	    inv_sbox[15][4]=8'hBA;
	    inv_sbox[15][5]=8'h77;
	    inv_sbox[15][6]= 8'hD6;
	    inv_sbox[15][7]= 8'h26;
	    inv_sbox[15][8]= 8'hE1;
	    inv_sbox[15][9]= 8'h69;
	    inv_sbox[15][10]= 8'h14;
	    inv_sbox[15][11]= 8'h63;
	    inv_sbox[15][12]= 8'h55;
	    inv_sbox[15][13]= 8'h21;
	    inv_sbox[15][14]= 8'h0C;
	    inv_sbox[15][15]= 8'h7D;
	
	 r= s_inp [7:4];
	 clm= s_inp [3:0];



	 inv_svalue = inv_sbox [r][clm];

	 end

endfunction

endmodule


