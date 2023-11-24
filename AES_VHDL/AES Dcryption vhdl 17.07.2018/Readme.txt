To encrypt Run:

vcs -full64  round.v roundkey.v shiftrow.v subbytes.v softbox.v mixcolumn.v finalround.v aes.v aes_tb.v -debug_all


To decrypt Run:
vcs -full64  dround.v droundkey.v dshiftrow.v dsubbytes.v dsoftbox.v softbox.v dmixcolumn.v dfirstround.v daes.v daes_tb.v -debug_all




For mixed vhdl + verilog do:

vlogan -full64 droundkey.v dsubbytes.v dsoftbox.v softbox.v  dfirstround.v dmixcolumn.v dround.v 

vhdlan -full64 dshiftrow.vhd daes.vhd daes_tb.vhd

vcs -full64  daes_tb
 
./simv