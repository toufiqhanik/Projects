`timescale 1ns / 1ps

module aes (clk, plaintextin, keyin, cipertex);

    input clk;
    input [127:0] plaintextin;
    input [127:0] keyin;
    output[127:0] cipertex;
    
    reg [127:0] round_0_out;
    wire [127:0] round_1_out,round_2_out,round_3_out,round_4_out,round_5_out,round_6_out,round_7_out,round_8_out,round_9_out;
    
    wire [127:0] key_1_out,key_2_out,key_3_out,key_4_out,key_5_out,key_6_out,key_7_out,key_7_out,key_8_out,key_9_out;
    
    always @ (clk && plaintextin && keyin)
        begin
            assign round_0_out = plaintextin^keyin;
            end 
    
     
    round r1(.clk(clk),.rc(4'h0),.inputdata(round_0_out),.inkey(keyin),.outkey(key_1_out),.r_out(round_1_out));

    always @ (round_1_out)
            begin
                $display("Round 1 :");
                $display("%h", key_1_out);
                $display("%h", round_1_out);
              
            end 

    round r2(.clk(clk),.rc(4'h1),.inputdata(round_1_out),.inkey(key_1_out),.outkey(key_2_out),.r_out(round_2_out));
    round r3(.clk(clk),.rc(4'h2),.inputdata(round_2_out),.inkey(key_2_out),.outkey(key_3_out),.r_out(round_3_out));

    always @ (round_3_out)
            begin
                $display("Round 3 :");
                $display("%h", key_3_out);
                $display("%h", round_3_out);
              
            end
    round r4(.clk(clk),.rc(4'h3),.inputdata(round_3_out),.inkey(key_3_out),.outkey(key_4_out),.r_out(round_4_out));
    round r5(.clk(clk),.rc(4'h4),.inputdata(round_4_out),.inkey(key_4_out),.outkey(key_5_out),.r_out(round_5_out));

    always @ (round_5_out)
            begin
                $display("Round 5 :");
                $display("%h", key_5_out);
                $display("%h", round_5_out);
              
            end

    round r6(.clk(clk),.rc(4'h5),.inputdata(round_5_out),.inkey(key_5_out),.outkey(key_6_out),.r_out(round_6_out));
    round r7(.clk(clk),.rc(4'h6),.inputdata(round_6_out),.inkey(key_6_out),.outkey(key_7_out),.r_out(round_7_out));

        always @ (round_7_out)
            begin
                $display("Round 7 :");
                $display("%h", key_7_out);
                $display("%h", round_7_out);
              
            end

    round r8(.clk(clk),.rc(4'h7),.inputdata(round_7_out),.inkey(key_7_out),.outkey(key_8_out),.r_out(round_8_out));
    round r9(.clk(clk),.rc(4'h8),.inputdata(round_8_out),.inkey(key_8_out),.outkey(key_9_out),.r_out(round_9_out));

    finalround round_10 (.clk(clk),.rc(4'h9),.inputdata(round_9_out),.inkey(key_9_out),.r_out(cipertex));
    
        always @ (key_9_out)
            begin
                $display("Key 1 :");
                $display("%h", key_1_out);
                $display("Key 9 :");
                $display("%h", key_9_out);
                //$display("%h", round_1_out);
                end
    
    always @ (cipertex)
            begin
                $display("%d", 10);
                $display("%h", cipertex);
                
            end 
    
endmodule