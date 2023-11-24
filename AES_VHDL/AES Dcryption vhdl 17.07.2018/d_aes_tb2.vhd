
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.std_logic_textio.all;
use work.std_logic_signed.all;
use work.std_logic_unsigned.all;
use work.std_logic_arith.all;


entity d_aes_tb2 is
end d_aes_tb2;

architecture behavioural of d_aes_tb2 is

	constant stimescale: time:= 1ns;


	component daes
	   port (
   		clk : in std_logic;
   		cipertext: in std_logic_vector(127 downto 0);
   		keyin: in std_logic_vector(127 downto 0);
   		plaintext: out std_logic_vector(127 downto 0));

 	end component;

 	signal clk1 : std_logic:= '0';
	signal cipertext1, keyin1, plaintext1 : std_logic_vector(127 downto 0) := (others => '0');

begin

	process
	  begin
	  	  wait for 1000 ns;
	  	  clk1<= not clk1;
	end process;

	
	aesdcd : daes port map (clk1,cipertext1,keyin1,plaintext1);

	
	process
	
	file keyin_file: TEXT is in "keyin.txt";
	file ciperinfile: TEXT is in "cipertext.txt";
	file plaintext_file : TEXT is out "newplaintext.txt";

	variable good: boolean;
	variable good2: boolean;
	variable ciper_line, keyin_line, result_line, out_line, displayline1,displayline2 : Line; 
	variable scan_ct, scan_key: std_logic_vector(127 downto 0);

	begin


	        readline(keyin_file,keyin_line);
	               
	        read(keyin_line,scan_key,good);
	        assert good
	        report "Text Keyin I/O read error"
	        severity ERROR;

	        readline(ciperinfile,ciper_line);
	        
	        read(ciper_line,scan_ct,good2);
	        assert good2
	        report "Text Ciper I/O read error"
	        severity ERROR;

	       

	        keyin1 <= scan_key;
	        cipertext1 <=scan_ct;

	        wait until plaintext1'event;

	        write (displayline1, string'("Decrypted Plaintext: "));
			writeline(output, displayline1);

	        write (result_line, plaintext1);
			writeline (plaintext_file, result_line);

			write (displayline2, plaintext1);
			writeline(output, displayline2);

		
				
		

	end process;

end;
