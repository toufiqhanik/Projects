`timescale 1ns / 1ps

module daes_tb();

	reg clk;
	reg [127:0] cipertext,keyin;
	
	wire [127:0] plaintext;



	integer keyin_file, cipertex_file, plaintext_file;

	reg [127:0] scan_pt,scan_kin;

	




	daes aesdcd (.clk(clk),.plaintext(plaintext),.keyin(keyin),.cipertext(cipertext));

	always	#1000 clk = ~clk;

	



	initial begin

		clk =  1'b0;

		cipertex_file = $fopen("./cipertext.txt", "r");
		if (!cipertex_file) 
				begin
					$display("error opening Cipher file for reading");
					$finish;
				end
		else 
				begin
					scan_pt = $fscanf(cipertex_file, "%b", cipertext);
				end


		if (!scan_pt) 
				begin
					$display("error opening scan ciper file for reading");
					$finish;
				end	


		keyin_file = $fopen("./keyin.txt", "r");
		if (!keyin_file) 
				begin
					$display("error opening keyin file for reading");
					$finish;
				end
		else 
				begin
					scan_kin = $fscanf(keyin_file, "%b", keyin);
				end




		plaintext_file = $fopen("./newplaintext.txt", "w");
		if (!plaintext_file) 
				begin
					$display("error plaintext output file for writing");
					$finish;
				end
				

	end

	
	

	

	always @ (keyin)
            begin
                $display("testbrench :");
                $display("Cipertext :");
                $display("%b", cipertext);
                $display("%h", cipertext);

                $display("Keyin :");
                $display("%b", keyin);
                $display("%h", keyin);
              
            end 
	
	
	always @ (plaintext)
			begin
				$display("plaintext: ");
				$display("%h", plaintext);
				if (plaintext_file) 
				begin
					$fwrite(plaintext_file, "%b\n", plaintext);
					$fwrite(plaintext_file, "%h\n", plaintext);
					#10
					$finish;
				end


			end	
	


	
endmodule
