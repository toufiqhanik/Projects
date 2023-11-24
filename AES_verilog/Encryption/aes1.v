`timescale 1ns / 1ps

module aes (clk, plaintextin, keyin, cipertex);

    input clk;
    input [127:0] plaintextin;
    input [127:0] keyin;
    output[127:0] cipertex;
    
    wire [127:0] r0_out;
    wire [127:0] r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out;
    
    wire [127:0] keyout1,keyout2,keyout3,keyout4,keyout5,keyout6,keyout7,keyout8,keyout9;
	 
	assign r0_out = plaintextin^keyin;
	 
    round r1(.clk(clk),.rc(4'b0000),.inputdata(r0_out),.inkey(keyin),.outkey(keyout1),.r_out(r1_out));
    always @ (r1_out)
            begin
                $display("Round 1 :");
                $display("%h", keyout1);
                $display("%h", r1_out);
              
            end 

    round r2(.clk(clk),.rc(4'b0001),.inputdata(r1_out),.inkey(keyout1),.outkey(keyout2),.r_out(r2_out));
    round r3(.rc(4'b0010),.inputdata(r2_out),.inkey(keyout2),.outkey(keyout3),.r_out(r3_out));

    always @ (r3_out)
            begin
                $display("%d", 3);
                $display("%h", keyout3);
                $display("%h", r3_out);
              
            end
    round r4(.clk(clk),.rc(4'b0011),.inputdata(r3_out),.inkey(keyout3),.outkey(keyout4),.r_out(r4_out));
    round r5(.clk(clk),.rc(4'b0100),.inputdata(r4_out),.inkey(keyout4),.outkey(keyout5),.r_out(r5_out));
    round r6(.clk(clk),.rc(4'b0101),.inputdata(r5_out),.inkey(keyout5),.outkey(keyout6),.r_out(r6_out));
    round r7(.clk(clk),.rc(4'b0110),.inputdata(r6_out),.inkey(keyout6),.outkey(keyout7),.r_out(r7_out));
    round r8(.clk(clk),.rc(4'b0111),.inputdata(r7_out),.inkey(keyout7),.outkey(keyout8),.r_out(r8_out));
    round r9(.clk(clk),.rc(4'b1000),.inputdata(r8_out),.inkey(keyout8),.outkey(keyout9),.r_out(r9_out));

    finalround round_10 (.clk(clk),.rc(4'b1001),.inputdata(r9_out),.inkey(keyout9),.r_out(cipertex));
    
    
    always @ (cipertex)
            begin
                $display("%d", 10);
                $display("%h", cipertex);
                
            end 
    
endmodule