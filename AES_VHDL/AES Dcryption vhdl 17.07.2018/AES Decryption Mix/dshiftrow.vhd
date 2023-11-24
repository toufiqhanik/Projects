library ieee;
use ieee.std_logic_1164.all;

ENTITY dshiftrow IS
  PORT(
  	sbyte :IN std_logic_vector(127 DOWNTO 0);
  	srow  :OUT std_logic_vector(127 DOWNTO 0));

 END dshiftrow;

 ARCHITECTURE shiftrow_arch OF dshiftrow IS

 	SIGNAL temp_vector : std_logic_vector(127 DOWNTO 0);

 BEGIN

 	--row 0
 	temp_vector(127 DOWNTO 120) <= sbyte(127 DOWNTO 120);
 	temp_vector(95 DOWNTO 88) <= sbyte(95 DOWNTO 88);
 	temp_vector(63 DOWNTO 56) <= sbyte(63 DOWNTO 56);
 	temp_vector(31 DOWNTO 24) <= sbyte(31 DOWNTO 24);

 	--row 1
 	temp_vector(119 DOWNTO 112) <= sbyte(23 DOWNTO 16);
 	temp_vector(87 DOWNTO 80) <= sbyte(119 DOWNTO 112);
 	temp_vector(55 DOWNTO 48) <= sbyte(87 DOWNTO 80);
 	temp_vector(23 DOWNTO 16) <= sbyte(55 DOWNTO 48);

    --row 2
 	temp_vector(111 DOWNTO 104) <= sbyte(47 DOWNTO 40);
 	temp_vector(79 DOWNTO 72) <= sbyte(15 DOWNTO 8);
 	temp_vector(47 DOWNTO 40) <= sbyte(111 DOWNTO 104);
 	temp_vector(15 DOWNTO 8) <= sbyte(79 DOWNTO 72);

 	--row 3
 	temp_vector(103 DOWNTO 96) <= sbyte(71 DOWNTO 64);
 	temp_vector(71 DOWNTO 64) <= sbyte(39 DOWNTO 32);
 	temp_vector(39 DOWNTO 32) <= sbyte(7 DOWNTO 0);
 	temp_vector(7 DOWNTO 0) <= sbyte(103 DOWNTO 96);

 	srow <= temp_vector;

 END shiftrow_arch;