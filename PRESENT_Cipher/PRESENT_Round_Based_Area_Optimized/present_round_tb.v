`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Md Toufiq Hasan Anik
//email: toufiqhanik@umbc.edu
//web: https://toufiqhanik.github.io/
//its for practice purposes to stay uptodate
//use it on your own risk

//module test brench PRESENT cipher*/
//Note: 
//Create Date: 05/29/2024 01:35:19 AM
// 
//////////////////////////////////////////////////////////////////////////////////


module present_round_tb;
    
    reg [63:0] plaintext;
    wire [63:0] chiphertext;
    reg [79:0] key;
    reg n_reset;
    reg clk;
    wire done;
    wire [4:0] round_count;

    present_round uut (.plaintext(plaintext),.chiphertext(chiphertext),.key(key),.n_reset(n_reset),.clk(clk),.done(done),.round_count(round_count));


    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    
    initial begin
        plaintext = 64'h0123456789ABCDEF;
        key = 80'h0123456789ABCDEF0123;
        //chiphertext = 60'hf8dd50531d973bde // This should be the output when done is high,
        
        n_reset = 1; 
        #10;
        n_reset = 0; 
        #10;
        n_reset = 1; 
        #2000; 
        $finish;
        

    end

    initial begin
        $monitor("Time: %d, plaintext: %h, key: %h, chiphertext: %h, done: %b, round_count: %d", 
                  $time, plaintext, key, chiphertext, done, round_count);
    end


endmodule

