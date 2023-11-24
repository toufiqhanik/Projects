`timescale 1ns / 1ps

module roundkey(inkey, outkey, rc);

input [127:0] inkey;
input [3:0] rc;

output [127:0] outkey;

wire [31:0] w0, w1, w2, w3, lc;

	assign w0 = inkey[127:96];
	assign w1 = inkey[95:64];
	assign w2 = inkey[63:32];
	assign w3 = inkey[31:0];

	softbox t0 ( .din(inkey[31:24]), .dout(lc[7:0]) );
	softbox t1 ( .din(inkey[23:16]), .dout(lc[31:24]) );
	softbox t2 ( .din(inkey[15:8]), .dout(lc[23:16]) );
	softbox t3 ( .din(inkey[7:0]), .dout(lc[15:8]) );
	
	function [31:0] rcxor;
      input	[3:0]	rc;
      case(rc)	
         4'h0: rcxor=32'h01000000;
         4'h1: rcxor=32'h02000000;
         4'h2: rcxor=32'h04000000;
         4'h3: rcxor=32'h08000000;
         4'h4: rcxor=32'h10000000;
         4'h5: rcxor=32'h20000000;
         4'h6: rcxor=32'h40000000;
         4'h7: rcxor=32'h80000000;
         4'h8: rcxor=32'h1b000000;
         4'h9: rcxor=32'h36000000;
         default: rcxor=32'h00000000;
       endcase
    endfunction


    assign outkey[127:96] = w0 ^ lc ^ rcxor(rc);
    assign outkey[95:64] = outkey[127:96] ^ w1;
    assign outkey[63:32] = outkey[95:64] ^ w2;
    assign outkey[31:0] = outkey[63:32] ^ w3;

endmodule

