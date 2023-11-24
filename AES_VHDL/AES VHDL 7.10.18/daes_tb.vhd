
library IEEE;
library STD;
use ieee.std_logic_1164.all;
use std.textio.all;
use work.std_logic_textio.all;

entity daes_tb is
end daes_tb;

ARCHITECTURE da_arch of daes_tb is 

	CONSTANT stimescale: time:= 1ns;

	component daes
	   PORT (
   		clk : IN std_logic;
   		cipertext: IN std_logic_vector(127 DOWNTO 0);
   		keyin: IN std_logic_vector(127 DOWNTO 0);
   		plaintext: OUT std_logic_vector(127 DOWNTO 0));

 	end component;

 	SIGNAL clk : std_logic;
 	SIGNAL cipertext,keyin,plaintext : std_logic_vector(127 DOWNTO 0);

BEGIN

  PROCESS
  BEGIN
  	  WAIT FOR 1000*stimescale;
  	  clk<= NOT clk;
  END PROCESS;

  aesdcd : daes
  		 port map (
  		   clk=> clk,
  		   cipertext=> cipertext,
  		   keyin=> keyin,
  		   plaintext=> plaintext);

  io_process: process
	file ciperinfile: TEXT is in "cipertext.txt";
	file keyinfile: TEXT is in "keyin.txt";
	file plaintextfile : TEXT is out "newplaintext.txt";

	variable good: boolean;
	variable ciper_line, keyin_line, plaintext_line : Line;
	variable scan_key, scan_ct : std_logic_vector(127 downto 0);

   BEGIN

		readline(ciperinfile,ciper_line);
		

		read(ciper_line,scan_ct,good);
          assert good
          report "CiperText I/O read error"
          severity ERROR;


    readline(keyinfile,keyin_line);
		

		read(keyin_line,scan_key,good);
          assert good
          report "KeyInText I/O read error"
          severity ERROR;

        cipertext <= scan_ct;
        keyin <= scan_key;

        wait for 1010000 ns;
        write (plaintext_line, plaintext);
        writeline (plaintextfile, plaintext_line);

        wait;

 END PROCESS;




 -- PROCESS
  --Variable intext :LINE;

 -- BEGIN
  --  WAIT UNTIL keyin'EVENT;
  --  WRITE(intext, "TESTBRENCH :");
  --  WRITE(intext, "CIPERTEXT :");
  --  WRITE(intext, to_hexstring(cipertext));

  --  WRITE(intext, "KEYIN :");
  --  WRITE(intext, to_hexstring(keyin));

  --  writeline(OUTPUT, intext);
  --END PROCESS;


  --PROCESS
 -- Variable outtext :LINE;
  --BEGIN
  --  WAIT UNTIL plaintext'EVENT;
   -- WRITE(outtext, "OUTPUT :");
   -- WRITE(outtext, "PLAINTEXT :");
   -- WRITE(outtext, to_hexstring(plaintext));
   -- writeline(OUTPUT, outtext);

  --END PROCESS;

END da_arch;