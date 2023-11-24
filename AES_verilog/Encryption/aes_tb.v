`timescale 1ns / 1ps

module aes_tb();

	reg clk;
	reg [127:0] plaintext,keyin;
	//reg[31:0] plaintext1 [0:127];
	//reg[31:0] keyin1 [0:127];
	wire [127:0] cipertext;



	integer keyin_file, cipertex_file, plaintext_file;

	reg [127:0] scan_pt,scan_kin;

	


	//aes_top aest (clk,cipertext);

	aes aesencd (.clk(clk),.plaintextin(plaintext),.keyin(keyin),.cipertex(cipertext));

	always	#1000 clk = ~clk;

	



	initial begin

		clk =  1'b0;
/*
		#100;

		$readmemb("./plaintext.txt", plaintext1);
		#10
		//plaintext [127:0] =	plaintext1 [0:127];
		#10
		$readmemb("./keyin.txt", keyin1);
		#10
		//keyin [127:0] =	keyin1 [0:127];


*/

		plaintext_file = $fopen("./plaintext.txt", "r");
		if (!plaintext_file) 
				begin
					$display("error opening plain file for reading");
					$finish;
				end
		else 
				begin
					scan_pt = $fscanf(plaintext_file, "%b", plaintext);
					//scan_pt =$fgets(plaintext, plaintext_file);
					end


		if (!scan_pt) 
				begin
					$display("error opening scan file for reading");
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
					//scan_kin=$fgets(keyin, keyin_file);
					end




		cipertex_file = $fopen("./cipertext.txt", "w");
		if (!cipertex_file) 
				begin
					$display("error cipertext output file for writing");
					$finish;
				end
				

	end

	
	

	

	always @ (keyin)
            begin
                $display("Initial :");
                $display("%b", keyin);
                $display("%h", keyin);
                $display("%b", plaintext);
                $display("%h", plaintext);
            end 
	
	
	always @ (cipertext)
			begin
				$display("Cipertext: ");
				$display("%h", cipertext);
				if (cipertex_file) 
				begin
					$fwrite(cipertex_file, "%b\n", cipertext);
					$fwrite(cipertex_file, "%h\n", cipertext);
					#10
					$finish;
				end


			end	
	


	
endmodule
