import os
os.system('echo "DEFAULT : ./work" > synopsys_sim.setup')
os.system('rm -rf work')
os.system('mkdir work')
os.system('vhdlan -full64 $VCS_HOME/packages/IEEE/src/std_logic_textio.vhd')
os.system('vhdlan -full64 $VCS_HOME/packages/IEEE/src/std_logic_signed.vhd')
os.system('vhdlan -full64 $VCS_HOME/packages/IEEE/src/std_logic_unsigned.vhd')
os.system('vhdlan -full64 $VCS_HOME/packages/IEEE/src/std_logic_arith.vhd')