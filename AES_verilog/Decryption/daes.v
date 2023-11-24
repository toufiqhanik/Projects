`timescale 1ns / 1ps

module daes (clk, plaintext, keyin, cipertext);

    input clk;
    input [127:0] cipertext;
    input [127:0] keyin;
    output[127:0] plaintext;
    
    reg [127:0] plaintext;
    wire [127:0] round_1_out,round_2_out,round_3_out,round_4_out,round_5_out,round_6_out,round_7_out,round_8_out,round_9_out,round_10_out;
    
    wire [127:0] key_1_out,key_2_out,key_3_out,key_4_out,key_5_out,key_6_out,key_7_out,key_8_out,key_9_out, key_10_out;
    
    droundkey rk1 (.inkey(keyin), .outkey(key_1_out), .rc(4'h0));
    droundkey rk2 (.inkey(key_1_out), .outkey(key_2_out), .rc(4'h1));
    droundkey rk3 (.inkey(key_2_out), .outkey(key_3_out), .rc(4'h2));
    droundkey rk4 (.inkey(key_3_out), .outkey(key_4_out), .rc(4'h3));
    droundkey rk5 (.inkey(key_4_out), .outkey(key_5_out), .rc(4'h4));
    droundkey rk6 (.inkey(key_5_out), .outkey(key_6_out), .rc(4'h5));
    droundkey rk7 (.inkey(key_6_out), .outkey(key_7_out), .rc(4'h6));
    droundkey rk8 (.inkey(key_7_out), .outkey(key_8_out), .rc(4'h7));
    droundkey rk9 (.inkey(key_8_out), .outkey(key_9_out), .rc(4'h8));
    droundkey rk10 (.inkey(key_9_out), .outkey(key_10_out), .rc(4'h9));




    dfirstround dr1 (.clk(clk), .inputdata(cipertext), .inkey(key_10_out), .r_out(round_1_out));

    dround dr2 (.clk(clk), .inputdata(round_1_out), .inkey(key_9_out), .r_out(round_2_out));
    dround dr3 (.clk(clk), .inputdata(round_2_out), .inkey(key_8_out), .r_out(round_3_out));
    dround dr4 (.clk(clk), .inputdata(round_3_out), .inkey(key_7_out), .r_out(round_4_out));
    dround dr5 (.clk(clk), .inputdata(round_4_out), .inkey(key_6_out), .r_out(round_5_out));
    dround dr6 (.clk(clk), .inputdata(round_5_out), .inkey(key_5_out), .r_out(round_6_out));

    dround dr7 (.clk(clk), .inputdata(round_6_out), .inkey(key_4_out), .r_out(round_7_out));
    dround dr8 (.clk(clk), .inputdata(round_7_out), .inkey(key_3_out), .r_out(round_8_out));
    dround dr9 (.clk(clk), .inputdata(round_8_out), .inkey(key_2_out), .r_out(round_9_out));
    dround dr10 (.clk(clk), .inputdata(round_9_out), .inkey(key_1_out), .r_out(round_10_out));

        always @ (clk && round_10_out && keyin)
        begin
            plaintext = round_10_out^keyin;
            end 
        

            always @ (key_10_out)
            begin
                $display("Key 1 :");
                $display("%h", key_1_out);
                $display("Key 9 :");
                $display("%h", key_9_out);
                //$display("%h", round_1_out);
                end


        always @ (round_1_out)
            begin
                $display("Round 1 :");
                $display("%h", key_1_out);
                $display("%h", round_1_out);
              
            end 

        always @ (round_3_out)
            begin
                $display("Round 3 :");
                $display("%h", key_3_out);
                $display("%h", round_3_out);
              
            end



        always @ (round_5_out)
            begin
                $display("Round 5 :");
                $display("%h", key_5_out);
                $display("%h", round_5_out);
              
            end

        always @ (round_7_out)
            begin
                $display("Round 7 :");
                $display("%h", key_7_out);
                $display("%h", round_7_out);
              
            end


            always @ (plaintext)
            begin
                $display("plaintext");
                $display("%h", plaintext);
                
            end 


            


endmodule