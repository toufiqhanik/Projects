To encrypt Run:

vcs -full64  round.v roundkey.v shiftrow.v subbytes.v softbox.v mixcolumn.v finalround.v aes.v aes_tb.v -debug_all


To decrypt Run:
vcs -full64  dround.v droundkey.v dshiftrow.v dsubbytes.v dsoftbox.v softbox.v dmixcolumn.v dfirstround.v daes.v daes_tb.v -debug_all