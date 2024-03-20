#cd /home/anik/research/intern/tmax/c17/
set_workspace_sizes -line 100000
set_messages -log ./c17_p1_log.log -replace
read_netlist ../NangateOpenCellLibrary.v
read_netlist ./c17_syn.v
run_build_model c17
#add_clocks 0 CK
set_drc -nofile
run_drc
remove_faults -all
set_faults -model stuck
#add_faults -all
read_faults ./c17_magic_p1.faults -add
set_atpg -abort_limit 100 -merge high
run_atpg -auto_compression
write_patterns ./c17_p1_pattern.pattern -exclude setup -format stil -replace
