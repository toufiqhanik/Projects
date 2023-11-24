`timescale 1ns / 1ps

module dsbox_tb ();
    wire [7:0] dout;
/*
//wire [127:0] xordata;
wire [127:0] mixclm;

	//wire = 128'h bd6e7c3df2b5779e0b61216e8b10b689;

	//dmixcolumn mc (128'b 10111101011011100111110000111101111100101011010101110111100111100000101101100001001000010110111010001011000100001011011010001001, mixclm);

	always @ (mixclm)

        begin
            //$display("input :");
            //$display("%b", xordata);
            //$display("%h", xordata);
            $display("output :"); 
            $display("%b", mixclm);
            $display("%h", mixclm);
          
        end 


*/

dsoftbox ds (8'h Ea, dout);





endmodule