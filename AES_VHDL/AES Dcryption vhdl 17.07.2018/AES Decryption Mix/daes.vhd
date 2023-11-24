library ieee;
use IEEE.std_logic_1164.all;
use work.std_logic_textio.all;
use work.std_logic_signed.all;
use work.std_logic_unsigned.all;
use work.std_logic_arith.all;
use std.textio.all;

ENTITY daes IS
 PORT (
 		clk : IN std_logic;
 		cipertext: IN std_logic_vector(127 DOWNTO 0);
 		keyin: IN std_logic_vector(127 DOWNTO 0);
 		plaintext: OUT std_logic_vector(127 DOWNTO 0));

 END daes;

 ARCHITECTURE daes_arch OF daes IS

 	component droundkey
 		port (
 		 inkey : IN std_logic_vector(127 DOWNTO 0);
 		 outkey : OUT std_logic_vector(127 DOWNTO 0);
 		 rc : IN std_logic_vector(3 DOWNTO 0));
 	end component;

 	component dfirstround
 		port (
 		 clk : IN std_logic;
 		 inputdata : IN std_logic_vector(127 DOWNTO 0);
 		 inkey : IN std_logic_vector(127 DOWNTO 0);
 		 r_out : OUT std_logic_vector(127 DOWNTO 0));
 	end component;

 	component dround
 		port (
 		 clk : IN std_logic;
 		 inputdata : IN std_logic_vector(127 DOWNTO 0);
 		 inkey : IN std_logic_vector(127 DOWNTO 0);
 		 r_out : OUT std_logic_vector(127 DOWNTO 0));
 	end component;


 	SIGNAL plaintext_temp : std_logic_vector(127 DOWNTO 0);

 	SIGNAL round_1_out,round_2_out,round_3_out,round_4_out,round_5_out,round_6_out,round_7_out,round_8_out,round_9_out,round_10_out : std_logic_vector(127 DOWNTO 0);

 	SIGNAL key_1_out,key_2_out,key_3_out,key_4_out,key_5_out,key_6_out,key_7_out,key_8_out,key_9_out, key_10_out : std_logic_vector(127 DOWNTO 0);

BEGIN

	plaintext<= plaintext_temp;

	rk1: droundkey port map (inkey=> keyin, outkey => key_1_out, rc => x"0"); 
	rk2: droundkey port map (inkey=> key_1_out, outkey=>key_2_out, rc=> x"1");
    rk3: droundkey port map (inkey=> key_2_out, outkey=>key_3_out, rc=> x"2");
    rk4: droundkey port map (inkey=> key_3_out, outkey=>key_4_out, rc=> x"3");
    rk5: droundkey port map (inkey=> key_4_out, outkey=>key_5_out, rc=> x"4");
    rk6: droundkey port map (inkey=> key_5_out, outkey=>key_6_out, rc=> x"5");
    rk7: droundkey port map (inkey=> key_6_out, outkey=>key_7_out, rc=> x"6");
    rk8: droundkey port map (inkey=> key_7_out, outkey=>key_8_out, rc=> x"7");
    rk9: droundkey port map (inkey=> key_8_out, outkey=>key_9_out, rc=> x"8");
    rk10: droundkey port map(inkey=> key_9_out, outkey=>key_10_out,rc=> x"9");


    dr1: dfirstround  port map (clk=>clk, inputdata=> cipertext, inkey=> key_10_out, r_out=> round_1_out);

    dr2: dround port map (clk=> clk, inputdata=> round_1_out, inkey=> key_9_out, r_out=> round_2_out);
    dr3: dround port map (clk=> clk, inputdata=> round_2_out, inkey=> key_8_out, r_out=> round_3_out);
    dr4: dround port map (clk=> clk, inputdata=> round_3_out, inkey=> key_7_out, r_out=> round_4_out);
    dr5: dround port map (clk=> clk, inputdata=> round_4_out, inkey=> key_6_out, r_out=> round_5_out);
    dr6: dround port map (clk=> clk, inputdata=> round_5_out, inkey=> key_5_out, r_out=> round_6_out);

    dr7: dround port map (clk=> clk, inputdata=> round_6_out, inkey=> key_4_out, r_out=> round_7_out);
    dr8: dround port map (clk=> clk, inputdata=> round_7_out, inkey=> key_3_out, r_out=> round_8_out);
    dr9: dround port map (clk=> clk, inputdata=> round_8_out, inkey=> key_2_out, r_out=> round_9_out);
    dr10: dround port map (clk=> clk, inputdata=> round_9_out, inkey=> key_1_out, r_out=> round_10_out);

    	process (round_10_out)
    	 begin
    	 	--wait until (clk AND round_10_out)'event;

    	 	plaintext_temp <= round_10_out XOR keyin;

    	 end process;


    --	 process
    --	 variable wline :LINE;
    --	 begin
    --	 	wait until plaintext_temp'event;
    --	 	write (wline, "Daes Plaintext:");
    --	 	write (wline, to_hexstring(plaintext_temp));
    --	 	writeline(OUTPUT, wline);
    	 	
    --	 end process;

END daes_arch;

